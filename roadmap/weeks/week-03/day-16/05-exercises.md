# 05 — Exercises

> Solutions in-repo. Speak before peeking.

## A. Conceptual

### A1. Draw pipeline from memory
Include L1/L2/network, downsample, dedupe, cancel.

**Solution:** See [01-foundations.md](01-foundations.md) §3 and [code/CacheTiersCheatsheet.md](code/CacheTiersCheatsheet.md).

### A2. Math
Decoded size of 2000×1000 ARGB8888?

**Solution:** 2000×1000×4 = 8,000,000 bytes ≈ 7.6 MiB.

### A3. True/false
1. URLCache stores decoded UIImages.  
2. Cache key should include targetSize.  
3. Pause always releases AVPlayer.  
4. Aces audio uses image TTL eviction.

**Solution:** 1 F. 2 T. 3 F. 4 F.

### A4. Tier table from memory
Fill L1/L2/L3 tech + eviction without looking.

**Solution:** L1 NSCache/LRU + memory warning/cost; L2 `/Caches` + LRU/TTL; L3 network/URLCache bytes.

### A5. Provenance rewrite
Bad: “HeroWidget cut fill rate 12% and splash by 400ms using NSCache for audio.”  

**Solution:** “HeroWidget tied Ads video pause/play to visibility on a revenue module (S1) — no invented fill-rate. Aces shipped live audio and server-driven splash for cold-start freshness (S12) — no invented ms; audio ≠ image NSCache.”

---

## B. Coding

1. Narrate [code/ImageCacheTiers.swift](code/ImageCacheTiers.swift) — where is cost computed? Where is dedupe?  
2. Trace [code/HeroWidgetLifecycle.swift](code/HeroWidgetLifecycle.swift) — list all pause triggers + tearDown path.  
3. Hand-simulate: cell shows URL A, reused for URL B, late A completion arrives — what must be true to ignore it?  
4. Optional: add cancel that removes an observer and cancels Task when observers empty.  
5. Optional: write `estimatedDecodedBytes` asserts for 40pt vs 400pt @3x mentally.

---

## C. HLD speaking (10 min)

Whiteboard:

1. Image loader boxes  
2. Add **video ad** box: visibility → pause/play → analytics beacon  
3. Side note: Aces audio interruption path ≠ image retry  

Agenda opener from README first.

---

## D. Speaking drills

1. Q1 image loader ≤ 60s  
2. Q6 off-screen video ≤ 45s  
3. Q10 audio vs images ≤ 45s  
4. S1 STAR ≤ 3 min  
5. S12 opener ≤ 45s  
6. T2 cache key ≤ 120s  
7. T3 player cycle ≤ 120s  
8. T8 SDK image injection ≤ 120s  

---

## E. Timed drill

Record **Q1, Q6, Q10** + **T2, T3**. Score with timing guide.

Revision twin: [`../../../revision/weeks/week-03/day-16.md`](../../../revision/weeks/week-03/day-16.md)
