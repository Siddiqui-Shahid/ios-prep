# Day 03 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 03 modules. 
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
| [01-arc-basics.md](01-arc-basics.md) | ARC, strong/weak/unowned, `deinit`, value types | Parent↔child decision; deinit print lab; unowned crash risk |
| [02-retain-cycles.md](02-retain-cycles.md) | Cycles + classic UIKit patterns + demo code | Nested `guard let self`; Combine store; Task; singleton forever-cache |
| [03-tools-and-leaks.md](03-tools-and-leaks.md) | Leak vs abandoned, Graph / Allocations / Leaks | CFRelease true leak; edge-walking script; jetsam; autoreleasepool |
| [04-production-s8.md](04-production-s8.md) | Verified reliability vs Applied triage | STAR with ARC as supporting color; honesty checklist |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Image loading (memory) | Cancel / weak completions; bounded cache vs forever map |
| [06-module-drills.md](06-module-drills.md) | Exercises + flash recall + close-out | A–I drills, trap cards, README outcomes |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Retain cycle | Reachable **abandoned** memory |
| Instruments **Leaks** | Finds **unreachable** memory — not cycles |
| “Found the cycle in Leaks” | **Never say this** — use Memory Graph / Allocations |
| Timer `target:selector:` | Timer **strongly retains** the target until `invalidate` |
| NotificationCenter block API | Store the **observer token** and remove on teardown |
| Uncertain lifetime (async UI) | Prefer `[weak self]` — `unowned` can use-after-free |
| Nested after `guard let self` | New escaping work can **re-strong-capture** |
| Autoreleasepool | Lowers watermark — **≠** cycle fix |
| Verified reliability culture | BookMyShow IMOC + crash-free at scale — do **not** invent a BMS Memory Graph war story |
| Applied triage | Graph → Allocations → Leaks — label **Applied** |

## Suggested order

`01` → `02` → `03` → `04` → `05` → `06` → [`../07-revision-qna.md`](../07-revision-qna.md) (T1–T10; timed cites T1, T5, T8) → coding in [`../05-exercises.md`](../05-exercises.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 03 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
