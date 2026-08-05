# Day 18 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 18 modules.  
> Use this when you want concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../04-questions.md`](../04-questions.md) and drills in [`../05-exercises.md`](../05-exercises.md).

## Module map

Main curriculum modules for this day — see [`../README.md`](../README.md#module-map).

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-crash-pipeline-cfs.md](01-crash-pipeline-cfs.md) | Crash SDK pipeline, CFS, S2≠S8 honesty | Foundations |
| [02-signal-safety-oom.md](02-signal-safety-oom.md) | Signal handlers, breadcrumbs, OOM, dSYM | Deep dive |
| [03-imoc-triage.md](03-imoc-triage.md) | Triage workflow, IMOC, mitigate vs hotfix | Deep dive · Foundations |
| [04-production-s8-s2.md](04-production-s8-s2.md) | Verified S8 IMOC/CFS + S2 correct coupling | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| S2 alone caused 99.95% CFS | **Forbidden** — S2 ⊂ reliability; S8 = system |
| try/catch catches SEGV | **No** — signals need handlers + discipline |
| Upload in signal handler | **Never** — persist async-signal-safe; upload next launch |
| CFS fine ⇒ no freezes | **False** — hangs/OOM may not move CFS |
| Leaks for retain cycles | **Wrong tool** — Graph + Allocations |
| Verified S8 | 30L+ DAU, 99.95%+ CFS, Crashlytics triage, IMOC |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 18 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
