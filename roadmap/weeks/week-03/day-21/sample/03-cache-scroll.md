# Sample 03 — Cache & scroll performance (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. Where does caching sit in the SDUI HLD?
**Answer:**

> **FallbackEngine** beside parser/registry/renderer: serves **last-good layout from disk** when network fails. Flow: CMS → Layout API → client → parse/registry/render → **cache** on success. Online-first default from clarify; cache is resilience + perceived speed — not sole source of truth for irreplaceable user actions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cache on every fetch? | Yes — update after successful parse; etag if API supports. |
| Memory vs disk? | Disk for layout JSON survival; NSCache for decoded images in session. |
| Kill switch? | Remote config disables SDUI → native scaffold — ops closer. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is the SDUI cache/freshness policy?
**Answer:**

> **Last-good layout** with **TTL** and **stale-while-revalidate**: show cached immediately, fetch in background, swap when fresh arrives. First launch empty cache → **native scaffold** — don’t white-screen home. Major schema unsupported → disk cache or force-update — product call.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Poison layout? | Validate before cache write; checksum/version gate. |
| Fallback hit rate metric? | Ops metric — spikes mean API/CDN pain. |
| Splash server-driven? | Audio streaming + server-driven splash (Aces) family — freshness without blocking forever. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. Unknown component vs cache — how do they interact?
**Answer:**

> Cache stores parsed layout; on render, **unknown types → EmptyView/placeholder** + non-fatal metric `sdui_unknown_type` — **never crash** the tree. Cached layout with new CMS experiment types still renders partial UI. Server can strip unsupported components for old schema clients.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| JSON decode fails entire home? | **Refuse** — partial decode or component-level tolerance. |
| Force-update vs cache? | Unsupported **major** schema — product decision. |
| BookMyShow backend-driven header & search-A1 label? | Unknown fallback = design judgment hook. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How do lists scroll in SDUI — pagination model?
**Answer:**

> **Pagination inside list components** — cursor **`fetch_more`** action, not usually paginating the whole screen JSON. Keep screen payload **lean** (~50KB gzip mindset). List component requests next page via API; renderer appends rows — **scroll performance** stays native collection/table where possible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Whole screen pagination? | Rare — heavy initial parse; bad for time-to-first-paint. |
| Cursor vs offset? | Prefer **cursor** for feeds — stable under inserts. |
| SDUI native list host? | Registry maps list type to UICollectionView/List — senior pattern. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. When do you deep-dive images vs scroll vs cache?
**Answer:**

> **Media-heavy layouts:** deep-dive **downsample, off-main decode, prefetch** — Day 16 family. **Otherwise:** name image pipeline once; spend dive time on **versioning, actions, cache**. Scroll jank → mention **frame budget**, parse off hot path, reuse cells. Timeboxed judgment — don’t draw buttons 20 minutes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Parse on main thread? | Bad — hitch scroll; background parse + main render. |
| Hero images in header SDUI? | BookMyShow backend-driven header & search proof — protocol-driven header; cache tiers. |
| WebView for list? | Trade-off beat — perf vs iteration speed. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Networking mock — where does cache sit?
**Answer:**

> **URLCache / app cache** beside URLSession pin layer and **Keychain token store**. Interceptors handle auth; cache policy per endpoint — GET feed vs never-cache POST. **Poison cache** and **idempotency** are failure modes in ops closer. Refresh single-flight prevents stampede — separate from cache but adjacent.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Retry GET from cache? | Stale-while-revalidate pattern for idempotent reads. |
| POST booking retry? | **Idempotency-Key** — no blind retry — Q11 in 04. |
| Pin fail + cached response? | Don’t serve stale over broken trust on sensitive hosts. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Scroll + cache ops metrics to mention?
**Answer:**

> **SDUI:** layout fetch **p50/p90**, **fallback hit rate**, unknown-type rate, journey trace on home scroll, **CFS 99.95%+** bar. **Networking:** journey p50/p90 (BookMyShow Firebase Performance traces), pin failure rate, 401/refresh rate. Rollout: flags, phased %, **pause if p90 cliffs** — IMOC (BookMyShow IMOC + crash-free at scale). Averages alone don’t close a senior mock.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scroll metric name? | Journey trace home feed — instrument start/stop. |
| Fallback spike? | CDN/API incident signal — ops response. |
| Prompt B full script? | Dedicated Q8 — HLD / API / dives / ops walkthrough. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q8. Prompt B — full HLD / API / ops walkthrough?
**Answer:**

> **Clarify:** first-party networking + auth + SSL pinning; **30L+ DAU**; out: backend mesh / Android; dives: **single-flight refresh** + **SPKI rotation as design**; close on p50/p90. 
> **HLD:** Features → protocols → **APIClient** (build → intercept → execute → decode → map errors) → Auth/Retry/Tracing interceptors → **URLSession + SPKI pin + domain allowlist** → URLCache / Keychain / reachability. Prefer URLSession when owning trust — **BookMyShow SSL pinning + URLSession migration Ads** proof. 
> **API:** `APIEndpoint` + `request(_:) async throws`; 401 → refresh coordinator; retry only transient 408/429/5xx on idempotent GETs; never blind-retry charge POSTs. 
> **Dive 1:** N parallel 401s → **one** actor-owned refresh; others await; success retries once; failure → logout. 
> **Dive 2:** Pin **SHA-256 of SPKI DER** (not raw SecKey bytes); backup pins; ship client before rotate; break-glass — **design** (Design: pin rotation / break-glass (not shipped runbook)), not invented runbook. 
> **Ops:** pin mismatch, refresh stampede, poison cache; metrics journey p50/p90 (BookMyShow Firebase Performance traces), pin fail rate, 401/refresh, CFS; flag + pause on cliffs (BookMyShow IMOC + crash-free at scale).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sketch crutch? | [`code/NetworkPinSketch.swift`](../code/NetworkPinSketch.swift). |
| Both prompts in 45? | Primary + 5-min secondary — T3 in 04. |
| Next topic? | Scoring — [04-scoring-rubric.md](04-scoring-rubric.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration; BookMyShow Firebase Performance traces; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

Next: [04-scoring-rubric.md](04-scoring-rubric.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the SDUI cache/freshness policy

**Ask yourself:** What is the SDUI cache/freshness policy?

**Answer:** “**Last-good layout** with **TTL** and **stale-while-revalidate**: show cached immediately, fetch in background, swap when fresh arrives. First launch empty cache → **native scaffold** — don’t white-screen home. Major schema unsupported → disk cache or force-update — product call.”

### Puzzle B — Unknown component vs cache — how do they interact

**Ask yourself:** Unknown component vs cache — how do they interact?

**Answer:** “Cache stores parsed layout; on render, **unknown types → EmptyView/placeholder** + non-fatal metric `sdui_unknown_type` — **never crash** the tree. Cached layout with new CMS experiment types still renders partial UI. Server can strip unsupported components for old schema clients.”

### Puzzle C — How do lists scroll in SDUI — pagination model

**Ask yourself:** How do lists scroll in SDUI — pagination model?

**Answer:** “**Pagination inside list components** — cursor **`fetch_more`** action, not usually paginating the whole screen JSON. Keep screen payload **lean** (~50KB gzip mindset). List component requests next page via API; renderer appends rows — **scroll performance** stays native collection/table where possible.”
