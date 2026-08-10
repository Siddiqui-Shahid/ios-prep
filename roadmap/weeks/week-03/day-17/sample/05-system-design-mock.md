# Sample 05 — System-design mock: App Performance Monitoring (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/app-performance-monitoring.md`](../../../../ios-system-design/docs/app-performance-monitoring.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 17 — Parallel SD APM.

---

### Q1. Interviewer: “Design App Performance Monitoring.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Cold start measurement** and **Hang watchdog**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Cold start, hang, network, memory in scope?
> 2. Crash SDK separate?
> 3. Batch upload budget?
> 4. MetricKit OK?
> 5. Overhead SLO <1% CPU?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** APM client: cold start, hang>250ms, network templates, MetricKit; crash separate; batch gzip upload.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> Instrumentation SDK → ring buffers → batch uploader → ingest/TSDB. Never block main.
> **Load:** batch ≤~500KB gzip; background upload; sampling under load.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| URL template anti-pattern? | Normalize `/users/123` → `/users/{id}` or cardinality explodes. |
| Firebase Performance? | BMS traces — listing/checkout/search. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> `POST /v1/metrics/batch` gzip. Local persistence if offline.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| PII in spans? | Scrub — no tokens/emails. |
| Kill switch? | Remote disable SDK if it hangs. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).

---

### Q5. Deep dive 1 — Cold start measurement?
**Answer:**

> process start/sysctl → first frame; break pre-main vs post-main. Target cold <1.2s class from spec.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pre-main heavy? | Dyld/frameworks — modularization link. |
| P90 >2s? | P1 alert. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).

---

### Q6. Deep dive 2 — Hang watchdog?
**Answer:**

> Main-thread ping; >250ms hang candidate; stack capture carefully; don’t deadlock in handler.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| False positives? | Debugger attached; breakpoints. |
| Hitch vs hang? | Hitch frame budget; hang multi-hundred ms. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> Upload success; cold p90; hang rate; network p99. Kill APM if self-hurting.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | BookMyShow Firebase Performance traces. |
| Crash-free? | Pair with crash SDK day — don’t conflate. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).

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
