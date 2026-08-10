# Day 16 — Image/Video Pipelines, Caching & Memory Pressure

> Week 3 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-03/day-16.md](../../../revision/weeks/week-03/day-16.md)

## Outcomes

By end of day, without notes, you can:

- Draw the **image pipeline**: L1 memory → L2 disk → network, with **downsample-before-decode-to-display-size**
- Quote **decoded bitmap math** (`width × height × 4`) — not JPEG file size
- Explain **dedupe**, **cancellation**, and **cell reuse** for scroll performance
- Deliver **Verified S1**: HeroWidget pause/play on revenue Ads video
- Deliver **Verified S12**: Aces audio + server-driven splash (not an image cache)
- Handle **memory pressure**: NSCache costs, purge, never decode full-res on main

## How to study (in Cursor only)

1. `01-foundations.md` — mental model + glossary + **cache tiers embedded** 
2. `02-deep-dive.md` — full pipeline, ImageIO, video/audio distinctions 
3. `03-production-bridge.md` — S1 + S12 STAR tracks 
4. `code/` — cache actor sketch + HeroWidget lifecycle 
5. `sample/07-revision-qna.md` — two-layer Q&A 
6. `05-exercises.md` — HLD + speaking 
7. Revision twin for timed recall 

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/](code/) |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Provenance reminder

| Label | Meaning |
|---|---|
| **Verified · S1** | HeroWidget pause/play; POP+Generics ads pipeline; revenue-critical (no invented fill-rate %) |
| **Verified · S12** | Aces audio streaming; server-driven splash; cold-start improvement (**no invented ms**) |
| **Verified · S10** | Soft: inject image loader into Stories SDK — don’t hardcode Kingfisher inside SDK |
| **Learning-lab** | Image cache / downsample sketches in `code/` |

## Agenda opener

> “I’ll define cache tiers and downsample math, then cancellation/dedupe, then HeroWidget video lifecycle and how Aces audio differs from image caching.”

## Time budget

| Block | Minutes |
|---|---|
| Foundations (tiers) | 45–60 |
| Deep dive + code | 90–120 |
| Production bridge S1/S12 | 35–45 |
| Questions | 45–60 |
| Exercises | 30–40 |
| Revision twin | 15 |

## Critical correctness (memorize)

| Claim | Truth |
|---|---|
| JPEG 200KB on disk | Decoded bitmap may be **multi-MB** |
| URLCache | Stores **bytes**, not policy for decoded UIImages |
| Cache key | **url + targetSize** (not URL alone) |
| HeroWidget | Pause offscreen / disappear / reuse |
| Aces audio | Session + interruptions — not LRU bitmaps |
