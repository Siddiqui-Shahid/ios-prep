# Sample 05 — System-design mock: Networking Layer / HTTP Client (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/networking-layer.md`](../../../../ios-system-design/docs/networking-layer.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 09 — Parallel SD Networking layer.

---

### Q1. Interviewer: “Design Networking Layer / HTTP Client.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Interceptor pipeline** and **Single-flight 401 refresh**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. REST URLSession client with interceptors — GraphQL/WS out?
> 2. Auth refresh + SSL pinning in scope?
> 3. DAU and peak RPS to origin?
> 4. Timeout defaults (~30s)?
> 5. Offline cache layer in or out?
> 6. iOS-only?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** URLSession APIClient; auth interceptor; single-flight refresh; SPKI pinning; retries on idempotent GET; out: GraphQL/WS, image SDK.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> Features → APIClient (build→intercept→execute→decode→map errors) → Auth/Retry/Tracing → URLSession + SPKI + allowlist → URLCache/Keychain.
> **Backend:** API gateway; `/auth/refresh`.
> **Load:** HTTP/2 multiplex; gzip; timeout ~30s; paginate huge JSON; pin rotation 60–90d.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Alamofire? | Prefer URLSession when owning trust/pinning — BMS migration story. |
| Where pinning sits? | URLSessionDelegate challenge — before bytes. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> `APIEndpoint` + `request(_:) async throws`. 401 → refresh coordinator; retry 408/429/5xx on idempotent GET only; never blind-retry charge POST.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Idempotency-Key? | For mutations that must be exactly-once. |
| Tracing? | X-Request-ID on all calls. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.

---

### Q5. Deep dive 1 — Interceptor pipeline?
**Answer:**

> Ordered interceptors: auth header → retry → tracing. Decode Codable on background; map to domain errors.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| URLProtocol tests? | Inject fakes without hitting network. |
| Priority/cancel? | Task cancel propagates to URLSessionTask. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.

---

### Q6. Deep dive 2 — Single-flight 401 refresh?
**Answer:**

> N parallel 401s → one actor-owned refresh; waiters await; success retries once; failure → logout clear Keychain.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Refresh 401? | Logout — avoid infinite loop. |
| Pin mismatch? | Fail closed; backup pins + rotation design. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> p50/p90/p99, 5xx rate, refresh fail→logout, pin fail metrics. Kill: loosen retries; break-glass pin design (label design vs shipped).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Thundering herd? | Jitter backoff ≤3 retries. |
| Production? | BookMyShow SSL pinning + URLSession migration Ads proof. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.

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
