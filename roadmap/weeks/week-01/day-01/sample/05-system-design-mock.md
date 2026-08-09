# Sample 05 — System-design mock: Infinite Social Feed (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/social-feed.md`](../../../../ios-system-design/docs/social-feed.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Week 1 Day 01 — **scope & clarify** muscle (Parallel SD: Social feed scope).

---

### Q1. Interviewer: “Design Infinite Social Feed.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Cursor pagination & prefetch** and **Optimistic like + offline cache**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. In scope: infinite scroll text/image posts with likes — or also video / live ranking?
> 2. Approximate DAU or peak concurrent scrollers? (I’ll label QPS estimates if needed.)
> 3. Offline required, or online-first with last ~200 posts cached?
> 4. iOS-only for this round?
> 5. Pagination latency SLO — e.g. <500ms p99 for next page?
> 6. Write load: like/comment rate vs read-heavy feed?
> 7. Out of scope OK: ML ranking, WebSocket “new posts” pill unless you want it?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** iOS social feed; cursor pagination; online-first + SQLite last ~200; ~30L DAU consumer context labeled; out: video streaming + ranking ML.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> **Presentation:** UICollectionView + DiffableDataSource (or SwiftUI List with stable IDs).
> **Domain:** FeedViewModel — paging state, optimistic likes, impression dwell.
> **Data:** FeedRepository coordinates Network + SQLite cache.
> **Platform:** URLSession, image pipeline (decode off main), analytics batcher.
> **Backend touchpoints:** Feed service behind API gateway/CDN; like mutation API; impression ingest (not ranking).
> **Load:** Prefer **cursor** (`after_cursor`, limit 15–20) — O(1) server cost vs offset. Prefetch next page ~70% scroll. Cache TTL ~5 min; JSON ~8–12KB/page. Labeled QPS from DAU × sessions × pages/session — never fake precision.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Four layers names? | Presentation · domain/use cases · data/network · platform — adapt naming. |
| Offset pagination? | Reject for dynamic feeds — inserts skip/duplicate; O(n) deep pages. |
| Where is CDN? | Image/media CDN; feed JSON may be edge-cached briefly — say invalidate on publish if asked. |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> **Entities:** Post (id, author, text, media thumbs, likeCount, cursor), LikeAction, ImpressionEvent.
> **Endpoints:** `GET /v1/feed?limit=20&after_cursor=` · `POST /v1/posts/{id}/like` (idempotent client UUID optional).
> **Scale:** Page 15–20; field-mask thumbs not full images; `Accept-Encoding: gzip`. Impressions batched — not per-frame.
> **Consistency:** Cursor opaque; mid-scroll inserts don’t shift offsets.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pull-to-refresh? | New head request; merge with cursor continuity; avoid wiping in-flight page. |
| Like storms? | Optimistic UI; server dedupe; client single-flight per post id. |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q5. Deep dive 1 — Cursor pagination & prefetch?

**Answer:**

> Trigger next page ~70% scroll depth; cancel/coalesce duplicate page requests; keep one in-flight next-page task.
> Prefetch image thumbs via image pipeline for upcoming cells. Never decode full-res on main.
> If page fails: keep existing list, show inline retry — don’t blank the feed.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| User at top with new posts? | “New posts” pill or insert only when near top — don’t jump scroll position. |
| Prefetch stampede? | Single-flight page task + generation token on reload. |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q6. Deep dive 2 — Optimistic like + offline cache?

**Answer:**

> Optimistic like flips UI immediately; persist intent; on failure rollback Diffable snapshot + toast.
> Offline: load last ~200 from SQLite off main thread; show Offline/Cached badge; queue like if product allows.
> Impressions: ≥50% visible for ≥1s — batch upload.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SQLite on main? | Never — background/async; hop to MainActor for UI. |
| OOM while scrolling? | Clear L1 image cache; keep feed text models. |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> **Metrics:** scroll hitch rate, TTFF cached <1s target, cache hit >80%, page p99, like success rate.
> **Failures:** 5xx → show SQLite + Cached; empty first launch offline → native empty + retry.
> **Rollout:** flag to disable prefetch aggressiveness; kill switch → shorter page size.
> **Load:** after outage, jittered backoff so clients don’t thundering-herd the feed origin.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent QPS? | Forbidden as fact — DAU + labeled estimate only. |
| Kill switch? | Remote config: disable video/heavy media; reduce prefetch. |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

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

