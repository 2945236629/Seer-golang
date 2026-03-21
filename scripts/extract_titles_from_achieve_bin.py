# -*- coding: utf-8 -*-
"""
从 AchieveXMLInfo_xmlClass.bin 中按 <Rule> 块解析 SpeNameBonus + title。
用法: python extract_titles_from_achieve_bin.py [path/to/40_...AchieveXMLInfo_xmlClass.bin]
默认使用仓库内 swf 解包文件（与客户端一致）。
"""
import json
import re
import sys
from pathlib import Path


def decode_title_bytes(b: bytes) -> str:
    if not b:
        return ""
    try:
        s = b.decode("utf-8")
        if "\ufffd" not in s:
            return s
    except UnicodeDecodeError:
        pass
    for enc in ("gb18030", "gbk"):
        try:
            return b.decode(enc)
        except UnicodeDecodeError:
            continue
    return b.decode("utf-8", errors="replace")


def extract_rule_inner_chunks(raw: bytes) -> list[bytes]:
    """每个元素为一条 Rule 的属性区字节（不含 <Rule 与结束符）。"""
    chunks: list[bytes] = []
    parts = raw.split(b"<Rule")
    for p in parts[1:]:
        if b"/>" in p:
            end = p.index(b"/>")
            chunks.append(p[:end])
        elif b"</Rule>" in p:
            end = p.index(b"</Rule>")
            chunks.append(p[:end])
    return chunks


def parse_attr_bytes(chunk: bytes, key: str) -> bytes | None:
    # key="SpeNameBonus" -> SpeNameBonus = "123"
    pat = re.compile(
        re.escape(key.encode("ascii")) + rb'\s*=\s*"([^"]*)"',
        re.IGNORECASE,
    )
    m = pat.search(chunk)
    return m.group(1) if m else None


def extract_titles(raw: bytes) -> dict[int, str]:
    titles: dict[int, str] = {}
    for chunk in extract_rule_inner_chunks(raw):
        spb = parse_attr_bytes(chunk, "SpeNameBonus")
        if not spb or not spb.isdigit():
            continue
        tid = int(spb)
        tb = parse_attr_bytes(chunk, "title")
        if tb is None:
            name = f"称号#{tid}"
        else:
            name = decode_title_bytes(tb).replace("|", "")
            if not name.strip():
                name = f"称号#{tid}"
        titles[tid] = name
    return titles


def main() -> None:
    default = (
        Path(__file__).resolve().parents[1]
        / "swf解包"
        / "NieoCore"
        / "binaryData"
        / "40_com.robot.core.config.xml.AchieveXMLInfo_xmlClass.bin"
    )
    bin_path = Path(sys.argv[1]) if len(sys.argv) > 1 else default
    if not bin_path.is_file():
        print("missing", bin_path)
        sys.exit(1)
    raw = bin_path.read_bytes()
    titles = extract_titles(raw)
    items = [{"id": k, "name": v} for k, v in sorted(titles.items())]
    root = Path(__file__).resolve().parents[1]
    gm_json = root / "GM" / "gm_title_list.json"
    gm_json.parent.mkdir(parents=True, exist_ok=True)
    gm_json.write_text(
        json.dumps(items, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    test_json = root / "test" / "gm_title_list.json"
    test_json.write_text(
        json.dumps(
            {"source": str(bin_path), "count": len(items), "titles": items},
            ensure_ascii=False,
            indent=2,
        ),
        encoding="utf-8",
    )
    print(gm_json, "and", test_json, "->", len(items), "titles")


if __name__ == "__main__":
    main()
