# Day 01 — Value vs Reference, COW, Enums, Actors Intro

> Week 1 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-01/day-01.md](../../../revision/weeks/week-01/day-01.md)

## Outcomes

By end of day, without notes, you can:

- Choose `struct` vs `class` vs `enum` vs `actor` with a clear decision rule and one production example
- Explain copy-on-write for Array/String/Dictionary: when assignment is cheap and when a real copy happens
- Model UI/network/payment flows as associated-value enums (impossible states eliminated)
- Give a 30s actors intro that bridges GCD serial queues → Swift actors (Day 05 deepens), including reentrancy awareness
- Speak a ≤20s pitch tying value semantics to BMS ads / listing models — no invented metrics

## How to study (in Cursor only)

1. [`01-foundations.md`](01-foundations.md) — mental model (intern → mid)
2. [`02-deep-dive.md`](02-deep-dive.md) — mechanics, traps, trade-offs
3. [`03-production-bridge.md`](03-production-bridge.md) — Verified / Applied hooks
4. [`code/`](code/) — read `LoadState.swift` and `COWDemo.swift`
5. [`sample/`](sample/) — spoken Q&A + brain puzzles (`01`–`06`; `06` folds exercise/flash-recall leftovers)
6. [`04-questions.md`](04-questions.md) — normal Qs + tricky **T1–T10** brain puzzles; speak aloud
7. [`05-exercises.md`](05-exercises.md) — coding + speaking drills (still do the hands-on exercises here)
8. Revision twin for flashcards / timed drill day-of

## Module map

| Module | File | Role |
|---|---|---|
| Foundations | [01-foundations.md](01-foundations.md) | Mental model + glossary + first examples |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) | COW internals, nested refs, enum machines, actors intro |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) | Ads / payment / dictionaries → interview lines |
| Questions | [04-questions.md](04-questions.md) | Normal + tricky **T1–T10** |
| Exercises | [05-exercises.md](05-exercises.md) | Coding + speaking drills |
| Code | [code/LoadState.swift](code/LoadState.swift), [code/COWDemo.swift](code/COWDemo.swift) | Runnable mental models |
| Sample Q&A | [sample/](sample/README.md) | Guided spoken cards — includes **06-module-drills** leftovers |

## Time budget (suggested)

| Block | Minutes |
|---|---|
| Foundations | 60–75 |
| Deep dive | 75–90 |
| Production bridge + code | 30–40 |
| Sample Q&A `01`–`06` | 45–60 |
| Questions (speak normals + T1–T10) | 60–75 |
| Exercises + timed drill | 45–60 |

## Provenance reminder

Only use Verified IDs from [`../../../provenance/README.md`](../../../provenance/README.md).

| Label | Use for today |
|---|---|
| **Verified · S1** | Type-safe ads / listing models; prefer value-friendly DTOs |
| **Verified · S7** | Payment processing popup intent (states as product feature) |
| **How I would apply it · S7-A1** | Explicit enum state machine for payment UI (design; resume does not name enums) |
| **Verified · S2** | Soft bridge: serial-queue isolation → actors (intro only) |
| **How I would apply it · S2-A1** | Greenfield shared maps as Swift `actor` |

Do **not** invent fill-rate %, drop-off %, or latency numbers. In answers, speak **named work** — never S-codes.

## Agenda openers (pin these)

| Topic | 5–10s opener |
|---|---|
| struct vs class | “Semantics → shared mutation → when I pick each.” |
| COW | “Cheap share until write — then unique copy.” |
| enum state | “Impossible states out → exhaustiveness in.” |
| actor intro | “Reference type with isolation; modern serial queue.” |

## Timed drill (after full study)

1. Speak Q1, Q2, Q3, T1, T3 from `04-questions.md` on a timer.
2. 90s: payment processing-status popup + Design: payment status pattern (honest labels).
3. 45s: synchronised dictionaries → Design: actor SafeDict (when not to migrate).
4. Score against [answer-timing-guide.md](../../../timing/answer-timing-guide.md); log misses.
