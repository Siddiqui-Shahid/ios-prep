# Day 02 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 02 modules.  
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
| [01-pop-and-generics.md](01-pop-and-generics.md) | POP, composition, generics, `some`/`any`, AnyObject, rethrows | Fragile base; conditional conformance vs `where`; YAGNI |
| [02-associated-types-erasure.md](02-associated-types-erasure.md) | Associated types, primary ATs, dispatch triad, erasure | Stay generic vs erase vs enum; Self blocking `any` |
| [03-pipeline-and-code.md](03-pipeline-and-code.md) | AdsPipeline / TypeErasureDemo walk, HeroWidget, 5-min spine | `_track` / upcast; anti-patterns; whiteboard agenda |
| [04-production-s1.md](04-production-s1.md) | Ads + HeroWidget honesty; Stories soft bridge | Lab vs shipped; no invent fill-rate % |
| [05-system-design-mock.md](05-system-design-mock.md) | SDUI HLD + ComponentRegistry | Open registry + unknown fallback; ops scorecard |
| [06-module-drills.md](06-module-drills.md) | Exercises + flash recall + close-out | A1–A7 style drills, README outcomes, triad |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| POP | Compose **capabilities**; inheritance models *what you are* |
| Generics | **Caller** chooses `T` |
| Associated type | **Adopter** chooses the concrete type |
| Mixed `[AdRenderable]` with associated types | Awkward — stay generic, erase at boundary, constrained `any`, or closed enum |
| Speech | Say “protocol with associated type” — not unexplained PAT letter-soup |
| Extension-only method | May **not** override through an existential — promote to requirements |
| Dispatch triad | Static · witness table · `@objc` message send |
| Type erasure | Allocation + indirection + lost specialization + narrower API |
| YAGNI vs revenue | Don’t abstract two forever-types; Ads scale justified POP |
| Honesty | Type-safe ads pipeline + HeroWidget lifecycle — **no** invented fill-rate % |

## Suggested order

`01` → `02` → `03` → `04` → `05` → `06` → [`../04-questions.md`](../04-questions.md) (T1–T10) → coding in [`../05-exercises.md`](../05-exercises.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 02.

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
