# Day 05 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 05 modules.  
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
| [01-async-await.md](01-async-await.md) | Suspension vs blocking, Tasks, async/await mental model | Foundations · Deep dive |
| [02-structured-concurrency.md](02-structured-concurrency.md) | Structured vs unstructured, cancel, debounce | Foundations · Deep dive |
| [03-actors-sendable.md](03-actors-sendable.md) | Actors, reentrancy, `@MainActor`, Sendable | Foundations · Deep dive |
| [04-production-s2.md](04-production-s2.md) | Verified S2 vs S2-A1, S3 cancel hook | Production bridge |

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

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).
