# Sample 03 — Video, audio, and memory (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the HeroWidget video contract?

**Answer:**

> Revenue Ads video in HeroWidget must **pause** when partially or fully off-screen (pager/scroll), on `viewWillDisappear`, when app backgrounds, and on cell `prepareForReuse`. **POP + Generics** ad protocols prevent creative-type forks — but lifecycle is a **product contract**, not an implementation detail. Ads vs editorial autoplay may differ (viewability for billing vs mute-autoplay) — encode policy in protocol, don’t assume one rule.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pause alone releases memory? | No — nil player, remove observers, break retain cycles (Day 03 bridge). |
| Worked sketch? | [`../code/HeroWidgetLifecycle.swift`](../code/HeroWidgetLifecycle.swift) |
| Off-screen audio symptom? | User hears ad while scrolled away — revenue and UX bug. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How do video retain cycles show up in ads?

**Answer:**

> AVPlayer + KVO/notification observers + escaping closures capturing `self` can form cycles. Pause stops playback but doesn’t guarantee deallocation. Fix: weak captures, invalidate observers, nil player on teardown. If players persist across navigation, use Allocations + Memory Graph — pause ≠ release.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Instruments for player leak? | Allocations persistent growth; Memory Graph for who retains player layer. |
| `[weak self]` in ad callbacks? | Same rule as network — escaping work may outlive the cell/VC. |
| HeroWidget + scroll container? | Track visibility fraction — pager may show partial off-screen. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How is live audio different from image caching?

**Answer:**

> Images: L1/L2 bitmaps/bytes, cancel on reuse, retry thumbnail. Live audio: continuous buffer/player item, **AVAudioSession** category, **interruptions** (phone calls), route changes, buffering failures, optional background modes. You don’t LRU-cache a live stream like a JPEG. Failure modes and lifecycle are entirely different pipelines.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Phone call kills audio? | Missing interruption handler — resume policy must be explicit. |
| Background audio? | May need background mode + session category — not image prefetch. |
| Forbidden conflation? | “We used image LRU for Aces audio” — wrong story. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is server-driven splash in the Aces context?

**Answer:**

> Splash content from server for freshness/flexibility — measure **time-to-interactive (TTI)**, not vanity first-frame alone. Cache last-good splash if network is slow. **Do not invent ms numbers** in interviews — speak categories: product surface, TTI mindset, fail-soft if payload bad (BookMyShow backend-driven header & search soft).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| TTI vs TTFF? | First frame vs data-ready useful UI — splash can paint before app is interactive. |
| Block main on splash fetch? | Avoid — show cached/placeholder; refresh when ready (Day 17 launch). |
| SDUI fail-soft? | Degrade to static splash — don’t white-screen cold start. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How does memory pressure differ for video vs images?

**Answer:**

> Images: trim decoded L1, stop prefetch/decode. Video: pause non-visible players, tear down off-screen AV layers, watch player item buffers. Both: listen for `UIApplication.didReceiveMemoryWarningNotification`. Neither: delete user Documents or sync massive purge on main.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Visible video during warning? | Product call — may pause all non-essential playback. |
| Aggressive prefetch + video feed? | Bandwidth and decode CPU compound — cap concurrency. |
| MetricKit / jetsam? | Exit reasons pair with Day 17 field signal — Day 18 OOM honesty. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What trade-offs belong in a staff media interview?

**Answer:**

> NSCache L1 vs custom LRU actor. Downsample always vs full-res for zoom/edit. Store original bytes vs per-size on disk. Aggressive prefetch vs fling storms. Third-party loader vs in-house (know internals). Pause offscreen video vs visibility tracking complexity. Each choice has a **when** and a **cost** — don’t pick one globally.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default feed recommendation? | Downsample + L1 keyed by size + cancel on reuse. |
| When third-party loader? | Speed to ship — still explain tiers in interview. |
| Ads viewability? | May require partial visibility threshold — product not engineering default. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What production stories preview on this day?

**Answer:**

> **BookMyShow Ads pipeline + HeroWidget lifecycle Verified:** HeroWidget pause/play on highest-revenue Ads — POP+Generics pipeline. **Audio streaming + server-driven splash (Aces) Verified:** Live audio + server-driven splash on Aces — TTI mindset, no invented ms. **Stories SDK (Raw / Miami Heat) soft:** Inject image loader into Stories. Next sample covers STAR language for BookMyShow Ads pipeline + HeroWidget lifecycle/Audio streaming + server-driven splash (Aces).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow Ads pipeline + HeroWidget lifecycle forbidden claim? | Invented fill-rate % or “I wrote Kingfisher.” |
| Audio streaming + server-driven splash (Aces) forbidden claim? | Invented splash latency ms. |
| Next sample? | [04-production-s1-s12.md](04-production-s1-s12.md) |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Audio streaming + server-driven splash (Aces); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

Next: [04-production-s1-s12.md](04-production-s1-s12.md)

---

