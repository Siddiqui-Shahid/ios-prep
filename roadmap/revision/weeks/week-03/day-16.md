# Day 16 — Image/Video Pipelines, Caching & Memory Pressure

> **Full chapter:** [`weeks/week-03/day-16/`](../../../weeks/week-03/day-16/) · Revision twin — timed recall only after the full study.

> Week 3 · Phase: Full architecture, performance, security, platform · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- End-to-end **image pipeline**: L1 memory → L2 disk → network, with **downsample-before-cache**
- Why **decoded bitmap size** (`width × height × 4`) dominates RAM — not JPEG file size
- Request **deduplication**, **cancellation**, and cell **reuse** for scroll performance
- How **HeroWidget** pause/play ties video ads to visibility/lifecycle on a revenue-critical path
- How **Aces live audio** differs from image caching (buffering, interruptions, cold-start splash)
- Memory-pressure strategy: `NSCache`, cost limits, purge on warnings, never decode full-res on main

## 2. Concept deep dive

### 2.1 Universal image pipeline (interview diagram)

```text
imageView.load(url, targetSize: bounds × scale)
    → L1 NSCache (key: url + targetSize)     HIT → UIImage
    → L2 Disk (SHA256(url))                  HIT → decode bg → L1 → UI
    → In-flight dedupe?                      YES → attach observer
    → URLSession fetch
    → ImageIO downsample (CGImageSourceCreateThumbnailAtIndex)
    → Store L1 + L2 → notify observers
```

**Critical API:** `CGImageSourceCreateThumbnailAtIndex` + `kCGImageSourceThumbnailMaxPixelSize` — decode *at display size*, avoid allocating a 12MP bitmap for a 120pt thumbnail.

**Math to quote:** 1000×1000 ARGB8888 ≈ **4MB decoded**. A feed of 30 full-res images = catastrophic. Always key cache by **url + targetSize**.

### 2.2 Caching policy (tie to cheatsheet)

| Tier | Tech | Eviction | Notes |
|---|---|---|---|
| L1 | `NSCache` / custom LRU actor | Memory warning + max cost | Auto-evicts under pressure better than raw `Dictionary` |
| L2 | FileManager `/Caches` + metadata | LRU + TTL (~7 days) | OS may purge; OK for images |
| L3 | CDN / URLSession | HTTP cache / ETag | Don’t rely on URLCache alone for decoded bitmaps |

**Write policy:** images usually **write-around** to L1 after decode (don’t block UI writing huge disks synchronously).

### 2.3 Scroll-safe loading

1. **Cancellation** — cell leaves screen → cancel token; ignore late callbacks (generation id / URL match)
2. **Dedup** — 10 cells, same poster URL → one download, fan-out completions
3. **Priority** — visible > prefetch; downgrade when scrolled past
4. **Prefetch** — `UICollectionViewDataSourcePrefetching` with budget; cancel aggressive prefetch on fast fling
5. **Main thread** — never decode JPEG on main; aim <16ms frame budget

### 2.4 Video ads & HeroWidget (your production proof)

Revenue-critical Ads module: video inside a reusable **HeroWidget** needs explicit **pause/play** tied to:

- View visibility (partially off-screen / pager page change)
- ViewController lifecycle (`viewWillDisappear` / appear)
- App lifecycle (background → pause; foreground → resume policy)
- Cell reuse (prepareForReuse must stop player / clear item)

**POP + Generics** rendering pipeline: ad component protocols so new creative types don’t fork the loader. Lifecycle is part of the **product contract**, not an afterthought — wasted playback and glitches hurt fill/UX on the highest-revenue module.

### 2.5 Aces audio + splash (media beyond images)

**Las Vegas Aces:** live **audio streaming** for broadcasts + **server-driven splash** to cut cold-start latency / improve freshness.

Interview distinctions:
- Audio: buffering, route changes (Bluetooth), interruptions (`AVAudioSession`), background modes
- Splash SDUI: measure **time-to-interactive**, not vanity first-frame alone
- Don’t conflate image disk cache with AV player item caching — different failure modes

### 2.6 Trade-offs

| Choice | When | Cost |
|---|---|---|
| NSCache | Decoded images L1 | Non-deterministic eviction; no ordered LRU guarantees |
| Custom LRU actor | Need strict cost + metrics | More code; must handle memory warnings yourself |
| Downsample at decode | Always for UI display | Extra CPU; still cheaper than OOM |
| Keep full-res on disk only | Zoom / edit flows | Second decode pass when needed |
| Aggressive prefetch | Slow networks / predictable lists | Bandwidth + decode storms on fling |
| Third-party (Kingfisher/SDWebImage) | Speed to market | Bundle size; know internals for interviews |
| Pause video when offscreen | Ads / autoplay feeds | Complexity in visibility tracking |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [image-loading-library.md](../../../ios-system-design/docs/image-loading-library.md) | Full HLD: cache tiers, dedupe, downsample, cancellation |
| Must | [cheatsheet.md](../../../ios-system-design/docs/cheatsheet.md) — Image Pipeline + Caching Policy | Numbers + universal flow |
| Deepen | WWDC: Image and Graphics Best Practices / Downsampling | ImageIO APIs |
| Story | [story-bank.md](../../stories/story-bank.md)#S1 · #S12 | HeroWidget; Aces audio + splash |

## 4. Map to your work

**Company / feature:** BookMyShow — **Ads / HeroWidget** pause-play lifecycle; Raw — **Aces** audio streaming + server-driven splash.  
**What you did:** Type-safe ad rendering (POP+Generics); visibility-correct video lifecycle; live audio integration; splash content driven by server to improve cold start.  
**Interview line (≤20s):**  
> “On our highest-revenue Ads surface I built HeroWidget with explicit pause/play tied to visibility — and on Aces I shipped live audio plus a server-driven splash to tighten cold start.”

→ Full STAR: [S1](../../stories/story-bank.md)#S1 · [S12](../../stories/story-bank.md)#S12

## 5. Normal questions

### Q1. Design an image loader for a feed. `(45–60s)`
**Skeleton:** L1/L2/network → downsample → dedupe → cancel on reuse → memory cost math.  
**Follow-up:** Where do you put this — Core module?  
**Story:** —

### Q2. Why not cache full-resolution UIImages? `(30–45s)`
**Skeleton:** Decoded size ≫ file size; 4 bytes/pixel; OOM under scroll.  
**Follow-up:** When *do* you keep full-res?  
**Story:** —

### Q3. NSCache vs Dictionary for images? `(30–45s)`
**Skeleton:** NSCache evicts under pressure, thread-safer for this use; Dictionary needs manual purge + locks/actor.  
**Follow-up:** Cost limits (`totalCostLimit`)?  
**Story:** —

### Q4. How do you handle cell reuse bugs (wrong image)? `(30–45s)`
**Skeleton:** Capture expected URL/token; cancel prior; clear image on reuse; ignore stale completions.  
**Follow-up:** SwiftUI `.id` / task cancellation?  
**Story:** —

### Q5. Explain request deduplication. `(30–45s)`
**Skeleton:** Map URL → in-flight task + observer list; one network, N callbacks.  
**Follow-up:** What if different targetSizes?  
**Story:** —

### Q6. Video ad is playing off-screen — what’s wrong? `(30–45s)`
**Skeleton:** Missing visibility/lifecycle pause; wasted QoS and UX; HeroWidget contract.  
**Follow-up:** How do you detect visibility in a pager?  
**Story:** S1

### Q7. Memory warning mid-scroll — what should happen? `(30–45s)`
**Skeleton:** Trim L1; pause non-visible video/decodes; keep L2; avoid main-thread work storm.  
**Follow-up:** MetricKit memory metrics? (bridge Day 17)  
**Story:** —

### Q8. Prefetching — benefits and footguns? `(30–45s)`
**Skeleton:** Warm L1/L2 for next cells; cancel on direction change; cap concurrency.  
**Follow-up:** Interaction with HTTP/2 multiplexing?  
**Story:** —

### Q9. Downsampling API you’d name? `(30–45s)`
**Skeleton:** ImageIO `CGImageSourceCreateThumbnailAtIndex` + max pixel size; background queue.  
**Follow-up:** UIImageJPEGRepresentation pitfalls?  
**Story:** —

### Q10. How is live audio different from image caching? `(30–45s)`
**Skeleton:** Continuous buffer, session categories, interruptions; not LRU bitmap cache.  
**Follow-up:** Background audio modes / Now Playing?  
**Story:** S12

### Q11. Server-driven splash — what do you measure? `(30–45s)`
**Skeleton:** Time-to-interactive / first meaningful content; fallback cached splash if network slow.  
**Follow-up:** Tie to SDUI versioning.  
**Story:** S12

### Q12. Where do GIFs/animated images fit? `(30–45s)`
**Skeleton:** Separate decoder path; higher memory; often out of scope in SD interviews — call it out.  
**Follow-up:** Video vs animated WebP trade-off?  
**Story:** —

## 6. Tricky questions

### T1. “URLCache is enough for images.” `(90–120s)`
**Trap:** Confusing HTTP cache with decoded bitmap cache.  
**Senior answer:** URLCache stores bytes; UI still needs decode/downsample and memory policy. You need an app-level image pipeline.  
**Follow-up:** When *do* you lean on URLCache?

### T2. Same URL, avatar 40pt vs hero 400pt — one cache entry? `(90–120s)`
**Trap:** Single key by URL only.  
**Senior answer:** Key includes target size (and maybe format). Storing one huge bitmap and scaling down on main is a hitch source.  
**Follow-up:** Disk store original bytes once, derive sizes?

### T3. Player retain cycle in HeroWidget. `(90–120s)`
**Trap:** Only talk UI.  
**Senior answer:** AVPlayer / observers / closures capturing self; pause alone doesn’t release. `prepareForReuse` + break observation + nil player on disappear. Instruments Allocations for leaked players.  
**Follow-up:** How POP helps test fake players (S1)

### T4. Memory graph shows UIImage spike but disk cache is small. `(90–120s)`
**Trap:** Blame network.  
**Senior answer:** Decoded bitmaps in L1 or image views retaining full-res; check downsample path and image view contents.  
**Follow-up:** Cost calculation for NSCache

### T5. Autoplay video policy for ads vs editorial. `(90–120s)`
**Trap:** One policy.  
**Senior answer:** Ads may require viewability for billing; editorial may mute-autoplay. Encode policy in protocol; HeroWidget enforces lifecycle; product/legal constraints differ.  
**Follow-up:** How you coordinated without breaking fill rates (S1)

### T6. Fast fling causes decode backlog — design fix. `(90–120s)`
**Trap:** “Buy a bigger device.”  
**Senior answer:** Bound decode queue QoS/concurrency; cancel stale; prioritize visible indexPaths; optionally show placeholder longer.  
**Follow-up:** OperationQueue vs task groups

### T7. Aces audio drops when user takes a call. `(90–120s)`
**Trap:** Ignore AVAudioSession.  
**Senior answer:** Handle interruption notifications; resume policy; route changes; don’t assume pipeline equals image retry.  
**Follow-up:** UX for “live” vs VOD resume

### T8. Should Stories SDK own the image pipeline? `(90–120s)`
**Trap:** Hardcode Kingfisher inside SDK.  
**Senior answer:** Inject `ImageLoading` protocol from host (Day 15) so portfolio apps share one loader/policy; SDK stays reusable.  
**Follow-up:** S10 module boundary

## 7. Flashcards for today

| Front | Back |
|---|---|
| Decoded image math | w×h×4 bytes · Trap: think JPEG size · Prod: downsample always |
| L1/L2/L3 | NSCache / disk / network · Trap: URLCache = UIImage cache · Prod: cheatsheet pipeline |
| Thumbnail API | CGImageSourceCreateThumbnailAtIndex · Trap: draw full UIImage then scale · Prod: ImageIO |
| Cache key | url + targetSize · Trap: URL only · Prod: avatar vs hero |
| Deduplication | One in-flight per key, N observers · Trap: N downloads · Prod: feed posters |
| Cancellation | Token + ignore stale · Trap: late setImage · Prod: cell reuse |
| NSCache benefit | Evicts under pressure · Trap: deterministic LRU · Prod: memory warnings |
| HeroWidget rule | Pause offscreen / on disappear · Trap: fire-and-forget AVPlayer · Prod: S1 ads |
| prepareForReuse | Stop player, clear image, cancel loads · Trap: only clear text · Prod: revenue ads |
| Prefetch footgun | Decode storm on fling · Trap: prefetch everything · Prod: cancel + cap |
| Aces audio | Session + interruptions · Trap: treat like image TTL · Prod: S12 |
| Splash metric | Time-to-interactive · Trap: only TTFF vanity · Prod: S12 SDUI splash |
| Write-around images | Decode then memory; disk async · Trap: sync disk on main · Prod: hitch budget |
| Memory warning | Trim L1, pause media · Trap: wipe user data · Prod: /Caches OK to lose |
| GIF scope | Separate path / call out of scope · Trap: same as JPEG pipeline · Prod: SD interviews |
| Inject loader in SDK | Protocol from host · Trap: hardcode dependency · Prod: S10 Stories |

## 8. Practice

- **Coding / SD:** Whiteboard the image loader HLD from [image-loading-library.md](../../../ios-system-design/docs/image-loading-library.md) in 10 minutes. Then add a **video ad** box: visibility → pause/play → analytics beacon.
- **Complexity / agenda to say first:**  
  > “I’ll define cache tiers and downsample math, then deep-dive cancellation/dedupe, then map HeroWidget video lifecycle and Aces audio differences.”
- **Optional code:** Sketch an `actor ImageCache` with cost-based eviction + a `load(url:targetSize:)` pseudocode that cancels via `Task`.

## 9. Timed drill

1. Pick 3 Normal + 2 Tricky (recommend **Q1, Q6, Q10** + **T2, T3**). Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Deliver **S1** (HeroWidget) in ≤3 min; **S12** opener in ≤45s.
4. Log misses ( esp. URLCache confusion, cache key size ).
