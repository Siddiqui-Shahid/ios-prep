# Day 04 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 04 modules.  
> Use this when you want concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../04-questions.md`](../04-questions.md) and drills in [`../05-exercises.md`](../05-exercises.md).

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-queues-sync-async.md](01-queues-sync-async.md) | Serial/concurrent, main vs global QoS, sync vs async, deadlock | Foundations · Deep dive |
| [02-thread-safe-dict.md](02-thread-safe-dict.md) | Pattern A serial queue, Pattern B barriers, async write / sync read visibility | Foundations · Deep dive · code |
| [03-groups-races.md](03-groups-races.md) | DispatchGroup, semaphores, race vs deadlock vs priority inversion, actors preview | Foundations · Deep dive |
| [04-production-s2.md](04-production-s2.md) | Verified S2 vs Applied S2-A1, anti-claims | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Shared dict without sync | **Data race** — undefined behavior |
| `main.sync` from main | **Deadlock** — same rule for any serial queue |
| Async write + sync read | May not see write until write runs — prefer **sync set** for read-after-write |
| Hide the queue | Expose safe methods only — S2 lesson |
| Barrier on concurrent queue | Exclusive writer; plain reads may overlap |
| Verified · S2 | Path-specific race elimination on synchronised dictionaries |
| S2-A1 actor | **How I would apply it** — not a claim you rewrote production |
| Spell it | **`final class`**, never `Final class` |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## Code (learning-lab)

- [`../code/SafeDict.swift`](../code/SafeDict.swift) — serial queue Pattern A  
- [`../code/BarrierDict.swift`](../code/BarrierDict.swift) — concurrent + barrier Pattern B
