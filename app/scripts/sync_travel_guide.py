#!/usr/bin/env python3
"""Copy Mumbai–Pune travel guide into Flutter assets and patch manifest.guideWeeks."""
from __future__ import annotations

import json
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SRC = ROOT / "roadmap" / "travel-guide"
DEST = ROOT / "app" / "assets" / "content" / "travel-guide"
MANIFEST = ROOT / "app" / "assets" / "content" / "manifest.json"

DAYS: list[tuple[str, str]] = [
    ("start", "Start — 60–90 minute ride plan"),
    ("ios-basics", "iOS basics — language, memory, lifecycle"),
    ("lld", "LLD — classes, sequences, iOS APIs"),
    ("hld", "HLD — scale, APIs, caching, mobile constraints"),
    ("prototype", "Prototype — 10–15 minute overflow"),
    ("trip-a", "Trip A — Mumbai → Pune (75 min)"),
    ("trip-b", "Trip B — Pune → Mumbai (75 min)"),
    ("trip-c", "Trip C — rotation (75 min, images)"),
    ("trip-d", "Trip D — LLD mock (75 min)"),
    ("trip-e", "Trip E — HLD / car (75 min)"),
    ("interview", "Interview checklists and sample answers"),
]

Q_SRC = ROOT / "roadmap" / "machine-questions"
Q_DEST = ROOT / "app" / "assets" / "content" / "machine-questions"
SYSTEM_DESIGN_SRC = ROOT / "ios-system-design" / "docs"
SYSTEM_DESIGN_DEST = ROOT / "app" / "assets" / "content" / "system-designs"


def title_from_markdown(path: Path) -> str:
    lines = path.read_text(encoding="utf-8").splitlines()
    for line in lines:
        if line.startswith("# "):
            return line[2:].strip()
        # A few source specs intentionally use an unadorned title before the
        # first section heading. Prefer it over a later code-example heading.
        if line.strip() and not line.startswith(("<", "#", "[", "!")):
            return line.strip()
    return path.stem.replace("-", " ")


def write_script(md_path: Path, script_path: Path) -> None:
    text = md_path.read_text(encoding="utf-8")
    title = title_from_markdown(md_path)
    parts: list[tuple[str, str]] = []
    current_title = "Introduction"
    buf: list[str] = []

    def flush() -> None:
        body = "\n".join(buf).strip()
        if body:
            parts.append((current_title, body))

    for line in text.splitlines():
        if line.startswith("## "):
            flush()
            buf = []
            current_title = line[3:].strip()
            continue
        buf.append(line)
    flush()

    if not parts:
        parts = [("Full chapter", text)]

    out: list[str] = [f"# Audio script — {title}", ""]
    for i, (sec_title, body) in enumerate(parts):
        spoken = re.sub(r"[#*`>_]", " ", body)
        spoken = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", spoken)
        spoken = re.sub(r"\s+", " ", spoken).strip()
        if len(spoken) > 2500:
            spoken = spoken[:2500] + " End of section."
        out.append(f"## §{i} {sec_title}")
        out.append("")
        out.append(spoken)
        out.append("")
    script_path.write_text("\n".join(out), encoding="utf-8")


def copy_folder(src: Path, dest: Path, asset_prefix: str, days: list[tuple[str, str]] | None = None) -> list[dict]:
    if dest.exists():
        shutil.rmtree(dest)
    dest.mkdir(parents=True)
    if days is None:
        # One day per markdown file in src root.
        chapters: list[dict] = []
        dest.mkdir(parents=True, exist_ok=True)
        day_id = "all"
        day_dir = dest / day_id
        day_dir.mkdir(parents=True)
        for md in sorted(src.glob("*.md")):
            shutil.copy2(md, day_dir / md.name)
            script_name = md.name.replace(".md", ".script.md")
            write_script(md, day_dir / script_name)
            chapters.append(
                {
                    "id": md.stem,
                    "title": title_from_markdown(md),
                    "markdown": f"assets/content/{asset_prefix}/{day_id}/{md.name}",
                    "script": f"assets/content/{asset_prefix}/{day_id}/{script_name}",
                }
            )
        return [{"id": day_id, "title": "All 30 questions", "chapters": chapters}]

    days_json: list[dict] = []
    for day_id, day_title in days:
        src_day = src / day_id
        dest_day = dest / day_id
        dest_day.mkdir(parents=True)
        chapters: list[dict] = []
        for md in sorted(src_day.glob("*.md")):
            if md.name.endswith(".script.md"):
                continue
            shutil.copy2(md, dest_day / md.name)
            script_name = md.name.replace(".md", ".script.md")
            write_script(md, dest_day / script_name)
            chapters.append(
                {
                    "id": md.stem,
                    "title": title_from_markdown(md),
                    "markdown": f"assets/content/{asset_prefix}/{day_id}/{md.name}",
                    "script": f"assets/content/{asset_prefix}/{day_id}/{script_name}",
                }
            )
        days_json.append({"id": day_id, "title": day_title, "chapters": chapters})
    return days_json


def copy_days() -> list[dict]:
    return copy_folder(SRC, DEST, "travel-guide", DAYS)


def copy_flat_days(src: Path, dest: Path, asset_prefix: str) -> list[dict]:
    """Each markdown file in src becomes one day with one chapter (flat dest)."""
    if dest.exists():
        shutil.rmtree(dest)
    dest.mkdir(parents=True)
    days_json: list[dict] = []
    for md in sorted(src.glob("*.md")):
        if md.name.endswith(".script.md"):
            continue
        shutil.copy2(md, dest / md.name)
        script_name = md.name.replace(".md", ".script.md")
        write_script(md, dest / script_name)
        title = title_from_markdown(md)
        days_json.append(
            {
                "id": md.stem,
                "title": title,
                "chapters": [
                    {
                        "id": md.stem,
                        "title": title,
                        "markdown": f"assets/content/{asset_prefix}/{md.name}",
                        "script": f"assets/content/{asset_prefix}/{script_name}",
                    }
                ],
            }
        )
    return days_json


def copy_questions() -> list[dict]:
    if Q_DEST.exists():
        shutil.rmtree(Q_DEST)
    mapping = [
        (
            "01-questions-01-10.md",
            "q-01-10",
            "Questions 01–10 — feeds, media, sync",
        ),
        (
            "02-questions-11-20.md",
            "q-11-20",
            "Questions 11–20 — auth, commerce, realtime",
        ),
        (
            "03-questions-21-30.md",
            "q-21-30",
            "Questions 21–30 — platform, AI, calling",
        ),
    ]
    days_json: list[dict] = []
    for filename, day_id, day_title in mapping:
        md = Q_SRC / filename
        dest_day = Q_DEST / day_id
        dest_day.mkdir(parents=True)
        shutil.copy2(md, dest_day / md.name)
        script_name = md.name.replace(".md", ".script.md")
        write_script(md, dest_day / script_name)
        days_json.append(
            {
                "id": day_id,
                "title": day_title,
                "chapters": [
                    {
                        "id": md.stem,
                        "title": title_from_markdown(md),
                        "markdown": f"assets/content/machine-questions/{day_id}/{md.name}",
                        "script": f"assets/content/machine-questions/{day_id}/{script_name}",
                    }
                ],
            }
        )
    return days_json


def main() -> None:
    days = copy_days()
    questions = copy_questions()
    trips = copy_flat_days(
        ROOT / "roadmap" / "study" / "trips",
        ROOT / "app" / "assets" / "content" / "study-trips",
        "study-trips",
    )
    topics = copy_flat_days(
        ROOT / "roadmap" / "study" / "topics",
        ROOT / "app" / "assets" / "content" / "study-topics",
        "study-topics",
    )
    weak = copy_flat_days(
        ROOT / "roadmap" / "study" / "weak-points",
        ROOT / "app" / "assets" / "content" / "study-weak",
        "study-weak",
    )
    system_designs = copy_flat_days(
        SYSTEM_DESIGN_SRC,
        SYSTEM_DESIGN_DEST,
        "system-designs",
    )
    data = json.loads(MANIFEST.read_text(encoding="utf-8"))
    data["guideWeeks"] = [
        {
            "id": "trips-mumbai-pune",
            "title": "Sequential trips (60–90 min each)",
            "days": trips,
        },
        {
            "id": "travel-mumbai-pune",
            "title": "Reference: old ride chapters (LLD/HLD/basics)",
            "days": days,
        },
    ]
    data["topicWeeks"] = [
        {
            "id": "study-topics",
            "title": "Study by topic",
            "days": topics,
        }
    ]
    data["weakPointWeeks"] = [
        {
            "id": "interview-weak-points",
            "title": "Weak points from interviews",
            "days": weak,
        }
    ]
    data["questionWeeks"] = [
        {
            "id": "machine-design-30",
            "title": "30 machine design questions",
            "days": questions,
        }
    ]
    data["systemDesignWeeks"] = [
        {
            "id": "system-design-library",
            "title": "Production mobile system-design case studies",
            "days": system_designs,
        }
    ]
    MANIFEST.write_text(
        json.dumps(data, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(f"trips: {len(trips)}  topics: {len(topics)}  weak: {len(weak)}")
    print(f"travel reference: {len(days)} days")
    print(f"machine questions: {sum(len(d['chapters']) for d in questions)} chapters")
    print(f"system designs: {len(system_designs)} case studies")


if __name__ == "__main__":
    main()
