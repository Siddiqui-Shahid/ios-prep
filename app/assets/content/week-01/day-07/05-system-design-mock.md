# Sample 05 — System-design mock: Infinite Social Feed (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/social-feed.md`](../../../../ios-system-design/docs/social-feed.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 07 Mock #1 — **full LLD mock** (Feed LLD Parallel SD).

---

### Q1. Interviewer: “Design Infinite Social Feed.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Pagination LLD** and **Optimistic like LLD**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Confirm feed vs networking/SDUI prompt for this mock?
> 2. DAU, offline, iOS-only?
> 3. Which two dives — pagination/prefetch + optimistic like?
> 4. Impressions required?
> 5. Out: video, ranking, WebSocket?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** Full 45‑min feed mock; dives: pagination/prefetch + optimistic like/offline; impressions batched; out: video/ranking.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> Draw end-to-end: CDN images → Feed API → Repository (SQLite + network) → VM → Diffable list.
> Call out memory <150MB, 60 FPS, page <500ms p99, TTL 5m, last 200 offline — from spec NFRs.
> **Load:** cursor pages 15–20; prefetch one page; single-flight refresh.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timebox HLD? | ≤10 min — then API. |
| Skip backend? | At least gateway + feed + like + analytics — one box each. |

**How can I relate to my case:**
- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> Full contract: feed page JSON shape, cursor opaque, like POST, impression batch POST.
> Error model: retry idempotent GET; careful POST like.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Idempotent like? | Client mutation id or server toggle semantics — state aloud. |
| Field masking? | List payload thumbs only. |

**How can I relate to my case:**
- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.

---

### Q5. Deep dive 1 — Pagination LLD?
**Answer:**

> State machine: idle → loading → loaded/failed; append vs reset; prefetch threshold; generation token.
> Diffable: append snapshots without full reload.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Duplicate IDs? | Merge by id; stable identity. |
| Scroll jump? | Avoid reloadData; animate append. |

**How can I relate to my case:**
- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.

---

### Q6. Deep dive 2 — Optimistic like LLD?
**Answer:**

> Local state → UI → network → commit/rollback; offline queue; conflict if server unlike.
> Threading: DB off main; UI MainActor.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Double tap? | Debounce UI; one in-flight. |
| Analytics? | Impression ≠ like; separate pipelines. |

**How can I relate to my case:**
- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> Full ops closer: hitch, TTFF, cache hit, like success, 5xx degrade, kill prefetch, rollout flag.
> Self-score clarify/HLD/dives/ops after mock.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mock #3 difference? | Day 21 is SDUI/networking 45‑min staff mock — same spine. |
| Sync-dict story? | ≤3 min production bridge if behavioral pulled — not inside SD. |

**How can I relate to my case:**
- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.

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
