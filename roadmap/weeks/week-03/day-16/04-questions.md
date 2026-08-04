# 04 — Questions (two-layer answers)

> Cover full spoken → speak from **Answer points** → compare.  
> **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. Design an image loader for a feed. `(45–60s)`

**Answer points:**
- L1/L2/network
- Downsample to targetSize
- Dedupe + cancel on reuse
- Decoded cost math

**Full spoken answer:**
> “I’d build a coordinator with L1 memory keyed by url plus target size, L2 disk for bytes, then network. Decode with ImageIO downsampling off the main thread, dedupe in-flight requests, and cancel when cells reuse. Decoded bitmaps dominate RAM — a 1000×1000 image is about four megabytes — so we never cache full-res for thumbnails.”

**Common wrong answer:** “Just URLSession + UIImage(data:) on main.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Module? | Core image loader; inject into features/SDK. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q2. Why not cache full-resolution UIImages? `(30–45s)`

**Answer points:**
- Decoded ≫ file size
- 4 bytes/pixel
- OOM under scroll

**Full spoken answer:**
> “JPEG size on disk is irrelevant compared to decoded ARGB — width times height times about four bytes. Caching full-res UIImages in a feed will OOM. Keep display-sized bitmaps in L1; keep full-res on disk only if zoom/edit needs a second decode.”

**Common wrong answer:** “200KB JPEG is fine in memory.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | When full-res? | Crop/zoom/edit flows. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q3. NSCache vs Dictionary for images? `(30–45s)`

**Answer points:**
- NSCache evicts under pressure
- Cost limits
- Dict needs manual purge + isolation
- Not strict LRU

**Full spoken answer:**
> “NSCache is a better default for decoded images because it can evict under memory pressure and supports cost limits. A Dictionary needs an actor or locks plus your own purge on warnings. I’d also admit NSCache isn’t a guaranteed ordered LRU if the interviewer wants strict eviction metrics.”

**Common wrong answer:** “NSCache is a perfect LRU.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Cost? | Approx decoded byte size. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q4. Cell reuse wrong image — fix? `(30–45s)`

**Answer points:**
- Cancel prior
- Clear image
- Token / URL match
- Ignore stale

**Full spoken answer:**
> “On reuse I cancel the prior request, clear the image view, capture the expected URL or generation token, and ignore completions that don’t match. Without that, fast scroll shows the classic wrong-poster bug.”

**Common wrong answer:** “UIKit bug — nothing we can do.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | SwiftUI? | task cancellation + stable id. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q5. Request deduplication? `(30–45s)`

**Answer points:**
- Map key → in-flight task + observers
- One network, N callbacks
- Different targetSizes = different keys

**Full spoken answer:**
> “I keep a map from cache key to an in-flight task and observer list. Ten cells asking for the same poster share one download and fan-out on completion. Avatar 40pt and hero 400pt are different keys even if the URL matches.”

**Common wrong answer:** “One cache entry per URL only, always.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Cancel policy? | Cancel when last observer leaves — product choice. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q6. Video ad playing off-screen — what’s wrong? `(30–45s)`

**Answer points:**
- Missing visibility/lifecycle pause
- Wasted QoS/UX
- HeroWidget contract (S1)

**Full spoken answer:**
> “The player isn’t tied to visibility. On our revenue Ads surface, HeroWidget made pause/play an explicit contract with visibility, disappear, background, and reuse — so video doesn’t keep playing off-screen.”

**Common wrong answer:** “Users will scroll back — leave it playing.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Pager detect? | Percent visible / willDisplay. |
| L2 | Story? | S1. |
| L3 | — | — |

**Provenance:** Verified · S1

---

### Q7. Memory warning mid-scroll — what happens? `(30–45s)`

**Answer points:**
- Trim L1
- Pause non-visible video/decodes
- Keep L2
- Avoid main-thread storm

**Full spoken answer:**
> “Trim the memory image cache, pause non-visible video and decode work, keep disk cache, and don’t schedule a huge purge on the main thread. Documents data stays; Caches are recreatable.”

**Common wrong answer:** “Delete the user’s saved tickets.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Metrics? | Bridge Day 17 / MetricKit. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q8. Prefetching — benefits and footguns? `(30–45s)`

**Answer points:**
- Warm next cells
- Cancel on direction change
- Cap concurrency
- Decode storms on fling

**Full spoken answer:**
> “Prefetch warms L1/L2 for upcoming cells, but unbounded prefetch on a fast fling creates decode and bandwidth storms. I cap concurrency, cancel when scroll direction changes, and prioritize visible index paths.”

**Common wrong answer:** “Prefetch everything always.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | API? | UICollectionViewDataSourcePrefetching. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q9. Downsampling API you’d name? `(30–45s)`

**Answer points:**
- CGImageSourceCreateThumbnailAtIndex
- Max pixel size
- Background queue

**Full spoken answer:**
> “ImageIO — create an image source, then CGImageSourceCreateThumbnailAtIndex with kCGImageSourceThumbnailMaxPixelSize set to the display pixel budget, on a background queue. That’s how you avoid allocating a 12-megapixel bitmap for a 120-point thumbnail.”

**Common wrong answer:** “UIImageJPEGRepresentation then scale.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | From file? | CGImageSourceCreateWithURL. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### Q10. Live audio vs image caching? `(30–45s)`

**Answer points:**
- Continuous buffer / session
- Interruptions & routes
- Not LRU bitmaps
- S12

**Full spoken answer:**
> “Live audio is a continuous buffer with AVAudioSession categories, route changes, and interruption handling — not an LRU of bitmaps with a seven-day TTL. On Aces we integrated live audio streaming; I’d never describe that as ‘the image cache with a longer TTL.’”

**Common wrong answer:** “Same pipeline, different MIME type.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Background? | Modes / Now Playing if product needs. |
| L2 | Story? | S12. |
| L3 | — | — |

**Provenance:** Verified · S12

---

### Q11. Server-driven splash — what measure? `(30–45s)`

**Answer points:**
- Time-to-interactive
- Last-good cache fallback
- Not vanity TTFF alone

**Full spoken answer:**
> “I’d measure time-to-interactive / first meaningful content, with a cached last-good splash if the network is slow. First-frame vanity alone can lie. On Aces the splash was server-driven for freshness and flexibility.”

**Common wrong answer:** “Only optimize splash animation fps.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | SDUI versioning? | Same fail-soft as header (S3 mindset). |
| L2 | No ms claim? | Correct — don’t invent. |
| L3 | — | — |

**Provenance:** Verified · S12

---

### Q12. GIFs / animated images? `(30–45s)`

**Answer points:**
- Separate decoder path
- Higher memory
- Often out of scope — call it out

**Full spoken answer:**
> “Animated formats need a separate decoder and higher memory budget. In system-design interviews I call them out of scope unless asked, rather than pretending the JPEG pipeline handles GIF frames the same way.”

**Common wrong answer:** “Same as still images.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Video vs animated WebP? | Product/ perf trade-off. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

## Tricky questions

### T1. “URLCache is enough for images.” `(90–120s)`

**Trap:** HTTP cache = UIImage cache.

**Answer points:**
- URLCache stores bytes
- Still need decode/downsample/memory policy
- App-level pipeline required

**Full spoken answer:**
> “URLCache can help with HTTP bytes, but the UI still needs downsampled decoding, memory cost limits, dedupe, and cancellation. Without an app-level image pipeline you’ll hitch and OOM even with a warm URLCache. I lean on URLCache as L3 byte help, not as the product cache.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | When lean on it? | Revalidation / bandwidth save for originals. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T2. Same URL, 40pt vs 400pt — one cache entry? `(90–120s)`

**Trap:** Key by URL only.

**Answer points:**
- Key includes target size
- Don’t store huge and scale on main
- Disk may store original once

**Full spoken answer:**
> “L1 keys include target size — avatar and hero are different entries. Storing one huge bitmap and scaling on the main thread causes hitches. Disk might keep original bytes once and derive sizes, but memory must not treat them as one UIImage.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Scale factor? | Bounds × screen scale. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T3. Player retain cycle in HeroWidget. `(90–120s)`

**Trap:** Only talk UI pause.

**Answer points:**
- AVPlayer / observers / self captures
- Pause ≠ release
- prepareForReuse + nil player
- Allocations / Memory Graph

**Full spoken answer:**
> “Pause stops playback; it doesn’t break retain cycles. AVPlayer observers and escaping closures that capture self can keep the widget alive. On reuse and disappear I remove observers, nil the player, and cancel loads. If memory climbs, Allocations or Memory Graph usually show the player subgraph. POP helps because I can inject a fake player in tests.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Story? | S1. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Verified · S1 · Applied Instruments triage

---

### T4. Memory graph UIImage spike, small disk. `(90–120s)`

**Trap:** Blame network.

**Answer points:**
- Decoded L1 / image views holding full-res
- Check downsample path
- NSCache cost calc

**Full spoken answer:**
> “Disk holding encoded bytes can look small while decoded bitmaps explode RAM. I’d verify downsample is actually used, that L1 costs reflect decoded size, and that image views aren’t retaining full-res copies. Network isn’t the first suspect when disk is tiny and UIImage is huge.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Cost formula? | w×h×4 roughly. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T5. Autoplay policy ads vs editorial. `(90–120s)`

**Trap:** One policy.

**Answer points:**
- Ads may need viewability
- Editorial mute-autoplay OK
- Protocolise policy
- HeroWidget enforces lifecycle

**Full spoken answer:**
> “Ads and editorial don’t share one autoplay religion. Ads may require viewability for billing; editorial may mute-autoplay for UX. I’d encode policy in a protocol and let HeroWidget enforce lifecycle either way — and coordinate with stakeholders so revenue behavior stays intentional.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Fill rates? | Don’t invent %. |
| L2 | Story? | S1. |
| L3 | — | — |

**Provenance:** Verified · S1

---

### T6. Fast fling decode backlog — fix. `(90–120s)`

**Trap:** “Buy bigger devices.”

**Answer points:**
- Bound decode concurrency
- Cancel stale
- Prioritize visible
- Placeholder longer OK

**Full spoken answer:**
> “I’d bound the decode queue’s concurrency and QoS, cancel work for cells that scrolled away, prioritize currently visible index paths, and accept placeholders a bit longer under fling. Task groups or an OperationQueue with max count both work — the product fix is prioritisation, not infinite parallelism.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Prefetch? | Downgrade/cancel on fling. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab

---

### T7. Aces audio drops on phone call. `(90–120s)`

**Trap:** Ignore AVAudioSession.

**Answer points:**
- Interruption notifications
- Resume policy
- Route changes
- ≠ image retry

**Full spoken answer:**
> “That’s an AVAudioSession interruption. I’d observe interruptions and route changes, define resume policy for live versus VOD, and update UX accordingly. Retrying like a failed image download misses the point — the session was stolen by the call.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Story? | S12. |
| L2 | Live vs VOD? | Live may catch up; VOD resume position. |
| L3 | — | — |

**Provenance:** Verified · S12

---

### T8. Should Stories SDK own the image pipeline? `(90–120s)`

**Trap:** Hardcode Kingfisher in SDK.

**Answer points:**
- Inject ImageLoading from host
- Portfolio shares policy
- SDK stays reusable (S10)

**Full spoken answer:**
> “I’d inject an ImageLoading protocol from the host. Hardcoding a third-party loader inside the SDK forks cache policy per app and couples releases. Portfolio reuse worked because Stories stayed independent of host shortcuts — the loader is one of those injected seams.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Day 15? | Composition root wires loader. |
| L2 | Story? | S10. |
| L3 | — | — |

**Provenance:** Verified · S10 soft · Day 15

---

Revision twin: [../../../revision/weeks/week-03/day-16.md](../../../revision/weeks/week-03/day-16.md)
