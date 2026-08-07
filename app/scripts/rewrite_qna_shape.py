#!/usr/bin/env python3
"""Rewrite sample Q&A + 04-questions + revision guides to named-case relate shape.

Canonical sample / questions shape:
  ### Qn. …
  **Answer:**
  > …
  **Follow-ups:** (table)
  **How can I relate to my case:**
  - **Shipped:** … / concept-only short block
  - **Design if asked:** …
  - **Lab only:** …
  - **Don’t claim:** …
"""
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WEEKS = ROOT / "roadmap" / "weeks"
REVISION_WEEKS = ROOT / "roadmap" / "revision" / "weeks"

# Longer keys first so S2-A1 wins over S2, S15 over S1, etc.
CASE_NAMES: list[tuple[str, str]] = [
    ("S2-A1", "Design: actor SafeDict (not shipped)"),
    ("S4-A1", "Design: pin rotation / break-glass (not shipped runbook)"),
    ("S7-A1", "Design: payment status pattern (not shipped)"),
    ("S15", "FinTrack on-device AI"),
    ("S16", "GymFlow on-device AI"),
    ("S10", "Stories SDK (Raw / Miami Heat)"),
    ("S11", "Live in-arena scoreboard (Raw)"),
    ("S12", "Audio streaming + server-driven splash (Aces)"),
    ("S13", "Hybrid UI / deeplinks"),
    ("S14", "Platform upgrade"),
    ("S1", "BookMyShow Ads pipeline + HeroWidget lifecycle"),
    ("S2", "BookMyShow synchronised dictionaries"),
    ("S3", "BookMyShow backend-driven header & search"),
    ("S4", "BookMyShow SSL pinning + URLSession migration"),
    ("S5", "BookMyShow Firebase Performance traces"),
    ("S6", "BookMyShow LE Bottom Sheet"),
    ("S7", "BookMyShow payment processing-status popup"),
    ("S8", "BookMyShow IMOC + crash-free at scale"),
    ("S9", "District Free Parking + Clean/MVVM + AI tooling"),
]

CASE_DICT = {k: v for k, v in CASE_NAMES}

SHIPPED_CASES = {
    "S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9",
    "S10", "S11", "S12", "S13", "S14", "S15", "S16",
}
DESIGN_CASES = {"S2-A1", "S4-A1", "S7-A1"}

PRODUCTION_H1 = {
    "04-production-s1-s7.md": "Sample 04 — Ads pipeline, HeroWidget & payment status popup (Q&A)",
    "04-production-s1.md": "Sample 04 — BookMyShow Ads pipeline + HeroWidget (Q&A)",
    "04-production-s8.md": "Sample 04 — IMOC + crash-free at scale (Q&A)",
    "04-production-s2.md": "Sample 04 — Synchronised dictionaries & actor SafeDict design (Q&A)",
    "04-production-s9-s3.md": "Sample 04 — Free Parking architecture & backend-driven search (Q&A)",
    "04-production-s4.md": "Sample 04 — SSL pinning + URLSession migration (Q&A)",
    "04-production-s3-s12.md": "Sample 04 — Backend-driven UI & Aces splash (Q&A)",
    "04-production-s13-s6.md": "Sample 04 — Hybrid UI, deeplinks & LE Bottom Sheet (Q&A)",
    "04-production-s10.md": "Sample 04 — Stories SDK (Raw / Miami Heat) (Q&A)",
    "04-production-bridges.md": "Sample 04 — Production story bridges (Q&A)",
    "04-production-s1-s12.md": "Sample 04 — HeroWidget lifecycle & Aces splash (Q&A)",
    "04-production-s5.md": "Sample 04 — Firebase Performance traces (Q&A)",
    "04-production-s8-s2.md": "Sample 04 — Crash-free culture & synchronised dictionaries (Q&A)",
    "04-production-trees.md": "Sample 04 — Trees in production systems (Q&A)",
    "04-production-maps-topk.md": "Sample 04 — Maps & top-K in production (Q&A)",
    "04-production-s15-s16.md": "Sample 04 — FinTrack & GymFlow on-device AI (Q&A)",
    "04-production-provenance.md": "Sample 04 — Provenance honesty & named cases (Q&A)",
}


def scrub_codes(text: str) -> str:
    """Replace S# tokens with human names; drop Verified · / Applied · prefixes."""
    text = re.sub(r"\bVerified\s*·\s*", "", text)
    text = re.sub(r"\bApplied\s*·\s*", "", text)
    text = re.sub(r"\bHow I would apply it\s*·\s*", "Design: ", text, flags=re.I)

    # Replace codes longest-first with word boundaries
    for code, name in CASE_NAMES:
        text = re.sub(rf"\b{re.escape(code)}\b", name, text)

    # Clean doubled labels like "Design: Design:"
    text = re.sub(r"Design:\s*Design:", "Design:", text)
    return text


def detect_codes(text: str) -> list[str]:
    found: list[str] = []
    for code, _ in CASE_NAMES:
        if re.search(rf"\b{re.escape(code)}\b", text):
            found.append(code)
    return found


def relate_block_from_context(blob: str, *, force_production: bool = False) -> str:
    codes = detect_codes(blob)
    shipped = [c for c in codes if c in SHIPPED_CASES]
    design = [c for c in codes if c in DESIGN_CASES]
    lab = bool(
        re.search(r"Learning-lab|SafeDict|BarrierDict|\.swift|lab only", blob, re.I)
    )
    concept_only = (
        not shipped
        and not design
        and not force_production
        and (
            re.search(r"Learning-lab|concept|mechanics|pattern|definition", blob, re.I)
            or not codes
        )
    )

    if concept_only and not force_production:
        return (
            "**How can I relate to my case:**\n"
            "- **Concept-only — no shipped story.** Use this as vocabulary; "
            "hook a named case only if the interviewer asks for production proof.\n"
        )

    shipped_line = (
        "; ".join(CASE_DICT[c] for c in shipped)
        if shipped
        else "None for this prompt — keep it conceptual unless they ask for a case."
    )
    design_line = (
        "; ".join(CASE_DICT[c] for c in design)
        if design
        else (
            "Only if they ask for a modern redesign — label it design, not shipped."
            if shipped
            else "N/A"
        )
    )
    lab_line = (
        "Learning-lab demos / sketches only — not production source."
        if lab or "SafeDict" in blob or "BarrierDict" in blob
        else "N/A for this prompt."
    )
    dont = (
        "Invented metrics, sole credit for org-wide CFS, or claiming design-only "
        "work as shipped."
    )
    if "S8" in shipped and "S2" in shipped:
        dont = (
            "Do not steal BookMyShow IMOC / crash-free culture credit for a "
            "path-specific dictionary race fix — keep scopes separate."
        )
    elif "S2" in shipped:
        dont = (
            "Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift "
            "was the shipped file."
        )
    elif "S4-A1" in design or "S4" in shipped:
        dont = "Claiming pin-rotation / break-glass runbook as a shipped production playbook."
    elif "S1" in shipped:
        dont = "Invented fill-rate % or sole credit for ads revenue."
    elif "S7" in shipped:
        dont = "Invented checkout drop-off % from the status popup alone."
    elif "S8" in shipped:
        dont = "Attributing 99.95%+ CFS to a single ticket; inventing DAU figures."

    return (
        "**How can I relate to my case:**\n"
        f"- **Shipped:** {shipped_line}\n"
        f"- **Design if asked:** {design_line}\n"
        f"- **Lab only:** {lab_line}\n"
        f"- **Don’t claim:** {dont}\n"
    )


def strip_points_to(block: str) -> str:
    return re.sub(r"^\*\*Points to:\*\*[^\n]*\n+", "", block, flags=re.M)


def ensure_relate_after_followups(q_block: str, *, force_production: bool = False) -> str:
    """Insert or replace How can I relate block after Follow-ups table."""
    q_block = strip_points_to(q_block)
    # Remove existing relate / provenance blocks
    q_block = re.sub(
        r"\n\*\*How can I relate to my case:\*\*[\s\S]*?(?=\n---|\n### |\Z)",
        "\n",
        q_block,
    )
    q_block = re.sub(r"\n\*\*Provenance:\*\*[^\n]*\n*", "\n", q_block)

    relate = relate_block_from_context(q_block, force_production=force_production)

    # Find end of follow-ups table (after header + rows) or after **Follow-ups:**
    if "**Follow-ups:**" in q_block:
        parts = q_block.split("**Follow-ups:**", 1)
        head, tail = parts[0], parts[1]
        # Consume blank line + table lines
        lines = tail.splitlines()
        i = 0
        while i < len(lines) and lines[i].strip() == "":
            i += 1
        # skip table
        while i < len(lines) and (
            lines[i].strip().startswith("|") or lines[i].strip() == ""
        ):
            # stop if blank after table and next is not table
            if lines[i].strip() == "":
                # peek
                j = i + 1
                while j < len(lines) and lines[j].strip() == "":
                    j += 1
                if j < len(lines) and not lines[j].strip().startswith("|"):
                    break
            i += 1
        table = "\n".join(lines[:i]).rstrip()
        rest = "\n".join(lines[i:]).lstrip("\n")
        # Drop leading --- from rest; we'll add structure
        rest = re.sub(r"^---\s*\n*", "", rest)
        rebuilt = (
            f"{head.rstrip()}\n\n**Follow-ups:**\n{table}\n\n{relate}"
        )
        if rest.strip():
            # unexpected trailing content inside question — keep
            rebuilt += f"\n{rest}"
        return rebuilt.rstrip() + "\n"

    # No follow-ups — append relate before end
    return q_block.rstrip() + "\n\n" + relate


def rewrite_sample_md(path: Path) -> str:
    md = path.read_text(encoding="utf-8")
    force_prod = "production" in path.name.lower()

    # Human H1 for production files
    if path.name in PRODUCTION_H1:
        md = re.sub(
            r"^# .+$",
            f"# {PRODUCTION_H1[path.name]}",
            md,
            count=1,
            flags=re.M,
        )
        # Soften intro that says Verified · S#
        md = re.sub(
            r"^> Guided teaching\..*$",
            "> Guided teaching. Separates **shipped** named cases from **design-if-asked** "
            "and **lab-only** so you never blur them in an interview.",
            md,
            count=1,
            flags=re.M,
        )
    else:
        md = re.sub(
            r"\*\*Points to\*\* shows where the full module expands the idea\.",
            "Each answer ends with **How can I relate to my case** using named work — never S-codes.",
            md,
            count=1,
        )

    parts = re.split(r"(?=^### Q\d+\.)", md, flags=re.M)
    out: list[str] = []
    for part in parts:
        if not re.match(r"^### Q\d+\.", part, flags=re.M):
            # preamble — scrub codes in body but keep structure
            out.append(scrub_codes(strip_points_to(part)))
            continue
        block = ensure_relate_after_followups(part, force_production=force_prod)
        # Scrub codes in Q text AFTER relate generation (relate used codes)
        # Re-run relate was based on codes — scrub display text now
        # Protect relate block names (already human)
        block = scrub_codes(block)
        out.append(block)
        if not block.rstrip().endswith("---"):
            # questions are separated by --- in original; restore
            if "---" not in block[-20:]:
                out.append("\n---\n\n")
    text = "".join(out)
    # Normalize multiple --- and scrub leftover S# in titles like "Verified S2"
    text = scrub_codes(text)
    text = re.sub(r"\n---\n(?:\n---\n)+", "\n---\n\n", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    if not text.endswith("\n"):
        text += "\n"
    return text


def ladder_to_table(ladder_block: str) -> str:
    rows: list[tuple[str, str]] = []
    for m in re.finditer(
        r"-\s*\*\*L\d+:\*\*\s*(.+)",
        ladder_block,
    ):
        q = m.group(1).strip()
        rows.append((q, "See full answer — expand if interviewer probes."))
    # Also catch plain - **L1:** forms already handled
    if not rows:
        for m in re.finditer(r"-\s*\*\*(L\d+)\*\*:\s*(.+)", ladder_block):
            rows.append((m.group(2).strip(), "Expand from the spoken answer."))
    if not rows:
        return (
            "| Follow-up | Answer |\n"
            "|---|---|\n"
            "| Probe deeper? | Expand from the spoken answer with one concrete example. |\n"
        )
    lines = ["| Follow-up | Answer |", "|---|---|"]
    for q, a in rows:
        lines.append(f"| {q} | {a} |")
    return "\n".join(lines) + "\n"


def rewrite_04_questions(path: Path) -> str:
    md = path.read_text(encoding="utf-8")
    header = (
        "# 04 — Questions (Q&A)\n\n"
        "> Cover the answer, speak aloud, then check follow-ups. "
        "Each question ends with **How can I relate to my case** using named work — never S-codes.\n"
        "> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.\n\n"
        "---\n\n"
    )

    # Keep section headers ## Normal / ## Tricky / ## Design / ## Timed
    sections = re.split(r"(?=^## )", md, flags=re.M)
    body_parts: list[str] = []
    for section in sections:
        if not section.strip():
            continue
        sec_m = re.match(r"^(## .+)$", section, flags=re.M)
        if not sec_m:
            continue
        sec_title = sec_m.group(1)
        # Skip old intro H1
        if sec_title.startswith("## ") and "04 —" in section[:80]:
            continue
        rest = section[sec_m.end() :]
        if sec_title.lower().startswith("## timed"):
            # Keep timed sets mostly as-is but scrub codes
            body_parts.append(scrub_codes(sec_title + rest))
            continue

        body_parts.append(sec_title + "\n\n")
        qs = re.split(r"(?=^### Q\d+\.)", rest, flags=re.M)
        for q in qs:
            qm = re.match(r"^### (Q\d+\.\s+.+)$", q, flags=re.M)
            if not qm:
                continue
            title = qm.group(1).strip()
            # Prefer Full spoken answer; fallback Answer points joined
            spoken = ""
            m_full = re.search(
                r"\*\*Full spoken answer:\*\*\s*\n+(?:>\s*.+(?:\n>.*)*|\n*(?:>\s*)?.+)",
                q,
            )
            if m_full:
                raw = m_full.group(0)
                raw = re.sub(r"\*\*Full spoken answer:\*\*\s*", "", raw)
                spoken = "\n".join(
                    re.sub(r"^>\s?", "", ln) for ln in raw.strip().splitlines()
                ).strip()
                spoken = spoken.strip('"“”')
            if not spoken:
                points = re.findall(r"^-\s+(.+)$", q, flags=re.M)
                # take first bullet cluster under Answer points
                spoken = " ".join(points[:6]) if points else "See day modules."

            ladder_m = re.search(
                r"\*\*Follow-up ladder:\*\*\s*\n((?:.+\n)*?)(?=\n\*\*Provenance:|\n---|\n### |\Z)",
                q,
            )
            ladder = ladder_m.group(1) if ladder_m else ""
            table = ladder_to_table(ladder)

            prov_m = re.search(r"\*\*Provenance:\*\*\s*(.+)", q)
            prov = prov_m.group(1).strip() if prov_m else ""
            ctx = q + "\n" + prov
            force = bool(detect_codes(ctx))
            relate = relate_block_from_context(ctx, force_production=force)
            relate = scrub_codes(relate)
            spoken = scrub_codes(spoken)
            title = scrub_codes(title)

            block = (
                f"### {title}\n\n"
                f"**Answer:**\n\n"
                f"> {spoken}\n\n"
                f"**Follow-ups:**\n\n"
                f"{table}\n"
                f"{relate}\n"
                f"---\n\n"
            )
            body_parts.append(block)

    text = header + "".join(body_parts)
    text = scrub_codes(text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    if not text.endswith("\n"):
        text += "\n"
    return text


def scrub_revision_guide(path: Path) -> str:
    md = path.read_text(encoding="utf-8")
    md = scrub_codes(md)
    # Soften Map to your work labels
    md = re.sub(r"\*\*Verified\s*[·:]\s*", "**Shipped:** ", md)
    md = re.sub(r"\*\*Applied\s*[·:]\s*", "**Design if asked:** ", md)
    # Story bank links may still say #s2-- — leave anchors (archival)
    return md if md.endswith("\n") else md + "\n"


def main() -> None:
    sample_n = 0
    for sample in sorted(WEEKS.glob("week-*/day-*/sample")):
        for src in sorted(sample.glob("0*.md")):
            if src.name.endswith(".script.md") or src.name == "README.md":
                continue
            new = rewrite_sample_md(src)
            src.write_text(new, encoding="utf-8")
            sample_n += 1
            print(f"sample {src.relative_to(ROOT)}")

    q_n = 0
    for qpath in sorted(WEEKS.glob("week-*/day-*/04-questions.md")):
        new = rewrite_04_questions(qpath)
        qpath.write_text(new, encoding="utf-8")
        q_n += 1
        print(f"questions {qpath.relative_to(ROOT)}")

    g_n = 0
    for gpath in sorted(REVISION_WEEKS.glob("week-*/day-*.md")):
        new = scrub_revision_guide(gpath)
        gpath.write_text(new, encoding="utf-8")
        g_n += 1
        print(f"guide {gpath.relative_to(ROOT)}")

    print(f"done: {sample_n} samples, {q_n} question files, {g_n} revision guides")


if __name__ == "__main__":
    main()
