# Audio script — Sample 02 — Image pipeline (Q&A)
> Listen-only sample Q&A from `02-image-pipeline.md`. Spoken answers and follow-ups.

## §0 Q1. What does the image loader HLD look like?

Next. Q1. What does the image loader HLD look like? Answer. UIImageView talks to an ImageLoader Coordinator that checks L1 memory, then L2 disk, then network — with an in-flight dedupe map, cancel tokens, and ImageIO downsample off the main thread. A P I shape for interviews: load(url:targetSize:) async throws - UIImage and cancel(id:). Sketch:../code/ImageCacheTiers.swift. Follow-ups. Why coordinator, not view-owned URLSession?: Central dedupe, policy, metrics, and memory pressure in one place.. Protocol name?: ImageLoading — host injects into SDKs (S 10 bridge).. Main thread rule?: Coordinator schedules decode off main; only UIImage assign on main..

## §1 Q2. How do you downsample correctly?

Next. Q2. How do you downsample correctly? Answer. Use ImageIO: CGImageSourceCreateWithData or URL, CGImageSourceCreateThumbnailAtIndex, set kCGImageSourceThumbnailMaxPixelSize and kCGImageSourceCreateThumbnailFromImageAlways. Never UIImage(data:) full decode then draw scaled on main for feed thumbnails. Disk can store original bytes once (derive sizes on miss) or per targetSize — either is fine if L1 key includes size. Follow-ups. Hitch symptom without downsample?: Main-thread decode during scroll — Time Profiler shows image work on main (Day 17).. Store original vs per-size on disk?: Original saves disk; per-size saves CPU on L2 hit — explain trade-off aloud.. maxPixelSize meaning?: Caps longest edge in pixels — match cell bounds × screen scale..

## §2 Q3. How do dedup and cancellation work together?

Next. Q3. How do dedup and cancellation work together? Answer. inflight[key] = Task with attached observers. On complete → fan-out to observers → clear inflight. On cancel (reuse or last observer policy) → cancel Task. Cell reuse: prepareForReuse clears image and cancels; capture expected URL/token; ignore stale completions. SwiftUI:.task(id: url) — still validate identity on fast list updates. Follow-ups. Race: complete after cancel?: Token mismatch → don’t assign to imageView.. Same URL two cells visible?: Dedup shares one Task — both observers get result.. Priority visible vs prefetch?: Visible runs higher QoS; prefetch yields under load..

## §3 Q4. What are prefetch footguns and fixes?

Next. Q4. What are prefetch footguns and fixes? Answer. Prefetch warms L1/L2 for upcoming cells — good for predictable lists. Footguns: decode storms on fast fling, bandwidth waste, starving visible cells. Fix: bound concurrency; cancel prefetch when scroll direction changes; prioritize visible indexPaths; lower QoS for prefetch vs visible work. Follow-ups. When skip prefetch?: Unknown scroll direction, metered network, or memory pressure warning active.. UITableView/UICollectionView hook?: prefetchDataSource with budget — not unbounded ahead queue.. Metric to watch?: RAM spike + CPU on fling — Allocations + Time Profiler..

## §4 Q5. What is the memory pressure playbook for images?

Next. Q5. What is the memory pressure playbook for images? Answer. On memory warning / jetsam risk: (1) trim L1 — NSCache helps; custom LRU must listen for warnings; (2) pause non-visible video and decode work; (3) keep L2 disk — recreatable; (4) don’t wipe user Documents; (5) avoid main-thread purge storms. NSCache is not strict deterministic LRU — say that honestly in interviews. Follow-ups. NSCache vs custom LRU actor?: NSCache: simpler, OS-friendly eviction. Custom: strict cost caps + metrics — more code.. Symptom: RAM spike, small disk?: Full-res decoded in L1 or imageViews holding huge images.. Jetsam connection?: Abandoned L1 under peak events → Day 18 OOM narrative..

## §5 Q6. What failure modes map to which fixes?

Next. Q6. What failure modes map to which fixes? Answer. Wrong image in cell → missing cancel/token. RAM spike → full-res L1 / no downsample. Scroll hitch → main-thread decode. Off-screen ad audio/video → missing HeroWidget lifecycle contract. Audio dies on phone call → missing AVAudioSession interruption handler. Same URL avatar+hero wrong → keyed by URL only. Follow-ups. Debug wrong-image bug?: Log token at request start vs completion; reproduce fast scroll.. Debug hitch?: Hitches instrument + confirm decode off main.. Third-party loader in interview?: Know internals — don’t say “Kingfisher handles it” without explaining tiers..

## §6 Q7. Should Stories SDK embed Kingfisher?

Next. Q7. Should Stories SDK embed Kingfisher? Answer. No — inject ImageLoading from host (Day 15 S 10). Portfolio apps share one loader, cache policy, and memory behavior. S D K stays reusable; hosts upgrade/downsample rules without forking the S D K. Follow-ups. Host implements protocol?: Wrap SDWebImage/Kingfisher/custom — boundary is ImageLoading.. Test hook?: Mock loader returns fixed UIImage — S D K U I tests without network.. Next sample?: 03-video-audio-media.md — video + audio contracts.. Next: 03-video-audio-media.md.
