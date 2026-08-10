# Day 04 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 04 modules. 
> Use this when you want concepts as **question → spoken answer → follow-ups → brain puzzles**. 
> Samples now also fold in leftovers from foundations, deep dive, production bridge, questions, and exercises.

## How to use

1. Read the question.
2. Say the **Answer** out loud like you’re in an interview.
3. Cover follow-ups, try to answer, then check.
4. Do **Brain puzzles** at the bottom of each file.
5. Finish with [06-module-drills.md](06-module-drills.md), then [`../07-revision-qna.md`](../07-revision-qna.md) (T1–T10) and [`../05-exercises.md`](../05-exercises.md).

## Topic map

| Sample file | What it teaches | Also pulled from modules |
|---|---|---|
| [01-queues-sync-async.md](01-queues-sync-async.md) | Serial/concurrent, main vs global QoS, sync vs async, deadlock | Target-queue inversion; GCD↔async bridge; QoS |
| [02-thread-safe-dict.md](02-thread-safe-dict.md) | Pattern A serial queue, Pattern B barriers, visibility | Hide API; writer starvation; mutable interior |
| [03-groups-races.md](03-groups-races.md) | DispatchGroup, semaphores, race vs deadlock vs PI | Actor preview; locks vs queues vs actors |
| [04-production-s2.md](04-production-s2.md) | Verified dictionaries vs actor design coda | Anti-claims; STAR timing; IMOC scope |
| [05-system-design-mock.md](05-system-design-mock.md) | Offline sync engine mock | Single-writer actor ↔ SafeDict instinct |
| [06-module-drills.md](06-module-drills.md) | Leftovers + flash recall + close-out | concurrentPerform harness; continuations; ABBA; unlockeds |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Shared dict without sync | **Data race** — undefined behavior |
| `main.sync` from main | **Deadlock** — same rule for any serial queue |
| Async write + sync read | May not see write until write runs — prefer **sync set** for read-after-write |
| Hide the queue | Expose safe methods only — BookMyShow synchronised dictionaries lesson |
| Barrier on concurrent queue | Exclusive writer; plain reads may overlap; watch **writer starvation** |
| BookMyShow synchronised dictionaries | Path-specific race elimination — not org-wide CFS |
| Design: actor SafeDict | **How I would apply it** — not a claim you rewrote production |
| Spell it | **`final class`**, never `Final class` |

## Suggested order

`01` → `02` → `03` → `04` → `05` → `06` → [`../07-revision-qna.md`](../07-revision-qna.md) (T1–T10) → coding in [`../05-exercises.md`](../05-exercises.md).

## Code (learning-lab)

- [`../code/SafeDict.swift`](../code/SafeDict.swift) — serial queue Pattern A 
- [`../code/BarrierDict.swift`](../code/BarrierDict.swift) — concurrent + barrier Pattern B
