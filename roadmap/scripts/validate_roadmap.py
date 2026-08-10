#!/usr/bin/env python3
"""Validate self-contained chapter roadmap (Q&A + sample revision)."""
from __future__ import annotations
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
WEEKS = ROOT / "weeks"
REQUIRED = [
    "README.md",
    "01-foundations.md",
    "02-deep-dive.md",
    "03-production-bridge.md",
    "05-exercises.md",
]
DAYS = {
    "week-01": ["01", "02", "03", "04", "05", "06", "07"],
    "week-02": ["08", "09", "10", "11", "12", "13", "14"],
    "week-03": ["15", "16", "17", "18", "19", "20", "21"],
    "week-04": ["22", "23", "24", "25", "26", "27", "28"],
}
TECHNICAL = {f"{w}/day-{d}" for w, ds in DAYS.items() for d in ds} - {
    "week-01/day-07",
    "week-02/day-14",
    "week-03/day-21",
    "week-04/day-25",
    "week-04/day-26",
    "week-04/day-27",
    "week-04/day-28",
}
BANNED = [
    re.compile(r"go read .+ (first|before)", re.I),
    re.compile(r"\*\*Skeleton:\*\*", re.I),
]
CARD = re.compile(r"^###\s+([QIT])(\d+)\.", re.M)


def count_cards(text: str, prefix: str) -> int:
    return len(re.findall(rf"^###\s+{prefix}\d+\.", text, flags=re.M))


def main() -> int:
    errors: list[str] = []
    for week, days in DAYS.items():
        for d in days:
            folder = WEEKS / week / f"day-{d}"
            key = f"{week}/day-{d}"
            if not folder.is_dir():
                errors.append(f"missing folder {folder}")
                continue
            for name in REQUIRED:
                if not (folder / name).exists():
                    errors.append(f"{key}: missing {name}")
            if (folder / "04-questions.md").exists():
                errors.append(
                    f"{key}: root 04-questions.md should move to sample/07-revision-qna.md"
                )
            rev = folder / "sample" / "07-revision-qna.md"
            if not rev.exists():
                errors.append(f"{key}: missing sample/07-revision-qna.md")
            else:
                text = rev.read_text(encoding="utf-8")
                if "## Normal questions" not in text:
                    errors.append(f"{key}: revision missing ## Normal questions")
                if "## Indirect questions" not in text:
                    errors.append(f"{key}: revision missing ## Indirect questions")
                if "## Tricky questions" not in text:
                    errors.append(f"{key}: revision missing ## Tricky questions")
                n_q = count_cards(text, "Q")
                n_i = count_cards(text, "I")
                n_t = count_cards(text, "T")
                if n_q < 10:
                    errors.append(f"{key}: revision Normal Q count {n_q} (want ≥10)")
                if n_i < 6:
                    errors.append(f"{key}: revision Indirect I count {n_i} (want ≥6)")
                if n_t < 10:
                    errors.append(f"{key}: revision Tricky T count {n_t} (want ≥10)")
                if key in TECHNICAL and text.count("**Answer:**") < 20:
                    errors.append(
                        f"{key}: technical revision has few **Answer:** blocks "
                        f"({text.count('**Answer:**')}, want ≥20)"
                    )
                for pat in BANNED:
                    if pat.search(text):
                        errors.append(f"{key}: banned pattern {pat.pattern}")
            rev_twin = ROOT / "revision" / "weeks" / week / f"day-{d}.md"
            if not rev_twin.exists():
                errors.append(f"missing revision twin {rev_twin}")

    anki = ROOT / "flashcards" / "anki-import.csv"
    if anki.exists():
        lines = anki.read_text(encoding="utf-8").splitlines()
        if not lines or not lines[0].lower().startswith("front"):
            errors.append("anki-import.csv missing Front,Back header")
    else:
        errors.append("missing flashcards/anki-import.csv")

    if errors:
        print("FAIL")
        for e in errors:
            print(" -", e)
        return 1
    print("OK — all 28 chapters present with sample revision Q&A (Normal/Indirect/Tricky)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
