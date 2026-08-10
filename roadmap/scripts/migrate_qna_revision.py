#!/usr/bin/env python3
"""
Migrate all days to Day-04 Q&A shape:
- Convert root 01/02/03/05 narrative modules → spoken Q&A cards
- Build sample/07-revision-qna.md (Normal + Indirect + Tricky) from 04-questions
- Delete root 04-questions.md (+ .script.md)
- Patch day + sample READMEs to point at revision sample
"""
from __future__ import annotations

import re
import textwrap
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
WEEKS = ROOT / "weeks"

DAYS = {
    "week-01": ["01", "02", "03", "04", "05", "06", "07"],
    "week-02": ["08", "09", "10", "11", "12", "13", "14"],
    "week-03": ["15", "16", "17", "18", "19", "20", "21"],
    "week-04": ["22", "23", "24", "25", "26", "27", "28"],
}

DAY_TOPICS: dict[str, dict[str, list[tuple[str, str]]]] = {
    # Indirect (I) and extra Tricky (T) banks keyed by day id.
    # Used when source 04-questions is thin.
}


def strip_md(s: str) -> str:
    s = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", s)
    s = re.sub(r"[`*]{1,3}", "", s)
    s = re.sub(r"^>\s?", "", s, flags=re.M)
    s = re.sub(r"\s+", " ", s).strip()
    return s


def spoken_quote(text: str, max_chars: int = 900) -> str:
    text = strip_md(text)
    # Drop code fences for speech
    text = re.sub(r"```[\s\S]*?```", " ", text)
    text = re.sub(r"\|[^\n]+\|", " ", text)
    text = re.sub(r"\s+", " ", text).strip()
    if len(text) > max_chars:
        text = text[: max_chars - 1].rsplit(" ", 1)[0] + "…"
    if not text:
        text = "See the notes for this topic and speak the core idea in simple words."
    if text[-1] not in ".!?\"":
        text += "."
    # Prefer quoted spoken style
    if not (text.startswith("“") or text.startswith('"')):
        text = f"“{text.strip('“”\"') }”"
    return text


def card(prefix: str, n: int, title: str, answer: str, followups: list[tuple[str, str]] | None = None, relate: str | None = None, timing: str = "(45s)") -> str:
    followups = followups or [("One-sentence opener?", "Say the core idea in one clear sentence.")]
    relate = relate or "- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked."
    rows = "
".join(f"| {q} | {a} |" for q, a in followups[:3])
    return (
        f"### {prefix}{n}. {title} `{timing}`

"
        f"**Answer:**

"
        f"> {answer}

"
        f"**Follow-ups:**

"
        f"| Follow-up | Answer |
"
        f"|---|---|
"
        f"{rows}

"
        f"**How can I relate to my case:**
"
        f"{relate}

"
        f"---
"
    )


def parse_existing_cards(text: str, prefix: str) -> list[tuple[str, str]]:
    """Return list of (title, full_card_body_including_heading)."""
    parts = re.split(rf"(?=^### {prefix}\d+\.)", text, flags=re.M)
    out: list[tuple[str, str]] = []
    for part in parts:
        m = re.match(rf"^### ({prefix}\d+\.\s+.+)$", part, flags=re.M)
        if not m:
            continue
        title_line = m.group(1).strip()
        # Keep whole card until next ### of same/other band or ## or EOF
        body = part.strip()
        # Cut at next top-level ## section if present after first line
        body = re.split(r"(?=\n## )", body, maxsplit=1)[0].strip()
        out.append((title_line, body))
    return out


def extract_answer_from_card(card_md: str) -> str:
    m = re.search(r"\*\*Answer:\*\*\s*\n+>\s*(.+?)(?=\n\n|\n\*\*|\Z)", card_md, flags=re.S)
    if m:
        return spoken_quote(m.group(1))
    m = re.search(r"\*\*Full spoken answer:\*\*\s*\n+>\s*(.+?)(?=\n\n|\n\*\*|\Z)", card_md, flags=re.S | re.I)
    if m:
        return spoken_quote(m.group(1))
    # Fallback: any blockquote
    m = re.search(r"^>\s*(.+)$", card_md, flags=re.M)
    if m:
        return spoken_quote(m.group(1))
    return spoken_quote(card_md)


def narrative_to_cards(path: Path) -> str:
    text = path.read_text(encoding="utf-8")
    title = "Q&A"
    lines = text.splitlines()
    if lines and lines[0].startswith("# "):
        title = lines[0][2:].strip()
        # Force Q&A marker
        if "(Q&A)" not in title:
            title = re.sub(r"\s*$", " (Q&A)", title)

    # Already Q&A?
    if re.search(r"^###\s+Q\d+\.", text, re.M) and "**Answer:**" in text:
        if "(Q&A)" not in text.splitlines()[0]:
            text = re.sub(r"^(# .+)$", r"\1 (Q&A)", text, count=1, flags=re.M)
        return text if text.endswith("\n") else text + "\n"

    # Split on ## or ### headings (skip H1)
    parts = re.split(r"(?=^#{2,3} )", text, flags=re.M)
    intro = parts[0]
    sections: list[tuple[str, str]] = []
    for part in parts[1:]:
        m = re.match(r"^(#{2,3})\s+(.+)$", part, flags=re.M)
        if not m:
            continue
        heading = m.group(2).strip()
        # Skip meta headings
        if re.match(r"^(outcomes|how to|module map|provenance|appendix|resources|links)\b", heading, re.I):
            continue
        body = part[m.end() :].strip()
        if len(strip_md(body)) < 40:
            continue
        sections.append((heading, body))

    cards: list[str] = []
    n = 0
    for heading, body in sections:
        n += 1
        # Turn heading into a question
        h = re.sub(r"^\d+(\.\d+)*\.?\s*", "", heading).strip()
        if h.endswith("?"):
            qtitle = h
        else:
            qtitle = f"Explain: {h}?"
        # Prefer "Say aloud" lines if present
        say = re.findall(r"\*\*Say aloud:\*\*\s*[“\"]?(.+?)[”\"]?\s*$", body, flags=re.M)
        if say:
            ans = spoken_quote(" ".join(say))
        else:
            # First meaningful paragraph
            paras = [p.strip() for p in re.split(r"\n\s*\n", body) if strip_md(p)]
            chunk = " ".join(paras[:2]) if paras else body
            ans = spoken_quote(chunk)
        # Follow-ups from bold callouts / Critical lines
        fus: list[tuple[str, str]] = []
        for crit in re.findall(r"\*\*Critical:?\*\*\s*(.+)", body):
            fus.append(("Critical catch?", strip_md(crit)[:180]))
        if not fus:
            fus = [
                ("One-sentence opener?", "Lead with the core rule in one sentence."),
                ("Common trap?", "Name the usual mistake and how you avoid it."),
            ]
        relate = "- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof."
        if re.search(r"BookMyShow|District|Verified", body, re.I):
            relate = "- **Shipped / Verified when honest:** Use named work only if this section cites it.\n- **Don’t claim:** Metrics or files you didn’t ship."
        cards.append(card("Q", n, qtitle, ans, fus, relate, "(45–60s)"))

    if not cards:
        # Absolute fallback — wrap whole file as one card
        cards.append(
            card(
                "Q",
                1,
                f"Summarize {title}?",
                spoken_quote(text),
                timing="(60s)",
            )
        )

    out = [
        f"# {title}",
        "",
        "> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.",
        "",
        "---",
        "",
        *cards,
    ]
    return "\n".join(out).rstrip() + "\n"


def indirect_from_normal(title_line: str, answer: str, n: int) -> str:
    # Strip Qn. prefix and timing
    t = re.sub(r"^Q\d+\.\s*", "", title_line)
    t = re.sub(r"\s*`\([^)]+\)`\s*$", "", t).strip().rstrip("?")
    # Scenario framing
    scenarios = [
        f"A junior asks you in standup: “{t}?” — how do you answer without jargon?",
        f"Production symptom: something related to “{t}” just broke under load. What do you check first?",
        f"Interviewer never names the topic. They describe a mess that maps to “{t}”. How do you diagnose?",
        f"Code review: you spot a smell around “{t}”. What do you say and what fix do you propose?",
        f"What happens if a teammate ignores the rule behind “{t}”?",
        f"Walk me through a failed interview answer on “{t}” and how you’d correct it.",
    ]
    title = scenarios[(n - 1) % len(scenarios)]
    return card(
        "I",
        n,
        title,
        answer if answer.startswith("“") else spoken_quote(answer),
        [
            ("What concept is this really?", strip_md(t)[:120]),
            ("How do you prove it?", "Give a tiny example or production boundary."),
        ],
        timing="(60–90s)",
    )


GENERIC_TRICKY = [
    (
        "They push you to invent a metric you don’t have",
        "I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.",
    ),
    (
        "They ask if your lab demo was the shipped file",
        "I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.",
    ),
    (
        "They want a one-tool forever answer",
        "I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.",
    ),
    (
        "Race vs deadlock — they mix the terms",
        "Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.",
    ),
    (
        "Main-thread rule under pressure",
        "UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.",
    ),
    (
        "Cancellation honesty",
        "Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.",
    ),
    (
        "Cache invalidation trap",
        "I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.",
    ),
    (
        "Security theater vs real pinning",
        "Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.",
    ),
    (
        "SDUI unknown component in prod",
        "Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.",
    ),
    (
        "DI vs singletons under test",
        "I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.",
    ),
    (
        "Prefetch that hurts scrolling",
        "Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.",
    ),
    (
        "Actor reentrancy surprise",
        "Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.",
    ),
]


def build_revision(day_folder: Path) -> str:
    qpath = day_folder / "04-questions.md"
    sample = day_folder / "sample"
    day_id = day_folder.name  # day-04
    week_id = day_folder.parent.name

    raw = qpath.read_text(encoding="utf-8") if qpath.exists() else ""
    title = f"Sample 07 — Revision Q&A ({day_id}) (Q&A)"

    # Collect Normal cards
    normal_cards = parse_existing_cards(raw, "Q")
    # Some files use Answer points format without ### Q — treat ### headings
    if len(normal_cards) < 5:
        # Try any ### as questions
        for m in re.finditer(r"^### (.+)$", raw, flags=re.M):
            heading = m.group(1).strip()
            if heading.startswith(("Q", "T", "I", "W", "D")) and re.match(r"^[QTIDW]\d+", heading):
                continue
            # skip
        # Pull from sample teaching files
        for sp in sorted(sample.glob("0*.md")):
            if sp.name.endswith(".script.md") or sp.name.startswith("07-"):
                continue
            normal_cards.extend(parse_existing_cards(sp.read_text(encoding="utf-8"), "Q"))
            if len(normal_cards) >= 12:
                break

    # Dedupe by title
    seen = set()
    uniq_normal: list[tuple[str, str]] = []
    for title_line, body in normal_cards:
        key = re.sub(r"^Q\d+\.\s*", "", title_line).lower()
        if key in seen:
            continue
        seen.add(key)
        uniq_normal.append((title_line, body))
    normal_cards = uniq_normal

    # Build Normal section with renumbered Qs
    normal_out: list[str] = []
    answers_for_indirect: list[tuple[str, str]] = []
    for i, (title_line, body) in enumerate(normal_cards[:16], start=1):
        ans = extract_answer_from_card(body)
        # Prefer keeping original card body but renumber
        clean_title = re.sub(r"^Q\d+\.\s*", "", title_line)
        # If original body already well-formed with Answer/Follow-ups, rewrite heading only
        if "**Answer:**" in body and "**Follow-ups:**" in body:
            body2 = re.sub(r"^### Q\d+\.", f"### Q{i}.", body, count=1, flags=re.M)
            # Ensure relate block exists
            if "**How can I relate to my case:**" not in body2:
                body2 += "\n\n**How can I relate to my case:**\n- **Concept-only — no shipped story.**\n"
            if not body2.strip().endswith("---"):
                body2 = body2.rstrip() + "\n\n---\n"
            normal_out.append(body2.strip() + "\n")
        else:
            normal_out.append(card("Q", i, clean_title, ans, timing="(45s)"))
        answers_for_indirect.append((clean_title, ans))

    # Pad Normal to 10 from sample brain / topic
    while len(normal_out) < 10:
        i = len(normal_out) + 1
        normal_out.append(
            card(
                "Q",
                i,
                f"What is the one rule to remember for {day_id}?",
                spoken_quote(
                    f"Keep a clear boundary, speak simply, and prove with a small example. For {day_id}, lead with the mental model before APIs."
                ),
                timing="(30–45s)",
            )
        )

    # Tricky from source
    tricky_cards = parse_existing_cards(raw, "T")
    # Also harvest Brain puzzles from samples as Tricky
    puzzle_extra: list[tuple[str, str]] = []
    for sp in sorted(sample.glob("0*.md")):
        if sp.name.endswith(".script.md") or sp.name.startswith("07-"):
            continue
        sm = sp.read_text(encoding="utf-8")
        if "## Brain puzzles" not in sm:
            continue
        puzzle_block = sm.split("## Brain puzzles", 1)[1]
        for pm in re.finditer(
            r"### (?:Puzzle [A-Z]|T\d+)\s*[—\-]\s*(.+)\n([\s\S]*?)(?=\n### |\Z)",
            puzzle_block,
        ):
            ptitle = pm.group(1).strip()
            pbody = pm.group(2)
            ask = re.search(r"\*\*Ask yourself:\*\*\s*(.+)", pbody)
            ans_m = re.search(r"\*\*Answer:\*\*\s*([\s\S]+?)(?=\n\*\*|\n###|\Z)", pbody)
            question = ask.group(1).strip() if ask else ptitle
            answer = spoken_quote(ans_m.group(1) if ans_m else pbody)
            puzzle_extra.append((question, answer))

    tricky_out: list[str] = []
    for i, (title_line, body) in enumerate(tricky_cards, start=1):
        if i > 14:
            break
        if re.match(r"^### T\d+\.", body) and "**Answer:**" in body:
            body2 = re.sub(r"^### T\d+\.", f"### T{i}.", body, count=1, flags=re.M)
            if "**How can I relate to my case:**" not in body2:
                body2 += "\n\n**How can I relate to my case:**\n- **Concept-only — no shipped story.**\n"
            if not body2.rstrip().endswith("---"):
                body2 = body2.rstrip() + "\n\n---\n"
            tricky_out.append(body2.strip() + "\n")
        else:
            clean = re.sub(r"^T\d+\.\s*", "", title_line)
            tricky_out.append(card("T", i, clean, extract_answer_from_card(body), timing="(90–120s)"))

    for question, answer in puzzle_extra:
        if len(tricky_out) >= 14:
            break
        i = len(tricky_out) + 1
        tricky_out.append(card("T", i, question, answer, timing="(90–120s)"))

    # Pad Tricky with generics (rotated by day number)
    day_num = int(day_id.split("-")[1])
    gi = day_num
    while len(tricky_out) < 10:
        i = len(tricky_out) + 1
        gt, ga = GENERIC_TRICKY[(gi + i) % len(GENERIC_TRICKY)]
        tricky_out.append(card("T", i, gt + "?", spoken_quote(ga), timing="(90–120s)"))

    # Indirect: prefer transforming normal answers into scenarios
    indirect_out: list[str] = []
    for i, (t, a) in enumerate(answers_for_indirect[:8], start=1):
        indirect_out.append(indirect_from_normal(t, a, i))
    while len(indirect_out) < 6:
        i = len(indirect_out) + 1
        gt, ga = GENERIC_TRICKY[(day_num + i) % len(GENERIC_TRICKY)]
        indirect_out.append(
            card(
                "I",
                i,
                f"Interviewer describes a failure that smells like: {gt}. What do you say?",
                spoken_quote(ga),
                timing="(60–90s)",
            )
        )

    parts = [
        f"# {title}",
        "",
        "> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.",
        "> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.",
        "",
        "---",
        "",
        "## Normal questions",
        "",
        *normal_out,
        "",
        "## Indirect questions",
        "",
        "> These do not name the concept first. Speak from the symptom, scenario, or junior question.",
        "",
        *indirect_out,
        "",
        "## Tricky questions / brain puzzles",
        "",
        '> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”',
        "",
        *tricky_out,
        "",
    ]
    return "\n".join(parts).rstrip() + "\n"


def patch_readme(path: Path, is_sample: bool) -> None:
    if not path.exists():
        return
    text = path.read_text(encoding="utf-8")
    text2 = text.replace("04-questions.md", "sample/07-revision-qna.md" if not is_sample else "07-revision-qna.md")
    text2 = text2.replace("`04-questions`", "`07-revision-qna`")
    # Ensure revision line exists
    if "07-revision-qna" not in text2:
        if is_sample:
            text2 += "\n\n## Revision\n\nThick speak practice: [07-revision-qna.md](07-revision-qna.md) — Normal + Indirect + Tricky.\n"
        else:
            text2 += "\n\n## Revision Q&A (app)\n\n[sample/07-revision-qna.md](sample/07-revision-qna.md) — Normal + Indirect + Tricky.\n"
    if text2 != text:
        path.write_text(text2, encoding="utf-8")


def process_day(week: str, day: str) -> None:
    folder = WEEKS / week / f"day-{day}"
    sample = folder / "sample"
    sample.mkdir(exist_ok=True)
    print(f"processing {week}/day-{day}")

    # Convert root modules
    for name in ["01-foundations.md", "02-deep-dive.md", "03-production-bridge.md", "05-exercises.md"]:
        p = folder / name
        if p.exists():
            p.write_text(narrative_to_cards(p), encoding="utf-8")

    # Build revision
    rev = build_revision(folder)
    (sample / "07-revision-qna.md").write_text(rev, encoding="utf-8")

    # Delete old questions
    for dead in [folder / "04-questions.md", folder / "04-questions.script.md"]:
        if dead.exists():
            dead.unlink()
            print(f"  deleted {dead.name}")

    patch_readme(folder / "README.md", is_sample=False)
    patch_readme(sample / "README.md", is_sample=True)


def main() -> None:
    for week, days in DAYS.items():
        for d in days:
            process_day(week, d)
    print("done")


if __name__ == "__main__":
    main()
