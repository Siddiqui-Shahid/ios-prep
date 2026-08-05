# Day 13 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 13 modules.  
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
| [01-stack-queue-basics.md](01-stack-queue-basics.md) | LIFO/FIFO, Array stack/queue footguns, complexity | Foundations · Deep dive |
| [02-monotonic-patterns.md](02-monotonic-patterns.md) | Valid parens, monotonic stack, min stack, two-stack queue | Deep dive · code |
| [03-linked-list-algos.md](03-linked-list-algos.md) | Reverse, Floyd cycle, merge, Swift honesty | Foundations · Deep dive · code |
| [04-production-bridges.md](04-production-bridges.md) | Agenda-first coding, soft S4/S6 bridges, Mock #2 prep | Production bridge · Deep dive |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Array as queue | `removeFirst()` is **O(n)** — call it out or use two-stack / Deque |
| Two-stack queue | **Amortized** O(1) — not strict O(1) every dequeue |
| Linked list in Swift apps | Interview skill + LRU design — **not** everyday UITableView |
| Agenda-first | 2–3 min spoken plan **before** typing |
| S4 bridge | Refresh **waiters** = FIFO queue of continuations (soft, not shipped LL) |
| Forbidden | “We used linked lists for the feed” |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 13 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
