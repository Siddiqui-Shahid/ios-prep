# Sample 07 — Revision Q&A (day-16) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Design an image loader for a feed? `(45–60s)`
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


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “Design an image loader for a feed.?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I’d build a coordinator with L1 memory keyed by url plus target size, L2 disk for bytes, then network. Decode with ImageIO downsampling off the main thread, dedupe in-flight requests, and cancel when cells reuse. Decoded bitmaps dominate RAM — a 1000×1000 image is about four megabytes — so we never cache full-res for thumbnails.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Design an image loader for a feed. |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “Why not cache full-resolution UIImages” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “JPEG size on disk is irrelevant compared to decoded ARGB — width times height times about four bytes. Caching full-res UIImages in a feed will OOM. Keep display-sized bitmaps in L1; keep full-res on disk only if zoom/edit needs a second decode.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Why not cache full-resolution UIImages |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “NSCache vs Dictionary for images”. How do you diagnose? `(60–90s)`
**Answer:**

> “NSCache is a better default for decoded images because it can evict under memory pressure and supports cost limits. A Dictionary needs an actor or locks plus your own purge on warnings. I’d also admit NSCache isn’t a guaranteed ordered LRU if the interviewer wants strict eviction metrics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | NSCache vs Dictionary for images |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “Cell reuse wrong image — fix”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “On reuse I cancel the prior request, clear the image view, capture the expected URL or generation token, and ignore completions that don’t match. Without that, fast scroll shows the classic wrong-poster bug.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Cell reuse wrong image — fix |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “Request deduplication”? `(60–90s)`
**Answer:**

> “I keep a map from cache key to an in-flight task and observer list. Ten cells asking for the same poster share one download and fan-out on completion. Avatar 40pt and hero 400pt are different keys even if the URL matches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Request deduplication |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “Video ad playing off-screen — what’s wrong” and how you’d correct it? `(60–90s)`
**Answer:**

> “The player isn’t tied to visibility. On our revenue Ads surface, HeroWidget made pause/play an explicit contract with visibility, disappear, background, and reuse — so video doesn’t keep playing off-screen.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Video ad playing off-screen — what’s wrong |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Memory warning mid-scroll — what happens?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “Trim the memory image cache, pause non-visible video and decode work, keep disk cache, and don’t schedule a huge purge on the main thread. Documents data stays; Caches are recreatable.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Memory warning mid-scroll — what happens |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “Prefetching — benefits and footguns” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Prefetch warms L1/L2 for upcoming cells, but unbounded prefetch on a fast fling creates decode and bandwidth storms. I cap concurrency, cancel when scroll direction changes, and prioritize visible index paths.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Prefetching — benefits and footguns |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. They push you to invent a metric you don’t have? `(90–120s)`
**Answer:**

> “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
