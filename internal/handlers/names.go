package handlers

import (
	"encoding/xml"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strconv"
	"strings"
	"sync"

	"github.com/seer-game/golang-version/internal/core/logger"
	"github.com/seer-game/golang-version/internal/game/pets"
	gameskills "github.com/seer-game/golang-version/internal/game/skills"
)

// 精灵名称映射（会在启动时从 pets.xml 自动填充）
var PetNames = map[int]string{
	// 可以在这里放一些手动覆盖/修正的别名
	4150: "拂晓兔",
}

var (
	petNamesOnce  sync.Once
	itemNamesOnce sync.Once
)

// monsterXML 用于解析 pets.xml 中我们需要的最小字段
type monsterXML struct {
	ID      int    `xml:"ID,attr"`
	DefName string `xml:"DefName,attr"`
}

type monstersRoot struct {
	// pets.xml 顶层就是 <Monsters>，其子节点为 <Monster>，这里直接取所有 Monster
	Monsters []monsterXML `xml:"Monster"`
}

// loadPetNamesOnce 从 spt（数据库或 data/spt.xml）或 pets.xml 加载精灵 ID 与中文名，填充到 PetNames 中
func loadPetNamesOnce() {
	petNamesOnce.Do(func() {
		// 优先从 spt（精灵表，可能来自数据库）取 DefName，避免依赖 pets.xml
		defNames := pets.GetInstance().GetAllDefNames()
		if len(defNames) > 0 {
			count := 0
			for id, name := range defNames {
				if _, exists := PetNames[id]; !exists {
					PetNames[id] = name
					count++
				}
			}
			logger.Info(fmt.Sprintf("[GM] 已从 spt 加载 %d 个精灵名称", count))
			return
		}

		// 回退：从 pets.xml 文件加载
		readAndFill := func(path string) bool {
			data, err := os.ReadFile(path)
			if err != nil {
				return false
			}
			var root monstersRoot
			if err := xml.Unmarshal(data, &root); err != nil {
				logger.Error(fmt.Sprintf("[GM] 解析 pets.xml 失败: %v", err))
				return false
			}
			count := 0
			for _, m := range root.Monsters {
				if m.ID <= 0 || m.DefName == "" {
					continue
				}
				if _, exists := PetNames[m.ID]; !exists {
					PetNames[m.ID] = m.DefName
					count++
				}
			}
			logger.Info(fmt.Sprintf("[GM] 已从 pets.xml 加载 %d 个精灵名称", count))
			return true
		}

		// 1) 以可执行文件目录为基准：先试 data/spt.xml（与 spt 同结构），再试 pets.xml
		if exePath, err := os.Executable(); err == nil {
			exeDir := filepath.Dir(exePath)
			candidates := []string{
				filepath.Join(exeDir, "..", "data", "spt.xml"), // 与 data/skills.xml 同目录
				filepath.Join(exeDir, "..", "..", "luvit_version", "data", "pets.xml"),
				filepath.Join(exeDir, "..", "luvit_version", "data", "pets.xml"),
				filepath.Join(exeDir, "luvit_version", "data", "pets.xml"),
			}
			for _, c := range candidates {
				if readAndFill(c) {
					return
				}
			}
		}

		// 2) 以当前工作目录为基准
		candidates := []string{
			filepath.Join("data", "spt.xml"),
			filepath.Join("luvit_version", "data", "pets.xml"),
			filepath.Join("..", "luvit_version", "data", "pets.xml"),
		}
		for _, c := range candidates {
			if readAndFill(c) {
				return
			}
		}

		logger.Warning("[GM] 未能找到 pets.xml，精灵中文名将仅使用内置少量映射")
	})
}

// 道具名称映射（会在启动时从 items.xml 或数据库自动填充）
var ItemNames = map[int]string{
	// 这里可以放少量覆盖/别名；绝大多数由 items.xml 自动加载
}

// 若设置则 loadItemNamesOnce 优先从该提供者读取（如数据库）
var itemContentProvider func() ([]byte, error)

// SetItemContentProvider 设置道具 XML 内容提供者；Load 时优先使用，失败或为空则回退到文件
func SetItemContentProvider(f func() ([]byte, error)) {
	itemContentProvider = f
}

// itemXML / itemsRoot 用于解析 items.xml
type itemXML struct {
	ID               int    `xml:"ID,attr"`
	Name             string `xml:"Name,attr"`
	Price            string `xml:"Price,attr"`
	UseAI            string `xml:"UseAI,attr"`
	UsePower         string `xml:"UsePower,attr"`
	Color            string `xml:"Color,attr"`
	HP               string `xml:"HP,attr"`
	PP               string `xml:"PP,attr"`
	EvRemove         string `xml:"EvRemove,attr"`         // 学习力遗忘：1=HP 2=ATK 3=DEF 4=SA 5=SD 6=SP 7=全能
	MonNatureReset   string `xml:"MonNatureReset,attr"`   // 性格重塑：1=随机新性格
	Nature           string `xml:"Nature,attr"`           // 性格转换：指定性格ID
	NatureSet        string `xml:"NatureSet,attr"`        // 性格生成：空格分隔的性格ID列表
	NatureProbs      string `xml:"NatureProbs,attr"`      // 性格生成：空格分隔的概率列表
	MonAttrReset     string `xml:"MonAttrReset,attr"`     // 精灵还原：1=等级1+EV重置+随机性格+DV
	DecreMonLv       string `xml:"DecreMonLv,attr"`       // 降级秘药：等级-1
	RemoveAllMonStat string `xml:"RemoveAllMonStat,attr"` // 战斗内解除异常状态
	RemoveBtLvDown   string `xml:"RemoveBtLvDown,attr"`   // 战斗内解除能力等级下降
	LimitPetClass    string `xml:"LimitPetClass,attr"`    // 限定精灵ID（空格分隔）
}

type itemsRoot struct {
	Cats []struct {
		Items []itemXML `xml:"Item"`
	} `xml:"Cat"`
}

// ItemEffect 描述道具在 NONO 系统中的简单数值效果（目前用于芯片）
type ItemEffect struct {
	UseAI    int
	UsePower int
	Color    int
}

// itemEffects 从 items.xml 解析出的道具效果表：key 为 ItemID
var itemEffects = map[int]ItemEffect{}

// itemPrices 从 items.xml 解析出的道具价格表（赛尔豆），key 为 ItemID
var itemPrices = map[int]int{}

// BattleItemEffect 描述战斗中常用的回复类效果（来自 items.xml）
type BattleItemEffect struct {
	HP               int  // 回复体力
	PP               int  // 恢复 PP（对所有技能）
	RemoveAllMonStat int  // 解除异常状态（中毒/烧伤/冻伤/麻痹/睡眠等）
	RemoveBtLvDown   int  // 解除能力等级下降（战斗等级归零）
}

// battleItemEffects 从 items.xml 解析出的战斗药剂效果表：key 为 ItemID
var battleItemEffects = map[int]BattleItemEffect{}

// GetBattleItemEffect 返回道具在战斗中可用的基础回复数值（HP / PP / 状态解除）
func GetBattleItemEffect(id int) BattleItemEffect {
	if id <= 0 {
		return BattleItemEffect{}
	}
	loadItemNamesOnce()
	if eff, ok := battleItemEffects[id]; ok {
		return eff
	}
	return BattleItemEffect{}
}

// OutOfFightItemEffect 战斗外使用精灵道具的效果（来自 items.xml）
type OutOfFightItemEffect struct {
	EvRemove       int    // 学习力遗忘：1=HP 2=ATK 3=DEF 4=SA 5=SD 6=SP 7=全能
	MonNatureReset int    // 性格重塑：1=随机新性格
	Nature         int    // 性格转换：指定性格ID（>0 时直接设置）
	NatureSet      string // 性格生成：空格分隔的性格ID列表
	NatureProbs    string // 性格生成：空格分隔的概率列表
	MonAttrReset   int    // 精灵还原：1=等级1+EV清零+随机性格+DV
	DecreMonLv     int    // 降级秘药：等级-1
	LimitPetClass  string // 限定精灵ID（空格分隔，空表示任意）
}

// outOfFightItemEffects 战斗外精灵道具效果表
var outOfFightItemEffects = map[int]OutOfFightItemEffect{}

// GetOutOfFightItemEffect 返回道具在战斗外使用时的效果
func GetOutOfFightItemEffect(id int) OutOfFightItemEffect {
	if id <= 0 {
		return OutOfFightItemEffect{}
	}
	loadItemNamesOnce()
	if eff, ok := outOfFightItemEffects[id]; ok {
		return eff
	}
	return OutOfFightItemEffect{}
}

// GetPetName 获取精灵中文名称（优先从 pets.xml 动态加载）
func GetPetName(id int) string {
	if id <= 0 {
		return "未知精灵"
	}
	loadPetNamesOnce()
	if name, exists := PetNames[id]; exists {
		return name
	}
	return "未知精灵"
}

// GMPetInfo 提供给 GM 前端使用的精灵信息
type GMPetInfo struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

// GetAllPetsForGM 返回按 ID 升序排序的精灵列表（ID + 中文名），供 GM 下拉/搜索用
func GetAllPetsForGM() []GMPetInfo {
	loadPetNamesOnce()
	list := make([]GMPetInfo, 0, len(PetNames))
	for id, name := range PetNames {
		list = append(list, GMPetInfo{
			ID:   id,
			Name: name,
		})
	}
	sort.Slice(list, func(i, j int) bool {
		return list[i].ID < list[j].ID
	})
	return list
}

// loadItemNamesOnce 从数据库或 items.xml 文件加载道具 ID 与中文名，填充到 ItemNames 中
func loadItemNamesOnce() {
	itemNamesOnce.Do(func() {
		parseIntAttr := func(s string) int {
			s = strings.TrimSpace(s)
			if s == "" {
				return 0
			}
			// 某些属性在 items.xml 中可能是空格分隔的列表（例如 "1 2 3 0"）；
			// 对于当前 GM 侧的用途（名称与简单数值效果），只取首个可解析的数值，解析失败则视为 0。
			if strings.IndexFunc(s, func(r rune) bool { return r == ' ' || r == '\t' || r == '\r' || r == '\n' }) >= 0 {
				parts := strings.Fields(s)
				if len(parts) == 0 {
					return 0
				}
				s = parts[0]
			}
			v, err := strconv.Atoi(s)
			if err != nil {
				return 0
			}
			return v
		}

		parseAndFillItems := func(data []byte) bool {
			if len(data) == 0 {
				return false
			}
			var root itemsRoot
			if err := xml.Unmarshal(data, &root); err != nil {
				logger.Error(fmt.Sprintf("[GM] 解析 items.xml 失败: %v", err))
				return false
			}
			count := 0
			for _, cat := range root.Cats {
				for _, it := range cat.Items {
					if it.ID <= 0 {
						continue
					}
					useAI := parseIntAttr(it.UseAI)
					usePower := parseIntAttr(it.UsePower)
					color := parseIntAttr(it.Color)
					price := parseIntAttr(it.Price)
					hp := parseIntAttr(it.HP)
					pp := parseIntAttr(it.PP)
					evRemove := parseIntAttr(it.EvRemove)
					monNatureReset := parseIntAttr(it.MonNatureReset)
					nature := parseIntAttr(it.Nature)
					monAttrReset := parseIntAttr(it.MonAttrReset)
					decreMonLv := parseIntAttr(it.DecreMonLv)
					removeAllMonStat := parseIntAttr(it.RemoveAllMonStat)
					removeBtLvDown := parseIntAttr(it.RemoveBtLvDown)

					// 1) 填充道具名称（若有）
					if it.Name != "" {
						if _, exists := ItemNames[it.ID]; !exists {
							ItemNames[it.ID] = it.Name
							count++
						}
					}
					// 1.5) 记录价格（允许为 0）
					if it.ID > 0 && price >= 0 {
						// 只记录首个，避免重复覆盖（不同分类可能重复出现同 ID）
						if _, exists := itemPrices[it.ID]; !exists {
							itemPrices[it.ID] = price
						}
					}
					// 2) 记录与 NONO 芯片相关的数值效果（UseAI / UsePower / Color）
					if useAI != 0 || usePower != 0 || color != 0 {
						itemEffects[it.ID] = ItemEffect{
							UseAI:    useAI,
							UsePower: usePower,
							Color:    color,
						}
					}
					// 3) 记录战斗中常用的 HP / PP / 状态解除（用于精灵战斗药剂）
					if hp != 0 || pp != 0 || removeAllMonStat != 0 || removeBtLvDown != 0 {
						be := battleItemEffects[it.ID]
						if hp != 0 {
							be.HP = hp
						}
						if pp != 0 {
							be.PP = pp
						}
						if removeAllMonStat != 0 {
							be.RemoveAllMonStat = removeAllMonStat
						}
						if removeBtLvDown != 0 {
							be.RemoveBtLvDown = removeBtLvDown
						}
						battleItemEffects[it.ID] = be
					}
					// 4) 记录战斗外精灵道具效果（学习力/性格/还原/降级等）
					if evRemove != 0 || monNatureReset != 0 || nature != 0 || it.NatureSet != "" ||
						monAttrReset != 0 || decreMonLv != 0 {
						oe := outOfFightItemEffects[it.ID]
						if evRemove != 0 {
							oe.EvRemove = evRemove
						}
						if monNatureReset != 0 {
							oe.MonNatureReset = monNatureReset
						}
						if nature != 0 {
							oe.Nature = nature
						}
						if it.NatureSet != "" {
							oe.NatureSet = it.NatureSet
							oe.NatureProbs = it.NatureProbs
						}
						if monAttrReset != 0 {
							oe.MonAttrReset = monAttrReset
						}
						if decreMonLv != 0 {
							oe.DecreMonLv = decreMonLv
						}
						if it.LimitPetClass != "" {
							oe.LimitPetClass = it.LimitPetClass
						}
						outOfFightItemEffects[it.ID] = oe
					}
				}
			}
			return count > 0
		}

		// 优先从数据库（或提供者）读取
		if itemContentProvider != nil {
			data, err := itemContentProvider()
			if err == nil && parseAndFillItems(data) {
				logger.Info("[GM] 已从数据库加载道具名称")
				return
			}
		}

		readAndFill := func(path string) bool {
			data, err := os.ReadFile(path)
			if err != nil {
				return false
			}
			if !parseAndFillItems(data) {
				return false
			}
			logger.Info(fmt.Sprintf("[GM] 已从 items.xml 加载道具名称: %s", path))
			return true
		}

		// 从某个起点目录开始，逐级向上查找指定相对路径（最多 maxUp 层），用于适配 go run / 从子目录启动的情况。
		walkUpCandidates := func(startDir string, rel string, maxUp int) []string {
			if startDir == "" {
				return nil
			}
			dir := startDir
			out := make([]string, 0, maxUp+1)
			for i := 0; i <= maxUp; i++ {
				out = append(out, filepath.Join(dir, rel))
				parent := filepath.Dir(dir)
				if parent == dir {
					break
				}
				dir = parent
			}
			return out
		}

		// 先试 data/items.xml（与 data/skills.xml、spt.xml 同目录），再试 luvit_version
		if exePath, err := os.Executable(); err == nil {
			exeDir := filepath.Dir(exePath)
			candidates := []string{
				filepath.Join(exeDir, "..", "data", "items.xml"),
				filepath.Join(exeDir, "..", "..", "luvit_version", "data", "items.xml"),
				filepath.Join(exeDir, "..", "luvit_version", "data", "items.xml"),
				filepath.Join(exeDir, "luvit_version", "data", "items.xml"),
			}
			for _, c := range candidates {
				if readAndFill(c) {
					return
				}
			}
		}

		// 优先：从当前工作目录向上寻找（例如从 cmd/gameserver 启动时，../data/items.xml 才存在）
		if wd, err := os.Getwd(); err == nil && wd != "" {
			for _, rel := range []string{
				filepath.Join("data", "items.xml"),
				filepath.Join("luvit_version", "data", "items.xml"),
			} {
				for _, c := range walkUpCandidates(wd, rel, 6) {
					if readAndFill(c) {
						return
					}
				}
			}
		}

		// 兜底：少量固定相对路径（保持兼容）
		candidates := []string{
			filepath.Join("data", "items.xml"),
			filepath.Join("..", "data", "items.xml"),
			filepath.Join("..", "..", "data", "items.xml"),
			filepath.Join("luvit_version", "data", "items.xml"),
			filepath.Join("..", "luvit_version", "data", "items.xml"),
			filepath.Join("..", "..", "luvit_version", "data", "items.xml"),
		}
		for _, c := range candidates {
			if readAndFill(c) {
				return
			}
		}

		logger.Warning("[GM] 未能找到 items.xml，道具中文名将仅使用内置映射")
	})
}

// GetItemName 获取道具中文名称（优先从 items.xml 动态加载）
func GetItemName(id int) string {
	if id <= 0 {
		return "未知道具"
	}
	loadItemNamesOnce()
	if name, exists := ItemNames[id]; exists {
		return name
	}
	return "未知道具"
}

// GetItemPrice 返回道具赛尔豆价格（来自 items.xml 的 Price 属性）；未知则返回 0
func GetItemPrice(id int) int {
	if id <= 0 {
		return 0
	}
	loadItemNamesOnce()
	if p, ok := itemPrices[id]; ok {
		return p
	}
	return 0
}

// GMItemInfo 提供给 GM 前端使用的道具信息
type GMItemInfo struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

// GetAllItemsForGM 返回按 ID 升序排序的道具列表（ID + 中文名），供 GM 下拉/搜索用
func GetAllItemsForGM() []GMItemInfo {
	loadItemNamesOnce()
	list := make([]GMItemInfo, 0, len(ItemNames))
	for id, name := range ItemNames {
		list = append(list, GMItemInfo{
			ID:   id,
			Name: name,
		})
	}
	sort.Slice(list, func(i, j int) bool {
		return list[i].ID < list[j].ID
	})
	return list
}

// GetSkillName 获取技能中文名称（从 skills.xml 加载）
func GetSkillName(id int) string {
	if id <= 0 {
		return ""
	}
	return gameskills.GetInstance().GetName(id)
}

// GMTraitInfo 特性 ID 与显示名，供 GM 下拉选择
type GMTraitInfo struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

// GetAllTraitsForGM 返回特性列表：0=无，1006–1045=特性1006 等，供 GM 下拉选择
func GetAllTraitsForGM() []GMTraitInfo {
	list := []GMTraitInfo{{ID: 0, Name: "无"}}
	for id := 1006; id <= 1045; id++ {
		list = append(list, GMTraitInfo{ID: id, Name: fmt.Sprintf("特性%d", id)})
	}
	return list
}