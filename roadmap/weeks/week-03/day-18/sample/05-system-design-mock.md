# Sample 05 — System-design mock: Crash Reporting SDK (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/crash-reporting-sdk.md`](../../../../ios-system-design/docs/crash-reporting-sdk.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 18 — Parallel SD Crash SDK.

---

### Q1. Interviewer: “Design Crash Reporting SDK.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Signal-safe handler** and **OOM + breadcrumbs**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Signals + NSException + Swift fatal?
> 2. OOM heuristics?
> 3. Breadcrumb budget?
> 4. Upload next launch?
> 5. Out: server symbolication internals?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** Async-signal-safe write; breadcrumbs; OOM next launch; upload; out: backend grouping deep dive.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> Handlers → mmap crash file → next launch uploader → ingest + dSYM.
> **Constraints:** signal handler — no malloc/ObjC. Init <10ms.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why mmap? | Safe under crash constraints. |
| 99.95%+ CFS? | Ops culture — BookMyShow IMOC participation — don’t claim sole ownership. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> `POST /v1/crashes/report`, non-fatal endpoint. Missing dSYM hold ~7d.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Upload fail? | SQLite retry queue. |
| PII in breadcrumbs? | Redact. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).

---

### Q5. Deep dive 1 — Signal-safe handler?

**Answer:**

> POSIX signals write preallocated buffer only; never lock/malloc.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Swift errors? | Fatal vs caught — nonfatal API separate. |
| Hang vs crash? | Watchdog separate path. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).

---

### Q6. Deep dive 2 — OOM + breadcrumbs?

**Answer:**

> Next-launch heuristic if jetsam; ring ~100 breadcrumbs <1µs write.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| False OOM? | Label heuristic. |
| dSYM? | Upload in CI; match build UUID. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> Crash-free sessions/users, symbolication %, upload success. Kill: disable nonfatal spam.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| IMOC? | Incident coordination vocabulary — BookMyShow. |
| SDK size? | Init budget sacred. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).

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

