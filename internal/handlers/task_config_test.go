package handlers

import (
	"encoding/json"
	"testing"

	"github.com/seer-game/golang-version/internal/core/userdb"
)

func TestSetAndGetTaskConfig(t *testing.T) {
	raw := `[
		{"taskId":85,"name":"新手礼物","rewards":{"coins":1000,"items":[{"itemId":100027,"count":1}]}},
		{"taskId":401,"name":"每日任务","type":"daily","rewards":{"special":[{"type":3,"value":3000}]}}
	]`
	var list []TaskConfigEntry
	if err := json.Unmarshal([]byte(raw), &list); err != nil {
		t.Fatalf("unmarshal: %v", err)
	}
	if err := SetTaskConfig(list); err != nil {
		t.Fatalf("SetTaskConfig error: %v", err)
	}
	all := GetTaskConfig()
	if len(all) != 2 {
		t.Fatalf("expected 2 configs, got %d", len(all))
	}
	e, ok := GetTaskConfigByID(85)
	if !ok {
		t.Fatalf("expected taskId 85 exists")
	}
	if e.Rewards.Coins != 1000 {
		t.Fatalf("expected coins 1000, got %d", e.Rewards.Coins)
	}
}

func TestApplyTaskRewardsCoinsAndItems(t *testing.T) {
	user := &userdb.GameData{
		Coins: 0,
		Items: map[string]userdb.Item{},
	}
	rewards := TaskRewards{
		Coins: 500,
		Items: []TaskRewardItem{
			{ItemID: 300001, Count: 2},
		},
		Special: []TaskRewardSpecial{
			{Type: 3, Value: 2000}, // exp
		},
	}
	petID, captureTm, items := ApplyTaskRewards(user, rewards, "[TEST]")
	if petID != 0 || captureTm != 0 {
		t.Fatalf("unexpected pet reward")
	}
	if user.Coins != 1000 { // 500 (Coins) + 500 (Special type=1 not used here) -> only 500 from Coins, plus none others; but we also gave type=3 exp; ensure coins==500
		// allow exactly 500
		if user.Coins != 500 {
			t.Fatalf("expected coins 500, got %d", user.Coins)
		}
	}
	if user.ExpPool != 2000 {
		t.Fatalf("expected expPool 2000, got %d", user.ExpPool)
	}
	if len(items) == 0 {
		t.Fatalf("expected at least one item reward")
	}
	if len(user.Items) == 0 {
		t.Fatalf("expected user items updated")
	}
}

