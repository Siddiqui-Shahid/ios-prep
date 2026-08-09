# Sample 05 — System-design mock: Networking Layer + SSL Pinning (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/networking-layer.md`](../../../../ios-system-design/docs/networking-layer.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 21 Mock #3 — **alternate** to SDUI-heavy samples 01–04 (Prompt B).

---

### Q1. Interviewer: “Design Networking Layer + SSL Pinning.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Single-flight refresh** and **SPKI pin rotation**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. First-party networking + auth + SPKI pinning?
> 2. 30L+ DAU context OK?
> 3. Out: backend mesh / Android?
> 4. Dives: single-flight refresh + SPKI rotation?
> 5. Ops with p50/p90?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** Networking+pinning 45‑min mock; refresh actor; pin rotation design; SDUI is the other prompt — pick one live.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> Features → protocols → APIClient → interceptors → URLSession + SPKI + allowlist → URLCache/Keychain/reachability.
> Prefer URLSession when owning trust. Load: HTTP/2, gzip, timeout 30s, pin rotate ≤90d.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI instead? | If Prompt A chosen, switch cards — don’t mix mid-draw. |
| Four layers? | Yes + data flow arrows. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> APIEndpoint async throws; 401 refresh coordinator; retry only transient on idempotent GET; pin challenge.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Charge POST retry? | Never blind — idempotency or poll. |
| Backup pins? | Ship before rotate; break-glass design labeled. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.

---

### Q5. Deep dive 1 — Single-flight refresh?

**Answer:**

> Actor-owned refresh; waiters; success retry once; failure logout.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| N parallel 401? | One refresh. |
| Refresh endpoint pin? | Same trust policy. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.

---

### Q6. Deep dive 2 — SPKI pin rotation?

**Answer:**

> Pin SHA-256 of SPKI DER; backup pins; client before server rotate; mismatch terminate + metric.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Outage from bad pin? | Backup + staged rollout. |
| Whitelist? | Domain allowlist beside pin. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> p50/p90/p99, 5xx, refresh fail, pin fail. Kill retries; break-glass design. Score with Day 21 rubric.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | BMS pinning + URLSession migration. |
| Cheatsheet? | ios-system-design/docs/cheatsheet.md spine. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.

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

