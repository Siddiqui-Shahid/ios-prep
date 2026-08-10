# Sample 05 — System-design mock: Mobile Payment Checkout (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/payment-checkout.md`](../../../../ios-system-design/docs/payment-checkout.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 14 Mock #2 Parallel SD — **Payment** primary; Search as sister follow-up.

---

### Q1. Interviewer: “Design Mobile Payment Checkout.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Idempotency exactly-once** and **Poller + mid-kill recovery**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Apple Pay / card tokenization — which methods?
> 2. Idempotency exactly-once required?
> 3. DAU and checkout QPS peak?
> 4. 3DS in scope?
> 5. Poll vs webhook-driven client?
> 6. Out: marketplace splits, bank acquiring internals?
> 7. If time: Search autocomplete sister prompt?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** Tokenized checkout; Idempotency-Key; payment FSM + SQLite recovery; poll status; 3DS; out: acquiring internals. Search = follow-up only.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> Checkout UI → Payment VM (FSM) → Repository (SQLite intent) → Merchant API → PSP (Stripe/Adyen). Pinning on payment hosts.
> **Load:** Idempotency TTL 24h; API timeout 30s; poll ≤5m every 5s; never double-charge on retry.
> **Sister:** Search debounce/cancel if interviewer switches — don’t mix into payment HLD.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| PCI? | No raw PAN on device if tokenized — Apple Pay/PSP fields. |
| Ads Mock #2? | Architecture talk may be Ads/SDUI — this card is Payment SD spine. |

**How can I relate to my case:**
- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> `POST /v1/payments/initiate` + `Idempotency-Key`. `GET /v1/payments/{id}/status`. 3DS challenge URL handling.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Retry POST? | Same Idempotency-Key — never new key on unknown outcome. |
| 4xx vs 5xx? | 4xx no retry charge; 5xx → poll status. |

**How can I relate to my case:**
- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.

---

### Q5. Deep dive 1 — Idempotency exactly-once?
**Answer:**

> Client UUID key persisted before call; retries reuse key; server dedupe 24h.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Lost response? | Poll by payment id — don’t re-initiate new key. |
| Clock skew? | Server TTL authoritative. |

**How can I relate to my case:**
- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.

---

### Q6. Deep dive 2 — Poller + mid-kill recovery?
**Answer:**

> Persist FSM in SQLite; on launch resume poll until terminal. Timeout → poll not fail toast.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| User kills app? | Resume pending payment screen. |
| Search follow-up? | Debounce 300ms + cancel — search-autocomplete.md. |

**How can I relate to my case:**
- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> Success >99.5% target, latency, 3ds rate. Kill: disable method; maintenance banner.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent auth rates? | Forbidden. |
| Pinning? | Payment hosts — networking sister dive. |

**How can I relate to my case:**
- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.

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
