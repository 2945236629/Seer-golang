package handlers

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"os"
	"path/filepath"
	"sort"
	"time"

	"github.com/seer-game/golang-version/internal/core/logger"
	"github.com/seer-game/golang-version/internal/core/userdb"
)

// defaultTaskConfigJSON 內嵌的任務獎勵默認配置（來源於原 test/gm_task_config.json）
const defaultTaskConfigJSON = `[
{"taskId":2,"name":"新手任务","type":"novice","rewards":{}},
{"taskId":3,"name":"新手任务","type":"novice","rewards":{}},
{"taskId":4,"name":"新手任务","type":"novice","rewards":{}},
{"taskId":85,"name":"新手礼物","rewards":{"items":[{"itemId":100027,"count":1},{"itemId":100028,"count":1},{"itemId":500001,"count":1},{"itemId":300650,"count":3},{"itemId":300025,"count":3},{"itemId":300035,"count":3},{"itemId":500502,"count":1},{"itemId":500503,"count":1}]}},
{"taskId":86,"name":"初次伙伴","type":"select_pet","paramMap":{"1":1,"2":7,"3":4},"rewards":{}},
{"taskId":87,"name":"初试身手","rewards":{"items":[{"itemId":300001,"count":5},{"itemId":300011,"count":3}]}},
{"taskId":88,"name":"治愈伤痛","rewards":{"coins":50000,"special":[{"type":3,"value":250000},{"type":5,"value":20}]}},
{"taskId":7,"name":"防寒套装制作","rewards":{"items":[{"itemId":400052,"count":1}]}},
{"taskId":8,"name":"西塔的珍贵回忆","rewards":{"fitments":[{"fitmentId":500510,"count":1}]}},
{"taskId":9,"name":"进入神秘通道","rewards":{"items":[{"itemId":100059,"count":1}]}},
{"taskId":10,"name":"神秘通道拼图","rewards":{}},
{"taskId":11,"name":"捕捉到果冻鸭","rewards":{}},
{"taskId":12,"name":"精灵广场拿石头","rewards":{}},
{"taskId":13,"name":"救咚咚","rewards":{}},
{"taskId":14,"name":"救叮叮","rewards":{}},
{"taskId":15,"name":"奇洛","rewards":{"pets":[{"petId":56,"level":1,"dv":0,"nature":0}]}},
{"taskId":19,"name":"先锋队招募","rewards":{"pets":[{"petId":46,"level":1,"dv":0,"nature":0}]}},
{"taskId":25,"name":"新船员的考验","rewards":{}},
{"taskId":28,"name":"遗迹中的精灵信号","rewards":{"pets":[{"petId":102,"level":1,"dv":0,"nature":0}]}},
{"taskId":29,"name":"健忘的大发明家","rewards":{}},
{"taskId":30,"name":"发明家的小测试","rewards":{}},
{"taskId":37,"name":"帕诺星系星球测绘","rewards":{"coins":3000,"items":[{"itemId":100178,"count":1},{"itemId":100179,"count":1},{"itemId":100180,"count":1},{"itemId":100181,"count":1},{"itemId":700452,"count":1}]}},
{"taskId":42,"name":"卡塔","rewards":{"coins":3000,"fitments":[{"fitmentId":500570,"count":1}],"pets":[{"petId":143,"level":1,"dv":0,"nature":0}]}},
{"taskId":79,"name":"寻访哈莫雷特的族人","rewards":{"coins":2000,"special":[{"type":3,"value":3000}]}},
{"taskId":81,"name":"守候宿命的追随者","rewards":{"coins":1000,"special":[{"type":3,"value":1000}]}},
{"taskId":83,"name":"光暗之谜","rewards":{"coins":1000,"special":[{"type":3,"value":1000}]}},
{"taskId":84,"name":"星球改造计划","rewards":{"coins":2000,"special":[{"type":3,"value":2000}]}},
{"taskId":89,"name":"试炼之塔的磨练","rewards":{"coins":1000,"special":[{"type":3,"value":500}]}},
{"taskId":90,"name":"克洛斯星的皮皮","rewards":{"coins":1000,"special":[{"type":3,"value":1000}]}},
{"taskId":91,"name":"月光下的约定","rewards":{"coins":2000,"items":[{"itemId":400124,"count":1}],"special":[{"type":3,"value":2000}]}},
{"taskId":92,"name":"站长归来","rewards":{"coins":2000,"special":[{"type":3,"value":2000}],"pets":[{"petId":95,"level":1,"dv":0,"nature":0}]}},
{"taskId":93,"name":"云霄星的新来客","rewards":{"coins":500,"special":[{"type":3,"value":1000}]}},
{"taskId":94,"name":"初识星球能源","type":"get_item","targetItemId":100014,"rewards":{"coins":2000,"special":[{"type":3,"value":500}]}},
{"taskId":95,"name":"宇宙中的黑色旋涡","rewards":{"coins":2000,"items":[{"itemId":100346,"count":1},{"itemId":100347,"count":1},{"itemId":100348,"count":1},{"itemId":100349,"count":1}],"special":[{"type":3,"value":4000}]}},
{"taskId":96,"name":"伙伴","rewards":{"coins":1000,"special":[{"type":3,"value":500}]}},
{"taskId":97,"name":"我是音乐小麦霸","rewards":{"coins":1000,"special":[{"type":3,"value":1000}]}},
{"taskId":98,"name":"尼布守卫战","rewards":{"coins":1000,"special":[{"type":3,"value":2000}],"pets":[{"petId":95,"level":1,"dv":0,"nature":0}]}},
{"taskId":99,"name":"盖亚","rewards":{"items":[{"itemId":400126,"count":1}]}},
{"taskId":121,"name":"雷神极限修行之里奥斯","rewards":{}},
{"taskId":122,"name":"雷神极限修行之提亚斯","rewards":{}},
{"taskId":123,"name":"繁殖任务","rewards":{}},
{"taskId":133,"name":"寻找迷失的心","rewards":{}},
{"taskId":201,"name":"教官考核","rewards":{}},
{"taskId":300,"name":"领普尼真身","rewards":{}},
{"taskId":301,"name":"先锋队-蘑菇怪","rewards":{"pets":[{"petId":46,"level":1,"dv":0,"nature":0}]}},
{"taskId":401,"name":"每日任务之毛毛","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":402,"name":"每日任务之小火猴武学梦想","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":403,"name":"布布种子每日任务","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":404,"name":"每日任务之伊优环保任务","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":405,"name":"每日任务之比比鼠的发电能源","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":406,"name":"每日任务之爱捉迷藏的幽浮","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":407,"name":"利牙鱼的口腔护理","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":461,"name":"领NoNo","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":462,"name":"每日任务之领取扭蛋牌","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":463,"name":"斯诺星的米鲁","type":"daily","rewards":{"special":[{"type":3,"value":3000}],"pets":[{"petId":161,"level":1,"dv":0,"nature":0}]}},
{"taskId":481,"name":"每日任务之赛尔打工","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}},
{"taskId":50001,"name":"赛尔召集令","type":"client_only","rewards":{}},
{"taskId":50002,"name":"教官任务","type":"client_only","rewards":{}}
]`

// TaskRewardItem 基礎物品獎勵
type TaskRewardItem struct {
	ItemID int `json:"itemId"`
	Count  int `json:"count"`
}

// TaskRewardPet 精靈獎勵
type TaskRewardPet struct {
	PetID  int `json:"petId"`
	Level  int `json:"level"`
	DV     int `json:"dv"`
	Nature int `json:"nature"`
}

// TaskRewardFitment 家具獎勵
type TaskRewardFitment struct {
	FitmentID int `json:"fitmentId"`
	Count     int `json:"count"`
}

// TaskRewardSpecial 特殊獎勵（對應原協議中用 itemID 表示的特殊類型）
// 常見類型：
//   1: 金幣（Coins）
//   2: 金豆（Gold）
//   3: 積累經驗（ExpPool）
//   5: 其他自定義值
type TaskRewardSpecial struct {
	Type  int `json:"type"`
	Value int `json:"value"`
}

// TaskRewards 一個任務的完整獎勵配置
type TaskRewards struct {
	Coins    int                `json:"coins,omitempty"`
	Items    []TaskRewardItem   `json:"items,omitempty"`
	Pets     []TaskRewardPet    `json:"pets,omitempty"`
	Fitments []TaskRewardFitment `json:"fitments,omitempty"`
	Special  []TaskRewardSpecial `json:"special,omitempty"`
}

// TaskConfigEntry 任務獎勵配置條目，對齊 test/gm_task_config.json 結構
type TaskConfigEntry struct {
	TaskID      int               `json:"taskId"`
	Name        string            `json:"name"`
	Type        string            `json:"type,omitempty"`
	ParamMap    map[string]int    `json:"paramMap,omitempty"`
	TargetItemID int              `json:"targetItemId,omitempty"`
	Rewards     TaskRewards       `json:"rewards"`
}

// TaskConfigPersistence 任務配置持久化介面，由 *userdb.UserDB 實作
type TaskConfigPersistence interface {
	LoadTaskConfig() ([]byte, error)
	SaveTaskConfig(data []byte) error
}

var (
	taskConfig     []TaskConfigEntry
	taskConfigByID = make(map[int]TaskConfigEntry)

	taskConfigPersistence TaskConfigPersistence
)

// SetTaskConfigPersistence 設定任務配置的持久化實作（一般由 *userdb.UserDB 提供）
func SetTaskConfigPersistence(p TaskConfigPersistence) {
	taskConfigPersistence = p
}

// LoadTaskConfig 從持久化層讀取並初始化任務配置；若持久化中沒有任何配置，則嘗試從本地默認文件(test/gm_task_config.json)加載並寫回。
func LoadTaskConfig() {
	// 1. 若沒有持久化實現，僅從本地默認文件加載到內存
	if taskConfigPersistence == nil {
		if list := loadDefaultTaskConfigFromLocal(); list != nil {
			setTaskConfigInternal(list)
			logger.Info(fmt.Sprintf("[任務獎勵] 使用本地默認任務配置，條目數=%d", len(taskConfig)))
		}
		return
	}

	data, err := taskConfigPersistence.LoadTaskConfig()
	if err != nil || len(data) == 0 {
		if err != nil {
			logger.Warning("[任務獎勵] 從持久化層載入失敗: " + err.Error())
		} else {
			logger.Info("[任務獎勵] 持久化層暫無任務配置，將嘗試載入本地默認配置")
		}
		// 2. 持久化中沒有數據時，嘗試從本地默認文件初始化，並寫回持久化層
		if list := loadDefaultTaskConfigFromLocal(); list != nil {
			if errSet := SetTaskConfig(list); errSet != nil {
				logger.Warning("[任務獎勵] 寫回默認任務配置失敗: " + errSet.Error())
			} else {
				logger.Info(fmt.Sprintf("[任務獎勵] 已從本地默認文件初始化並保存任務配置，條目數=%d", len(taskConfig)))
			}
		}
		return
	}

	var list []TaskConfigEntry
	if err := json.Unmarshal(data, &list); err != nil {
		logger.Warning("[任務獎勵] 配置 JSON 解析失敗: " + err.Error())
		return
	}

	// 若持久化中存在記錄但為空列表，視為「尚未初始化」，同樣嘗試使用本地默認配置覆蓋
	if len(list) == 0 {
		logger.Info("[任務獎勵] 持久化中任務配置為空列表，將嘗試使用本地默認配置覆蓋")
		if def := loadDefaultTaskConfigFromLocal(); def != nil {
			if errSet := SetTaskConfig(def); errSet != nil {
				logger.Warning("[任務獎勵] 覆蓋空列表為默認配置失敗: " + errSet.Error())
			} else {
				logger.Info(fmt.Sprintf("[任務獎勵] 已用本地默認配置覆蓋空列表，條目數=%d", len(taskConfig)))
			}
		}
		return
	}

	setTaskConfigInternal(list)
	logger.Info(fmt.Sprintf("[任務獎勵] 已載入任務配置，條目數=%d", len(taskConfig)))
}

// SetTaskConfig 更新配置並持久化（供 GM API 調用）
func SetTaskConfig(list []TaskConfigEntry) error {
	setTaskConfigInternal(list)

	if taskConfigPersistence == nil {
		return nil
	}
	data, err := json.Marshal(taskConfig)
	if err != nil {
		return err
	}
	return taskConfigPersistence.SaveTaskConfig(data)
}

// setTaskConfigInternal 僅更新記憶體中的任務配置
func setTaskConfigInternal(list []TaskConfigEntry) {
	// 規範化：過濾非法 taskId，排序方便瀏覽
	tmp := make([]TaskConfigEntry, 0, len(list))
	m := make(map[int]TaskConfigEntry)
	for _, e := range list {
		if e.TaskID <= 0 {
			continue
		}
		tmp = append(tmp, e)
		m[e.TaskID] = e
	}
	sort.Slice(tmp, func(i, j int) bool {
		return tmp[i].TaskID < tmp[j].TaskID
	})

	taskConfig = tmp
	taskConfigByID = m
}

// loadDefaultTaskConfigFromLocal 嘗試從本地默認 JSON 文件載入任務配置（僅在 DB/文件中沒有配置時使用）
func loadDefaultTaskConfigFromLocal() []TaskConfigEntry {
	// 1. 優先嘗試使用內嵌默認 JSON
	if len(defaultTaskConfigJSON) > 0 {
		var list []TaskConfigEntry
		if err := json.Unmarshal([]byte(defaultTaskConfigJSON), &list); err == nil && len(list) > 0 {
			logger.Info(fmt.Sprintf("[任務獎勵] 使用內嵌默認任務配置，條目數=%d", len(list)))
			return list
		}
	}

	// 2. 其次嘗試從本地文件讀取（方便你自定義覆蓋）
	candidates := []string{}
	if exePath, err := os.Executable(); err == nil {
		exeDir := filepath.Dir(exePath)
		candidates = append(candidates,
			filepath.Join(exeDir, "test", "gm_task_config.json"),
			filepath.Join(exeDir, "..", "test", "gm_task_config.json"),
		)
	}
	// 也嘗試當前工作目錄相對路徑
	candidates = append(candidates,
		filepath.Join("test", "gm_task_config.json"),
		"gm_task_config.json",
	)

	for _, p := range candidates {
		data, err := os.ReadFile(p)
		if err != nil || len(data) == 0 {
			continue
		}
		var list []TaskConfigEntry
		if err := json.Unmarshal(data, &list); err != nil {
			continue
		}
		if len(list) == 0 {
			continue
		}
		logger.Info(fmt.Sprintf("[任務獎勵] 已從本地默認文件載入任務配置: %s (條目數=%d)", p, len(list)))
		return list
	}
	logger.Warning("[任務獎勵] 未找到本地默認任務配置文件 gm_task_config.json")
	return nil
}

// GetTaskConfig 返回全部任務配置副本（供 GM 前端展示）
func GetTaskConfig() []TaskConfigEntry {
	out := make([]TaskConfigEntry, len(taskConfig))
	copy(out, taskConfig)
	return out
}

// GetTaskConfigByID 根據任務 ID 取得配置；若不存在則 ok=false
func GetTaskConfigByID(taskID int) (TaskConfigEntry, bool) {
	e, ok := taskConfigByID[taskID]
	return e, ok
}

// ApplyTaskRewards 根據 TaskRewards 對指定玩家資料施加獎勵，同時構造 NoviceFinishInfo 中需要的 itemRewards。
// 傳回值：
//   petID/captureTm：若 Rewards 中包含寵物獎勵，則回傳第一只寵物的 ID 與生成的 catchTime，否則為 0。
//   itemRewards：包含普通物品與特殊類型（1=金幣、3=經驗、5=其他）條目，供 buildTaskCompleteResponse 序列化。
func ApplyTaskRewards(user *userdb.GameData, rewards TaskRewards, logPrefix string) (petID, captureTm uint32, itemRewards []struct {
	id    uint32
	count uint32
}) {
	if user == nil {
		return 0, 0, nil
	}
	if user.Items == nil {
		user.Items = make(map[string]userdb.Item)
	}

	// 金幣
	if rewards.Coins > 0 {
		if user.Coins < 0 {
			user.Coins = 0
		}
		user.Coins += rewards.Coins
		itemRewards = append(itemRewards, struct {
			id    uint32
			count uint32
		}{id: 1, count: uint32(rewards.Coins)})
	}

	// 一般物品
	for _, it := range rewards.Items {
		if it.ItemID <= 0 || it.Count == 0 {
			continue
		}
		key := fmt.Sprintf("%d", it.ItemID)
		existing := user.Items[key]
		existing.Count += it.Count
		if existing.ExpireTime == 0 {
			existing.ExpireTime = 0x057E40
		}
		user.Items[key] = existing
		itemRewards = append(itemRewards, struct {
			id    uint32
			count uint32
		}{id: uint32(it.ItemID), count: uint32(it.Count)})
	}

	// 家具：目前僅簡單加入 AllFitments，具體擺放由玩家自行處理
	for _, f := range rewards.Fitments {
		if f.FitmentID <= 0 || f.Count <= 0 {
			continue
		}
		for i := 0; i < f.Count; i++ {
			user.AllFitments = append(user.AllFitments, userdb.Fitment{ID: f.FitmentID})
		}
	}

	// 特殊獎勵
	for _, sp := range rewards.Special {
		if sp.Value <= 0 {
			continue
		}
		switch sp.Type {
		case 1: // 金幣
			if user.Coins < 0 {
				user.Coins = 0
			}
			user.Coins += sp.Value
		case 2: // 金豆
			if user.Gold < 0 {
				user.Gold = 0
			}
			user.Gold += sp.Value
		case 3: // 積累經驗
			if user.ExpPool < 0 {
				user.ExpPool = 0
			}
			user.ExpPool += sp.Value
		default:
			// 其他類型暫不直接改寫 GameData，只透過協議通知客戶端
		}
		itemRewards = append(itemRewards, struct {
			id    uint32
			count uint32
		}{id: uint32(sp.Type), count: uint32(sp.Value)})
	}

	// 寵物獎勵：目前取配置中的第一只作為 NoviceFinishInfo 的 petID/captureTm
	if len(rewards.Pets) > 0 {
		p := rewards.Pets[0]
		if p.PetID > 0 {
			petID = uint32(p.PetID)
			if p.Level <= 0 {
				p.Level = 1
			}
			if p.Level > 100 {
				p.Level = 100
			}
			if p.DV < 0 {
				p.DV = 0
			}
			if p.DV > 31 {
				p.DV = 31
			}
			if p.Nature < 0 {
				p.Nature = 0
			}
			if p.Nature > 24 {
				p.Nature = 24
			}
			// 若未在配置中显式指定个体/性格（默认为 0），则随机生成
			rand.Seed(time.Now().UnixNano())
			dv := p.DV
			nature := p.Nature
			if dv == 0 {
				dv = rand.Intn(32) // 0-31
			}
			if nature == 0 {
				nature = rand.Intn(25) // 0-24
			}
			// 使用任務類型固定前綴 + petID 作為唯一 catchTime（任務獎勵不強制與官方一致）
			captureTm = uint32(petID) + 0x70000000
			newPet := userdb.Pet{
				ID:        int(petID),
				CatchTime: int(captureTm),
				Level:     p.Level,
				DV:        dv,
				Nature:    nature,
				Exp:       0,
				Name:      "",
			}
			user.Pets = append(user.Pets, newPet)
			logger.Info(fmt.Sprintf("%s 任務獎勵發放精靈: PetID=%d Level=%d DV=%d Nature=%d", logPrefix, petID, p.Level, dv, nature))
		}
	}

	return petID, captureTm, itemRewards
}

