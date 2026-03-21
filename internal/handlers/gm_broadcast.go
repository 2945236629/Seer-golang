package handlers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/seer-game/golang-version/internal/core/logger"
	"github.com/seer-game/golang-version/internal/core/userdb"
	"github.com/seer-game/golang-version/internal/server/gameserver"
)

// collectBroadcastUserIDs 根據 scope 收集目標用戶：all=全庫帳號，online=當前已登入連線（去重）。
func collectBroadcastUserIDs(gs *gameserver.GameServer, scope string) []int64 {
	if gs == nil || gs.UserDB == nil {
		return nil
	}
	scope = strings.ToLower(strings.TrimSpace(scope))
	if scope == "online" {
		raw := gs.GetOnlineUserIDs()
		seen := make(map[int64]struct{}, len(raw))
		out := make([]int64, 0, len(raw))
		for _, id := range raw {
			if id <= 0 {
				continue
			}
			if _, ok := seen[id]; ok {
				continue
			}
			seen[id] = struct{}{}
			out = append(out, id)
		}
		return out
	}
	var ids []int64
	if gs.UserDB.UseMySQL() {
		list, _, err := gs.UserDB.MySQLListUsersForGM("", 1000000, 0)
		if err != nil {
			logger.Error(fmt.Sprintf("[GM] broadcast 列舉 MySQL 用戶失敗: %v", err))
			return nil
		}
		for _, row := range list {
			ids = append(ids, row.UserID)
		}
		return ids
	}
	for uid := range gs.UserDB.GetAllGameData() {
		if gs.UserDB.FindByUserID(uid) != nil {
			ids = append(ids, uid)
		}
	}
	return ids
}

func writeJSON(w http.ResponseWriter, v interface{}) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	_ = json.NewEncoder(w).Encode(v)
}

// handleGMBroadcastItems POST /gm/broadcast/items
// body: {"scope":"all"|"online","items":[{"itemId":1,"count":10}]}
func handleGMBroadcastItems(w http.ResponseWriter, r *http.Request, gs *gameserver.GameServer) {
	if r.Method != http.MethodPost {
		writeJSON(w, map[string]interface{}{"success": false, "message": "只支持POST请求"})
		return
	}
	if gs == nil || gs.UserDB == nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "服务未就绪"})
		return
	}
	var req struct {
		Scope string `json:"scope"`
		Items []struct {
			ItemID int `json:"itemId"`
			Count  int `json:"count"`
		} `json:"items"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "请求参数错误"})
		return
	}
	if len(req.Items) == 0 {
		writeJSON(w, map[string]interface{}{"success": false, "message": "请至少选择一种道具"})
		return
	}
	for _, it := range req.Items {
		if it.ItemID <= 0 || it.Count <= 0 {
			writeJSON(w, map[string]interface{}{"success": false, "message": "道具ID与数量须为正数"})
			return
		}
	}
	ids := collectBroadcastUserIDs(gs, req.Scope)
	if ids == nil && strings.ToLower(strings.TrimSpace(req.Scope)) == "all" && gs.UserDB.UseMySQL() {
		writeJSON(w, map[string]interface{}{"success": false, "message": "无法枚举用户列表"})
		return
	}
	var processed int
	for _, uid := range ids {
		if gs.UserDB.FindByUserID(uid) == nil {
			continue
		}
		gameData := gs.UserDB.GetOrCreateGameData(uid)
		if gameData.Items == nil {
			gameData.Items = make(map[string]userdb.Item)
		}
		for _, it := range req.Items {
			key := fmt.Sprintf("%d", it.ItemID)
			if row, ok := gameData.Items[key]; ok {
				row.Count += it.Count
				gameData.Items[key] = row
			} else {
				gameData.Items[key] = userdb.Item{
					Count:      it.Count,
					ExpireTime: 360000,
				}
			}
		}
		gs.UserDB.SaveGameData(uid, gameData)
		processed++
	}
	logger.Info(fmt.Sprintf("[GM] 批量发放道具 scope=%s targets=%d itemsKinds=%d", req.Scope, processed, len(req.Items)))
	writeJSON(w, map[string]interface{}{
		"success":   true,
		"message":   fmt.Sprintf("已对 %d 名玩家发放所选道具", processed),
		"processed": processed,
	})
}

// handleGMBroadcastPets POST /gm/broadcast/pets
// body: {"scope":"all"|"online","pets":[{"petId":1,"level":1,"trait":0}]}
func handleGMBroadcastPets(w http.ResponseWriter, r *http.Request, gs *gameserver.GameServer) {
	if r.Method != http.MethodPost {
		writeJSON(w, map[string]interface{}{"success": false, "message": "只支持POST请求"})
		return
	}
	if gs == nil || gs.UserDB == nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "服务未就绪"})
		return
	}
	var req struct {
		Scope string `json:"scope"`
		Pets  []struct {
			PetID  int  `json:"petId"`
			Level  int  `json:"level"`
			Trait  int  `json:"trait"`
			Nature *int `json:"nature"`
		} `json:"pets"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "请求参数错误"})
		return
	}
	if len(req.Pets) == 0 {
		writeJSON(w, map[string]interface{}{"success": false, "message": "请至少选择一只精灵"})
		return
	}
	for _, p := range req.Pets {
		if p.PetID <= 0 {
			writeJSON(w, map[string]interface{}{"success": false, "message": "精灵ID须为正数"})
			return
		}
	}
	ids := collectBroadcastUserIDs(gs, req.Scope)
	if ids == nil && strings.ToLower(strings.TrimSpace(req.Scope)) == "all" && gs.UserDB.UseMySQL() {
		writeJSON(w, map[string]interface{}{"success": false, "message": "无法枚举用户列表"})
		return
	}
	var processed int
	baseCT := int(time.Now().UnixNano() / 1e6)
	for _, uid := range ids {
		if gs.UserDB.FindByUserID(uid) == nil {
			continue
		}
		gameData := gs.UserDB.GetOrCreateGameData(uid)
		for j, p := range req.Pets {
			lv := p.Level
			if lv <= 0 {
				lv = 1
			}
			if lv > 100 {
				lv = 100
			}
			newPet := userdb.Pet{
				ID:        p.PetID,
				CatchTime: baseCT + j,
				Level:     lv,
				DV:        31,
				Nature: func() int {
					if p.Nature != nil {
						return *p.Nature
					}
					return 0
				}(),
				Exp:  0,
				Name: "",
			}
			if p.Trait > 0 {
				newPet.Trait = p.Trait
			} else if p.Trait == -1 {
				userdb.AssignFusionTraitIfNeeded(&newPet)
			}
			addGrantedPetToBagOrStorage(gameData, newPet)
		}
		gs.UserDB.SaveGameData(uid, gameData)
		processed++
	}
	logger.Info(fmt.Sprintf("[GM] 批量发放精灵 scope=%s targets=%d petKinds=%d", req.Scope, processed, len(req.Pets)))
	writeJSON(w, map[string]interface{}{
		"success":   true,
		"message":   fmt.Sprintf("已对 %d 名玩家发放所选精灵", processed),
		"processed": processed,
	})
}

// handleGMBroadcastExpPool POST /gm/broadcast/exp-pool
// body: {"scope":"all"|"online","amount":1000} 累加到经验池 ExpPool
func handleGMBroadcastExpPool(w http.ResponseWriter, r *http.Request, gs *gameserver.GameServer) {
	if r.Method != http.MethodPost {
		writeJSON(w, map[string]interface{}{"success": false, "message": "只支持POST请求"})
		return
	}
	if gs == nil || gs.UserDB == nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "服务未就绪"})
		return
	}
	var req struct {
		Scope  string `json:"scope"`
		Amount int    `json:"amount"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "请求参数错误"})
		return
	}
	if req.Amount <= 0 {
		writeJSON(w, map[string]interface{}{"success": false, "message": "经验数量须为正数"})
		return
	}
	ids := collectBroadcastUserIDs(gs, req.Scope)
	if ids == nil && strings.ToLower(strings.TrimSpace(req.Scope)) == "all" && gs.UserDB.UseMySQL() {
		writeJSON(w, map[string]interface{}{"success": false, "message": "无法枚举用户列表"})
		return
	}
	var processed int
	for _, uid := range ids {
		if gs.UserDB.FindByUserID(uid) == nil {
			continue
		}
		gameData := gs.UserDB.GetOrCreateGameData(uid)
		gameData.ExpPool += req.Amount
		gs.UserDB.SaveGameData(uid, gameData)
		processed++
	}
	logger.Info(fmt.Sprintf("[GM] 批量发放经验池 scope=%s targets=%d amount=%d", req.Scope, processed, req.Amount))
	writeJSON(w, map[string]interface{}{
		"success":   true,
		"message":   fmt.Sprintf("已对 %d 名玩家经验池增加 %d", processed, req.Amount),
		"processed": processed,
	})
}

// handleGMBroadcastTitles POST /gm/broadcast/titles
// body: {"scope":"all"|"online","titleIds":[1,2],"wearNow":false}
func handleGMBroadcastTitles(w http.ResponseWriter, r *http.Request, gs *gameserver.GameServer) {
	if r.Method != http.MethodPost {
		writeJSON(w, map[string]interface{}{"success": false, "message": "只支持POST请求"})
		return
	}
	if gs == nil || gs.UserDB == nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "服务未就绪"})
		return
	}
	var req struct {
		Scope    string `json:"scope"`
		TitleIDs []int  `json:"titleIds"`
		WearNow  bool   `json:"wearNow"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		writeJSON(w, map[string]interface{}{"success": false, "message": "请求参数错误"})
		return
	}
	if len(req.TitleIDs) == 0 {
		writeJSON(w, map[string]interface{}{"success": false, "message": "请至少选择一个称号"})
		return
	}
	for _, tid := range req.TitleIDs {
		if tid <= 0 {
			writeJSON(w, map[string]interface{}{"success": false, "message": "称号ID须为正数"})
			return
		}
	}
	ids := collectBroadcastUserIDs(gs, req.Scope)
	if ids == nil && strings.ToLower(strings.TrimSpace(req.Scope)) == "all" && gs.UserDB.UseMySQL() {
		writeJSON(w, map[string]interface{}{"success": false, "message": "无法枚举用户列表"})
		return
	}
	var processed int
	for _, uid := range ids {
		if gs.UserDB.FindByUserID(uid) == nil {
			continue
		}
		gameData := gs.UserDB.GetOrCreateGameData(uid)
		if gameData.Achievements.List == nil {
			gameData.Achievements.List = []int{}
		}
		exist := make(map[int]struct{}, len(gameData.Achievements.List))
		for _, id := range gameData.Achievements.List {
			exist[id] = struct{}{}
		}
		for _, tid := range req.TitleIDs {
			if _, ok := exist[tid]; !ok {
				gameData.Achievements.List = append(gameData.Achievements.List, tid)
				exist[tid] = struct{}{}
			}
		}
		gameData.Achievements.Total = len(gameData.Achievements.List)
		if req.WearNow && len(req.TitleIDs) > 0 {
			maxT := req.TitleIDs[0]
			for _, t := range req.TitleIDs[1:] {
				if t > maxT {
					maxT = t
				}
			}
			gameData.CurTitle = maxT
		}
		gs.UserDB.SaveGameData(uid, gameData)
		processed++
	}
	logger.Info(fmt.Sprintf("[GM] 批量发放称号 scope=%s targets=%d titles=%d wearNow=%v", req.Scope, processed, len(req.TitleIDs), req.WearNow))
	writeJSON(w, map[string]interface{}{
		"success":   true,
		"message":   fmt.Sprintf("已对 %d 名玩家写入所选称号", processed),
		"processed": processed,
	})
}
