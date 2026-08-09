# Sample 05 — System-design mock: Infinite Social Feed (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.  
> **Source:** [`ios-system-design/docs/social-feed.md`](../../../../ios-system-design/docs/social-feed.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)  
> **Angle:** Week 1 Day 01 — **scope & clarify** muscle (Parallel SD: Social feed scope).  
> **Brain puzzles** at the bottom — cover → think → check.

---

### Q1. Interviewer: “Design Infinite Social Feed.” How do you open?

**Answer:**

> “I’ll take about five minutes clarifying scope and scale. Then a four-layer client high-level design with backend touchpoints and load. Then API and data. Two deep dives: cursor pagination and prefetch, and optimistic like plus offline cache. I’ll close on failure modes, metrics, and kill switches. Does that plan work?
>
> Before I draw: infinite scroll text and image posts with likes — or also video and live ranking? Approximate DAU or peak concurrent scrollers? Offline required, or online-first with last about two hundred posts cached? iOS-only for this round? Pagination latency SLO — say under five hundred milliseconds p99 for next page? Write load versus read-heavy feed? Out of scope okay for ML ranking and a WebSocket new-posts pill unless you want them?”

Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | “Don’t — they may want different dives.” |
| Clarify for 15 min? | “Hard stop at five. Rest becomes labeled assumptions.” |
| They refuse numbers? | “State labeled estimates from DAU context; continue.” |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q2. After clarify — what does the good flow look like?

**Answer:**

> “For this mock: iOS social feed; cursor pagination; online-first plus SQLite last about two hundred; about thirty lakh DAU consumer context labeled; out: video streaming and ranking ML.
>
> Good flow: agenda, clarify, confirm, HLD with four layers plus backend plus load, API, two crisp dives, last five minutes ops.
>
> Weak flow: drawing in silence, only happy path, inventing QPS as fact, skipping ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scope changes mid-HLD? | “Re-confirm in and out in twenty seconds. Adjust dives. Protect ops.” |
| Backend mesh deep-dive? | “Sketch touchpoints; stay client-owned unless they ask.” |
| Forgot offline? | “Assumption: online-first plus last-good cache — correct me if wrong.” |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q3. Walk the HLD — client layers, backend, load

**Answer:**

> “Presentation: UICollectionView with DiffableDataSource — or SwiftUI List with stable IDs. Domain: FeedViewModel — paging state, optimistic likes, impression dwell. Data: FeedRepository coordinates network and SQLite cache. Platform: URLSession, image pipeline with decode off main, analytics batcher.
>
> Backend touchpoints: feed service behind API gateway and CDN; like mutation API; impression ingest — not ranking.
>
> Load: prefer cursor — after_cursor, limit fifteen to twenty — O(1) server cost versus offset. Prefetch next page around seventy percent scroll. Cache TTL around five minutes; JSON roughly eight to twelve KB per page. Labeled QPS from DAU times sessions times pages per session — never fake precision.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Four layer names? | “Presentation, domain, data, platform — adapt naming.” |
| Offset pagination? | “Reject for dynamic feeds — inserts skip or duplicate; O(n) deep pages.” |
| Where is CDN? | “Image and media CDN; feed JSON may be edge-cached briefly.” |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q4. Data / API — entities, endpoints, scale

**Answer:**

> “Entities: Post with id, author, text, media thumbs, likeCount, cursor; LikeAction; ImpressionEvent. Endpoints: GET feed with limit and after_cursor; POST like — idempotent client UUID optional. Scale: page fifteen to twenty; field-mask thumbs not full images; gzip. Impressions batched — not per frame. Consistency: cursor opaque; mid-scroll inserts don’t shift offsets.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pull-to-refresh? | “New head request; merge with cursor continuity; avoid wiping in-flight page.” |
| Like storms? | “Optimistic UI; server dedupe; client single-flight per post id.” |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q5. Deep dive 1 — Cursor pagination & prefetch?

**Answer:**

> “Trigger next page around seventy percent scroll depth; cancel or coalesce duplicate page requests; keep one in-flight next-page task. Prefetch image thumbs via the image pipeline for upcoming cells. Never decode full-res on main. If a page fails: keep the existing list, show inline retry — don’t blank the feed.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| User at top with new posts? | “New posts pill or insert only when near top — don’t jump scroll position.” |
| Prefetch stampede? | “Single-flight page task plus generation token on reload.” |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q6. Deep dive 2 — Optimistic like + offline cache?

**Answer:**

> “Optimistic like flips UI immediately; persist intent; on failure rollback Diffable snapshot plus toast. Offline: load last about two hundred from SQLite off main thread; show Offline or Cached badge; queue like if product allows. Impressions: at least fifty percent visible for at least one second — batch upload.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SQLite on main? | “Never — background or async; hop to MainActor for UI.” |
| OOM while scrolling? | “Clear L1 image cache; keep feed text models.” |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> “Metrics: scroll hitch rate, TTFF cached under one second target, cache hit over eighty percent as a target, page p99, like success rate. Failures: five-xx → show SQLite plus Cached; empty first launch offline → native empty plus retry. Rollout: flag to disable prefetch aggressiveness; kill switch → shorter page size. Load: after outage, jittered backoff so clients don’t thundering-herd the feed origin.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent QPS? | “Forbidden as fact — DAU plus labeled estimate only.” |
| Kill switch? | “Remote config: disable heavy media; reduce prefetch.” |

**How can I relate to my case:**
- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Don’t claim:** Invented feed QPS or ranking ownership.

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> “Pass bar: clarify and agenda in five minutes or less; HLD shows four layers plus backend plus load; API has cursors and idempotency as needed; two deep dives; ops with kill switch and concrete metrics.
>
> Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite or decode; inventing QPS as fact; never reaching ops; blob architecture with no data flow.
>
> Spine: zero to five clarify, five to fifteen HLD, fifteen to twenty-five API, twenty-five to forty dives, forty to forty-five ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | “Park dive 2 bullets; protect ops five minutes.” |
| Forgot load? | “One sentence: DAU → labeled QPS, cursor cost, single-flight.” |
| Invented crash-free %? | “Forbidden — use resume-backed numbers or label as target.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

---

### Q9. Where do Day 01 type-choice instincts show up in the feed?

**Answer:**

> “Post and cursor models as value types so Diffable snapshots stay independent. Feed screen state as an enum — idle, loading, loaded, failed — not boolean soup. Like coordinator identity as a class or actor if concurrent; UI ViewModel on MainActor. Nested class caches inside Post DTOs are a trap — inject services at the boundary. Same north star as Ads listing models, applied to a design feed.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI unknown component? | “unknown(type:raw:) fallback — don’t crash the whole feed on a new CMS type.” |
| HeroWidget analogy? | “Autoplay video lifecycle is identity — class or dedicated player owner — not a struct DTO.” |

**How can I relate to my case:**
- **Design if asked:** Feed design judgment — label design.
- **Shipped hooks:** BookMyShow Ads pipeline + HeroWidget lifecycle instincts for model vs identity split.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Silent drawing

You open the whiteboard and start boxes before asking a single question.

**Ask yourself:** What senior signal did you lose?

**Answer:** Scope ownership. Interviewer may want different dives. Always agenda then clarify — or labeled assumptions — before ink.

---

### Puzzle B — Offset pagination on a live feed

Someone insists on `offset=40&limit=20` because “it’s simpler.”

**Ask yourself:** What fails as posts insert at the top?

**Answer:** Skips and duplicates; deep pages get expensive. Prefer opaque cursors for dynamic feeds.

---

### Puzzle C — Metric honesty in ops

You quote “feed QPS is exactly 12,847” with no source.

**Ask yourself:** Fix?

**Answer:** Label the estimate: DAU × sessions × pages, with assumptions spoken. Invented precision is a fail.

---

Next: [06-module-drills.md](06-module-drills.md)
