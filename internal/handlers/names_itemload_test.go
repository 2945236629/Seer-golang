package handlers

import (
	"os"
	"path/filepath"
	"sync"
	"testing"
)

func TestGetItemName_LoadsItemsXmlWhenStartedFromSubdir(t *testing.T) {
	oldWD, err := os.Getwd()
	if err != nil {
		t.Fatalf("Getwd: %v", err)
	}
	t.Cleanup(func() { _ = os.Chdir(oldWD) })

	// Locate repo root by finding data/items.xml upward from current directory.
	root := ""
	dir := oldWD
	for i := 0; i <= 8; i++ {
		if _, err := os.Stat(filepath.Join(dir, "data", "items.xml")); err == nil {
			root = dir
			break
		}
		parent := filepath.Dir(dir)
		if parent == dir {
			break
		}
		dir = parent
	}
	if root == "" {
		t.Skip("repo data/items.xml not found from test working dir")
	}

	subdir := filepath.Join(root, "cmd", "gameserver")
	if _, err := os.Stat(subdir); err != nil {
		t.Skipf("subdir not found: %s", subdir)
	}
	if err := os.Chdir(subdir); err != nil {
		t.Fatalf("Chdir(%s): %v", subdir, err)
	}

	// Reset caches to force path-resolution code to run under this working directory.
	ItemNames = map[int]string{}
	itemEffects = map[int]ItemEffect{}
	battleItemEffects = map[int]BattleItemEffect{}
	outOfFightItemEffects = map[int]OutOfFightItemEffect{}
	itemContentProvider = nil
	itemNamesOnce = sync.Once{}

	name := GetItemName(1)
	if name == "" || name == "未知道具" {
		t.Fatalf("expected item name loaded from items.xml, got %q", name)
	}
}

