# Day 02 — Protocols, POP, Generics, Associated Types, Type Erasure

> Week 1 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-01/day-02.md](../../../revision/weeks/week-01/day-02.md)

## Outcomes

By end of day, without notes, you can:

- Explain protocol-oriented design vs inheritance for UI / ad component pipelines
- Use generics + associated types + `where` clauses and say when each belongs
- Contrast `some` vs `any`, and when associated types force generics or type erasure
- Explain type erasure (AnyPublisher-style boxing) and its cost
- Deliver a ≤5 min architecture talk on BMS Ads / HeroWidget without inventing fill-rate metrics
- Soft-bridge to Stories SDK for reusable protocol APIs at a boundary

## How to study (in Cursor only)

1. [`01-foundations.md`](01-foundations.md) — mental model (intern → mid)
2. [`02-deep-dive.md`](02-deep-dive.md) — associated types, dispatch, erasure, trade-offs
3. [`03-production-bridge.md`](03-production-bridge.md) — Ads + HeroWidget + Stories soft bridge
4. [`code/`](code/) — mini ads pipeline; walk through aloud
5. [`sample/`](sample/README.md) — spoken Q&A + brain puzzles (`01`–`06`; `06` folds exercise/flash-recall leftovers)
6. [`04-questions.md`](04-questions.md) — normal Qs + tricky **T1–T10** brain puzzles; speak aloud
7. [`05-exercises.md`](05-exercises.md) — coding + speaking drills (still do the hands-on exercises here)
8. Revision twin for flashcards / timed drill day-of

## Module map

| Module | File | Role |
|---|---|---|
| Foundations | [01-foundations.md](01-foundations.md) | POP mental model + first generics |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) | associatedtype, some/any, erasure, dispatch |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) | Ads + HeroWidget + Stories soft bridge |
| Questions | [04-questions.md](04-questions.md) | Normal + tricky **T1–T10** |
| Exercises | [05-exercises.md](05-exercises.md) | Coding + speaking drills |
| Code | [code/AdsPipeline.swift](code/AdsPipeline.swift), [code/TypeErasureDemo.swift](code/TypeErasureDemo.swift) | Runnable mental models |
| Sample Q&A (guided) | [sample/](sample/README.md) | Includes **06-module-drills** leftovers from these modules |

## Time budget (suggested)

| Block | Minutes |
|---|---|
| Foundations | 60–75 |
| Deep dive | 75–90 |
| Production bridge + code | 35–45 |
| Sample `01`–`06` (spoken) | 45–60 |
| Questions (speak 7–9 aloud + T1–T5) | 60–75 |
| Exercises + timed drill | 45–60 |

## Provenance reminder

Only use Verified IDs from [`../../../provenance/README.md`](../../../provenance/README.md).

| Label | Use for today |
|---|---|
| **Verified · S1** | Ads module refactor; POP + Generics type-safe pipeline; HeroWidget pause/play lifecycle |
| **Verified · S10** | Soft bridge: Stories SDK — reusable protocol APIs across portfolio |
| **Verified · S3** | Soft mention only: protocol-driven header / SDUI-ish shape (deepen later) |
| **How I would apply it · S3-A1** | Schema versioning + unknown-component fallback (design; not Day 02 core claim) |
| **Learning-lab** | `AdsPipeline.swift` / type-erasure demos — not claimed as shipped BMS source |

Do **not** invent fill-rate %, revenue deltas, or crash rates for ads.

In spoken answers and relate sections, prefer **named work** (BookMyShow Ads pipeline + HeroWidget lifecycle, Stories SDK, backend-driven header) — never S-codes.

## Agenda openers (pin these)

| Topic | 5–10s opener |
|---|---|
| POP | “Compose capabilities with protocols — prefer that over deep inheritance.” |
| associatedtype vs generic | “Associated type is chosen by the conformer; generic param by the caller.” |
| some vs any | “Opaque concrete vs existential box.” |
| Type erasure | “Box a protocol with associated types into one type — pay allocation and lose specialization.” |
| Ads + HeroWidget | “Highest-revenue Ads path — protocols, generics, video lifecycle.” |

## Timed drill (after full study)

1. Speak Q1, Q4, Q6, T1, T5 from `04-questions.md` on a timer (timed sets cite **T1–T5**).
2. 5 min whiteboard: Ads inheritance pain → POP → generics pipeline → HeroWidget → trade-offs.
3. Score against [answer-timing-guide.md](../../../timing/answer-timing-guide.md); log misses.
