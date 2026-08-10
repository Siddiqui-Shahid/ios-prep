# Day 08 — MVVM / Clean / MVI · Layering · DI

> Week 2 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-02/day-08.md](../../../revision/weeks/week-02/day-08.md)

## Outcomes

By end of day, without notes, you can:

- Choose **MVVM vs Clean vs MVI** with a clear decision rule and one production example each
- Draw the **layer stack** (View → VM → UseCase → Repository → DataSource) and say what each layer must never own
- Defend **constructor + protocol DI** without DI-framework religion; name when factories / Environment are OK
- Deliver **S9** honestly: Free Parking + MVVM↔Clean migration; AI as **accelerator inside an architectural envelope**, not author of record
- Walk **S3** BMS search as MVVM: debounce, cancel, explicit idle/loading/results/empty/error states

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary (intern → mid)
2. `02-deep-dive.md` — layering, DI graphs, migration strangler, MVI, search VM shape
3. `03-production-bridge.md` — Verified S9 + S3 + interview scripts (AI wording)
4. `code/` — `SearchViewModel.swift`, `FreeParkingUseCase.swift`, `FeatureAssembler.swift`
5. `sample/07-revision-qna.md` — cover full answers; speak from **Answer points**; compare
6. `05-exercises.md` — whiteboard + coding + speaking drills
7. Revision twin for timed recall after the full read

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Sample Q&A | [sample/README.md](sample/README.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/SearchViewModel.swift](code/SearchViewModel.swift), [code/FreeParkingUseCase.swift](code/FreeParkingUseCase.swift), [code/FeatureAssembler.swift](code/FeatureAssembler.swift) |

## Provenance reminder

| Label | Meaning for today |
|---|---|
| **Verified · S9** | District Free Parking billing adjustments; MVVM↔Clean migration; Context Engineering; XCTest/XCUITest assist |
| **Verified · S3** | BMS search debounce / MVVM state / cancel; backend-driven header is Day 10’s SDUI beat |
| **Learning-lab** | Illustrative Search VM, UseCase, assembler snippets in this chapter |

Do **not** claim “AI wrote the architecture,” invented velocity %, or that every screen was Clean-ified.

## Agenda opener (say this first in an architecture HLD)

> “I’ll default to MVVM for feature UI, introduce Clean UseCases where domain or migration risk demands it, and keep DI as protocol + constructor injection — then map to District Free Parking and BMS search.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive + code | 90–120 |
| Production bridge + S9 STAR | 30–40 |
| Questions (record 5) | 45–60 |
| Exercises | 30–40 |
| Revision twin skim | 15 |

## Source / version note

Teaching targets **modern Swift** with async/await ViewModels and optional `@Observable` (iOS 17+) as the SwiftUI binding path. Clean Architecture here means **UseCase/Entity boundaries**, not a cult of folder names. Optional citations only at the end of `02-deep-dive.md` — this chapter is self-contained.
