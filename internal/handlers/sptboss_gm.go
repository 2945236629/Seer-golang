package handlers

import (
	"encoding/json"
	"sync"

	"github.com/seer-game/golang-version/internal/core/logger"
	"github.com/seer-game/golang-version/internal/game/sptboss"
)

// SPTBossPersistence SPT BOSS 配置持久化接口（由 main 注入 *userdb.UserDB）
type SPTBossPersistence interface {
	LoadSPTBossConfig() ([]byte, error)
	SaveSPTBossConfig(data []byte) error
}

var (
	sptBossPersistenceMu sync.RWMutex
	sptBossPersistence   SPTBossPersistence
)

// SetSPTBossPersistence 设置 SPT BOSS 配置持久化实现
func SetSPTBossPersistence(p SPTBossPersistence) {
	sptBossPersistenceMu.Lock()
	defer sptBossPersistenceMu.Unlock()
	sptBossPersistence = p
}

// LoadSPTBossConfig 从数据库或本地加载 SPT BOSS 配置并应用到 sptboss 包
func LoadSPTBossConfig() {
	sptBossPersistenceMu.RLock()
	p := sptBossPersistence
	sptBossPersistenceMu.RUnlock()
	if p == nil {
		return
	}
	data, err := p.LoadSPTBossConfig()
	if err != nil {
		logger.Warning("[SPT BOSS] 从数据库加载失败: " + err.Error())
		return
	}
	if len(data) == 0 {
		return
	}
	var cfg sptboss.FullConfig
	if err := json.Unmarshal(data, &cfg); err != nil {
		logger.Warning("[SPT BOSS] 配置 JSON 解析失败: " + err.Error())
		return
	}

	// 为了兼容旧版本已持久化但缺少新地图/新 BOSS（如 401 玄武空间、403 青龙空间等）的配置，
	// 这里将数据库配置与当前内置默认进行合并：数据库中的条目覆盖同键（mapId+param2 / bossPetId）的内置配置，
	// 但不会丢失本次版本新增的内置 BOSS。
	builtIn := sptboss.GetConfig()
	merged := mergeSPTBossConfig(builtIn, cfg)

	sptboss.SetConfig(&merged)
	logger.Info("[SPT BOSS] 已从数据库加载配置并与内置默认合并后应用")
}

// GetSPTBossConfig 返回当前 SPT BOSS 配置（供 GM 前端展示）
func GetSPTBossConfig() sptboss.FullConfig {
	return sptboss.GetConfig()
}

// SetSPTBossConfig 更新 SPT BOSS 配置并持久化（GM 保存）
func SetSPTBossConfig(cfg *sptboss.FullConfig) error {
	if cfg == nil {
		sptboss.SetConfig(nil)
		// 恢复内置后也持久化一份“空”或内置快照，便于下次加载时可选
		cfg2 := sptboss.GetConfig()
		return saveSPTBossConfigToPersistence(&cfg2)
	}
	for i := range cfg.SPTBosses {
		sptboss.NormalizeSPTBossItemTitles(&cfg.SPTBosses[i])
	}
	sptboss.SetConfig(cfg)
	return saveSPTBossConfigToPersistence(cfg)
}

func saveSPTBossConfigToPersistence(cfg *sptboss.FullConfig) error {
	sptBossPersistenceMu.RLock()
	p := sptBossPersistence
	sptBossPersistenceMu.RUnlock()
	if p == nil {
		return nil
	}
	data, err := json.MarshalIndent(cfg, "", "  ")
	if err != nil {
		return err
	}
	return p.SaveSPTBossConfig(data)
}

// mergeSPTBossConfig 将数据库中的 SPT BOSS 配置与当前内置默认配置合并。
// 规则：
// - MapBosses：按 (mapId, param2) 去重，数据库条目覆盖同键的内置条目，其余保持内置默认（确保新地图 BOSS 不会丢失）
// - SPTBosses：按 bossPetId 去重，数据库条目覆盖同 boss 的内置条目
// - Traits：按精灵 ID 取并集，DamageTakenMultiplier 以数据库 Mult 覆盖同 petId 的内置配置
// - PuniSeals：按 doorIndex(1~8) 合并，数据库条目覆盖对应 doorIndex 的内置配置
func mergeSPTBossConfig(builtIn, db sptboss.FullConfig) sptboss.FullConfig {
	out := builtIn

	// 1) 地图 BOSS
	type mapKey struct {
		MapID  int
		Param2 uint32
	}
	mapBossMap := make(map[mapKey]sptboss.MapBossItem)
	for _, it := range builtIn.MapBosses {
		mapBossMap[mapKey{MapID: it.MapID, Param2: it.Param2}] = it
	}
	for _, it := range db.MapBosses {
		mapBossMap[mapKey{MapID: it.MapID, Param2: it.Param2}] = it
	}
	out.MapBosses = out.MapBosses[:0]
	for _, it := range mapBossMap {
		out.MapBosses = append(out.MapBosses, it)
	}

	// 2) SPT BOSS 奖励（按 BossPetID 合并）
	sptMap := make(map[int]sptboss.SPTBossItem)
	for _, it := range builtIn.SPTBosses {
		sptMap[it.BossPetID] = it
	}
	for _, it := range db.SPTBosses {
		if it.BossPetID > 0 {
			copyIt := it
			sptboss.NormalizeSPTBossItemTitles(&copyIt)
			sptMap[it.BossPetID] = copyIt
		}
	}
	out.SPTBosses = out.SPTBosses[:0]
	for _, it := range sptMap {
		out.SPTBosses = append(out.SPTBosses, it)
	}

	// 3) Traits：大多为 ID 集合，采用并集；伤害倍数按数据库覆盖
	unionInts := func(a, b []int) []int {
		if len(a) == 0 && len(b) == 0 {
			return nil
		}
		m := make(map[int]bool)
		for _, v := range a {
			if v > 0 {
				m[v] = true
			}
		}
		for _, v := range b {
			if v > 0 {
				m[v] = true
			}
		}
		res := make([]int, 0, len(m))
		for v := range m {
			res = append(res, v)
		}
		return res
	}

	out.Traits.StatusImmune = unionInts(builtIn.Traits.StatusImmune, db.Traits.StatusImmune)
	out.Traits.StatDropImmune = unionInts(builtIn.Traits.StatDropImmune, db.Traits.StatDropImmune)
	out.Traits.SameLifeDeathImmune = unionInts(builtIn.Traits.SameLifeDeathImmune, db.Traits.SameLifeDeathImmune)
	out.Traits.InfinitePP = unionInts(builtIn.Traits.InfinitePP, db.Traits.InfinitePP)
	out.Traits.FirstStrike = unionInts(builtIn.Traits.FirstStrike, db.Traits.FirstStrike)
	out.Traits.PriorityBonus = unionInts(builtIn.Traits.PriorityBonus, db.Traits.PriorityBonus)
	out.Traits.HalfHPOneShot = unionInts(builtIn.Traits.HalfHPOneShot, db.Traits.HalfHPOneShot)

	// DamageTakenMultiplier：以数据库为主，覆盖内置
	dmMap := make(map[int]int)
	for _, it := range builtIn.Traits.DamageTakenMultiplier {
		if it.Mult > 0 {
			dmMap[it.PetID] = it.Mult
		}
	}
	for _, it := range db.Traits.DamageTakenMultiplier {
		if it.Mult > 0 {
			dmMap[it.PetID] = it.Mult
		}
	}
	out.Traits.DamageTakenMultiplier = out.Traits.DamageTakenMultiplier[:0]
	for pid, mult := range dmMap {
		out.Traits.DamageTakenMultiplier = append(out.Traits.DamageTakenMultiplier, sptboss.DamageMultItem{
			PetID: pid,
			Mult:  mult,
		})
	}

	// 4) 谱尼封印与真身：按 doorIndex 合并
	puniMap := make(map[int]sptboss.PuniSealConfig)
	for _, it := range builtIn.PuniSeals {
		if it.DoorIndex >= 1 && it.DoorIndex <= 8 {
			puniMap[it.DoorIndex] = it
		}
	}
	for _, it := range db.PuniSeals {
		if it.DoorIndex >= 1 && it.DoorIndex <= 8 {
			puniMap[it.DoorIndex] = it
		}
	}
	out.PuniSeals = out.PuniSeals[:0]
	for i := 1; i <= 8; i++ {
		if cfg, ok := puniMap[i]; ok {
			out.PuniSeals = append(out.PuniSeals, cfg)
		}
	}

	return out
}

