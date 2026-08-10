# Day 21 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 21 modules. 
> Use this when you want Mock #3 prep as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, run the full 45-min mock from [`../02-deep-dive.md`](../02-deep-dive.md) and score with Part II in [`../07-revision-qna.md`](../07-revision-qna.md).

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](../01-foundations.md) |
| Deep dive (full scripts) | [02-deep-dive.md](../02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](../03-production-bridge.md) |
| Questions + rubric | [07-revision-qna.md](../07-revision-qna.md) |
| Exercises (live mock) | [05-exercises.md](../05-exercises.md) |
| Code | [code/SDUISketch.swift](../code/SDUISketch.swift) · [code/NetworkPinSketch.swift](../code/NetworkPinSketch.swift) |

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-running-the-mock.md](01-running-the-mock.md) | 45-min spine, prompt pick, checkpoints, exercises | Foundations · Exercises |
| [02-clarify-phase.md](02-clarify-phase.md) | Scope, scale, offline, in/out, resume-true numbers | Foundations · Deep dive |
| [03-cache-scroll.md](03-cache-scroll.md) | SDUI cache/freshness, list scroll, pagination | Foundations · Deep dive |
| [04-scoring-rubric.md](04-scoring-rubric.md) | Two-layer rubric, pass bar, self-grade after mock | Questions · Exercises |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Networking+pinning (Mock #3 alt) | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Spine | Clarify 5 → HLD 10 → API 10 → Dive 15 → Ops 5 |
| Pick one prompt | SDUI **or** Networking+pin live — skim the other after |
| Scale | **30L+ DAU** from resume — don’t invent precise QPS |
| Ops | Last 5 minutes mandatory — cut dive rather than skip ops |
| Pass bar | **≥70** with **ops ≥6/10** and **no fabricated metrics** |
| Provenance | S4-A1 = design; S2 ≠ sole CFS; SPKI ≠ SecKey raw bytes |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then live mock in [`../05-exercises.md`](../05-exercises.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 21 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
