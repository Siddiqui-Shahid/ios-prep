# Sample 05 — System-design mock: Image Loading Library (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/image-loading-library.md`](../../../../ios-system-design/docs/image-loading-library.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 16 — Parallel SD Image loading (video via follow-ups).

---

### Q1. Interviewer: “Design Image Loading Library.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Downsample + cache tiers** and **Cancel / HeroWidget media**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Still images pipeline — GIF/video out unless asked?
> 2. L1/L2 budgets?
> 3. Feed integration / prefetch?
> 4. HeroWidget video pause separate?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** Image pipeline deep; video-feed-streaming as follow-up if pulled; HeroWidget pause separate media contract.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> Image pipeline as Day 03/spec; place beside feed repository. Video: AVPlayerPool sister doc if asked.
> CDN Cache-Control; downsample; cancel on reuse.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Video in scope suddenly? | Switch dive to player pool — don’t pretend ImageIO handles GIF frames. |
| Audio? | Aces audio — separate session category. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> Image GET + library cancelable load. Video: feed cursor + stream URLs if pulled.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Thumb vs full? | List thumbs; detail full — separate cache keys. |
| Prefetch policy? | Next page thumbs only. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.

---

### Q5. Deep dive 1 — Downsample + cache tiers?

**Answer:**

> Cost eviction; memory warning clears L1; disk LRU. Never full-res decode.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| WebP? | Accept negotiation; size win 25–35% vs JPEG per spec. |
| Hit rate targets? | L1 >40%, combined >80%. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.

---

### Q6. Deep dive 2 — Cancel / HeroWidget media?

**Answer:**

> Cancel on reuse; generation token. If video: pause on disappear/offscreen — HeroWidget lifecycle.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Animated WebP? | Out unless asked — separate decoder. |
| Related doc? | video-feed-streaming.md. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> Decode latency, OOM, hitch; video stall if pulled. Kill: disable prefetch.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | HeroWidget; Aces audio/media instincts. |
| Instruments? | Day 17 APM continues metrics. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.

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

