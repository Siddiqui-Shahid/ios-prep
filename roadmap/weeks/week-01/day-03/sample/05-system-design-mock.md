# Sample 05 — System-design mock: Image Loading Library (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/image-loading-library.md`](../../../../ios-system-design/docs/image-loading-library.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 03 — **memory / decode** (ARC & Instruments parallel).

---

### Q1. Interviewer: “Design Image Loading Library.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **3-tier cache** and **Downsample, dedupe, cancel**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. In scope: download + decode + L1/L2 cache + cancel on reuse — or also GIF/video?
> 2. Memory budget for decoded L1 (e.g. ~50MB)?
> 3. CDN only GET, or custom image API?
> 4. Must support WebP/AVIF accept negotiation?
> 5. Out of scope: upload, editing, CDN architecture?
> 6. Cell reuse cancel required?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** Still-image pipeline; L1 ~50MB NSCache + disk ~500MB; cancel on reuse; out: GIF/video decode, upload, CDN design.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> **Pipeline:** URL → (dedupe) → L1 NSCache → L2 disk → network CDN → ImageIO downsample → display.
> **Threads:** download/decode off main; MainActor only for UIImage assignment.
> **Load:** Cache-Control max-age ~7d; Accept webp/avif; decoded cost = width×height×4 — always downsample to view size.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where ARC bites? | Retain cycles in completion handlers; cancel tokens on deinit/reuse. |
| Three tiers? | Memory / disk / network — write-around for decoded often. |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> `GET {image_url}` with Cache-Control. Library API: `load(url, targetSize, priority) → Task` cancelable.
> Dedupe identical in-flight URLs; priority boost for on-screen.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Same URL two cells? | One download; fan-out completions. |
| Auth images? | Inject headers via session; don’t put tokens in URL query if avoidable. |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q5. Deep dive 1 — 3-tier cache?

**Answer:**

> L1 cost-based NSCache (~50MB) responds to memory warnings. L2 disk LRU (~500MB). Network last.
> Combined hit target >80%; L1 >40%.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Memory warning? | Clear L1; keep disk. |
| Disk full? | LRU free ~20%; continue. |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q6. Deep dive 2 — Downsample, dedupe, cancel?

**Answer:**

> ImageIO create thumbnail at display size — never full decode then scale.
> Cancel on `prepareForReuse`; generation token ignores stale completions. Decode p50 <10ms / p99 <50ms targets from spec.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| GIF asked? | Out of scope unless pulled — separate decoder + memory budget. |
| Main-thread decode? | Classic hitch — always background. |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> L1/L2 hit rates, decode latency, OOM rate <0.1% target, scroll hitch.
> Kill: disable high-res prefetch under memory pressure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| HeroWidget link? | Pause/cancel media on disappear — same cancel discipline. |
| Instruments? | Allocations + Time Profiler for decode spikes — Day 03 tools. |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

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

