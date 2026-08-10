# Day 14 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 14 modules. 
> Use this when you want revision and Mock #2 prep as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, run Mock #2 from [`../02-deep-dive.md`](../02-deep-dive.md) and speak tracks from [`../code/MockTalkTracks.md`](../code/MockTalkTracks.md).

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-week2-synthesis.md](01-week2-synthesis.md) | Week 2 narrative, connective micro-answers | Foundations · Deep dive |
| [02-mock-format.md](02-mock-format.md) | Mock #2 blocks, timing, scoring, retro | Foundations · Deep dive · Exercises |
| [03-ads-architecture.md](03-ads-architecture.md) | Track A 5-min spine: POP, HeroWidget, pinning | Deep dive · Production bridge |
| [04-sdui-architecture.md](04-sdui-architecture.md) | Track B 5-min spine: schema, registry, fallback | Deep dive · Production bridge |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Payment checkout (+ Search sister) | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Pick one track | Ads **or** SDUI for 5-min talk — not both cold |
| 5-min hard stop | Agenda in first 20s; stop at 5:00 and invite questions |
| S1 / S3 | Core STAR for Ads / SDUI tracks respectively |
| S4-A1 / S3-A1 | Pin rotation / schema fallback = **Applied design**, not shipped runbook |
| Forbidden | Invented fill-rate %, splash ms, pin shadow-traffic claims |
| Bridge | SDUI **config** + native **HeroWidget renderer** — best of both |

## Suggested order

`01` → `02` → `03` or `04` (your track) → `05` (Payment SD mock) → then full Mock #2 in [`../05-exercises.md`](../05-exercises.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 14 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```


## Revision

Thick speak practice: [07-revision-qna.md](07-revision-qna.md) — Normal + Indirect + Tricky.
