# Sample 05 — System-design mock: Short-form Video Feed (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/video-feed-streaming.md`](../../../../ios-system-design/docs/video-feed-streaming.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 12 — SwiftUI lists / identity parallel (player pool).

---

### Q1. Interviewer: “Design Short-form Video Feed.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **AVPlayerPool sliding window** and **Prefetch + ABR**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Short-form vertical feed — record/upload out?
> 2. DAU and bitrate caps on cellular?
> 3. AVPlayer pool size (e.g. 3)?
> 4. Low Power / thermal guards?
> 5. Cursor pagination OK?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** 3-player pool; prefetch ~80%; ABR + Low Power; cursor feed; out: upload/transcode.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> Feed VM → page cursor → AVPlayerPool (prev/current/next) → Video CDN. Thumb pipeline separate.
> **Backend:** Feed service + Redis; Video CDN.
> **Load:** limit 10; JSON <15KB; ~15MB/player; memory <150MB; TTFF <300ms target.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why pool? | Avoid alloc/teardown hitch each swipe. |
| SwiftUI identity? | Stable IDs for cells; don’t recreate players on identity churn. |

**How can I relate to my case:**
- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> `GET /v1/feed?cursor=&limit=10` with stream URLs + thumb. Optional `X-Network-Quality`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Tokenized CDN URLs? | Refresh before expiry; don’t log secrets. |
| Prefetch bytes? | One ahead; not entire catalog. |

**How can I relate to my case:**
- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.

---

### Q5. Deep dive 1 — AVPlayerPool sliding window?

**Answer:**

> Keep prev/current/next; on swipe recycle farthest; pause offscreen. OOM → empty pool.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cell reuse? | Detach player; clear; generation token. |
| Background? | Pause all; release some. |

**How can I relate to my case:**
- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.

---

### Q6. Deep dive 2 — Prefetch + ABR?

**Answer:**

> PrefetchEngine at ~80% progress; NWPathMonitor drops to 240p (~200Kbps) on poor path; Low Power disables prefetch.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Stall metric? | <1% views target; drop quality. |
| Audio session? | Mix/duck policy explicit. |

**How can I relate to my case:**
- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> TTFF, stall rate, thumb cache >95%, memory. Kill: force 240p; disable autoplay.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| HeroWidget pause? | Same disappear/offscreen pause contract. |
| Stories SDK? | List identity + media lifecycle. |

**How can I relate to my case:**
- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> **Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; API has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics.
> **Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.
> **Spine:** 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | Park dive 2 bullets; protect ops 5 min. |
| Forgot load? | One sentence: DAU → labeled QPS, cursor cost, single-flight. |
| Invented crash-free %? | Forbidden — use resume-backed numbers or label as target. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

