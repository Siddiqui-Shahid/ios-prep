# 01 — Foundations: Images, Caches, Media

> Cache tiers are taught **here** — you do not need to leave Cursor.

## 1. Plain-English mental model

Showing a remote image is a pipeline, not `Data(contentsOf:)`:

1. Ask for a URL at a **target pixel size**  
2. Check **memory** for a decoded image already sized  
3. Else check **disk** for bytes → decode/downsample off main  
4. Else **download**, downsample, store, display  
5. If the cell scrolled away — **cancel** and ignore late results  

Video ads add a second contract: **don’t play when invisible**.  
Live audio adds a third: **session interruptions**, not bitmap TTL.

## 2. Glossary

| Term | Meaning |
|---|---|
| **L1** | Memory cache of decoded images (`NSCache` / LRU actor) |
| **L2** | Disk cache of encoded bytes (`Caches/`) |
| **L3** | Network / CDN (+ optional HTTP `URLCache` for bytes) |
| **Downsample** | Decode at display size via ImageIO thumbnails |
| **Decoded size** | ≈ `width × height × 4` bytes (ARGB8888) |
| **Dedup** | One in-flight fetch per cache key; N observers |
| **Generation / token** | Ignore stale completions after reuse |
| **Prefetch** | Warm upcoming cells with a concurrency budget |
| **Memory warning** | Trim L1; pause non-visible media/decodes |
| **HeroWidget** | Ads video surface with explicit pause/play (S1) |
| **AVAudioSession** | Audio category, interruptions, route changes (S12) |
| **TTI** | Time-to-interactive — splash success metric |

## 3. Cache tiers (embedded teaching)

```text
imageView.load(url, targetSize: bounds × scale)
    → L1 NSCache (key: url + targetSize)     HIT → UIImage
    → L2 Disk (hash(url) ± size variant)     HIT → decode bg → L1 → UI
    → In-flight dedupe?                      YES → attach observer
    → URLSession fetch
    → ImageIO downsample (max pixel size)
    → Store L1 (+ L2 bytes) → notify observers
```

| Tier | Tech | Eviction | Notes |
|---|---|---|---|
| **L1** | `NSCache` / custom LRU actor | Memory warning + `totalCostLimit` | Cost ≈ decoded bytes |
| **L2** | FileManager `/Caches` + metadata | LRU + TTL (~7d) | OS may purge — OK for images |
| **L3** | CDN / URLSession | HTTP cache / ETag | **Not** a substitute for decoded L1 |

**Write policy:** decode → L1 immediately for UI; write L2 **async** (don’t block main on disk).

**Math to quote:** 1000×1000 ARGB8888 ≈ **4MB decoded**. Thirty full-res feed images → catastrophe. Always key by **url + targetSize**.

## 4. Why URLCache alone is insufficient

`URLCache` may store response **bytes**. UI still needs:

- Downsampled decode  
- Memory pressure policy  
- Dedupe across image views  
- Cancellation on reuse  

Senior line: “HTTP cache ≠ UIImage cache.”

## 5. Scroll-safe loading (60s)

1. Cancel when off-screen  
2. Dedup same key  
3. Priority: visible > prefetch  
4. Cap prefetch on fast fling  
5. Never decode JPEG on main (<16ms frame budget)

## 6. Two production media stories (preview)

| Story | Media | Not the same as |
|---|---|---|
| **S1 HeroWidget** | Video ads pause/play | Image L1 TTL |
| **S12 Aces** | Live audio + SDUI splash | Disk image LRU |

## 7. Checkpoint

1. Draw L1/L2/L3 from memory  
2. Say decoded-size math  
3. Name one HeroWidget pause trigger  

→ [02-deep-dive.md](02-deep-dive.md)
