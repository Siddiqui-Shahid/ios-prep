# Day 11 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 11 modules. 
> Use this when you want concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../07-revision-qna.md`](../07-revision-qna.md) and drills in [`../05-exercises.md`](../05-exercises.md).

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-lifecycle-hooks.md](01-lifecycle-hooks.md) | VC lifecycle order, load vs appear, tab trap, ads pause | Foundations · Deep dive |
| [02-cells-reuse-prefetch.md](02-cells-reuse-prefetch.md) | Cell reuse, prepareForReuse, Diffable, prefetch budgets | Foundations · Deep dive · code |
| [03-hybrid-interop.md](03-hybrid-interop.md) | UIHostingController, Representables, deeplinks, one router | Foundations · Deep dive · code |
| [04-production-s13-s6.md](04-production-s13-s6.md) | Verified S13 hybrid + S6 bottom sheet + S1 lifecycle hook | Production bridge |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Deep linking | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Load vs appear | `viewDidLoad` once; tabs **appear many times** — refresh on appear |
| Wrong cell image | Async completion after reuse without ID check |
| Prefetch | Warm + **cancel** + bound concurrency — not unlimited download |
| Hybrid nav | **One router owner** — dual stacks double-present |
| S6 metric | **30%+** fewer full-screen navigations — resume only |
| S13 | Hybrid interop + deeplinks **designed**, not bolted |
| S1 | HeroWidget pause/play is a **product contract**, not plumbing |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then main [`../07-revision-qna.md`](../07-revision-qna.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 11 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
