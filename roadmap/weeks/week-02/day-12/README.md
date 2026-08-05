# Day 12 — SwiftUI State, Identity, @Observable, Lists, Performance

> Week 2 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-02/day-12.md](../../../revision/weeks/week-02/day-12.md)

## Outcomes

By end of day, without notes, you can:

- Apply **state ownership** rules: `@State`, `@Binding`, `@Observable` / `@Bindable`, Environment — what belongs where
- Explain **identity** (structural vs explicit `.id`, `@State` lifetime) and why UUID-in-body bugs happen
- Build **performant lists** (lazy stacks, stable IDs, avoid invalidation storms)
- Note **`@Observable` is iOS 17+**; know `ObservableObject` for legacy interviews
- Deliver **S10** Stories SDK: public API, host isolation, stable page identity, pause on disappear

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary
2. `02-deep-dive.md` — identity, Observation, lists, SDK state machine
3. `03-production-bridge.md` — Verified S10 + honest API claims
4. `code/` — `StoriesPlayerModel.swift`, `IdentityTraps.swift`, `LazyListNotes.swift`
5. `04-questions.md` — Answer points → full spoken
6. `05-exercises.md`
7. Revision twin

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [04-questions.md](04-questions.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/StoriesPlayerModel.swift](code/StoriesPlayerModel.swift), [code/IdentityTraps.swift](code/IdentityTraps.swift), [code/LazyListNotes.swift](code/LazyListNotes.swift) |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Provenance reminder

| Label | Meaning for today |
|---|---|
| **Verified · S10** | Stories SDK — standalone reusable; clear public API; isolation from app-specific networking where possible; portfolio reuse (Miami Heat / Raw) |
| **Verified · S13** | Hybrid hosting identity sibling (Day 11) |
| **Learning-lab** | Player model / identity / list snippets |

Do **not** claim a specific third-party image library as required; do not invent portfolio install counts.

## Agenda opener

> “State ownership, then identity, then list performance, then Stories SDK API isolation with S10.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive + code | 90–120 |
| Production bridge + S10 STAR | 30–40 |
| Questions | 45–60 |
| Exercises | 30–40 |
| Revision skim | 15 |

## Source / version note

**`@Observable` / Observation framework: iOS 17+.** For older deployment targets, `ObservableObject` + `@Published` remains interview-relevant. This chapter is self-contained; optional citations at end of deep dive.
