# Day 12 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 12 modules.  
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
| [01-state-ownership.md](01-state-ownership.md) | @State, @Binding, @Observable, Environment rules | Foundations · Deep dive |
| [02-identity-traps.md](02-identity-traps.md) | Structural vs explicit identity, UUID trap, @State lifetime | Foundations · Deep dive · code |
| [03-lists-performance.md](03-lists-performance.md) | Lazy containers, stable IDs, invalidation storms | Foundations · Deep dive · code |
| [04-production-s10.md](04-production-s10.md) | Verified S10 Stories SDK API + isolation | Production bridge |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Short-form video feed | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| `@State` | View-local **ephemeral** UI — not every toggle in VM |
| `@Observable` | iOS **17+** — still explain `ObservableObject` for legacy |
| Identity | `@State` lifetime follows identity — `.id(UUID())` in body resets everything |
| Lists | `List` / `LazyVStack` for large data — not eager `VStack` of thousands |
| S10 | Reusable SDK = **public API + host isolation** — not hardcoded networking |
| Trap | UUID in `.id` → text fields clear, representables remake (Day 11 pain) |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 12 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
