# Day 10 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 10 modules. 
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
| [01-sdui-foundations.md](01-sdui-foundations.md) | SDUI mental model, glossary, wins/costs, hybrid apps | Foundations |
| [02-schema-version-fallbacks.md](02-schema-version-fallbacks.md) | Version gate, unknown skip, FallbackEngine, cache | Deep dive · code |
| [03-registry-actions-splash.md](03-registry-actions-splash.md) | Component registry, allowlisted actions, cold start | Deep dive · Foundations |
| [04-production-s3-s12.md](04-production-s3-s12.md) | Verified S3 header + S12 splash; S3-A1 design | Production bridge |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — SDUI engine | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| SDUI def | Schema → version gate → registry → **native** render |
| Not SDUI | JS eval, whole-app WebView, arbitrary code in JSON |
| Unknown component | **Skip + metric** — never crash |
| Empty root | Hard fallback — blank chrome unacceptable |
| S3 verified | BMS backend-driven / protocolised header |
| S3-A1 | Schema versioning + unknown fallback = **design** |
| S12 verified | Aces server-driven splash — **no invented ms** |
| Ads media | S1 native lifecycle — config maybe SDUI, video stays native |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then main [`../07-revision-qna.md`](../07-revision-qna.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 10 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
