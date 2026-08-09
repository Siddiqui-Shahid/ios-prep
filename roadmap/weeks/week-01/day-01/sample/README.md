# Day 01 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 01 modules.  
> Use this when you want concepts as **question → spoken answer → follow-ups → brain puzzles**.  
> Samples now also fold in leftovers from foundations, deep dive, production bridge, questions, and exercises.

## How to use

1. Read the question.
2. Say the **Answer** out loud like you’re in an interview.
3. Cover follow-ups, try to answer, then check.
4. Do **Brain puzzles** at the bottom of each file.
5. Finish with [06-module-drills.md](06-module-drills.md), then [`../04-questions.md`](../04-questions.md) and [`../05-exercises.md`](../05-exercises.md).

## Topic map

| Sample file | What it teaches | Also pulled from modules |
|---|---|---|
| [01-value-types.md](01-value-types.md) | struct vs class, copy vs share, let vs var, exclusivity / mutating | Large-struct copy cost; 45s agenda; closure nested-ref |
| [02-cow-enums.md](02-cow-enums.md) | COW, handmade COWList, enums as state machines | Payment transition graph; Result→UI; `@unknown` / SDUI unknown |
| [03-actors-classes.md](03-actors-classes.md) | class identity, actors intro, MainActor | Reentrancy awareness; Set hashing; when not to migrate |
| [04-production-s1-s7.md](04-production-s1-s7.md) | Ads / HeroWidget, payment popup, dictionaries → actors | Metric-inflation & story-combining traps |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Social Feed (scope/clarify) | Type-choice instincts in feed HLD |
| [06-module-drills.md](06-module-drills.md) | Exercises + flash recall + close-out | LoadState, payment graph, COW, nested refs, SyncedMap, README outcomes |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Value vs reference | Structs copy snapshots; classes share identity on the heap |
| `let` vs `var` | Controls **binding** mutability — not the same as value vs reference |
| COW | Share buffer until write; then copy if not uniquely referenced |
| Enum state | Impossible combinations become compile errors, not runtime bugs |
| Actor intro | Isolated reference type; `await` to touch state — **reentrant at await** |
| Verified Ads / HeroWidget | Type-safe ads pipeline + HeroWidget lifecycle — **no** invented fill-rate % |
| Verified payment popup | Processing popup with explicit status — **no** invented drop-off % |
| Payment / SafeDict design | **How I would apply it** — design patterns, not shipped claims |

## Suggested order

`01` → `02` → `03` → `04` → `05` → `06` → [`../04-questions.md`](../04-questions.md) (T1–T10) → coding in [`../05-exercises.md`](../05-exercises.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 01 (not the full curriculum modules).
