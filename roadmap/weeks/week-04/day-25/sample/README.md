# Day 25 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 25 modules. 
> Use this when you want **machine-round structure** explained as **question → module pointer → answer → follow-ups** — Briefs A & B, timing, debrief.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, **run** the 3hr session in [`../05-exercises.md`](../05-exercises.md) and debrief with [`../07-revision-qna.md`](../07-revision-qna.md).

## Module map

Full curriculum layout: [`../README.md`](../README.md)

| Module | File |
|---|---|
| Foundations | [01-foundations.md](../01-foundations.md) |
| Deep dive | [02-deep-dive.md](../02-deep-dive.md) — **Brief A & B specs** |
| Production bridge | [03-production-bridge.md](../03-production-bridge.md) |
| Questions | [07-revision-qna.md](../07-revision-qna.md) — sample architecture answers |
| Exercises | [05-exercises.md](../05-exercises.md) — **3hr timed build** |

No `code/` folder today — your Xcode project is the artifact.

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-machine-round-os.md](01-machine-round-os.md) | 3hr clock, vertical slice, anti-perfectionism | Foundations |
| [02-brief-a-pagination.md](02-brief-a-pagination.md) | Paginated list + cache + tests structure | Deep dive Brief A |
| [03-brief-b-sdui.md](03-brief-b-sdui.md) | SDUI renderer + unknown fallback + tests | Deep dive Brief B |
| [04-debrief-structure.md](04-debrief-structure.md) | Rubrics, trade-offs, post-build Q&A | Deep dive · Questions · Production bridge |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — E-commerce catalog (list+cache) | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| North star | Demoable **tested happy path** + documented cut lines |
| 0:00–0:15 | Clarify — **don’t code immediately** |
| Vertical slice | 60s demo: load → data → one secondary behavior → mention test |
| Brief A | Pagination + cache policy + 3+ meaningful unit tests |
| Brief B | ≥3 component types + unknown fallback + schemaVersion |
| Pass bar | Rubric avg ≥3.5, correctness ≥4, tests ≥3 |

## Suggested order

`01` → pick A or B (`02` or `03`) → run [`../05-exercises.md`](../05-exercises.md) → `04` debrief → `05` (catalog SD mock) → [`../07-revision-qna.md`](../07-revision-qna.md).
