# Day 02 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 02 modules.  
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
| [01-pop-and-generics.md](01-pop-and-generics.md) | POP, protocols, generics, `some`/`any` first cut | Foundations · Deep dive |
| [02-associated-types-erasure.md](02-associated-types-erasure.md) | Associated types under pressure, dispatch, type erasure | Foundations · Deep dive |
| [03-pipeline-and-code.md](03-pipeline-and-code.md) | Ads pipeline shape, HeroWidget, code demos | Deep dive · code |
| [04-production-s1.md](04-production-s1.md) | Verified S1 / S10 interview language | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| POP | Compose **capabilities**; inheritance models *what you are* |
| Generics | **Caller** chooses `T` |
| Associated type | **Adopter** chooses the concrete type |
| Mixed `[AdRenderable]` with associated types | Awkward — stay generic, erase at boundary, constrained `any`, or closed enum |
| Speech | Say “protocol with associated type” — not unexplained PAT letter-soup |
| Extension-only method | May **not** override through an existential — promote to requirements |
| Type erasure | Allocation + indirection + lost specialization |
| Verified S1 | Type-safe ads pipeline + HeroWidget lifecycle — **no** invented fill-rate % |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 02.

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
