# Sample 05 — System-design mock: Search Autocomplete (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/search-autocomplete.md`](../../../../ios-system-design/docs/search-autocomplete.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 06 DSA day — still a full **search** SD mock (debounce ≈ cancel in-flight).

---

### Q1. Interviewer: “Design Search Autocomplete.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Debounce + cancel** and **Trie + FTS5 offline**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Autocomplete only, or full results page too?
> 2. Offline Trie/FTS required?
> 3. DAU and peak QPS on typeahead?
> 4. Latency SLO — p99 <200ms remote?
> 5. Debounce interval expectation (e.g. 300ms)?
> 6. Out: ML ranking / ES internals?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** Autocomplete + full results; debounce 300ms; cancel in-flight; offline Trie/FTS; out: ML ranking.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> **UI** Search bar → ViewModel → **local Trie/recent** first → remote autocomplete → results list with cursor.
> **Backend:** autocomplete service (often Redis/ES) + search service behind gateway.
> **Load:** Debounce 300ms cuts QPS massively; limit 10 suggest / 20 results; drop stale by request_id.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why local first? | Perceived latency <10ms; works offline. |
| DSA link? | Two-pointer/window intuition ≠ Trie — say cancel/debounce maps to concurrency story. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> `GET /v1/search/autocomplete?q=&limit=10`
> `GET /v1/search/results?q=&cursor=&limit=20`
> Client sends monotonic `request_id`; ignore older responses.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty query? | Show recent/local only — no remote storm. |
| Rate limit 429? | Backoff; keep last good suggestions. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.

---

### Q5. Deep dive 1 — Debounce + cancel?
**Answer:**

> Timer 300ms; cancel previous `URLSessionTask`/`Task`; race guard with request_id.
> Maps to interview line: cancel in-flight work (BMS search instincts) — not an algorithm brag.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Leading vs trailing debounce? | Trailing for search — wait until pause. |
| Parallel results fetch? | Only after submit or explicit results mode. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.

---

### Q6. Deep dive 2 — Trie + FTS5 offline?
**Answer:**

> Recent queries in Trie/memory; catalog slice in SQLite FTS5 (<10MB target).
> Sync index on foreground with version/ETag.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Index too big? | Shard by category; trim rare terms. |
| Security? | Don’t put PII in analytics query text raw. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> Autocomplete p50/p99, zero-result rate, offline freshness, cancel rate.
> Kill: disable remote typeahead → local only.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Thundering herd? | Debounce + jitter on reconnect. |
| Invent CTR? | Forbidden. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.

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
