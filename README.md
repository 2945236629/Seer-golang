# 賽爾號 Go 服務端

賽爾號私服 Go 語言實作，包含遊戲伺服器、登入伺服器、資源伺服器與 GM 管理後台。

## 專案結構

```
d:\go\
├── cmd/
│   └── gameserver/
│       └── main.go              # 主程式入口
├── internal/
│   ├── core/                    # 核心基礎設施
│   │   ├── logger/              # 日誌
│   │   ├── packet/              # 封包編解碼
│   │   ├── protocolvalidator/   # 協議驗證
│   │   ├── userdb/              # 用戶與遊戲資料（JSON / MySQL）
│   │   ├── nonoformcache/       # 超能 NONO 形態快取
│   │   └── soultransformcache/ # 元神變身快取
│   ├── game/                    # 遊戲邏輯
│   │   ├── battle/              # 戰鬥系統
│   │   ├── skills/              # 技能與效果
│   │   ├── pets/                # 精靈
│   │   ├── sptboss/             # SPT Boss
│   │   ├── mapogres/            # 地圖怪物
│   │   └── typechart/           # 屬性克制表
│   ├── handlers/                # 業務處理與 GM API
│   │   ├── handlers.go          # 主處理器（戰鬥、精靈、地圖等）
│   │   ├── gm_handlers.go       # GM HTTP API
│   │   ├── sptboss_gm.go        # SPT Boss GM
│   │   ├── maps_gm.go           # 地圖 GM
│   │   ├── dark_portal.go       # 暗黑武鬥場
│   │   ├── arena.go             # 競技場
│   │   ├── gacha.go             # 扭蛋
│   │   ├── task_config.go       # 任務配置
│   │   └── ...
│   └── server/                  # 伺服器層
│       ├── gameserver/          # 遊戲主伺服器（Socket 5000）
│       ├── loginserver/         # 登入伺服器（1863）
│       ├── resserver/           # 資源伺服器（32400、8088）
│       └── loginip/             # 登入 IP 伺服器（32401）
├── GM/                          # GM 網頁後台
│   ├── gm_admin.html            # GM 管理主頁
│   ├── gm_panel.html            # GM 面板
│   ├── kyse.html                # 前端入口
│   ├── tasks_section.html       # 任務區塊
│   └── skills.xml               # 技能配置
├── data/                        # 遊戲資料 XML
│   ├── skills.xml               # 技能表
│   ├── spt.xml                  # 精靈表
│   └── items.xml                # 道具表
├── test/                        # 測試資料與編譯輸出
│   ├── users.json               # 測試用戶
│   ├── gm_*.json                # GM 配置檔
│   └── gameserver_*.exe         # 編譯產物
├── go.mod
├── 編譯.bat                     # 建置入口（呼叫 compile.ps1）
└── compile.ps1                  # PowerShell 編譯腳本
```

## 模組說明

### 伺服器層 (`internal/server/`)

| 模組 | 埠號 | 說明 |
|------|------|------|
| **gameserver** | 5000 | 遊戲主伺服器，處理客戶端連線與協議 |
| **loginserver** | 1863 | 登入伺服器，帳號驗證與伺服器列表 |
| **resserver** | 32400, 8088 | 資源伺服器，提供遊戲資源與代理 |
| **loginip** | 32401 | 登入 IP 伺服器，處理登入 IP 查詢 |

### 核心模組 (`internal/core/`)

| 模組 | 說明 |
|------|------|
| **userdb** | 用戶與遊戲資料，支援 JSON 與 MySQL |
| **packet** | 封包編解碼 |
| **logger** | 日誌 |
| **protocolvalidator** | 協議驗證 |
| **nonoformcache** | 超能 NONO 形態快取 |
| **soultransformcache** | 元神變身快取 |

### 遊戲邏輯 (`internal/game/`)

| 模組 | 說明 |
|------|------|
| **battle** | 戰鬥系統 |
| **skills** | 技能與效果 |
| **pets** | 精靈 |
| **sptboss** | SPT Boss |
| **mapogres** | 地圖怪物 |
| **typechart** | 屬性克制表 |

### 業務處理 (`internal/handlers/`)

處理遊戲指令與 GM API，包含：戰鬥、精靈、地圖、暗黑武鬥場、競技場、扭蛋、任務配置、融合規則等。

## 建置與執行

### 編譯

```powershell
# 一般建置 → test/gameserver_yyyy-MM-dd_HHmm.exe
.\compile.ps1

# Release 建置（-ldflags "-s -w"）
.\compile.ps1 -Release

# 監聽變更自動重建
.\compile.ps1 -Watch

# 清理編譯產物
.\compile.ps1 -Clean
```

或使用 `編譯.bat` 進行建置。

### 執行

執行編譯後的 `test/gameserver_*.exe`，或：

```bash
go run ./cmd/gameserver
```

**啟動參數：**
- `-y`：跳過免責申明確認，直接啟動
- `-import-data-docs`：僅將 data/*.xml 導入 data_docs 表後退出

### 環境變數（MySQL）

| 變數 | 說明 |
|------|------|
| MYSQL_HOST | 主機（預設 127.0.0.1） |
| MYSQL_PORT | 埠號（預設 3306） |
| MYSQL_DATABASE | 資料庫名（預設 seer） |
| MYSQL_USER | 使用者 |
| MYSQL_PASSWORD | 密碼 |

## 啟動流程

1. 顯示免責聲明並設定對外 IP
2. 設定資源目錄（可下載 gameres.rar 或手動指定）
3. 連接 MySQL
4. 啟動各伺服器：
   - 遊戲伺服器（5000）
   - 資源伺服器（32400、8088）
   - 登入伺服器（1863）
   - 登入 IP 伺服器（32401）
   - GM 管理（HTTP 8080）

## 依賴

- Go 1.20+
- [github.com/go-sql-driver/mysql](https://github.com/go-sql-driver/mysql)

## 授權

本專案僅供學習研究使用。
