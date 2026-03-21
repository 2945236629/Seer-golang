package main

import (
	"bufio"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"strconv"
	"strings"
	"syscall"
	"time"

	"github.com/seer-game/golang-version/internal/core/logger"
	"github.com/seer-game/golang-version/internal/core/userdb"
	"github.com/seer-game/golang-version/internal/game/pets"
	"github.com/seer-game/golang-version/internal/game/skills"
	"github.com/seer-game/golang-version/internal/handlers"
	"github.com/seer-game/golang-version/internal/server/gameserver"
	"github.com/seer-game/golang-version/internal/server/loginip"
	"github.com/seer-game/golang-version/internal/server/loginserver"
	"github.com/seer-game/golang-version/internal/server/resserver"
)

// 官方资源包直连下载地址（gameres.rar）以及自动解压所需的 7-Zip 运行时下载地址
const (
	resourcePackageURL = "http://222.186.21.30:5888/d/%E7%A7%BB%E5%8A%A8%E4%BA%91%E7%9B%98/gameres.rar?sign=-NAcS1HGyq68sGi_Xn3mBUh4eYIMQxMESNU195V3KEc=:0"
	sevenZipMiniURL    = "https://www.7-zip.org/a/7zr.exe"          // 7-Zip 精简控制台版，用于解压 extra 包
	sevenZipExtraURL   = "https://www.7-zip.org/a/7z2301-extra.7z" // 含 7z.exe 的额外包
)

func main() {
	skipDisclaimer := flag.Bool("y", false, "跳过免责申明确认，直接启动（适合双击运行或脚本启动）")
	importDataDocs := flag.Bool("import-data-docs", false, "仅将 data/skills.xml、spt.xml、items.xml 导入 data_docs 表后退出")
	configPrompt := flag.Bool("config-prompt", false, "强制在控制台交互设置 IP 与端口（忽略 res_path.json 中已写全的配置）")
	flag.Parse()

	// 根据可执行文件路径解析项目根目录，保证从 bin/ 或任意目录运行都能找到 gameres
	exePath, _ := os.Executable()
	exeDir := filepath.Dir(exePath)
	projectRoot := exeDir
	if filepath.Base(exeDir) == "bin" {
		projectRoot = filepath.Dir(exeDir)
	}
	// GM 网页固定放在项目根目录下的 GM 文件夹；优先从当前目录向上查找 GM/gm_admin.html
	gmDir := filepath.Join(projectRoot, "GM")
	if cwd, err := os.Getwd(); err == nil {
		dir := cwd
		for {
			tryGM := filepath.Join(dir, "GM", "gm_admin.html")
			if _, err := os.Stat(tryGM); err == nil {
				projectRoot = dir
				gmDir = filepath.Join(dir, "GM")
				break
			}
			parent := filepath.Dir(dir)
			if parent == dir {
				break
			}
			dir = parent
		}
	}
	defaultResDir, _ := filepath.Abs(filepath.Join(projectRoot, "..", "gameres", "root"))

	// 游戏入口固定为可执行文件所在目录下的 gameres_proxy\root
	resProxyDir, _ := filepath.Abs(filepath.Join(exeDir, "gameres_proxy", "root"))

	// 资源目录配置保存在可执行文件所在目录（运行目录），便于随程序携带
	resPathConfigPath := filepath.Join(exeDir, "res_path.json")
	usersJSON := filepath.Join(projectRoot, "users.json")
	if _, err := os.Stat(usersJSON); os.IsNotExist(err) {
		usersJSON = filepath.Join(exeDir, "users.json")
	}
	gmPanelPath := filepath.Join(gmDir, "gm_panel.html")
	gmAdminPath := filepath.Join(gmDir, "gm_admin.html")

	// 仅导入 data_docs：连接 MySQL，将 data/*.xml 写入表后退出（同样支持 MYSQL_* 环境变量）
	if *importDataDocs {
		logger.Init()
		importHost := os.Getenv("MYSQL_HOST")
		if importHost == "" {
			importHost = "127.0.0.1"
		}
		importPort := 3306
		if p := os.Getenv("MYSQL_PORT"); p != "" {
			if i, err := strconv.Atoi(p); err == nil {
				importPort = i
			}
		}
		importDB := os.Getenv("MYSQL_DATABASE")
		if importDB == "" {
			importDB = "seer"
		}
		importUser := os.Getenv("MYSQL_USER")
		if importUser == "" {
			importUser = "seer"
		}
		importPass := os.Getenv("MYSQL_PASSWORD")
		if importPass == "" {
			importPass = "abc.123"
		}
		dbConfig := userdb.Config{
			LocalServerMode: true,
			UseMySQL:        true,
			DBPath:          usersJSON,
			MySQLConfig: userdb.MySQLConfig{
				Host:     importHost,
				Port:     importPort,
				Database: importDB,
				User:     importUser,
				Password: importPass,
			},
		}
		gs := gameserver.New(dbConfig)
		if gs.UserDB != nil && gs.UserDB.UseMySQL() {
			dataDir := filepath.Join(projectRoot, "data")
			if _, err := os.Stat(filepath.Join(dataDir, "skills.xml")); err != nil {
				dataDir = filepath.Join(exeDir, "..", "data")
			}
			gs.UserDB.ForceImportDataDocs(dataDir)
			gs.UserDB.CloseMySQL()
		}
		fmt.Println("data_docs 导入完成。")
		os.Exit(0)
	}

	// 初始化日志（控制台 + 运行目录 log 文件）
	logger.InitWithLogDir(filepath.Join(exeDir, "log"))
	if _, err := os.Stat(gmAdminPath); os.IsNotExist(err) {
		logger.Error(fmt.Sprintf("GM 页面未找到，请确保存在: %s", gmAdminPath))
	}

	// 启动前在控制台展示免责申明，未同意则直接退出（传 -y 可跳过）
	if !*skipDisclaimer && !confirmDisclaimerInConsole() {
		fmt.Println("未同意免责申明，服务器不会启动。")
		os.Exit(0)
	}

	// 从 res_path.json 读取配置（含各服务可选独立 IP）
	startCfg, _ := readResPathConfig(resPathConfigPath)
	skipInteractive := !*configPrompt && resPathConfigComplete(startCfg)

	var publicIP string
	var gamePort, resPort, resPort80, loginPort, loginIPPort, gmPort int
	var resDir string

	if skipInteractive {
		fmt.Println("============================================================")
		fmt.Println("已从 res_path.json 加载完整配置，跳过 IP、端口与资源目录交互。")
		fmt.Println("如需在控制台重新配置，请使用启动参数: -config-prompt")
		fmt.Println("============================================================")
		publicIP = strings.TrimSpace(startCfg.PublicIP)
		if publicIP == "" {
			publicIP = "127.0.0.1"
		}
		gamePort = portOrDefault(startCfg.GamePort, 5000)
		resPort = portOrDefault(startCfg.ResPort, 32400)
		resPort80 = portOrDefault(startCfg.ResPort80, 8088)
		loginPort = portOrDefault(startCfg.LoginPort, 1863)
		loginIPPort = portOrDefault(startCfg.LoginIPPort, 32401)
		gmPort = portOrDefault(startCfg.GMPort, 8080)
		abs, err := filepath.Abs(strings.TrimSpace(startCfg.ResDir))
		if err != nil {
			fmt.Println("res_path.json 中 ResDir 无效:", err)
			os.Exit(1)
		}
		resDir = abs
	} else {
		publicIP = promptPublicIP(startCfg.PublicIP)
		gamePort = promptPort("游戏服务器（TCP）", portOrDefault(startCfg.GamePort, 5000))
		resPort = promptPort("资源服务器（HTTP 静态）", portOrDefault(startCfg.ResPort, 32400))
		resPort80 = promptPort("资源服务器备用 HTTP 端口", portOrDefault(startCfg.ResPort80, 8088))
		loginPort = promptPort("登录服务器（TCP）", portOrDefault(startCfg.LoginPort, 1863))
		loginIPPort = promptPort("登录 IP 服务器（HTTP）", portOrDefault(startCfg.LoginIPPort, 32401))
		gmPort = promptPort("GM 管理后台（HTTP）", portOrDefault(startCfg.GMPort, 8080))
		resDir = resolveResDir(defaultResDir, startCfg.ResDir)
	}

	startCfg.ResDir = resDir
	startCfg.PublicIP = publicIP
	startCfg.GamePort = gamePort
	startCfg.ResPort = resPort
	startCfg.ResPort80 = resPort80
	startCfg.LoginPort = loginPort
	startCfg.LoginIPPort = loginIPPort
	startCfg.GMPort = gmPort

	gameIP := resolveServiceIP(startCfg, startCfg.GameIP)
	resIP := resolveServiceIP(startCfg, startCfg.ResIP)
	loginTCPIP := resolveServiceIP(startCfg, startCfg.LoginTCPIP)
	loginHTTPIP := resolveServiceIP(startCfg, startCfg.LoginHTTPIP)
	gmIP := resolveServiceIP(startCfg, startCfg.GMIP)
	_ = resolveServiceIP(startCfg, startCfg.ResPort80IP)

	gameserver.SetPublicIP(gameIP)
	handlers.SetResourceBaseURL("http://" + resIP + ":" + strconv.Itoa(resPort))

	if err := saveResPathConfig(resPathConfigPath, startCfg); err != nil {
		fmt.Println("警告: 无法保存 res_path.json:", err)
	} else {
		savedAbs, _ := filepath.Abs(resPathConfigPath)
		fmt.Println("已将自定义 IP、端口与资源目录保存到文件:", savedAbs)
		logger.Info(fmt.Sprintf("运行配置（res_path.json）已写入: %s", savedAbs))
	}

	logger.Info(fmt.Sprintf("项目根目录: %s", projectRoot))
	logger.Info(fmt.Sprintf("GM 网页目录: %s", gmDir))
	logger.Info(fmt.Sprintf("资源目录 gameres: %s", resDir))
	logger.Info(fmt.Sprintf("游戏入口 gameres_proxy: %s", resProxyDir))

	// 配置数据库（默认 MySQL：127.0.0.1 库 seer 用户 seer 密码 abc.123；可通过环境变量 MYSQL_HOST/MYSQL_PORT/MYSQL_DATABASE/MYSQL_USER/MYSQL_PASSWORD 覆盖）
	mysqlHost := os.Getenv("MYSQL_HOST")
	if mysqlHost == "" {
		mysqlHost = "127.0.0.1"
	}
	mysqlPort := 3306
	if p := os.Getenv("MYSQL_PORT"); p != "" {
		if i, err := strconv.Atoi(p); err == nil {
			mysqlPort = i
		}
	}
	mysqlDatabase := os.Getenv("MYSQL_DATABASE")
	if mysqlDatabase == "" {
		mysqlDatabase = "seer"
	}
	mysqlUser := os.Getenv("MYSQL_USER")
	if mysqlUser == "" {
		mysqlUser = "seer"
	}
	mysqlPassword := os.Getenv("MYSQL_PASSWORD")
	if mysqlPassword == "" {
		mysqlPassword = "abc.123"
	}
	dbConfig := userdb.Config{
		LocalServerMode:   true,
		UseMySQL:         true,
		DBPath:           usersJSON,
		OfflineConfigDir: exeDir, // 未连接数据库时 GM 配置写入运行目录，下次连上后自动同步到 DB
		MySQLConfig: userdb.MySQLConfig{
			Host:     mysqlHost,
			Port:     mysqlPort,
			Database: mysqlDatabase,
			User:     mysqlUser,
			Password: mysqlPassword,
		},
	}

	// 创建游戏服务器
	gs := gameserver.New(dbConfig)

	// 启用 MySQL 且存在 users.json 时，将原有账号数据导入数据库（导入成功后重命名为 users.json.imported）
	if dbConfig.UseMySQL {
		if gs.UserDB != nil && gs.UserDB.UseMySQL() {
			if _, err := os.Stat(usersJSON); err == nil {
				importedAccounts, importedGameData, err := gs.UserDB.ImportFromFile(usersJSON, filepath.Join(filepath.Dir(usersJSON), "users.json.imported"))
				if err != nil {
					logger.Error(fmt.Sprintf("从 users.json 导入 MySQL 失败: %v", err))
				} else if importedAccounts > 0 || importedGameData > 0 {
					logger.Info(fmt.Sprintf("已从 users.json 导入: 账号 %d 个，玩家数据 %d 条", importedAccounts, importedGameData))
				}
			}
		}
		// 将 data/items.xml、data/skills.xml、data/spt.xml 导入 data_docs 表（仅当库中尚无或内容很短时），供技能/精灵/道具从数据库读取
		dataDir := filepath.Join(projectRoot, "data")
		if _, err := os.Stat(filepath.Join(dataDir, "skills.xml")); err != nil {
			dataDir = filepath.Join(exeDir, "..", "data")
		}
		_ = gs.UserDB.EnsureDataDocsImported(dataDir)
		udb := gs.UserDB
		skills.SetContentProvider(func() ([]byte, error) {
			s, e := udb.GetDataDoc("skills.xml")
			return []byte(s), e
		})
		pets.SetContentProvider(func() ([]byte, error) {
			s, e := udb.GetDataDoc("spt.xml")
			return []byte(s), e
		})
		handlers.SetItemContentProvider(func() ([]byte, error) {
			s, e := udb.GetDataDoc("items.xml")
			return []byte(s), e
		})
	}
	// 权重配置：启用 MySQL 时从数据库读写，否则从 weights_config.json
	if dbConfig.UseMySQL && gs.UserDB != nil {
		handlers.SetWeightsPersistence(gs.UserDB)
		handlers.SetFusionRulesPersistence(gs.UserDB)
		handlers.SetFreshFightPersistence(gs.UserDB)
		handlers.SetFightLevelPersistence(gs.UserDB)
		handlers.SetMapConfigsPersistence(gs.UserDB)
		handlers.SetGachaPersistence(gs.UserDB)
		handlers.SetDarkPortalPersistence(gs.UserDB)
		handlers.SetSPTBossPersistence(gs.UserDB)
		handlers.SetBossEffectPersistence(gs.UserDB)
	}
	handlers.LoadWeightsConfig()
	handlers.LoadFusionRulesConfig()
	handlers.LoadFreshFightConfig()
	handlers.LoadFightLevelConfig()
	handlers.LoadGMMapConfigsOnStart()
	handlers.LoadGachaRewards()
	handlers.LoadDarkPortalConfig()
	handlers.LoadSPTBossConfig()
	handlers.LoadBossEffectConfig()
	// 如果数据库中没有配置，从handlers.go中的默认配置初始化
	if len(handlers.GetDarkPortalConfig()) == 0 {
		handlers.InitDarkPortalConfigFromHandlers()
	}

	// 本想用 MySQL 但连接失败时：将当前配置保存到运行目录，下次启动若能连上数据库会自动同步到 DB
	if dbConfig.UseMySQL && gs.UserDB != nil && !gs.UserDB.UseMySQL() {
		logger.Info("数据库未连接，已将当前 GM 配置保存到运行目录；恢复连接后下次启动将自动同步到数据库")
		_ = handlers.SaveWeightsConfig()
		_ = handlers.SaveFusionRulesConfig(handlers.GetAllFusionRules())
		_ = handlers.SetFreshFightConfig(handlers.GetFreshFightConfig())
		_ = handlers.SetFightLevelConfig(handlers.GetFightLevelConfig())
		_ = handlers.SaveGMMapConfigsToPersistence()
		_ = handlers.SaveGachaRewards()
		_ = handlers.SetDarkPortalConfig(handlers.GetDarkPortalConfig())
		cfg := handlers.GetSPTBossConfig()
		_ = handlers.SetSPTBossConfig(&cfg)
	}

	// 注册命令处理器
	handlers.RegisterHandlers(gs)
	
	// 注册GM管理接口：先綁到 API mux，再用 GMAuthWrapper 包一層簡單登入驗證
	gmAPIMux := http.NewServeMux()
	handlers.RegisterGMHandlers(gmAPIMux, gs)
	protectedGMAPIMux := handlers.GMAuthWrapper(gmAPIMux)

	// 提供 GM 靜態頁面與 API：同一個 HTTP 服務上，同源避免 CORS 問題
	gmMux := http.NewServeMux()

	// GM API 統一走 /gm 前綴，交給帶驗證的 mux
	gmMux.Handle("/gm/", protectedGMAPIMux)
	gmMux.Handle("/gm", protectedGMAPIMux)

	// 提供GM管理面板HTML文件（使用基于 exe 的路径）
	gmMux.HandleFunc("/gm_panel.html", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, gmPanelPath)
	})
	gmMux.HandleFunc("/gm_admin.html", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, gmAdminPath)
	})
	gmLoginPath := filepath.Join(gmDir, "gm_login.html")
	gmMux.HandleFunc("/gm_login.html", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, gmLoginPath)
	})
	kysePath := filepath.Join(gmDir, "kyse.html")
	gmMux.HandleFunc("/kyse.html", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, kysePath)
	})
	gmMux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, "/gm_login.html", http.StatusFound)
	})

	// 启动GM管理HTTP服务器
	go func() {
		gmServer := &http.Server{
			Addr:    fmt.Sprintf(":%d", gmPort),
			Handler: gmMux,
		}
		logger.Info(fmt.Sprintf("GM管理面板启动在端口 %d", gmPort))
		logger.Info(fmt.Sprintf("访问 http://%s:%d 打开管理面板（本机监听所有网卡，客户端请用配置的 GMIP/PublicIP）", gmIP, gmPort))
		if err := gmServer.ListenAndServe(); err != nil {
			logger.Error(fmt.Sprintf("GM管理服务器启动失败: %v", err))
		}
	}()

	// 使用自訂端口啟動遊戲伺服器
	gs.Port = gamePort
	err := gs.Start()
	if err != nil {
		logger.Error(fmt.Sprintf("启动游戏服务器失败: %v", err))
		os.Exit(1)
	}

	// 创建并启动资源服务器（路径已按 exe 位置解析）
	resConfig := resserver.Config{
		ResPort:              resPort,
		ResPort80:            resPort80, // 原 80 需管理员权限，改为 8088 免权限
		ResDir:               resDir,
		ResProxyDir:          resProxyDir,
		ResOfficialAddress:   "https://seer.61.com",
		LocalServerMode:      true,
		UseOfficialResources: false,
		PureOfficialMode:     false,
		LoginPort:            loginIPPort,
		LoginServerAddress:   fmt.Sprintf("%s:%d", loginHTTPIP, loginIPPort),
		OfficialLoginServer:  "115.238.192.7",
		OfficialLoginPort:    9999,
		PublicIP:             publicIP,
		LoginHTTPIP:          startCfg.LoginHTTPIP,
		ResHTTPHostIP:        startCfg.ResIP,
		GameServerIP:         startCfg.GameIP,
		LoginTCPIP:           startCfg.LoginTCPIP,
		TCPLoginPort:         loginPort,
		GameServerPort:       gamePort,
	}

	resServer := resserver.New(resConfig)
	if err := resServer.Start(); err != nil {
		logger.Error(fmt.Sprintf("启动资源服务器失败: %v", err))
	}

	// 创建并启动登录IP服务器
	loginIPConfig := loginip.Config{
		LoginIPPort:         loginIPPort,
		LocalServerMode:     true,
		LoginPort:           loginPort,
		OfficialLoginServer: "115.238.192.7",
		OfficialLoginPort:   9999,
		PublicIP:            loginTCPIP,
	}

	loginIPServer := loginip.New(loginIPConfig)
	if err := loginIPServer.Start(); err != nil {
		logger.Error(fmt.Sprintf("启动登录IP服务器失败: %v", err))
	}

	// 创建并启动登录服务器
	loginConfig := loginserver.Config{
		LoginPort:       loginPort,
		ServerID:        1,
		GameServerPort:  gamePort,
		LocalServerMode: true,
		UserDBPath:      usersJSON,
		PublicIP:        gameIP,
	}

	loginServer := loginserver.New(loginConfig)
	if err := loginServer.Start(); err != nil {
		logger.Error(fmt.Sprintf("启动登录服务器失败: %v", err))
	}

	logger.Info("所有服务器已启动")

	// 等待中断信号
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)
	<-sigChan

	logger.Info("正在关闭服务器...")

	// 在关闭数据库连接前导出一次完整快照，并把 GM 配置表导出为 gm_*.json 到运行目录（供下次无数据库时读取）
	if gs != nil && gs.UserDB != nil {
	// 1) 导出逻辑视图快照（users + gameData）
		snapshotPath := filepath.Join(exeDir, "db_snapshot.json")
		if err := gs.UserDB.ExportSnapshotToFile(snapshotPath); err != nil {
			logger.Error(fmt.Sprintf("导出数据库快照失败: %v", err))
		} else {
			logger.Info(fmt.Sprintf("数据库快照已导出到: %s", snapshotPath))
		}

		// 2) 导出 GM 配置表为离线 gm_*.json（下次没启动数据库时可直接读取）
		gs.UserDB.ExportGMConfigsToOfflineFiles()

	// 关闭 MySQL 连接（若使用 MySQL）
	gs.UserDB.CloseMySQL()
	}
	// 停止所有服务器
	if resServer != nil {
		resServer.Stop()
	}
	if loginIPServer != nil {
		loginIPServer.Stop()
	}
	if loginServer != nil {
		loginServer.Stop()
	}

	logger.Info("服务器已关闭")
}

// confirmDisclaimerInConsole 在启动服务端前于控制台展示免责申明，并要求用户确认
// 返回 true 表示用户输入 Y 或 YES（不区分大小写）同意继续；否则返回 false
func confirmDisclaimerInConsole() bool {
	fmt.Println("============================================================")
	fmt.Println("                       免责申明")
	fmt.Println("============================================================")
	fmt.Println("本源码、软件仅为个人非商业学习、研究使用，")
	fmt.Println("基于公开技术逆向分析开发，")
	fmt.Println("严禁任何形式商用（含运营、收费、销售、转让等）。")
	fmt.Println()
	fmt.Println("使用者需遵守法律法规，自行承担使用风险；")
	fmt.Println("若违规商用或从事违法操作，")
	fmt.Println("一切法律责任由使用者自行承担，与开发方无关。")
	fmt.Println("============================================================")
	fmt.Print("请输入 Y 或 YES 表示已阅读并同意上述免责申明，然后回车（其他任意输入将退出）：")

	reader := bufio.NewReader(os.Stdin)
	line, err := reader.ReadString('\n')
	if err != nil {
		return false
	}
	line = strings.TrimSpace(line)
	line = strings.ToUpper(line)

	return line == "Y" || line == "YES"
}

// promptPublicIP 启动时提示用户输入对外暴露的服务器 IP；回车使用 savedDefault，若其为空则 127.0.0.1。
func promptPublicIP(savedDefault string) string {
	defaultIP := strings.TrimSpace(savedDefault)
	if defaultIP == "" {
		defaultIP = "127.0.0.1"
	}
	fmt.Println("============================================================")
	fmt.Println("                    设置服务器对外 IP")
	fmt.Println("============================================================")
	fmt.Printf("请输入客户端连接使用的服务器 IP（回车默认 %s）：", defaultIP)
	reader := bufio.NewReader(os.Stdin)
	line, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("读取输入失败，将使用默认 IP。")
		return defaultIP
	}
	line = strings.TrimSpace(line)
	if line == "" {
		fmt.Println("未输入，使用默认 IP:", defaultIP)
		return defaultIP
	}
	fmt.Println("已设置服务器对外 IP 为:", line)
	return line
}

// resPathConfig 保存在 exe 同目录的 res_path.json：资源目录、总 IP（PublicIP）、各端口及可选的分服务 IP（未填则回退到 PublicIP）。
type resPathConfig struct {
	ResDir   string `json:"ResDir,omitempty"`
	PublicIP string `json:"PublicIP,omitempty"`
	// 各服务独立对外 IP，可省略；省略时使用 PublicIP
	GameIP      string `json:"GameIP,omitempty"`
	ResIP       string `json:"ResIP,omitempty"`
	ResPort80IP string `json:"ResPort80IP,omitempty"`
	LoginTCPIP  string `json:"LoginTCPIP,omitempty"`
	LoginHTTPIP string `json:"LoginHTTPIP,omitempty"`
	GMIP        string `json:"GMIP,omitempty"`

	GamePort    int `json:"GamePort,omitempty"`
	ResPort     int `json:"ResPort,omitempty"`
	ResPort80   int `json:"ResPort80,omitempty"`
	LoginPort   int `json:"LoginPort,omitempty"`
	LoginIPPort int `json:"LoginIPPort,omitempty"`
	GMPort      int `json:"GMPort,omitempty"`
}

func readResPathConfig(path string) (resPathConfig, error) {
	var cfg resPathConfig
	data, err := os.ReadFile(path)
	if err != nil {
		return cfg, err
	}
	if err := json.Unmarshal(data, &cfg); err != nil {
		return cfg, err
	}
	return cfg, nil
}

// saveResPathConfig 将用户设置的 PublicIP、各端口、ResDir 及可选分服务 IP 写入可执行文件同目录下的 res_path.json（单文件，非目录）。
func saveResPathConfig(path string, cfg resPathConfig) error {
	abs, err := filepath.Abs(path)
	if err != nil {
		abs = path
	}
	data, err := json.MarshalIndent(cfg, "", "  ")
	if err != nil {
		return err
	}
	return os.WriteFile(abs, data, 0644)
}

// portOrDefault 若 p 为合法端口则返回 p，否则返回 def（用于读取 json 中未填写的 0）
func portOrDefault(p, def int) int {
	if p <= 0 || p > 65535 {
		return def
	}
	return p
}

// resPathConfigComplete 当 PublicIP 与有效 ResDir 均已写在 json 中时，可跳过控制台 IP/端口/资源目录交互（除非 -config-prompt）。
func resPathConfigComplete(cfg resPathConfig) bool {
	if strings.TrimSpace(cfg.PublicIP) == "" {
		return false
	}
	rd := strings.TrimSpace(cfg.ResDir)
	if rd == "" {
		return false
	}
	abs, err := filepath.Abs(rd)
	if err != nil {
		return false
	}
	st, err := os.Stat(abs)
	if err != nil || !st.IsDir() {
		return false
	}
	return true
}

// resolveServiceIP 返回 override（若已填写），否则返回 PublicIP，再否则 127.0.0.1。
func resolveServiceIP(cfg resPathConfig, override string) string {
	if s := strings.TrimSpace(override); s != "" {
		return s
	}
	if s := strings.TrimSpace(cfg.PublicIP); s != "" {
		return s
	}
	return "127.0.0.1"
}

// downloadResourcePackage 将远程资源包压缩文件 (gameres.rar) 下载到默认资源目录的上级目录（即 gameres 所在目录）。
func downloadResourcePackage(defaultResDir string) error {
	parentDir := filepath.Dir(defaultResDir) // .../gameres
	if err := os.MkdirAll(parentDir, 0755); err != nil {
		return fmt.Errorf("创建目录失败: %w", err)
	}
	rarPath := filepath.Join(parentDir, "gameres.rar")

	resp, err := http.Get(resourcePackageURL)
	if err != nil {
		return fmt.Errorf("下载请求失败: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("下载失败，HTTP 状态码: %d", resp.StatusCode)
	}

	total := resp.ContentLength
	if total > 0 {
		fmt.Printf("资源包大小：%.2f MB\n", float64(total)/1024.0/1024.0)
	} else {
		fmt.Println("资源包大小：未知（服务器未返回 Content-Length）")
	}

	// 直接写入最终文件路径（与资源目录同级）
	out, err := os.Create(rarPath)
	if err != nil {
		return fmt.Errorf("创建临时文件失败: %w", err)
	}

	defer out.Close()

	var downloaded int64
	start := time.Now()
	lastPrint := start
	buf := make([]byte, 32*1024)

	for {
		n, readErr := resp.Body.Read(buf)
		if n > 0 {
			if _, err := out.Write(buf[:n]); err != nil {
				return fmt.Errorf("写入文件失败: %w", err)
			}
			downloaded += int64(n)

			now := time.Now()
			if now.Sub(lastPrint) >= time.Second || (total > 0 && downloaded == total) {
				elapsed := now.Sub(start).Seconds()
				if elapsed <= 0 {
					elapsed = 0.000001
				}
				speedMB := float64(downloaded) / 1024.0 / 1024.0 / elapsed
				if total > 0 {
					percent := float64(downloaded) * 100.0 / float64(total)
					fmt.Printf("\r已下载 %.2f MB / %.2f MB (%.1f%%)，当前速度 %.2f MB/s",
						float64(downloaded)/1024.0/1024.0,
						float64(total)/1024.0/1024.0,
						percent, speedMB)
				} else {
					fmt.Printf("\r已下载 %.2f MB，当前速度 %.2f MB/s",
						float64(downloaded)/1024.0/1024.0,
						speedMB)
				}
				lastPrint = now
			}
		}

		if readErr == io.EOF {
			break
		}
		if readErr != nil {
			return fmt.Errorf("下载过程中出错: %w", readErr)
		}
	}
	fmt.Println()

	return nil
}

// ensureSevenZipRuntime 确保存在可用的 7z.exe，用于解压 .rar 资源包。
// 返回 7z.exe 的完整路径；若失败则返回错误。
func ensureSevenZipRuntime() (string, error) {
	// 1) 若系统 PATH 中已有 7z，直接使用
	if p, err := exec.LookPath("7z"); err == nil {
		return p, nil
	}

	// 2) 若程序目录下已有准备好的 7z.exe，直接使用
	exePath, _ := os.Executable()
	exeDir := filepath.Dir(exePath)
	runtimeDir := filepath.Join(exeDir, "7zip_runtime")
	sevenZipPath := filepath.Join(runtimeDir, "7z.exe")
	if info, err := os.Stat(sevenZipPath); err == nil && !info.IsDir() {
		return sevenZipPath, nil
	}

	// 3) 自动下载并解压 7-Zip Extra 包
	if err := os.MkdirAll(runtimeDir, 0755); err != nil {
		return "", fmt.Errorf("创建 7-Zip 运行时目录失败: %w", err)
	}

	miniPath := filepath.Join(runtimeDir, "7zr.exe")
	extraPath := filepath.Join(runtimeDir, "7z-extra.7z")

	// 下载 7zr.exe（仅当不存在时）
	if _, err := os.Stat(miniPath); os.IsNotExist(err) {
		fmt.Println("正在下载 7-Zip 精简运行时（7zr.exe），用于自动解压资源包...")
		if err := downloadFileSimple(sevenZipMiniURL, miniPath); err != nil {
			return "", fmt.Errorf("下载 7zr.exe 失败: %w", err)
		}
	}

	// 下载 7z Extra 包（仅当不存在时）
	if _, err := os.Stat(extraPath); os.IsNotExist(err) {
		fmt.Println("正在下载 7-Zip 扩展包，用于提供 7z.exe...")
		if err := downloadFileSimple(sevenZipExtraURL, extraPath); err != nil {
			return "", fmt.Errorf("下载 7-Zip 扩展包失败: %w", err)
		}
	}

	// 使用 7zr.exe 解压 7z-extra.7z 到 runtimeDir
	fmt.Println("正在解压 7-Zip 扩展包以准备 7z.exe...")
	cmd := exec.Command(miniPath, "x", "-y", extraPath, "-o"+runtimeDir)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		return "", fmt.Errorf("解压 7-Zip 扩展包失败: %w", err)
	}

	if info, err := os.Stat(sevenZipPath); err == nil && !info.IsDir() {
		return sevenZipPath, nil
	}

	return "", fmt.Errorf("未能在 %s 中找到 7z.exe", runtimeDir)
}

// downloadFileSimple 将指定 URL 的内容简单下载到本地文件（无进度显示，用于下载 7-Zip 运行时）。
func downloadFileSimple(url, path string) error {
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("HTTP 状态码 %d", resp.StatusCode)
	}

	out, err := os.Create(path)
	if err != nil {
		return err
	}
	defer out.Close()

	if _, err := io.Copy(out, resp.Body); err != nil {
		return err
	}
	return nil
}

// extractResourcePackage 解压默认目录上级中的 gameres.rar 到该目录下。
// 优先使用自动准备好的 7-Zip 运行时；若准备失败，再尝试系统自带的 7z/unrar；若均失败，则提示用户手动解压。
func extractResourcePackage(defaultResDir string) error {
	parentDir := filepath.Dir(defaultResDir) // .../gameres
	rarPath := filepath.Join(parentDir, "gameres.rar")

	run := func(name string, args ...string) error {
		cmd := exec.Command(name, args...)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		return cmd.Run()
	}

	// 1) 优先尝试使用自动准备好的 7-Zip 运行时
	if sevenZipPath, err := ensureSevenZipRuntime(); err == nil {
		if err := run(sevenZipPath, "x", "-y", rarPath, "-o"+parentDir); err == nil {
			return nil
		}
	} else {
		fmt.Println("自动准备 7-Zip 运行时失败，将尝试系统环境中的 7z/unrar。错误信息：", err)
	}

	// 2) 尝试系统 PATH 中的 7z
	if err := run("7z", "x", "-y", rarPath, "-o"+parentDir); err == nil {
		return nil
	}

	// 3) 尝试系统 PATH 中的 unrar
	if err := run("unrar", "x", "-y", rarPath, parentDir); err == nil {
		return nil
	}

	return fmt.Errorf("自动解压失败：未能使用内置 7-Zip 运行时或系统 7z/UnRAR，请手动将 %s 解压到目录 %s", rarPath, parentDir)
}

// resolveResDir 若 savedResDir 有效则直接使用；否则交互式选择资源目录（不写文件，由 main 统一保存 res_path.json）。
// 首次运行时增加一个选项：直接从远程地址下载资源包压缩包（gameres.rar）到默认目录并自动解压。
func resolveResDir(defaultResDir, savedResDir string) (resDir string) {
	resDir = defaultResDir

	if strings.TrimSpace(savedResDir) != "" {
		abs, _ := filepath.Abs(strings.TrimSpace(savedResDir))
		if info, err := os.Stat(abs); err == nil && info.IsDir() {
			fmt.Println("已从 res_path.json 使用资源目录:", abs)
			return abs
		}
	}

	defAbs, _ := filepath.Abs(defaultResDir)

	// 首次运行或配置无效：提供选项（1 手动输入本地路径，2 自动下载并解压资源包压缩包）
	fmt.Println("============================================================")
	fmt.Println("                    首次运行 - 设置资源目录")
	fmt.Println("============================================================")
	reader := bufio.NewReader(os.Stdin)
	fmt.Printf("默认资源目录（推荐解压到此处）: %s\n", defAbs)
	fmt.Println("请选择资源包来源：")
	fmt.Println("  1) 手动输入本地资源目录路径（指向 gameres/root）")
	fmt.Println("  2) 直接从远程地址下载资源包压缩包 (gameres.rar) 到默认目录并自动解压，然后使用解压后的资源目录")
	fmt.Print("请输入选项 [1/2]，回车默认为 1：")
	choiceLine, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("读取输入失败:", err)
		os.Exit(1)
	}
	choice := strings.TrimSpace(strings.ToUpper(choiceLine))
	if choice == "2" {
		fmt.Println("将从远程服务器下载资源包压缩包（gameres.rar）。")
		fmt.Println("请确保当前网络可以访问该地址，开始下载并解压...")
		if err := downloadResourcePackage(defAbs); err != nil {
			fmt.Println("下载资源包失败:", err)
			fmt.Println("将转为手动选择本地资源目录。")
			goto manualInput
		}
		if err := extractResourcePackage(defAbs); err != nil {
			fmt.Println("解压资源包失败:", err)
			fmt.Println("将转为手动选择本地资源目录。")
			goto manualInput
		}

		if info, err := os.Stat(defAbs); err != nil || !info.IsDir() {
			fmt.Println("已下载并解压资源包，但未找到预期的资源目录：", defAbs)
			fmt.Println("将转为手动选择本地资源目录。")
			goto manualInput
		}

		fmt.Println("资源包已下载并解压，资源目录已配置为:", defAbs)
		return defAbs
	}

	// 选项 1：手动输入本地资源目录路径
manualInput:
	fmt.Print("请输入资源目录的完整路径（指向 gameres/root 或包含游戏资源的文件夹）：")
	line, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("读取输入失败:", err)
		os.Exit(1)
	}
	line = strings.TrimSpace(line)
	if line == "" {
		fmt.Println("未输入路径，将使用默认路径。")
		return defAbs
	}
	abs, err := filepath.Abs(line)
	if err != nil {
		fmt.Println("路径无效:", err)
		os.Exit(1)
	}
	info, err := os.Stat(abs)
	if err != nil {
		fmt.Println("路径不存在或无法访问:", err)
		os.Exit(1)
	}
	if !info.IsDir() {
		fmt.Println("该路径不是文件夹，请指定一个目录。")
		os.Exit(1)
	}

	fmt.Println("将使用资源目录:", abs)
	return abs
}

// promptPort 在启动时提示输入端口；留空则使用默认值
func promptPort(label string, defaultPort int) int {
	fmt.Println("============================================================")
	fmt.Printf("请输入 %s 端口（回车默认 %d）：", label, defaultPort)
	reader := bufio.NewReader(os.Stdin)
	line, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("读取输入失败，将使用默认端口。")
		return defaultPort
	}
	line = strings.TrimSpace(line)
	if line == "" {
		fmt.Println("未输入，使用默认端口：", defaultPort)
		return defaultPort
	}
	p, err := strconv.Atoi(line)
	if err != nil || p <= 0 || p > 65535 {
		fmt.Println("端口不合法，将使用默认端口。")
		return defaultPort
	}
	fmt.Printf("已设置 %s 端口为：%d\n", label, p)
	return p
}
