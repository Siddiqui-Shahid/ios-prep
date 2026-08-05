# Day 16 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 16 modules.  
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
| [01-cache-tiers.md](01-cache-tiers.md) | L1/L2/L3, decoded size math, URLCache limits | Foundations |
| [02-image-pipeline.md](02-image-pipeline.md) | ImageIO downsample, dedup, cancel, prefetch | Deep dive |
| [03-video-audio-media.md](03-video-audio-media.md) | Memory pressure, HeroWidget video, Aces audio | Deep dive |
| [04-production-s1-s12.md](04-production-s1-s12.md) | Verified S1 HeroWidget + S12 audio/splash | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| HTTP cache | **Not** a UIImage cache — still need decode + L1 policy |
| Decoded 1000×1000 ARGB | ≈ **4 MB** — key by **url + targetSize** |
| Wrong image in cell | Missing cancel/token on reuse |
| HeroWidget | Pause when off-screen / background / reuse — **product contract** |
| Aces audio | **Not** image LRU — AVAudioSession + interruptions |
| Verified S1 / S12 | **No** invented fill-rate % or splash ms |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 16 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
