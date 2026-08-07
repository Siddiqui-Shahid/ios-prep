#!/usr/bin/env python3
"""Generate listen-only scripts for all week-*/day-*/sample Q&A markdown."""
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WEEKS = ROOT / "roadmap" / "weeks"


def md_to_speech_body(text: str) -> str:
    text = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", text)
    text = re.sub(r"[`*]{1,3}", "", text)
    text = re.sub(r"^>\s?", "", text, flags=re.M)
    lines: list[str] = []
    for line in text.splitlines():
        if re.match(r"^\s*\|?\s*:?-+:?\s*\|", line):
            continue
        if "|" in line and line.strip().startswith("|"):
            cells = [c.strip() for c in line.strip().strip("|").split("|")]
            cells = [c for c in cells if c]
            if cells and cells[0].lower() in {"follow-up", "follow-ups"}:
                continue
            if len(cells) >= 2:
                lines.append(f"{cells[0]}: {cells[1]}.")
            continue
        if re.match(r"^-{3,}\s*$", line):
            continue
        line = re.sub(r"^#{1,6}\s*", "", line)
        line = re.sub(r"^\s*[-*]\s+", "", line)
        if line.strip():
            lines.append(line.strip())
    text = " ".join(lines)
    text = re.sub(r"\s+", " ", text).strip()
    text = re.sub(r"\s*>\s*", " ", text)
    text = re.sub(r"\|\s*Follow-ups?\s*\|\s*Answer\s*\|", " ", text, flags=re.I)
    text = re.sub(r"\s+", " ", text).strip()
    text = re.sub(r"\s+\.", ".", text)
    text = re.sub(r"\?\.\s*", "? ", text)
    swaps = [
        (r"\bARC\b", "A R C"),
        (r"\bUI\b", "U I"),
        (r"\bAPI\b", "A P I"),
        (r"\bPOP\b", "P O P"),
        (r"\bGCD\b", "G C D"),
        (r"\bCOW\b", "copy on write"),
        (r"\bMVVM\b", "M V V M"),
        (r"\bSDK\b", "S D K"),
        (r"\bSDUI\b", "S D U I"),
        (r"\bVC\b", "view controller"),
        (r"\bS1\b", "S 1"),
        (r"\bS2\b", "S 2"),
        (r"\bS7\b", "S 7"),
        (r"\bS8\b", "S 8"),
        (r"\bS10\b", "S 10"),
        (r"\bCFS\b", "crash free sessions"),
        (r"\bDAU\b", "daily active users"),
        (r"\bIMOC\b", "I M O C"),
        (r"\biOS\b", "i O S"),
        (r"\bHLD\b", "high level design"),
        (r"\bDSA\b", "D S A"),
    ]
    for pat, repl in swaps:
        text = re.sub(pat, repl, text)
    if text and text[-1] not in ".!?":
        text += "."
    return text


def parse_questions(md: str) -> list[tuple[str, str]]:
    parts = re.split(r"(?=^### Q\d+\.)", md, flags=re.M)
    out: list[tuple[str, str]] = []
    for part in parts:
        m = re.match(r"^### (Q\d+\.\s+.+)$", part, flags=re.M)
        if not m:
            continue
        title = m.group(1).strip()
        rest = part[m.end() :]
        rest = re.sub(r"\*\*Points to:\*\*[^\n]*\n*", "", rest)
        # Keep listen scripts focused on answer + follow-ups (relate is read-mode).
        rest = re.sub(
            r"\*\*How can I relate to my case:\*\*[\s\S]*$",
            "",
            rest,
        )
        rest = re.sub(r"\*\*Answer:\*\*\s*", "Answer. ", rest)
        rest = re.sub(r"\*\*Follow-ups:\*\*\s*", "Follow-ups. ", rest)
        body = md_to_speech_body(rest)
        if body:
            spoken_title = title.rstrip(".")
            out.append((title, f"Next. {spoken_title} {body}"))
    return out


def generate(src: Path) -> str:
    md = src.read_text(encoding="utf-8")
    title_line = md.splitlines()[0].lstrip("# ").strip()
    qs = parse_questions(md)
    lines = [
        f"# Audio script — {title_line}",
        f"> Listen-only sample Q&A from `{src.name}`. Spoken answers and follow-ups.",
        "",
    ]
    for i, (title, speech) in enumerate(qs):
        lines += [f"## §{i} {title}", "", speech, ""]
    return "\n".join(lines).rstrip() + "\n"


def main() -> None:
    count = 0
    for sample in sorted(WEEKS.glob("week-*/day-*/sample")):
        for src in sorted(sample.glob("0*.md")):
            if src.name.endswith(".script.md"):
                continue
            dest = sample / f"{src.stem}.script.md"
            dest.write_text(generate(src), encoding="utf-8")
            count += 1
            print(f"wrote {dest.relative_to(ROOT)}")
    print(f"generated {count} sample scripts")


if __name__ == "__main__":
    main()
