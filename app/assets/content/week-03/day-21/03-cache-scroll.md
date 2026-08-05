# Sample 03 — Cache & scroll performance (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Where does caching sit in the SDUI HLD?

**Points to:** [Foundations · Prompt A HLD layers](../01-foundations.md#prompt-a--sdui-engine) · [Deep dive · A1 HLD](../02-deep-dive.md#a1-hld-515)

**Answer:**

> **FallbackEngine** beside parser/registry/renderer: serves **last-good layout from disk** when network fails. Flow: CMS → Layout API → client → parse/registry/render → **cache** on success. Online-first default from clarify; cache is resilience + perceived speed — not sole source of truth for irreplaceable user actions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cache on every fetch? | Yes — update after successful parse; etag if API supports. |
| Memory vs disk? | Disk for layout JSON survival; NSCache for decoded images in session. |
| Kill switch? | Remote config disables SDUI → native scaffold — ops closer. |

---

### Q2. What is the SDUI cache/freshness policy?

**Points to:** [04-questions · Q10](../04-questions.md#q10-offline-for-sdui-3045s) · [Deep dive · A0 Clarify](../02-deep-dive.md#a0-clarify-05)

**Answer:**

> **Last-good layout** with **TTL** and **stale-while-revalidate**: show cached immediately, fetch in background, swap when fresh arrives. First launch empty cache → **native scaffold** — don’t white-screen home. Major schema unsupported → disk cache or force-update — product call.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Poison layout? | Validate before cache write; checksum/version gate. |
| Fallback hit rate metric? | Ops metric — spikes mean API/CDN pain. |
| Splash server-driven? | S12 family — freshness without blocking forever. |

---

### Q3. Unknown component vs cache — how do they interact?

**Points to:** [Deep dive · A3 Deep dive 1](../02-deep-dive.md#a3-deep-dive-1--versioning--unknown-component-2533) · [04-questions · Q4](../04-questions.md#q4-unknown-component-type--behavior-3045s)

**Answer:**

> Cache stores parsed layout; on render, **unknown types → EmptyView/placeholder** + non-fatal metric `sdui_unknown_type` — **never crash** the tree. Cached layout with new CMS experiment types still renders partial UI. Server can strip unsupported components for old schema clients.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| JSON decode fails entire home? | **Refuse** — partial decode or component-level tolerance. |
| Force-update vs cache? | Unsupported **major** schema — product decision. |
| S3-A1 label? | Unknown fallback = design judgment hook. |

---

### Q4. How do lists scroll in SDUI — pagination model?

**Points to:** [Deep dive · A2 Data / API](../02-deep-dive.md#a2-data--api-1525) · [Deep dive · Shared trade-offs](../02-deep-dive.md#shared-trade-offs-use-live)

**Answer:**

> **Pagination inside list components** — cursor **`fetch_more`** action, not usually paginating the whole screen JSON. Keep screen payload **lean** (~50KB gzip mindset). List component requests next page via API; renderer appends rows — **scroll performance** stays native collection/table where possible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Whole screen pagination? | Rare — heavy initial parse; bad for time-to-first-paint. |
| Cursor vs offset? | Prefer **cursor** for feeds — stable under inserts. |
| SDUI native list host? | Registry maps list type to UICollectionView/List — senior pattern. |

---

### Q5. When do you deep-dive images vs scroll vs cache?

**Points to:** [04-questions · Q9](../04-questions.md#q9-when-to-deep-dive-images-in-sdui-3045s) · [Foundations · Prompt A deep dives](../01-foundations.md#prompt-a--sdui-engine)

**Answer:**

> **Media-heavy layouts:** deep-dive **downsample, off-main decode, prefetch** — Day 16 family. **Otherwise:** name image pipeline once; spend dive time on **versioning, actions, cache**. Scroll jank → mention **frame budget**, parse off hot path, reuse cells. Timeboxed judgment — don’t draw buttons 20 minutes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Parse on main thread? | Bad — hitch scroll; background parse + main render. |
| Hero images in header SDUI? | S3 proof — protocol-driven header; cache tiers. |
| WebView for list? | Trade-off beat — perf vs iteration speed. |

---

### Q6. Networking mock — where does cache sit?

**Points to:** [Deep dive · B1 HLD](../02-deep-dive.md#b1-hld-515) · [04-questions · Q6](../04-questions.md#q6-which-deep-dives-for-networking-mock-3045s)

**Answer:**

> **URLCache / app cache** beside URLSession pin layer and **Keychain token store**. Interceptors handle auth; cache policy per endpoint — GET feed vs never-cache POST. **Poison cache** and **idempotency** are failure modes in ops closer. Refresh single-flight prevents stampede — separate from cache but adjacent.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Retry GET from cache? | Stale-while-revalidate pattern for idempotent reads. |
| POST booking retry? | **Idempotency-Key** — no blind retry — Q11 in 04. |
| Pin fail + cached response? | Don’t serve stale over broken trust on sensitive hosts. |

---

### Q7. Scroll + cache ops metrics to mention?

**Points to:** [Foundations · §4 Ops closer](../01-foundations.md#4-ops-closer-both-prompts--last-5-min) · [Deep dive · A5 Ops](../02-deep-dive.md#a5-ops-4045)

**Answer:**

> **SDUI:** layout fetch **p50/p90**, **fallback hit rate**, unknown-type rate, journey trace on home scroll, **CFS 99.95%+** bar. **Networking:** journey p50/p90 (S5), pin failure rate, 401/refresh rate. Rollout: flags, phased %, **pause if p90 cliffs** — IMOC (S8). Averages alone don’t close a senior mock.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scroll metric name? | Journey trace home feed — instrument start/stop. |
| Fallback spike? | CDN/API incident signal — ops response. |
| Next topic? | Scoring — [04-scoring-rubric.md](04-scoring-rubric.md). |

---

Next: [04-scoring-rubric.md](04-scoring-rubric.md)
