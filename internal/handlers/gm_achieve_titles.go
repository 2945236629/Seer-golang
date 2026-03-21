package handlers

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strings"
	"unicode/utf8"

	"github.com/seer-game/golang-version/internal/core/logger"
	"github.com/seer-game/golang-version/internal/server/gameserver"
)

// TitleCatalogIDSet 称号表（data/achieve.xml）中的 ID 集合；nil 或空表示未配置（合併時不剔除旧项）
func TitleCatalogIDSet() map[int]struct{} {
	path := findDataAchieveXML()
	if path == "" {
		return nil
	}
	list, err := LoadGMAchieveTitlesFromFile(path)
	if err != nil || len(list) == 0 {
		return nil
	}
	m := make(map[int]struct{}, len(list))
	for _, t := range list {
		if t.ID > 0 {
			m[t.ID] = struct{}{}
		}
	}
	return m
}

// MergeAchievementsPreservingNonTitles 用 GM 提交的 ownedTitleIDs 更新「称号类」成就，保留不在称号表中的成就 ID。
func MergeAchievementsPreservingNonTitles(existing []int, ownedTitleIDs []int, catalog map[int]struct{}) []int {
	if catalog == nil || len(catalog) == 0 {
		seen := make(map[int]struct{}, len(existing))
		for _, id := range existing {
			if id > 0 {
				seen[id] = struct{}{}
			}
		}
		out := append([]int(nil), existing...)
		for _, id := range ownedTitleIDs {
			if id <= 0 {
				continue
			}
			if _, ok := seen[id]; ok {
				continue
			}
			seen[id] = struct{}{}
			out = append(out, id)
		}
		sort.Ints(out)
		return out
	}
	var kept []int
	for _, id := range existing {
		if id <= 0 {
			continue
		}
		if _, isTitle := catalog[id]; !isTitle {
			kept = append(kept, id)
		}
	}
	seen := make(map[int]struct{}, len(kept)+len(ownedTitleIDs))
	for _, id := range kept {
		seen[id] = struct{}{}
	}
	out := append([]int(nil), kept...)
	for _, id := range ownedTitleIDs {
		if id <= 0 {
			continue
		}
		if _, ok := catalog[id]; !ok {
			continue
		}
		if _, ok := seen[id]; ok {
			continue
		}
		seen[id] = struct{}{}
		out = append(out, id)
	}
	sort.Ints(out)
	return out
}

// GMAchieveTitle GM 称号下拉项（与客户端 SpeNameBonus / 佩戴称号 ID 一致）
type GMAchieveTitle struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

var (
	reSpeNameBonus = regexp.MustCompile(`(?i)SpeNameBonus\s*=\s*"([0-9]+)"`)
	reTitleAttr    = regexp.MustCompile(`(?i)title\s*=\s*"([^"]*)"`)
)

// findDataAchieveXML 查找 data/achieve.xml（可为 JSON 数组或 AchieveXML 式 Rule 片段）
func findDataAchieveXML() string {
	exePath, err := os.Executable()
	exeDir := "."
	if err == nil {
		exeDir = filepath.Dir(exePath)
	}
	candidates := []string{
		filepath.Join("data", "achieve.xml"),
		filepath.Join("..", "data", "achieve.xml"),
		filepath.Join("..", "..", "data", "achieve.xml"),
		filepath.Join(exeDir, "data", "achieve.xml"),
		filepath.Join(exeDir, "..", "data", "achieve.xml"),
	}
	if cwd, err := os.Getwd(); err == nil {
		dir := cwd
		for i := 0; i < 10; i++ {
			candidates = append(candidates, filepath.Join(dir, "data", "achieve.xml"))
			parent := filepath.Dir(dir)
			if parent == dir {
				break
			}
			dir = parent
		}
	}
	seen := map[string]struct{}{}
	for _, p := range candidates {
		if ap, err := filepath.Abs(p); err == nil {
			p = ap
		}
		if _, ok := seen[p]; ok {
			continue
		}
		seen[p] = struct{}{}
		if st, err := os.Stat(p); err == nil && !st.IsDir() {
			return p
		}
	}
	return ""
}

func extractRuleInnerChunks(raw []byte) [][]byte {
	var chunks [][]byte
	parts := bytes.Split(raw, []byte("<Rule"))
	for _, p := range parts[1:] {
		if i := bytes.Index(p, []byte("/>")); i >= 0 {
			chunks = append(chunks, p[:i])
		} else if i := bytes.Index(p, []byte("</Rule>")); i >= 0 {
			chunks = append(chunks, p[:i])
		}
	}
	return chunks
}

func decodeTitleBytes(b []byte) string {
	if !utf8.Valid(b) {
		b = []byte(strings.ToValidUTF8(string(b), ""))
	}
	return strings.ReplaceAll(string(b), "|", "")
}

// LoadGMAchieveTitlesFromFile 解析 data/achieve.xml：JSON 数组优先，否则按 <Rule> 提取 SpeNameBonus/title
func LoadGMAchieveTitlesFromFile(path string) ([]GMAchieveTitle, error) {
	raw, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}
	raw = bytes.TrimSpace(raw)
	if len(raw) == 0 {
		return nil, nil
	}
	first := raw[0]
	if first == '[' {
		var arr []GMAchieveTitle
		if err := json.Unmarshal(raw, &arr); err != nil {
			return nil, fmt.Errorf("JSON 数组解析失败: %w", err)
		}
		return normalizeTitles(arr), nil
	}
	if first == '{' {
		var wrap struct {
			Titles []GMAchieveTitle `json:"titles"`
		}
		if err := json.Unmarshal(raw, &wrap); err == nil && len(wrap.Titles) > 0 {
			return normalizeTitles(wrap.Titles), nil
		}
		var single GMAchieveTitle
		if err := json.Unmarshal(raw, &single); err == nil && single.ID > 0 {
			return normalizeTitles([]GMAchieveTitle{single}), nil
		}
		return nil, fmt.Errorf("JSON 对象解析失败")
	}
	return parseTitlesFromAchieveXMLBytes(raw), nil
}

func normalizeTitles(in []GMAchieveTitle) []GMAchieveTitle {
	out := make([]GMAchieveTitle, 0, len(in))
	seen := map[int]struct{}{}
	for _, t := range in {
		if t.ID <= 0 {
			continue
		}
		if _, ok := seen[t.ID]; ok {
			continue
		}
		seen[t.ID] = struct{}{}
		n := strings.TrimSpace(t.Name)
		if n == "" {
			n = fmt.Sprintf("称号#%d", t.ID)
		}
		out = append(out, GMAchieveTitle{ID: t.ID, Name: n})
	}
	sort.Slice(out, func(i, j int) bool { return out[i].ID < out[j].ID })
	return out
}

func parseTitlesFromAchieveXMLBytes(raw []byte) []GMAchieveTitle {
	m := make(map[int]string)
	for _, chunk := range extractRuleInnerChunks(raw) {
		sm := reSpeNameBonus.FindSubmatch(chunk)
		if len(sm) < 2 {
			continue
		}
		var id int
		_, _ = fmt.Sscanf(string(sm[1]), "%d", &id)
		if id <= 0 {
			continue
		}
		name := fmt.Sprintf("称号#%d", id)
		if tm := reTitleAttr.FindSubmatch(chunk); len(tm) >= 2 {
			name = decodeTitleBytes(tm[1])
			if strings.TrimSpace(name) == "" {
				name = fmt.Sprintf("称号#%d", id)
			}
		}
		m[id] = name
	}
	out := make([]GMAchieveTitle, 0, len(m))
	for id, name := range m {
		out = append(out, GMAchieveTitle{ID: id, Name: name})
	}
	sort.Slice(out, func(i, j int) bool { return out[i].ID < out[j].ID })
	return out
}

// handleGMAchieveTitles GET /gm/achieve-titles — 从 data/achieve.xml 读取称号列表供 GM 下拉
func handleGMAchieveTitles(w http.ResponseWriter, r *http.Request, gs *gameserver.GameServer) {
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	if r.Method != http.MethodGet {
		_ = json.NewEncoder(w).Encode(map[string]interface{}{"success": false, "message": "只支持 GET"})
		return
	}
	path := findDataAchieveXML()
	if path == "" {
		logger.Warning("[GM] data/achieve.xml 未找到")
		_ = json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "未找到 data/achieve.xml",
			"data":    []GMAchieveTitle{},
		})
		return
	}
	list, err := LoadGMAchieveTitlesFromFile(path)
	if err != nil {
		logger.Warning("[GM] 读取 achieve.xml 失败: " + err.Error())
		_ = json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": err.Error(),
			"data":    []GMAchieveTitle{},
		})
		return
	}
	_ = json.NewEncoder(w).Encode(map[string]interface{}{
		"success": true,
		"source":  path,
		"data":    list,
	})
}
