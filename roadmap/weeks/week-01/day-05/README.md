# Day 05 — async/await, Structured Concurrency, Actors, Sendable

> Week 1 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-01/day-05.md](../../../revision/weeks/week-01/day-05.md)

## Outcomes

By end of day, without notes, you can:

- Explain `async`/`await` as cooperative suspension (not “background thread magic”)
- Contrast structured concurrency (`async let`, `TaskGroup`) with unstructured `Task` / `Task.detached`
- Describe cooperative Task cancellation and why search debounce must cancel in-flight work
- Explain actor isolation, **reentrancy** (state may change across `await`), and `@MainActor`
- State `Sendable` rules correctly — including that value types are Sendable **only if** all stored properties are
- Pitch the BMS synchronised-dictionary story (Verified · S2) and a greenfield actor migration (How I would apply it · S2-A1)
- Speak carefully about Swift 6.2 / Approachable Concurrency / default MainActor isolation as **settings when enabled**, not universal language law

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary (intern → competent)
2. `02-deep-dive.md` — full mechanics, reentrancy, Sendable, settings caveats
3. `03-production-bridge.md` — S2 / S2-A1 / S3 hooks and interview lines
4. `code/SafeDictActor.swift` — read, then explain aloud line by line
5. `04-questions.md` — cover Full spoken answers; speak from **Answer points**; compare
6. `05-exercises.md` — coding + speaking drills
7. Revision twin for timed drill after the full read

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [04-questions.md](04-questions.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/SafeDictActor.swift](code/SafeDictActor.swift) |
| Sample Q&A (guided) | [sample/](sample/README.md) |

## Provenance reminder

Only use Verified IDs from [`../../../provenance/README.md`](../../../provenance/README.md).

| Label | What you may say |
|---|---|
| **Verified · S2** | GCD serial queues / RW locks around shared dictionaries at BookMyShow; race/crash reduction **on that path** (do not claim sole ownership of app-wide crash-free %) |
| **How I would apply it · S2-A1** | Greenfield shared maps → Swift `actor` with the same safe API surface |
| **Verified · S3** | Search debounce + explicit loading/empty/error state + MVVM at BMS |
| **Learning-lab** | Illustrative snippets (`SafeDictActor`, reentrancy demos) not claimed as shipped |

## Source / version note

Teaching targets **Swift concurrency as available in modern Xcode** (async/await, actors, Sendable). Behaviors that depend on **Swift 6 language mode**, **Approachable Concurrency**, or **default actor isolation** settings are called out explicitly as *when enabled* — they are not presented as “how every Swift app works.”

## Timed drill (after full study)

1. Speak Q4, Q5, T1, T3 from `04-questions.md` on a timer.
2. 90s pitch: “How would you migrate synchronised dictionaries to actors?” (S2 → S2-A1).
3. Score against [answer-timing-guide.md](../../../timing/answer-timing-guide.md); log misses.
