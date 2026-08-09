#!/usr/bin/env python3
"""Attach per-day `code` entries to assets/content/manifest.json from synced files.
Also refresh chapter titles from markdown H1 (human names for production samples),
and auto-append any missing numbered sample chapters (e.g. 05-system-design-mock).
"""
from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "assets" / "content" / "manifest.json"
CONTENT = ROOT / "assets" / "content"


def code_files_for(week_id: str, day_id: str) -> list[dict]:
    day_dir = CONTENT / week_id / day_id
    if not day_dir.is_dir():
        return []
    out: list[dict] = []
    for path in sorted(day_dir.iterdir()):
        if not path.is_file():
            continue
        if path.suffix.lower() not in {".swift", ".md", ".txt", ".json"}:
            continue
        # Sample Q&A / scripts live alongside — only treat lab filenames as code.
        name = path.name
        if name.endswith(".script.md"):
            continue
        if name[0].isdigit() and name.endswith(".md"):
            # 01-foo.md sample chapters
            continue
        if name.lower() == "readme.md":
            continue
        lang = {
            ".swift": "swift",
            ".md": "markdown",
            ".json": "json",
            ".txt": "text",
        }.get(path.suffix.lower(), "text")
        out.append(
            {
                "id": name,
                "title": name,
                "asset": f"assets/content/{week_id}/{day_id}/{name}",
                "language": lang,
            }
        )
    return out


def title_from_markdown(path: Path) -> str | None:
    if not path.is_file():
        return None
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith("# "):
            t = line[2:].strip()
            t = re.sub(r"^Sample\s+\d+\s*[—\-]\s*", "", t)
            if not t.endswith("(Q&A)"):
                t = re.sub(r"\s*\(Q&A\)\s*$", "", t).strip() + " (Q&A)"
            return t
    return None


def sample_chapters_for(week_id: str, day_id: str) -> list[dict]:
    """Discover numbered sample Q&A markdown files (+ scripts) under a day folder."""
    day_dir = CONTENT / week_id / day_id
    if not day_dir.is_dir():
        return []
    chapters: list[dict] = []
    for path in sorted(day_dir.glob("0*.md")):
        if path.name.endswith(".script.md"):
            continue
        if not path.name[0].isdigit():
            continue
        stem = path.stem
        script = day_dir / f"{stem}.script.md"
        title = title_from_markdown(path) or f"{stem} (Q&A)"
        ch: dict = {
            "id": stem,
            "title": title,
            "markdown": f"assets/content/{week_id}/{day_id}/{path.name}",
        }
        if script.is_file():
            ch["script"] = f"assets/content/{week_id}/{day_id}/{script.name}"
        chapters.append(ch)
    return chapters


def sync_sample_chapters(data: dict) -> int:
    """Replace/merge day chapters so all discovered 0N-*.md samples are listed."""
    added = 0
    for week in data.get("weeks", []):
        week_id = week["id"]
        for day in week.get("days", []):
            day_id = day["id"]
            discovered = sample_chapters_for(week_id, day_id)
            if not discovered:
                continue
            existing = {c["id"]: c for c in day.get("chapters", [])}
            # Preserve non-sample chapters (shouldn't exist, but be safe).
            non_sample = [
                c
                for c in day.get("chapters", [])
                if not re.match(r"^\d{2}-", c.get("id", ""))
            ]
            merged: list[dict] = []
            for ch in discovered:
                old = existing.get(ch["id"])
                if old:
                    # Keep existing title unless production/S-code refresh path prefers H1.
                    if "production" not in ch["id"] and not re.search(
                        r"\bS\d", old.get("title", "")
                    ):
                        # Prefer discovered H1 for new cards; keep old for stable 01-04
                        # unless missing script path that now exists.
                        ch["title"] = old.get("title", ch["title"])
                    if old.get("script") and "script" not in ch:
                        ch["script"] = old["script"]
                else:
                    added += 1
                merged.append(ch)
            day["chapters"] = merged + non_sample
    return added


def refresh_chapter_titles(data: dict) -> int:
    updated = 0
    for week in data.get("weeks", []):
        for day in week.get("days", []):
            for ch in day.get("chapters", []):
                md_path = ROOT / ch["markdown"]
                new_title = title_from_markdown(md_path)
                if not new_title or new_title == ch.get("title"):
                    continue
                # Prefer H1 when chapter is production-tagged, title still has S-codes,
                # or chapter is the system-design mock (keep title in sync with card).
                if (
                    "production" in ch["id"]
                    or "system-design" in ch["id"]
                    or re.search(r"\bS\d", ch.get("title", ""))
                ):
                    ch["title"] = new_title
                    updated += 1
    return updated


def main() -> None:
    data = json.loads(MANIFEST.read_text(encoding="utf-8"))
    added = sync_sample_chapters(data)
    total = 0
    for week in data.get("weeks", []):
        week_id = week["id"]
        for day in week.get("days", []):
            day_id = day["id"]
            files = code_files_for(week_id, day_id)
            day["code"] = files
            total += len(files)
    titles = refresh_chapter_titles(data)
    MANIFEST.write_text(
        json.dumps(data, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(
        f"patched manifest: {total} code files, {titles} titles refreshed, "
        f"{added} sample chapters added"
    )


if __name__ == "__main__":
    main()
