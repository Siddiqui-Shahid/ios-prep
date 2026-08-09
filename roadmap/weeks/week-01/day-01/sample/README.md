# Day 01 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 01 modules.  
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
| [01-value-types.md](01-value-types.md) | struct vs class, copy vs share, decision table | Foundations · Deep dive |
| [02-cow-enums.md](02-cow-enums.md) | COW mechanics, enums as state machines, nested refs | Foundations · Deep dive · code |
| [03-actors-classes.md](03-actors-classes.md) | class identity, actors intro, trade-offs | Foundations · Deep dive |
| [04-production-s1-s7.md](04-production-s1-s7.md) | Verified S1 ads models, S7 payment, Applied S7-A1, S2 actors bridge | Production bridge |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Social Feed (scope/clarify) | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Value vs reference | Structs copy snapshots; classes share identity on the heap |
| `let` vs `var` | Controls **binding** mutability — not the same as value vs reference |
| COW | Share buffer until write; then copy if not uniquely referenced |
| Enum state | Impossible combinations become compile errors, not runtime bugs |
| Actor intro | Isolated reference type; `await` to touch state — not “replace all classes” |
| Verified S1 | Type-safe ads pipeline + HeroWidget lifecycle — **no** invented fill-rate % |
| Verified S7 | Processing popup with explicit status — **no** invented drop-off % |
| S7-A1 / S2-A1 | **How I would apply it** — design patterns, not shipped claims |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 01 (not the full curriculum modules).
