# Day 02 — Protocols, POP, Generics, Associated Types, Type Erasure

> Week 1 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-01/day-02.md](../../../revision/weeks/week-01/day-02.md)

## Outcomes

By end of day, without notes, you can:

- Explain protocol-oriented design vs inheritance for UI / ad component pipelines
- Use generics + associated types + `where` clauses and say when each belongs
- Contrast `some` vs `any`, and when PATs force generics or type erasure
- Explain type erasure (AnyPublisher-style boxing) and its cost
- Deliver a ≤5 min architecture talk on BMS Ads / HeroWidget (Verified · S1) without inventing fill-rate metrics
- Soft-bridge to Stories SDK (Verified · S10) for reusable protocol APIs at a boundary

## How to study (in Cursor only)

1. [`01-foundations.md`](01-foundations.md) — mental model (intern → mid)
2. [`02-deep-dive.md`](02-deep-dive.md) — PATs, dispatch, erasure, trade-offs
3. [`03-production-bridge.md`](03-production-bridge.md) — Verified · S1 / S10 hooks
4. [`code/`](code/) — mini ads pipeline; walk through aloud
5. [`04-questions.md`](04-questions.md) — speak from **Answer points**; compare to full answer
6. [`05-exercises.md`](05-exercises.md) — drills + timed practice
7. Revision twin for flashcards / timed drill day-of

## Module map

| Module | File | Role |
|---|---|---|
| Foundations | [01-foundations.md](01-foundations.md) | POP mental model + first generics |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) | associatedtype, some/any, erasure, dispatch |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) | S1 Ads + HeroWidget + S10 soft bridge |
| Questions | [04-questions.md](04-questions.md) | Two-layer Q&A (normal + tricky) |
| Exercises | [05-exercises.md](05-exercises.md) | Coding + speaking drills |
| Code | [code/AdsPipeline.swift](code/AdsPipeline.swift), [code/TypeErasureDemo.swift](code/TypeErasureDemo.swift) | Runnable mental models |
| Sample Q&A (guided) | [sample/](sample/README.md) | Concept teaching; does not replace modules above |

## Time budget (suggested)

| Block | Minutes |
|---|---|
| Foundations | 60–75 |
| Deep dive | 75–90 |
| Production bridge + code | 35–45 |
| Questions (speak 7–9 aloud) | 60–75 |
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

## Agenda openers (pin these)

| Topic | 5–10s opener |
|---|---|
| POP | “Compose capabilities with protocols — prefer that over deep inheritance.” |
| associatedtype vs generic | “Associated type is chosen by the conformer; generic param by the caller.” |
| some vs any | “Opaque concrete vs existential box.” |
| Type erasure | “Box a PAT into one type — pay allocation and lose specialization.” |
| S1 Ads | “Highest-revenue Ads path — protocols, generics, video lifecycle.” |
