# Sample 02 — Image pipeline (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What does the image loader HLD look like?

**Points to:** [Deep dive · §1 End-to-end image loader HLD](../02-deep-dive.md#1-end-to-end-image-loader-hld)

**Answer:**

> UIImageView talks to an **ImageLoader Coordinator** that checks L1 memory, then L2 disk, then network — with an in-flight dedupe map, cancel tokens, and **ImageIO downsample** off the main thread. API shape for interviews: `load(url:targetSize:) async throws -> UIImage` and `cancel(id:)`. Sketch: [`../code/ImageCacheTiers.swift`](../code/ImageCacheTiers.swift).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why coordinator, not view-owned URLSession? | Central dedupe, policy, metrics, and memory pressure in one place. |
| Protocol name? | `ImageLoading` — host injects into SDKs (S10 bridge). |
| Main thread rule? | Coordinator schedules decode off main; only `UIImage` assign on main. |

---

### Q2. How do you downsample correctly?

**Points to:** [Deep dive · §2 Downsampling](../02-deep-dive.md#2-downsampling-critical-api)

**Answer:**

> Use **ImageIO**: `CGImageSourceCreateWithData` or URL, `CGImageSourceCreateThumbnailAtIndex`, set `kCGImageSourceThumbnailMaxPixelSize` and `kCGImageSourceCreateThumbnailFromImageAlways`. **Never** `UIImage(data:)` full decode then `draw` scaled on main for feed thumbnails. Disk can store original bytes once (derive sizes on miss) or per targetSize — either is fine if L1 key includes size.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hitch symptom without downsample? | Main-thread decode during scroll — Time Profiler shows image work on main (Day 17). |
| Store original vs per-size on disk? | Original saves disk; per-size saves CPU on L2 hit — explain trade-off aloud. |
| maxPixelSize meaning? | Caps longest edge in pixels — match cell bounds × screen scale. |

---

### Q3. How do dedup and cancellation work together?

**Points to:** [Deep dive · §3 Dedup & cancellation](../02-deep-dive.md#3-dedup--cancellation)

**Answer:**

> `inflight[key] = Task` with attached observers. On complete → fan-out to observers → clear inflight. On cancel (reuse or last observer policy) → cancel Task. Cell reuse: `prepareForReuse` clears image and cancels; capture expected URL/token; ignore stale completions. SwiftUI: `.task(id: url)` — still validate identity on fast list updates.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Race: complete after cancel? | Token mismatch → don’t assign to imageView. |
| Same URL two cells visible? | Dedup shares one Task — both observers get result. |
| Priority visible vs prefetch? | Visible runs higher QoS; prefetch yields under load. |

---

### Q4. What are prefetch footguns and fixes?

**Points to:** [Deep dive · §4 Prefetch footguns](../02-deep-dive.md#4-prefetch-footguns)

**Answer:**

> Prefetch warms L1/L2 for upcoming cells — good for predictable lists. Footguns: decode storms on fast fling, bandwidth waste, starving visible cells. **Fix:** bound concurrency; cancel prefetch when scroll direction changes; prioritize visible indexPaths; lower QoS for prefetch vs visible work.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When skip prefetch? | Unknown scroll direction, metered network, or memory pressure warning active. |
| UITableView/UICollectionView hook? | `prefetchDataSource` with budget — not unbounded ahead queue. |
| Metric to watch? | RAM spike + CPU on fling — Allocations + Time Profiler. |

---

### Q5. What is the memory pressure playbook for images?

**Points to:** [Deep dive · §5 Memory pressure playbook](../02-deep-dive.md#5-memory-pressure-playbook)

**Answer:**

> On memory warning / jetsam risk: (1) trim L1 — `NSCache` helps; custom LRU must listen for warnings; (2) pause non-visible video and decode work; (3) keep L2 disk — recreatable; (4) don’t wipe user Documents; (5) avoid main-thread purge storms. **NSCache** is not strict deterministic LRU — say that honestly in interviews.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| NSCache vs custom LRU actor? | NSCache: simpler, OS-friendly eviction. Custom: strict cost caps + metrics — more code. |
| Symptom: RAM spike, small disk? | Full-res decoded in L1 or imageViews holding huge images. |
| Jetsam connection? | Abandoned L1 under peak events → Day 18 OOM narrative. |

---

### Q6. What failure modes map to which fixes?

**Points to:** [Deep dive · §10 Failure modes](../02-deep-dive.md#10-failure-modes)

**Answer:**

> Wrong image in cell → missing cancel/token. RAM spike → full-res L1 / no downsample. Scroll hitch → main-thread decode. Off-screen ad audio/video → missing HeroWidget lifecycle contract. Audio dies on phone call → missing AVAudioSession interruption handler. Same URL avatar+hero wrong → keyed by URL only.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debug wrong-image bug? | Log token at request start vs completion; reproduce fast scroll. |
| Debug hitch? | Hitches instrument + confirm decode off main. |
| Third-party loader in interview? | Know internals — don’t say “Kingfisher handles it” without explaining tiers. |

---

### Q7. Should Stories SDK embed Kingfisher?

**Points to:** [Deep dive · §8 Should Stories SDK own pipeline](../02-deep-dive.md#8-should-stories-sdk-own-the-image-pipeline-s10-bridge)

**Answer:**

> **No** — inject `ImageLoading` from host (Day 15 S10). Portfolio apps share one loader, cache policy, and memory behavior. SDK stays reusable; hosts upgrade/downsample rules without forking the SDK.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Host implements protocol? | Wrap SDWebImage/Kingfisher/custom — boundary is `ImageLoading`. |
| Test hook? | Mock loader returns fixed UIImage — SDK UI tests without network. |
| Next sample? | [03-video-audio-media.md](03-video-audio-media.md) — video + audio contracts. |

---

Next: [03-video-audio-media.md](03-video-audio-media.md)
