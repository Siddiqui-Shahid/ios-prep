#!/usr/bin/env python3
"""Validate self-contained chapter roadmap."""
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
    "04-questions.md",
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
            q = folder / "04-questions.md"
            if q.exists():
                text = q.read_text(encoding="utf-8")
                points = len(re.findall(r"Answer points", text))
                spoken = len(re.findall(r"Full spoken answer", text, flags=re.I))
                if points == 0 or spoken == 0:
                    errors.append(f"{key}: need Answer points + Full spoken answer")
                elif abs(points - spoken) > 3:
                    errors.append(
                        f"{key}: Answer points ({points}) vs Full spoken ({spoken}) mismatch"
                    )
                if key in TECHNICAL and spoken < 12:
                    errors.append(f"{key}: technical day has only {spoken} full answers (want ≥12)")
                for pat in BANNED:
                    if pat.search(text):
                        errors.append(f"{key}: banned pattern {pat.pattern}")
            rev = ROOT / "revision" / "weeks" / week / f"day-{d}.md"
            if not rev.exists():
                errors.append(f"missing revision twin {rev}")

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
    print("OK — all 28 chapters present with two-layer Q&A")
    return 0


if __name__ == "__main__":
    sys.exit(main())
