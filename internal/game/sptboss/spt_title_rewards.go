package sptboss

// 客户端 AchieveXML 中 Rule@SpeNameBonus 与称号文案对应；无独立 SpeNameBonus 的经典 SPT 使用 ClassicFallbackTitleID（SPT斗魂）

// ClassicFallbackTitleID 经典 SPT（成就 XML 中「击败xxx」无 SpeNameBonus）的通用称号编号
const ClassicFallbackTitleID = 239 // SPT斗魂

// builtinTitleIDByBossPetID 内置：BOSS 精灵 ID -> 称号编号（SpeNameBonus）；与 AchieveXMLInfo_xml 中 SPT/神兽等规则对齐
var builtinTitleIDByBossPetID = map[int]int{
	// 经典 SPT 1~20 等（无单独 SpeNameBonus 的用 239）
	47:  ClassicFallbackTitleID, // 蘑菇怪
	34:  ClassicFallbackTitleID, // 钢牙鲨
	42:  ClassicFallbackTitleID, // 里奥斯
	50:  ClassicFallbackTitleID, // 阿克希亚
	69:  ClassicFallbackTitleID, // 提亚斯
	70:  3,                        // 雷伊 -> 孤傲挑战者
	88:  ClassicFallbackTitleID, // 纳多雷
	113: ClassicFallbackTitleID, // 雷纳多
	132: ClassicFallbackTitleID, // 尤纳斯
	187: ClassicFallbackTitleID, // 魔狮迪露
	216: 4,                        // 哈莫雷特 -> 龙族盟友
	264: ClassicFallbackTitleID, // 奈尼芬多
	261: 14,                       // 盖亚 -> 狂傲战栗者（与「完胜盖亚」同档展示名）
	274: ClassicFallbackTitleID, // 塔克林
	391: ClassicFallbackTitleID, // 塔西亚
	421: 17,                       // 厄尔塞拉 -> 七色光羽（与「完胜厄尔塞拉」成就一致）
	347: ClassicFallbackTitleID, // 远古鱼龙
	393: ClassicFallbackTitleID, // 上古炎兽
	300: 25,                       // 谱尼 -> 传说
	4150: ClassicFallbackTitleID, // 拂晓兔
	413: 16,                       // 塞维尔 -> 龙族卫士
	589: ClassicFallbackTitleID, // 克瑞斯
	166: ClassicFallbackTitleID, // 闪光波克尔
	501: 18,                       // 玄武 -> 玄武终结者
	502: 19,                       // 青龙 -> 青龙终结者
	490: ClassicFallbackTitleID, // 劳克蒙德
	538: 27,                       // 克拉尼特 -> 烈火之翼（与「再次击败克拉尼特」成就）
	587: ClassicFallbackTitleID, // 墨杜萨
	617: ClassicFallbackTitleID, // 肯佩德
	672: ClassicFallbackTitleID, // 亚伦斯
	5012: ClassicFallbackTitleID, // 亚伦斯（形态 5012）
	798: 43,                       // 卡修斯 -> 破空挑战者
	715: ClassicFallbackTitleID, // 德拉萨
	1000: 93,                      // 异能王终极 -> 光明
}

// ResolveRewardTitleIDs 首次击败应发放的称号 ID 列表；GM 配置非空时仅用配置；否则用内置表/默认
func ResolveRewardTitleIDs(e SPTBossEntry, bossPetID int) []int {
	if len(e.RewardTitleIDs) > 0 {
		return DedupePositiveSorted(e.RewardTitleIDs)
	}
	if id, ok := builtinTitleIDByBossPetID[bossPetID]; ok && id > 0 {
		return []int{id}
	}
	if e.SPTID >= 1 && e.SPTID <= 20 {
		return []int{ClassicFallbackTitleID}
	}
	return nil
}

// ResolveYiNengTitleID 地图 677 异能王：六重试炼与终极试炼称号（与客户端成就描述对齐）
func ResolveYiNengTitleID(region uint32) int {
	if IsYiNengUltimateBoss(MapIDYiNengWang, region) {
		return 93 // 光明（击败终极异能王）
	}
	if IsYiNengSealBoss(MapIDYiNengWang, region) {
		return ClassicFallbackTitleID
	}
	return 0
}
