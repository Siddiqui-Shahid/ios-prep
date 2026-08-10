# Day 05 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 05 modules. 
> Use this when you want concepts as **question → spoken answer → follow-ups → brain puzzles**. 
> Samples now also fold in leftovers from foundations, deep dive, production bridge, questions, and exercises.

## How to use

1. Read the question.
2. Say the **Answer** out loud like you’re in an interview.
3. Cover follow-ups, try to answer, then check.
4. Do **Brain puzzles** at the bottom of each file.
5. Finish with [06-module-drills.md](06-module-drills.md), then [`../07-revision-qna.md`](../07-revision-qna.md) and [`../05-exercises.md`](../05-exercises.md).

## Topic map

| Sample file | What it teaches | Also pulled from modules |
|---|---|---|
| [01-async-await.md](01-async-await.md) | Suspension, Tasks, async vs callbacks | Why Day 05 after 04; not every await suspends; 30s definition; data race vs race condition |
| [02-structured-concurrency.md](02-structured-concurrency.md) | Structure, cancel, debounce | Search VM pattern; failure-mode table; continuations; venue `async let`; timeouts |
| [03-actors-sendable.md](03-actors-sendable.md) | Actors, reentrancy, Sendable | Office analogy; 8 decision rules; MainActor.run vs sync; SafeDictActor narration |
| [04-production-s2.md](04-production-s2.md) | S2 / S2-A1 / S3 honesty | Full STAR spine; bridges A/B/C |
| [05-system-design-mock.md](05-system-design-mock.md) | Social feed HLD + async | Feed concurrency map; timeouts / kill switches |
| [06-module-drills.md](06-module-drills.md) | Exercises + flash recall + close-out | A1–A3, C1–C3, flash cards, README outcomes |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| `await` | Suspension point — **not** “always background thread” |
| Structured concurrency | Parent owns children; cancel and errors can propagate |
| Unstructured `Task` | You own lifetime and cancellation (UI boundaries) |
| Cancellation | **Cooperative** — not preemptive thread killing |
| Actor | Prevents data races on isolated state — **reentrant at `await`** |
| Sendable | Value types are Sendable **only if** stored properties are |
| Verified S2 | GCD synchronised dictionaries at BMS — not org-wide actor rewrite |
| S2-A1 | Greenfield actor migration — **How I would apply it** |

## Suggested order

`01` → `02` → `03` → `04` → `05` → `06` → [`../07-revision-qna.md`](../07-revision-qna.md) (T1–T10) → coding in [`../05-exercises.md`](../05-exercises.md).
