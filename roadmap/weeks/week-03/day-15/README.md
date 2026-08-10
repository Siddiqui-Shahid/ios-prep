# Day 15 — App Modularization, SPM & DI Graphs

> Week 3 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-03/day-15.md](../../../revision/weeks/week-03/day-15.md)

## Outcomes

By end of day, without notes, you can:

- Explain why features depend on **interfaces**, never other feature **implementations**
- Map **SPM** targets to Interface / Impl / Core and what that buys for build parallelism
- Wire a **composition root** (App target) without feature-level singletons
- Deliver **Verified S10**: Stories SDK as a reusable module across the portfolio
- Defend trade-offs: CocoaPods vs SPM, static vs dynamic, constructor/tree DI vs service locator

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary 
2. `02-deep-dive.md` — graphs, SPM, DI, SDK extraction (embedded) 
3. `03-production-bridge.md` — Verified S10 STAR + Applied hooks 
4. `code/` — Package sketch + DI + Stories public API 
5. `sample/07-revision-qna.md` — two-layer Q&A 
6. `05-exercises.md` — whiteboard + speaking 
7. Revision twin for timed recall 

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/](code/) |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Provenance reminder

| Label | Meaning |
|---|---|
| **Verified · S10** | Standalone reusable Stories SDK; portfolio adoption; public API + isolation |
| **Verified · S1** | Soft: Ads as module with POP+Generics boundary |
| **Verified · S9** | Soft: Clean/MVVM boundaries + test discipline |
| **Verified · S4** | Soft: packaging ≠ architecture (Ads pod path ownership) |
| **Learning-lab** | Package.swift / DI sketches in `code/` |

Do **not** invent “80 modules cut build by X%” numbers you don’t have.

## Agenda opener

> “I’ll clarify module boundaries, show Interface/Impl plus a DI composition root, then deep-dive Stories-as-SDK and build/link trade-offs.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 40–50 |
| Deep dive + code | 90–110 |
| Production bridge + S10 STAR | 30–40 |
| Questions | 45–60 |
| Exercises | 30–40 |
| Revision twin | 15 |
