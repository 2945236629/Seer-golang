package logger

import (
	"fmt"
	"os"
	"path/filepath"
	"sync"
	"time"
)

// Level 日志级别
type Level int

const (
	DebugLevel Level = iota
	InfoLevel
	WarningLevel
	ErrorLevel
	FatalLevel
)

var levelNames = map[Level]string{
	DebugLevel:   "DEBUG",
	InfoLevel:    "INFO",
	WarningLevel: "WARNING",
	ErrorLevel:   "ERROR",
	FatalLevel:   "FATAL",
}

// Logger 日志记录器
type Logger struct {
	level Level
	mu    sync.Mutex
	file  *os.File
}

// New 创建日志记录器
func New(level Level) *Logger {
	return &Logger{
		level: level,
	}
}

// Default 默认日志记录器
var Default = New(InfoLevel)

// SetLevel 设置日志级别
func SetLevel(level Level) {
	Default.level = level
}

// Debug 记录调试日志
func Debug(format string, args ...interface{}) {
	Default.log(DebugLevel, format, args...)
}

// Info 记录信息日志
func Info(format string, args ...interface{}) {
	Default.log(InfoLevel, format, args...)
}

// Warning 记录警告日志
func Warning(format string, args ...interface{}) {
	Default.log(WarningLevel, format, args...)
}

// Error 记录错误日志
func Error(format string, args ...interface{}) {
	Default.log(ErrorLevel, format, args...)
}

// Fatal 记录致命错误日志并退出
func Fatal(format string, args ...interface{}) {
	Default.log(FatalLevel, format, args...)
	os.Exit(1)
}

// log 记录日志
func (l *Logger) log(level Level, format string, args ...interface{}) {
	if level < l.level {
		return
	}

	timestamp := time.Now().Format("2006-01-02 15:04:05")
	message := fmt.Sprintf(format, args...)
	levelName := levelNames[level]
	plainLine := fmt.Sprintf("[%s] %s %s\n", timestamp, levelName, message)

	color := getColor(level)
	reset := "\033[0m"

	l.mu.Lock()
	defer l.mu.Unlock()
	fmt.Printf("%s[%s] %s%s %s\n", color, timestamp, levelName, reset, message)
	if l.file != nil {
		_, _ = l.file.WriteString(plainLine)
	}
}

// getColor 获取日志级别对应的颜色
func getColor(level Level) string {
	switch level {
	case DebugLevel:
		return "\033[36m" // Cyan
	case InfoLevel:
		return "\033[32m" // Green
	case WarningLevel:
		return "\033[33m" // Yellow
	case ErrorLevel:
		return "\033[31m" // Red
	case FatalLevel:
		return "\033[35m" // Magenta
	default:
		return "\033[0m" // Reset
	}
}

// TPrint 打印调试信息（来自Lua的tprint函数）
func TPrint(args ...interface{}) {
	for _, arg := range args {
		fmt.Printf("%v ", arg)
	}
	fmt.Println()
}

// PrintSeparator 打印分隔线
func PrintSeparator() {
	fmt.Println("===========================================================")
}

// Init 初始化日志模块
func Init() {
	// 初始化日志设置
	// 可以在这里添加更多初始化逻辑
	Info("日志模块已初始化")
}

// InitWithLogDir 初始化日志模块并启用文件日志（按日期文件名写入）
func InitWithLogDir(logDir string) {
	if logDir == "" {
		Init()
		return
	}
	if err := os.MkdirAll(logDir, 0755); err != nil {
		Init()
		Error("创建日志目录失败: %v", err)
		return
	}
	fileName := fmt.Sprintf("server-%s.log", time.Now().Format("20060102"))
	logPath := filepath.Join(logDir, fileName)
	file, err := os.OpenFile(logPath, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0644)
	if err != nil {
		Init()
		Error("打开日志文件失败: %v", err)
		return
	}
	Default.mu.Lock()
	if Default.file != nil {
		_ = Default.file.Close()
	}
	Default.file = file
	Default.mu.Unlock()
	Info("日志模块已初始化")
	Info("日志文件: %s", logPath)
}
