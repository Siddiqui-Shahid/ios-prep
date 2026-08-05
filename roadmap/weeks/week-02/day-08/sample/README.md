# Day 08 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 08 modules.  
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
| [01-layer-stack-di.md](01-layer-stack-di.md) | Layer stack, MVVM vs Clean vs MVI, DI without dogma | Foundations · Deep dive |
| [02-mvvm-clean-mvi.md](02-mvvm-clean-mvi.md) | UseCase vs Repository, MVI, fat VM surgery, migration | Deep dive · code |
| [03-search-cancel-states.md](03-search-cancel-states.md) | Debounce, cancel, state enum, stale responses | Deep dive · code |
| [04-production-s9-s3.md](04-production-s9-s3.md) | Verified S9 Free Parking + S3 search interview language | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Default pattern | MVVM for feature UI; Clean UseCases where rules/migration demand |
| Debounce | Lives in ViewModel (presentation policy), not URLSession |
| Repository vs UseCase | Repo = where bytes come from; UseCase = what product should do |
| DI default | Protocol + constructor injection; assembler at module edge |
| S9 AI line | Accelerator inside envelope — you own architecture, not the tool |
| S3 search | Explicit idle/loading/results/empty/error + cancel stale work |
| Forbidden | “AI wrote our Clean Architecture” or “whole app is Clean” |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 08 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
