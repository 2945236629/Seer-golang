package protocolvalidator

import (
	"fmt"

	"github.com/seer-game/golang-version/internal/core/logger"
)

// Protocol 描述单个 CMD 的包体大小约束。
type Protocol struct {
	Name    string
	MinSize int // 最小包体长度（字节）
	MaxSize int // 最大包体长度；<=0 表示不限制上限，仅检查 MinSize
}

// 协议定义表（根据 Lua core/protocol_validator.lua 精简移植）。
var protocols = map[int32]Protocol{
	// 地图/玩家
	2001: {Name: "ENTER_MAP", MinSize: 144, MaxSize: 0}, // PeopleInfo + 动态服装列表，先只检查最小值
	2002: {Name: "LEAVE_MAP", MinSize: 4, MaxSize: 4},
	2003: {Name: "LIST_MAP_PLAYER", MinSize: 4, MaxSize: 0},

	// 精灵
	2301: {Name: "GET_PET_INFO", MinSize: 154, MaxSize: 0}, // PetInfo + 可选效果列表
	2303: {Name: "GET_PET_LIST", MinSize: 4, MaxSize: 0},
	2304: {Name: "PET_RELEASE", MinSize: 12, MaxSize: 0},

	// 战斗
	2404: {Name: "READY_TO_FIGHT", MinSize: 0, MaxSize: 0},
	2405: {Name: "USE_SKILL", MinSize: 0, MaxSize: 0},
	2411: {Name: "CHALLENGE_BOSS", MinSize: 0, MaxSize: 0},
	2503: {Name: "NOTE_READY_TO_FIGHT", MinSize: 196, MaxSize: 0},
	2504: {Name: "NOTE_START_FIGHT", MinSize: 104, MaxSize: 104},
	2505: {Name: "NOTE_USE_SKILL", MinSize: 180, MaxSize: 0},
	2506: {Name: "FIGHT_OVER", MinSize: 28, MaxSize: 28},
	2507: {Name: "NOTE_UPDATE_SKILL", MinSize: 16, MaxSize: 16},
	2508: {Name: "NOTE_UPDATE_PROP", MinSize: 80, MaxSize: 80},

	// 登录 / 系统
	1001: {Name: "LOGIN_IN", MinSize: 1146, MaxSize: 0}, // 结构非常复杂，仅检查最小值
	1002: {Name: "SYSTEM_TIME", MinSize: 4, MaxSize: 4},
	1106: {Name: "GOLD_ONLINE_CHECK_REMAIN", MinSize: 4, MaxSize: 4},
	2150: {Name: "GET_RELATION_LIST", MinSize: 8, MaxSize: 0},
	2157: {Name: "SEE_ONLINE", MinSize: 8, MaxSize: 8},
	2354: {Name: "GET_SOUL_BEAD_LIST", MinSize: 4, MaxSize: 0},
	2757: {Name: "MAIL_GET_UNREAD", MinSize: 4, MaxSize: 4},
	8004: {Name: "GET_BOSS_MONSTER", MinSize: 24, MaxSize: 24},

	// 物品/服装
	2601: {Name: "ITEM_BUY", MinSize: 16, MaxSize: 16},
	2604: {Name: "CHANGE_CLOTH", MinSize: 8, MaxSize: 0},
	2605: {Name: "ITEM_LIST", MinSize: 4, MaxSize: 0},

	// 精灵高级功能
	2316: {Name: "PET_HATCH_GET", MinSize: 16, MaxSize: 16},
	2318: {Name: "PET_SET_EXP", MinSize: 4, MaxSize: 4},
	2319: {Name: "PET_GET_EXP", MinSize: 4, MaxSize: 4},

	// NONO & 扩展
	9014: {Name: "NONO_CLOSE_OPEN", MinSize: 0, MaxSize: 0},
	9019: {Name: "NONO_FOLLOW_OR_HOME", MinSize: 12, MaxSize: 36},
	9003: {Name: "NONO_INFO", MinSize: 90, MaxSize: 90},

	// 地图热度
	1004: {Name: "MAP_HOT", MinSize: 4, MaxSize: 0},

	// 荣誉/超能 NONO 登录
	70000: {Name: "PET_GENE_RECAST", MinSize: 4, MaxSize: 12}, // flag + 可选 newPetId/newCatchTime
	70001: {Name: "GET_EXCHANGE_INFO", MinSize: 4, MaxSize: 0}, // count + 列表
	70002: {Name: "EXCHANGE_ITEM", MinSize: 4, MaxSize: 4},
	70003: {Name: "GET_HONOR_VALUE", MinSize: 4, MaxSize: 4},
	70004: {Name: "EXCHANGE_GOLD_NIEOBEAN", MinSize: 8, MaxSize: 8},
	70005: {Name: "GET_ACHIEVETITLE", MinSize: 4, MaxSize: 4},
	80001: {Name: "OPEN_SUPER_NONO", MinSize: 4, MaxSize: 4},
	80002: {Name: "ALERT", MinSize: 4, MaxSize: 0}, // 登录阶段也可能复用该 CMD 推送列表，故不限制上限
	80003: {Name: "ACTIVEACHIEVE", MinSize: 0, MaxSize: 0},
	80004: {Name: "ACHIEVELIST", MinSize: 4, MaxSize: 0},
	80005: {Name: "ACHIEVE_CURRENT", MinSize: 4, MaxSize: 4},
	80006: {Name: "ACHIEVEINFO", MinSize: 4, MaxSize: 4},
	80007: {Name: "GET_CURRENT_GOLD_NIEOBEAN", MinSize: 4, MaxSize: 4},
}

// Validate 对要发送的包体进行大小检查，仅记录日志，不拦截发送。
// body 为 17 字节头之后的包体。
func Validate(cmdID int32, body []byte) {
	proto, ok := protocols[cmdID]
	if !ok {
		return
	}
	actual := len(body)

	// 固定大小协议：min == max > 0
	if proto.MinSize > 0 && proto.MinSize == proto.MaxSize {
		if actual != proto.MinSize {
			logger.Warning(fmt.Sprintf("[ProtocolValidator] CMD %d (%s) 包体大小错误: 期望=%d 实际=%d",
				cmdID, proto.Name, proto.MinSize, actual))
		}
		return
	}

	// 仅有最小值，或有范围约束
	if proto.MaxSize > 0 {
		if actual < proto.MinSize || actual > proto.MaxSize {
			logger.Warning(fmt.Sprintf("[ProtocolValidator] CMD %d (%s) 包体大小超出范围: 期望[%d,%d] 实际=%d",
				cmdID, proto.Name, proto.MinSize, proto.MaxSize, actual))
		}
	} else {
		if actual < proto.MinSize {
			logger.Warning(fmt.Sprintf("[ProtocolValidator] CMD %d (%s) 包体过小: 期望≥%d 实际=%d",
				cmdID, proto.Name, proto.MinSize, actual))
		}
	}
}

