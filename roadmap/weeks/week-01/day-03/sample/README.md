# Day 03 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 03 modules.  
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
| [01-arc-basics.md](01-arc-basics.md) | ARC, strong/weak/unowned, `deinit`, value types | Foundations · Deep dive |
| [02-retain-cycles.md](02-retain-cycles.md) | Cycles + classic UIKit patterns + demo code | Foundations · Deep dive · code |
| [03-tools-and-leaks.md](03-tools-and-leaks.md) | Leak vs abandoned, Memory Graph / Allocations / Leaks | Foundations · Deep dive |
| [04-production-s8.md](04-production-s8.md) | Verified S8 vs Applied triage language | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Retain cycle | Reachable **abandoned** memory |
| Instruments **Leaks** | Finds **unreachable** memory — not cycles |
| Timer `target:selector:` | Timer **strongly retains** the target until `invalidate` |
| NotificationCenter block API | Store the **observer token** and remove on teardown |
| Uncertain lifetime (async UI) | Prefer `[weak self]` |
| S8 | Reliability culture — do not invent a BMS Memory Graph war story |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 03 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
