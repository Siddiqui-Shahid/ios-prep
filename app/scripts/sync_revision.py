#!/usr/bin/env python3
"""Build revision day guides + flashcard packs, patch manifest."""
from __future__ import annotations

import json
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
FLASHCARDS_SRC = ROOT / "roadmap" / "revision" / "flashcards"
GUIDES_SRC = ROOT / "roadmap" / "revision" / "weeks"
DEST_REVISION = ROOT / "app" / "assets" / "content" / "revision"
DEST_FLASHCARDS = ROOT / "app" / "assets" / "content" / "flashcards"
MANIFEST = ROOT / "app" / "assets" / "content" / "manifest.json"

SPEECH_SWAPS = [
    (r"\bARC\b", "A R C"),
    (r"\bUI\b", "U I"),
    (r"\bAPI\b", "A P I"),
    (r"\bPOP\b", "P O P"),
    (r"\bGCD\b", "G C D"),
    (r"\bCOW\b", "copy on write"),
    (r"\bMVVM\b", "M V V M"),
    (r"\bMVI\b", "M V I"),
    (r"\bSDK\b", "S D K"),
    (r"\bSDUI\b", "S D U I"),
    (r"\bVC\b", "view controller"),
    (r"\bDI\b", "D I"),
    (r"\bSPM\b", "S P M"),
    (r"\bSPKI\b", "S P K I"),
    (r"\bATS\b", "A T S"),
    (r"\bBFS\b", "B F S"),
    (r"\bDFS\b", "D F S"),
    (r"\bBST\b", "B S T"),
    (r"\bCFS\b", "crash free sessions"),
    (r"\bDAU\b", "daily active users"),
    (r"\bIMOC\b", "I M O C"),
    (r"\biOS\b", "i O S"),
    (r"\bHLD\b", "high level design"),
    (r"\bDSA\b", "D S A"),
    (r"\bBMS\b", "Book My Show"),
]


def strip_md_inline(text: str) -> str:
    text = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", text)
    text = re.sub(r"[`*]{1,3}", "", text)
    return text.strip()


def md_to_speech_body(text: str) -> str:
    text = strip_md_inline(text)
    text = re.sub(r"^>\s?", "", text, flags=re.M)
    text = re.sub(r"\s+", " ", text).strip()
    for pat, repl in SPEECH_SWAPS:
        text = re.sub(pat, repl, text)
    if text and text[-1] not in ".!?":
        text += "."
    return text


def parse_table_rows(block: str) -> list[tuple[str, str]]:
    rows: list[tuple[str, str]] = []
    for line in block.splitlines():
        line = line.strip()
        if not line.startswith("|"):
            continue
        cells = [c.strip() for c in line.strip("|").split("|")]
        if len(cells) < 2:
            continue
        front, back = cells[0], cells[1]
        if not front or front.lower() in {"front", "claim"}:
            continue
        if re.match(r"^:?-+:?$", front) or re.match(r"^:?-+:?$", back):
            continue
        rows.append((strip_md_inline(front), strip_md_inline(back)))
    return rows


def parse_flashcard_file(path: Path) -> tuple[str, list[tuple[str, str, list[tuple[str, str]]]]]:
    """Return (week_title, [(day_id, day_title, cards), ...])."""
    md = path.read_text(encoding="utf-8")
    lines = md.splitlines()
    week_title = "Flashcards"
    for line in lines:
        if line.startswith("# "):
            week_title = line[2:].strip()
            week_title = re.sub(
                r"^Week\s+(\d+)\s+Flashcards\s*[—\-]\s*",
                r"Flashcards · Week \1 — ",
                week_title,
            )
            break

    sections = re.split(r"(?=^## day-\d+)", md, flags=re.M)
    days: list[tuple[str, str, list[tuple[str, str]]]] = []
    for section in sections:
        m = re.match(
            r"^## (day-\d+)\s*[—\-]\s*(.+)$",
            section,
            flags=re.M,
        )
        if not m:
            continue
        day_id = m.group(1)
        day_title = m.group(2).strip()
        cards = parse_table_rows(section)
        if cards:
            days.append((day_id, day_title, cards))
    return week_title, days


def cards_to_qa_md(day_id: str, day_title: str, cards: list[tuple[str, str]]) -> str:
    lines = [
        f"# Flashcards — {day_title}",
        "",
        f"> Active recall for `{day_id}`. Cover the answer, speak aloud, then reveal.",
        "",
        "---",
        "",
    ]
    for i, (front, back) in enumerate(cards, 1):
        lines += [
            f"### Q{i}. {front}",
            "",
            "**Answer:**",
            "",
            f"> {back}",
            "",
            "---",
            "",
        ]
    return "\n".join(lines).rstrip() + "\n"


def cards_to_script(day_title: str, src_name: str, cards: list[tuple[str, str]]) -> str:
    lines = [
        f"# Audio script — Flashcards — {day_title}",
        f"> Listen-only flashcard Q&A from `{src_name}`. Spoken answers.",
        "",
    ]
    for i, (front, back) in enumerate(cards):
        title = f"Q{i + 1}. {front}"
        spoken_q = md_to_speech_body(front).rstrip(".")
        spoken_a = md_to_speech_body(back)
        speech = f"Next. {spoken_q}? Answer. {spoken_a}"
        lines += [f"## §{i} {title}", "", speech, ""]
    return "\n".join(lines).rstrip() + "\n"


def week_num_from_name(name: str) -> str:
    m = re.search(r"week-(\d+)", name)
    return m.group(1) if m else "00"


def clear_week_dirs(dest: Path) -> None:
    if dest.exists():
        for child in dest.iterdir():
            if child.is_dir() and child.name.startswith("week-"):
                shutil.rmtree(child)
    dest.mkdir(parents=True, exist_ok=True)


def guide_title(md: str, day_id: str) -> str:
    for line in md.splitlines():
        if line.startswith("# "):
            title = line[2:].strip()
            title = re.sub(r"^Day\s+\d+\s*[—\-]\s*", "", title)
            return title
    return day_id


def guide_to_script(day_title: str, src_name: str, md: str) -> str:
    """Build listen script from ## / ### headings + first prose/list under each."""
    lines_out = [
        f"# Audio script — Revision guide — {day_title}",
        f"> Listen-only revision day guide from `{src_name}`.",
        "",
    ]
    sections = re.split(r"(?=^#{2,3} )", md, flags=re.M)
    idx = 0
    for section in sections:
        m = re.match(r"^(#{2,3})\s+(.+)$", section, flags=re.M)
        if not m:
            continue
        heading = strip_md_inline(m.group(2))
        body = section[m.end() :]
        # Stop before nested heading of same-or-higher level handled by split
        prose_bits: list[str] = []
        for line in body.splitlines():
            if re.match(r"^#{1,3}\s+", line):
                break
            if line.startswith("```"):
                break
            if line.strip().startswith("|"):
                continue
            if re.match(r"^-{3,}\s*$", line):
                continue
            cleaned = strip_md_inline(re.sub(r"^\s*[-*]\s+", "", line))
            if cleaned:
                prose_bits.append(cleaned)
            if len(prose_bits) >= 4:
                break
        spoken = md_to_speech_body(" ".join(prose_bits) if prose_bits else heading)
        lines_out += [
            f"## §{idx} {heading}",
            "",
            f"Next. {heading}. {spoken}",
            "",
        ]
        idx += 1
    if idx == 0:
        lines_out += [
            "## §0 Full guide",
            "",
            md_to_speech_body(md[:800]),
            "",
        ]
    return "\n".join(lines_out).rstrip() + "\n"


def build_flashcard_weeks() -> list[dict]:
    clear_week_dirs(DEST_FLASHCARDS)
    flashcard_weeks: list[dict] = []
    total_cards = 0

    for fc in sorted(FLASHCARDS_SRC.glob("week-*.md")):
        week_title, days = parse_flashcard_file(fc)
        num = week_num_from_name(fc.stem)
        week_id = f"fc-week-{num.zfill(2)}"
        week_folder = f"week-{num.zfill(2)}"
        week_days: list[dict] = []

        for day_id, day_title, cards in days:
            total_cards += len(cards)
            day_dir = DEST_FLASHCARDS / week_folder / day_id
            day_dir.mkdir(parents=True, exist_ok=True)
            chapter_id = "01-flashcards"
            md_name = f"{chapter_id}.md"
            script_name = f"{chapter_id}.script.md"
            (day_dir / md_name).write_text(
                cards_to_qa_md(day_id, day_title, cards),
                encoding="utf-8",
            )
            (day_dir / script_name).write_text(
                cards_to_script(day_title, fc.name, cards),
                encoding="utf-8",
            )
            asset_base = f"assets/content/flashcards/{week_folder}/{day_id}"
            week_days.append(
                {
                    "id": day_id,
                    "title": f"Day {day_id.split('-')[1]} — Flashcards: {day_title}",
                    "chapters": [
                        {
                            "id": chapter_id,
                            "title": f"Flashcards · {len(cards)} cards",
                            "markdown": f"{asset_base}/{md_name}",
                            "script": f"{asset_base}/{script_name}",
                        }
                    ],
                }
            )
            print(f"flashcards {week_folder}/{day_id} ({len(cards)} cards)")

        flashcard_weeks.append(
            {
                "id": week_id,
                "title": week_title,
                "days": week_days,
            }
        )

    print(f"built {len(flashcard_weeks)} flashcard weeks, {total_cards} cards")
    return flashcard_weeks


def build_revision_weeks() -> list[dict]:
    clear_week_dirs(DEST_REVISION)
    revision_weeks: list[dict] = []

    for week_dir in sorted(GUIDES_SRC.glob("week-*")):
        if not week_dir.is_dir():
            continue
        num = week_num_from_name(week_dir.name)
        week_id = f"rev-week-{num.zfill(2)}"
        week_folder = f"week-{num.zfill(2)}"
        week_days: list[dict] = []
        week_title = f"Revision · Week {int(num)} — Day guides"

        for day_path in sorted(week_dir.glob("day-*.md")):
            md = day_path.read_text(encoding="utf-8")
            day_id = day_path.stem  # day-01
            day_title = guide_title(md, day_id)
            day_dir = DEST_REVISION / week_folder / day_id
            day_dir.mkdir(parents=True, exist_ok=True)
            chapter_id = "01-guide"
            md_name = f"{chapter_id}.md"
            script_name = f"{chapter_id}.script.md"
            (day_dir / md_name).write_text(md, encoding="utf-8")
            (day_dir / script_name).write_text(
                guide_to_script(day_title, day_path.name, md),
                encoding="utf-8",
            )
            asset_base = f"assets/content/revision/{week_folder}/{day_id}"
            day_num = day_id.split("-")[1]
            week_days.append(
                {
                    "id": day_id,
                    "title": f"Day {day_num} — {day_title}",
                    "chapters": [
                        {
                            "id": chapter_id,
                            "title": "Day guide",
                            "markdown": f"{asset_base}/{md_name}",
                            "script": f"{asset_base}/{script_name}",
                        }
                    ],
                }
            )
            print(f"revision {week_folder}/{day_id}")

        if week_days:
            revision_weeks.append(
                {
                    "id": week_id,
                    "title": week_title,
                    "days": week_days,
                }
            )

    print(f"built {len(revision_weeks)} revision guide weeks")
    return revision_weeks


def main() -> None:
    revision_weeks = build_revision_weeks()
    flashcard_weeks = build_flashcard_weeks()

    data = json.loads(MANIFEST.read_text(encoding="utf-8"))
    data["revisionWeeks"] = revision_weeks
    data["flashcardWeeks"] = flashcard_weeks
    MANIFEST.write_text(
        json.dumps(data, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(
        f"patched manifest: {len(revision_weeks)} revision weeks, "
        f"{len(flashcard_weeks)} flashcard weeks"
    )


if __name__ == "__main__":
    main()
