# 02 — Deep Dive: Pipeline, ImageIO, Video & Audio

> Self-contained. Optional WWDC/ImageIO docs are enrichment only.

## 1. End-to-end image loader HLD

```text
+-------------+     +--------------+     +-----------+
| UIImageView | <-> | ImageLoader  | <-> | L1 Memory |
+-------------+     | Coordinator  |     +-----------+
                    |              |     +-----------+
                    |              | <-> | L2 Disk   |
                    |              |     +-----------+
                    |              |     +-----------+
                    |              | <-> | Network   |
                    +--------------+     +-----------+
                           |
                    downsample (ImageIO)
                    dedupe map
                    cancel tokens
```

**API shape (interview):**

```swift
protocol ImageLoading {
    func load(url: URL, targetSize: CGSize) async throws -> UIImage
    func cancel(id: ImageRequestID)
}
```

Worked sketch: [code/ImageCacheTiers.swift](code/ImageCacheTiers.swift)

## 2. Downsampling (critical API)

Use ImageIO:

- `CGImageSourceCreateWithData` / URL  
- `CGImageSourceCreateThumbnailAtIndex`  
- `kCGImageSourceThumbnailMaxPixelSize`  
- `kCGImageSourceCreateThumbnailFromImageAlways`

**Never:** `UIImage(data:)` full decode then `draw` scaled on main for feed thumbnails.

**Disk strategy options:**

| Strategy | Pros | Cons |
|---|---|---|
| Store original bytes once; derive sizes | Saves disk | CPU on each size miss |
| Store per targetSize | Fast L2 hit | More disk |

Either is fine if you **explain**; always include size in **L1 key**.

## 3. Dedup & cancellation

```text
inflight[key] = Task
  observers...
on complete → fan-out → clear inflight
on cancel last observer → cancel Task (policy choice)
```

**Cell reuse:**

1. `prepareForReuse` — clear image, cancel prior  
2. Capture expected URL/token  
3. Ignore completion if token mismatch  

SwiftUI: `.task(id: url)` cancellation helps — still reason about identity.

## 4. Prefetch footguns

Benefits: warmer L1/L2 for next cells.  
Footguns: decode storms on fling; bandwidth waste.

**Fix:** bound concurrency; cancel prefetch when direction changes; prioritize visible indexPaths; lower QoS for prefetch vs visible.

## 5. Memory pressure playbook

On warning / jetsam risk:

1. Trim L1 (`NSCache` helps; custom LRU must listen)  
2. Pause non-visible video / decode work  
3. Keep L2 (disk) — recreatable  
4. Don’t wipe user Documents  
5. Avoid main-thread purge storms  

**NSCache vs Dictionary:** NSCache can evict under pressure and is friendlier for this use; Dictionary needs manual purge + isolation (actor/lock). NSCache is **not** a strict deterministic LRU — say that.

## 6. HeroWidget video (S1 deep)

Revenue Ads video must pause when:

- Partially / fully off-screen (pager / scroll)  
- `viewWillDisappear`  
- App background  
- Cell `prepareForReuse`  

**POP + Generics:** ad component protocols so creative types don’t fork the loader. Lifecycle is a **product contract**.

**Retain cycles:** AVPlayer + observers + closures capturing `self`. Pause alone doesn’t release — nil player, remove observers, break cycles. Instruments Allocations if players leak.

Worked: [code/HeroWidgetLifecycle.swift](code/HeroWidgetLifecycle.swift)

**Ads vs editorial autoplay:** Ads may need viewability for billing; editorial may mute-autoplay. Encode policy in protocol — don’t assume one policy.

## 7. Aces audio + splash (S12 deep)

**Audio ≠ image cache:**

| Concern | Images | Live audio |
|---|---|---|
| Storage | L1/L2 bitmaps/bytes | Continuous buffer / player item |
| Failure | Retry thumbnail | Interruptions, routes, buffering |
| Lifecycle | Cancel on reuse | `AVAudioSession` interruption + resume policy |
| Background | Usually stop | May continue with background modes |

**Splash SDUI:** server-driven content for freshness/flexibility; measure **time-to-interactive**; cache last-good splash if network slow. (**No invented ms.**)

## 8. Should Stories SDK own the image pipeline? (S10 bridge)

**No hardcode Kingfisher inside SDK forever.** Inject `ImageLoading` from host so portfolio apps share one loader/policy (Day 15). SDK stays reusable.

## 9. Trade-offs

| Choice | When | Cost |
|---|---|---|
| NSCache L1 | Default decoded | Non-deterministic eviction |
| Custom LRU actor | Strict cost + metrics | More code |
| Downsample always | UI display | CPU; still beats OOM |
| Full-res disk only | Zoom/edit | Second decode |
| Aggressive prefetch | Predictable lists | Fling storms |
| Third-party loader | Speed | Know internals in interviews |
| Pause offscreen video | Ads/feeds | Visibility tracking complexity |

## 10. Failure modes

| Symptom | Likely cause |
|---|---|
| Wrong image in cell | Missing cancel/token |
| RAM spike, small disk | Full-res decoded L1 / image views |
| Hitch on scroll | Main-thread decode |
| Off-screen ad audio/video | Missing HeroWidget contract |
| Audio dies on phone call | Missing interruption handler |
| Same URL avatar+hero blurry/huge | Keyed by URL only |

## 11. Optional citations

- WWDC Image and Graphics Best Practices / Downsampling  
- `ios-system-design/docs/image-loading-library.md` (optional skim)
