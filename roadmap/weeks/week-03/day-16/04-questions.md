# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Design an image loader for a feed. `(45–60s)`

**Answer:**

> I’d build a coordinator with L1 memory keyed by url plus target size, L2 disk for bytes, then network. Decode with ImageIO downsampling off the main thread, dedupe in-flight requests, and cancel when cells reuse. Decoded bitmaps dominate RAM — a 1000×1000 image is about four megabytes — so we never cache full-res for thumbnails.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Module? | Core image loader; inject into features/SDK. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Why not cache full-resolution UIImages? `(30–45s)`

**Answer:**

> JPEG size on disk is irrelevant compared to decoded ARGB — width times height times about four bytes. Caching full-res UIImages in a feed will OOM. Keep display-sized bitmaps in L1; keep full-res on disk only if zoom/edit needs a second decode.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When full-res? | Crop/zoom/edit flows. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. NSCache vs Dictionary for images? `(30–45s)`

**Answer:**

> NSCache is a better default for decoded images because it can evict under memory pressure and supports cost limits. A Dictionary needs an actor or locks plus your own purge on warnings. I’d also admit NSCache isn’t a guaranteed ordered LRU if the interviewer wants strict eviction metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cost? | Approx decoded byte size. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Cell reuse wrong image — fix? `(30–45s)`

**Answer:**

> On reuse I cancel the prior request, clear the image view, capture the expected URL or generation token, and ignore completions that don’t match. Without that, fast scroll shows the classic wrong-poster bug.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SwiftUI? | task cancellation + stable id. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Request deduplication? `(30–45s)`

**Answer:**

> I keep a map from cache key to an in-flight task and observer list. Ten cells asking for the same poster share one download and fan-out on completion. Avatar 40pt and hero 400pt are different keys even if the URL matches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cancel policy? | Cancel when last observer leaves — product choice. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Video ad playing off-screen — what’s wrong? `(30–45s)`

**Answer:**

> The player isn’t tied to visibility. On our revenue Ads surface, HeroWidget made pause/play an explicit contract with visibility, disappear, background, and reuse — so video doesn’t keep playing off-screen.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pager detect? | Percent visible / willDisplay. |
| Story? | HeroWidget / Ads video lifecycle. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. Memory warning mid-scroll — what happens? `(30–45s)`

**Answer:**

> Trim the memory image cache, pause non-visible video and decode work, keep disk cache, and don’t schedule a huge purge on the main thread. Documents data stays; Caches are recreatable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metrics? | Bridge Day 17 / MetricKit. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Prefetching — benefits and footguns? `(30–45s)`

**Answer:**

> Prefetch warms L1/L2 for upcoming cells, but unbounded prefetch on a fast fling creates decode and bandwidth storms. I cap concurrency, cancel when scroll direction changes, and prioritize visible index paths.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| API? | UICollectionViewDataSourcePrefetching. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Downsampling API you’d name? `(30–45s)`

**Answer:**

> ImageIO — create an image source, then CGImageSourceCreateThumbnailAtIndex with kCGImageSourceThumbnailMaxPixelSize set to the display pixel budget, on a background queue. That’s how you avoid allocating a 12-megapixel bitmap for a 120-point thumbnail.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| From file? | CGImageSourceCreateWithURL. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Live audio vs image caching? `(30–45s)`

**Answer:**

> Live audio is a continuous buffer with AVAudioSession categories, route changes, and interruption handling — not an LRU of bitmaps with a seven-day TTL. On Aces we integrated live audio streaming; I’d never describe that as ‘the image cache with a longer TTL.’

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Background? | Modes / Now Playing if product needs. |
| Story? | Aces audio / server-driven splash. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q11. Server-driven splash — what measure? `(30–45s)`

**Answer:**

> I’d measure time-to-interactive / first meaningful content, with a cached last-good splash if the network is slow. First-frame vanity alone can lie. On Aces the splash was server-driven for freshness and flexibility.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI versioning? | Same fail-soft mindset as SDUI header/search — degrade unknown parts, don’t crash the screen. |
| No ms claim? | Correct — don’t invent. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q12. GIFs / animated images? `(30–45s)`

**Answer:**

> Animated formats need a separate decoder and higher memory budget. In system-design interviews I call them out of scope unless asked, rather than pretending the JPEG pipeline handles GIF frames the same way.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Video vs animated WebP? | Product/ perf trade-off. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

