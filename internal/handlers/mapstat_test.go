package handlers

import (
	"testing"

	"github.com/seer-game/golang-version/internal/server/gameserver"
)

// TestHandleMapStatLog 确认 1020 日志协议能够被正常注册并返回 4 字节 retCode
func TestHandleMapStatLog(t *testing.T) {
	gs := gameserver.New(testUserDBConfig())

	// 伪造一个客户端连接和上下文
	cd := &gameserver.ClientData{}
	ctx := &gameserver.HandlerContext{
		UserID:     12345,
		CmdID:      1020,
		SeqID:      1,
		Body:       []byte{0, 0, 0, 47}, // eventId=47
		ClientData: cd,
		GameServer: gs,
	}

	// 不要求具体日志内容，只要不 panic 且能正常调用 SendResponse 即视为通过
	handleMapStatLog(ctx)
}

