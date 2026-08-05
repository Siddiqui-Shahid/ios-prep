#!/usr/bin/env python3
"""Generate listen-only audiobook scripts in very simple English.

Listener may have eyes closed or phone in pocket.
Explain every idea from the basics in short sentences.
Resume-safe shortforms only (UI, AI, POP, MVVM, GCD, API, SDK, UIKit, SwiftUI, SDUI).
Expand uncommon ones (PAT → protocol with associated type; COW → copy on write).
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WEEK = ROOT / "roadmap" / "weeks" / "week-01"

CHAPTER_TITLES = {
    "01-foundations": "01 Foundations",
    "02-deep-dive": "02 Deep Dive",
    "03-production-bridge": "03 Production Bridge",
    "04-questions": "04 Questions",
    "05-exercises": "05 Exercises",
}

# Strip visual / slang phrasing
PLAIN_ENGLISH = [
    (r"\bnorth star\b", "main guiding idea"),
    (r"\bAlright\.?\s*", ""),
    (r"\bOK\.?\s*", ""),
    (r"\bOkay\.?\s*", ""),
    (r"\btrip-?ups?\b", "common mistakes"),
    (r"\bcrisp\b", "clear"),
    (r"\bintern demo\b", "simple example"),
    (r"\bdo this once out loud\b", "remember this example"),
    (r"\bmust say aloud\b", "must be able to explain"),
    (r"\bSay aloud:?\s*", "Remember: "),
    (r"\bSay this out loud[^.]*\.\s*", ""),
    (r"\bYour turn\.?\s*", ""),
    (r"\bKeep the chapter open\.?\s*", ""),
    (r"\bI will teach\.?\s*", ""),
    (r"\bYou follow on screen\.?\s*", ""),
    (r"\bLook at[^.]*\.\s*", ""),
    (r"\bGlance at[^.]*\.\s*", ""),
    (r"\bon screen\b", ""),
    (r"\bin the text\b", ""),
    (r"\bwhile you listen\b", ""),
    (r"\bFollow the same example[^.]*\.\s*", ""),
    (r"\bHere is a diagram from the chapter\.\s*", "Picture this. "),
    (r"\bHere is a Swift example from the chapter\.\s*", "Here is a simple Swift example. "),
    (r"\bHere is an example from the chapter\.\s*", "Here is a simple example. "),
    (r"\bfrom the chapter\b", ""),
    (r"\bDo not read every line\.\s*", ""),
    (r"\bNotice this idea:\s*", "In short: "),
    (r"\bThat is the point of the example\.\s*", ""),
    (r"\bSo the takeaway is simple\.\s*", "What to remember: "),
    (r"\bThat is how you sound senior and clear\.\s*", ""),
    (r"\bThis foundation shows up in almost every senior i O S interview\.\s*", ""),
    (r"\bThis section is:\s*", "Next. "),
    (r"\bThis section is titled\s+", "Next topic: "),
    (r"\bleverage\b", "use"),
    (r"\butilize\b", "use"),
    (r"\brobust\b", "strong"),
    (r"\bseamless\b", "smooth"),
    (r"\bparadigm\b", "way of thinking"),
    (r"\bidiomatic\b", "natural"),
    (r"\borthogonal\b", "separate"),
    (r"\bnuance\b", "small difference"),
    (r"\bnuances\b", "small differences"),
]

# Expand uncommon shortforms first (before letter-spelling).
EXPAND_SHORTFORMS = [
    (r"\bPAT\b", "protocol with associated type"),
    (r"\bPATs\b", "protocols with associated types"),
    (r"\bCOW\b", "copy on write"),
    (r"\bDTO\b", "data transfer object"),
    (r"\bDTOs\b", "data transfer objects"),
    (r"\bARC\b", "automatic reference counting"),
    (r"\bWWDC\b", "Apple developer conference"),
    (r"\bUUID\b", "unique id"),
    (r"\bCPU\b", "processor"),
    (r"\bGPU\b", "graphics chip"),
    (r"\bURI\b", "web address"),
    (r"\bHTTPS\b", "secure H T T P"),
    (r"\bHTTP\b", "H T T P"),
    (r"\bJSON\b", "Jason"),
    (r"\bNSObject\b", "N S object"),
    (r"\bAppKit\b", "App kit"),
]

# Resume-safe shortforms: spell letter by letter for TTS.
SPELL_SHORTFORMS = [
    (r"\bUI\b", "U I"),
    (r"\bAI\b", "A I"),
    (r"\bPOP\b", "P O P"),
    (r"\bAPI\b", "A P I"),
    (r"\bGCD\b", "G C D"),
    (r"\bMVVM\b", "M V V M"),
    (r"\bMVC\b", "M V C"),
    (r"\bSDK\b", "S D K"),
    (r"\bSDUI\b", "S D U I"),
    (r"\bURL\b", "U R L"),
    (r"\biOS\b", "i O S"),
    (r"\bID\b", "I D"),
    (r"\bUIKit\b", "U I kit"),
    (r"\bSwiftUI\b", "Swift U I"),
    (r"\bXcode\b", "X code"),
]


def expand_shortforms(text: str) -> str:
    for pat, repl in EXPAND_SHORTFORMS:
        text = re.sub(pat, repl, text)
    return text


def spell_acronyms(text: str) -> str:
    for pat, repl in SPELL_SHORTFORMS:
        text = re.sub(pat, repl, text)
    return text


def plain_english(text: str) -> str:
    text = re.sub(r"\bnorth star\b", "main guiding idea", text, flags=re.IGNORECASE)
    for pat, repl in PLAIN_ENGLISH:
        text = re.sub(pat, repl, text, flags=re.IGNORECASE)
    text = re.sub(r"\s{2,}", " ", text)
    text = re.sub(r"\s+\.", ".", text)
    return text.strip()


def shorten_sentences(text: str, max_words: int = 18) -> str:
    """Split long sentences so speech stays easy to follow."""
    parts = re.split(r"(?<=[.!?])\s+", text)
    out: list[str] = []
    for part in parts:
        words = part.split()
        if len(words) <= max_words:
            if part.strip():
                out.append(part.strip())
            continue
        # Prefer splitting on commas / and / so
        chunks: list[str] = []
        buf: list[str] = []
        for w in words:
            buf.append(w)
            joined = " ".join(buf)
            at_break = w.endswith(",") or w.lower() in {"and", "so", "because", "then"}
            if len(buf) >= 10 and at_break:
                chunk = joined.rstrip(",")
                if not chunk.endswith("."):
                    chunk += "."
                chunks.append(chunk)
                buf = []
            elif len(buf) >= max_words:
                chunk = " ".join(buf)
                if not chunk.endswith((".", "!", "?")):
                    chunk += "."
                chunks.append(chunk)
                buf = []
        if buf:
            chunk = " ".join(buf)
            if not chunk.endswith((".", "!", "?")):
                chunk += "."
            chunks.append(chunk)
        out.extend(chunks)
    return " ".join(out)


def describe_code(block: str) -> str:
    """Narrate code fully in simple words for eyes-free listening."""
    m = re.match(r"```(\w+)?\n([\s\S]*?)```", block)
    lang = (m.group(1) or "").strip() if m else ""
    body = m.group(2) if m else block
    lines = [ln.rstrip() for ln in body.splitlines() if ln.strip()]

    joined = " ".join(lines)
    lower = joined.lower()

    if "struct " in joined and "class " not in joined and "var b = a" in joined.replace(" ", ""):
        return (
            "Here is a simple example with a struct. "
            "A struct is a value type. "
            "That means each copy is its own data. "
            "Create point A. "
            "Assign B equals A. "
            "Change B. "
            "A does not change. "
            "Why this matters: value types avoid shared surprise changes. "
            "What to remember: structs copy."
        )
    if "class " in joined and ("var d = c" in joined.replace(" ", "") or "d.value" in joined):
        return (
            "Here is a simple example with a class. "
            "A class is a reference type. "
            "That means names can share one object. "
            "Create object C. "
            "Assign D equals C. "
            "Change D. "
            "C also changes. "
            "Why this matters: shared objects can surprise you. "
            "What to remember: classes share."
        )
    if "enum " in lower and ("case " in lower or "associated" in lower):
        return (
            "Here is a simple example with an enum. "
            "An enum is a fixed set of modes. "
            "Each case is one mode. "
            "Some cases can carry extra data. "
            "A switch must handle every case. "
            "Why this matters: enums make illegal states hard. "
            "What to remember: model states with enums."
        )
    if "actor " in lower:
        return (
            "Here is a simple example with an actor. "
            "An actor protects its own data. "
            "Other work talks to it with await. "
            "Access happens one at a time. "
            "Why this matters: fewer data races. "
            "What to remember: actors isolate mutable state."
        )
    if "protocol " in lower and ("associatedtype" in lower or "associated type" in lower):
        return (
            "Here is a simple example with a protocol that has an associated type. "
            "That means the protocol names a placeholder type. "
            "Each adopter fills in its own concrete type. "
            "Why this matters: flexible designs without a shared base class. "
            "What to remember: associated type is filled in by the adopter."
        )
    if "protocol " in lower:
        return (
            "Here is a simple example with a protocol. "
            "A protocol is a list of capabilities. "
            "A type can adopt it without sharing a base class. "
            "Why this matters: this is protocol oriented programming, or P O P. "
            "What to remember: protocols describe behavior."
        )
    if "func " in lower and "async" in lower:
        return (
            "Here is a simple example with an async function. "
            "Async means the function can pause. "
            "It pauses at await while waiting. "
            "Other work can run during the wait. "
            "Why this matters: the U I stays responsive. "
            "What to remember: await marks a pause point."
        )

    spoken = []
    for ln in lines[:6]:
        clean = re.sub(r"[{};]", " ", ln)
        clean = re.sub(r"[<>]", " ", clean)
        clean = re.sub(r"\s+", " ", clean).strip()
        clean = re.sub(r"[=]", " equals ", clean)
        clean = re.sub(r"->", " returns ", clean)
        if clean:
            spoken.append(clean)
    detail = ". ".join(spoken)[:280]
    kind = "Swift" if lang == "swift" else "code"
    return (
        f"Here is a simple {kind} example, explained in words. "
        f"{detail}. "
        f"What to remember: focus on the idea, not every symbol."
    )


def md_to_speech(text: str) -> str:
    parts: list[str] = []
    pos = 0
    for m in re.finditer(r"```[\s\S]*?```", text):
        before = text[pos : m.start()]
        if before.strip():
            parts.append(before)
        parts.append(describe_code(m.group(0)))
        pos = m.end()
    parts.append(text[pos:])
    text = "\n\n".join(p.strip() for p in parts if p.strip())

    text = re.sub(r"!\[([^\]]*)\]\([^)]+\)", r"\1", text)
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
            if len(cells) >= 2:
                lines.append(f"{cells[0]}: {', '.join(cells[1:])}.")
            elif cells:
                lines.append(cells[0] + ".")
            continue
        if re.match(r"^\s*-{3,}\s*$", line):
            continue
        line = re.sub(r"^#{1,6}\s*", "", line)
        line = re.sub(r"^\s*[-*]\s+", "", line)
        line = re.sub(r"^\s*\d+\.\s+", "", line)
        if line.strip():
            lines.append(line.strip())

    paragraphs: list[str] = []
    buf: list[str] = []
    for line in lines:
        if not line:
            if buf:
                paragraphs.append(" ".join(buf))
                buf = []
            continue
        buf.append(line)
        if len(" ".join(buf).split()) > 70:
            paragraphs.append(" ".join(buf))
            buf = []
    if buf:
        paragraphs.append(" ".join(buf))

    text = " ".join(paragraphs)
    text = re.sub(r"\s+", " ", text).strip()
    text = re.sub(r";\s+", ". ", text)
    text = re.sub(r"\s*[—–→]+\s*", ". ", text)
    text = re.sub(r"[─│┌┐└┘├┤▲▼►◄]+", " ", text)
    text = re.sub(r"\s+", " ", text).strip()
    text = plain_english(text)
    text = expand_shortforms(text)
    # Prefer spoken phrase for associated types (resume-safe; no PAT).
    text = re.sub(
        r"\bprotocols with associated types\b",
        "protocols that have an associated type",
        text,
        flags=re.I,
    )
    text = re.sub(
        r"\bprotocol with associated type\b",
        "protocol that has an associated type",
        text,
        flags=re.I,
    )
    text = re.sub(r"\bassociatedtype\b", "associated type", text, flags=re.I)
    text = spell_acronyms(text)
    text = shorten_sentences(text)
    if text and text[-1] not in ".!?":
        text += "."
    return text


def split_sections(md: str) -> list[tuple[str, str]]:
    lines = md.splitlines()
    body_lines: list[str] = []
    started = False
    for line in lines:
        if line.startswith("# ") and not started:
            started = True
            continue
        started = True
        body_lines.append(line)

    sections: list[tuple[str, str]] = []
    current_title = "Introduction"
    buf: list[str] = []
    for line in body_lines:
        if line.startswith("## "):
            if buf and any(x.strip() for x in buf):
                sections.append((current_title, "\n".join(buf).strip()))
            current_title = line[3:].strip()
            buf = []
        else:
            buf.append(line)
    if buf and any(x.strip() for x in buf):
        sections.append((current_title, "\n".join(buf).strip()))
    if not sections:
        sections = [("Full chapter", "\n".join(body_lines).strip())]
    return sections


def spoken_intro(chapter_file: str, day_label: str) -> str:
    return (
        f"# Audio script — {CHAPTER_TITLES.get(chapter_file, chapter_file)}\n"
        f"> Listen-only audiobook of `{chapter_file}.md` ({day_label}). "
        f"Simple English. Basic explanations. Self-contained speech. "
        f"Does not assume you are looking at a screen.\n"
    )


def section_opener(title: str) -> str:
    plain_title = plain_english(title)
    plain_title = expand_shortforms(plain_title)
    plain_title = spell_acronyms(plain_title)
    if re.search(r"north star|main guiding idea", title, re.IGNORECASE):
        return f"Next. {plain_title}. That means the main guiding idea.\n\n"
    return f"Next. {plain_title}.\n\n"


def generate_script(md_path: Path, day_label: str) -> str:
    stem = md_path.stem
    md = md_path.read_text(encoding="utf-8")
    sections = split_sections(md)
    out = [spoken_intro(stem, day_label), ""]
    for i, (title, body) in enumerate(sections):
        speech = md_to_speech(body)
        if not speech.strip():
            continue
        speech = section_opener(title) + speech
        out.append(f"## §{i} {title}")
        out.append("")
        out.append(speech)
        out.append("")
    return "\n".join(out).rstrip() + "\n"


BAD_PATTERNS = [
    (re.compile(r"\bPAT\b"), "unexplained PAT"),
    (re.compile(r"\bon screen\b", re.I), "screen reference"),
    (re.compile(r"\blook at\b", re.I), "look-at reference"),
    (re.compile(r"\bnorth star\b", re.I), "slang north star"),
    (re.compile(r"\balright\b", re.I), "slang alright"),
]


def simplicity_check(path: Path) -> list[str]:
    text = path.read_text(encoding="utf-8")
    issues: list[str] = []
    for i, line in enumerate(text.splitlines(), 1):
        # Headings keep original markdown titles for section matching.
        if line.startswith("#"):
            continue
        for pat, label in BAD_PATTERNS:
            if pat.search(line):
                issues.append(f"{path.relative_to(ROOT)}:{i}: {label}: {line[:100]}")
        for sent in re.split(r"(?<=[.!?])\s+", line):
            words = sent.split()
            if len(words) > 28:
                issues.append(
                    f"{path.relative_to(ROOT)}:{i}: long sentence ({len(words)} words)"
                )
    return issues


def main() -> None:
    count = 0
    all_issues: list[str] = []
    for day_dir in sorted(WEEK.glob("day-*")):
        if not day_dir.is_dir():
            continue
        readme = day_dir / "README.md"
        day_label = day_dir.name
        if readme.exists():
            first = readme.read_text(encoding="utf-8").splitlines()[0]
            day_label = first.lstrip("# ").strip()
        for chapter in CHAPTER_TITLES:
            src = day_dir / f"{chapter}.md"
            if not src.exists():
                continue
            dest = day_dir / f"{chapter}.script.md"
            dest.write_text(generate_script(src, day_label), encoding="utf-8")
            count += 1
            print(f"wrote {dest.relative_to(ROOT)}")
            all_issues.extend(simplicity_check(dest))
    print(f"generated {count} scripts")
    if all_issues:
        print(f"simplicity check: {len(all_issues)} flags", file=sys.stderr)
        for issue in all_issues[:40]:
            print(f"  {issue}", file=sys.stderr)
        if len(all_issues) > 40:
            print(f"  ... and {len(all_issues) - 40} more", file=sys.stderr)
    else:
        print("simplicity check: clean")


if __name__ == "__main__":
    main()
