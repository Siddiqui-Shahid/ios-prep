# Sample 05 — System-design mock: App Modularization & DI (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/app-modularization.md`](../../../../ios-system-design/docs/app-modularization.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 15 — Parallel SD App modularization (Stories SDK module).

---

### Q1. Interviewer: “Design App Modularization & DI.” How do you open?
**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **SDK boundary** and **Build & launch cost**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. SDK as SPM binary vs source module?
> 2. Host app DI integration?
> 3. Binary size / launch budget?
> 4. Interface for host navigation?
> 5. Out: full release train EM prompt?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> **Scripted outcomes for this mock:** Stories-style feature module; Interface/Impl; host composition root; size/launch budgets.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> Same module topology; emphasize **SDK boundary**: public Interface, private Impl, minimal Host API.
> Metrics: binary_size, dyld, incremental build.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Static vs dynamic for SDK? | Static often simpler; dynamic if replacement needed. |
| Versioning? | Semver Interface; avoid breaking hosts. |

**How can I relate to my case:**
- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> `StoriesSDK.start(dependency:)` ; host provides analytics/network protocols.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Callback hell? | Async sequences / delegates thin. |
| Tests? | Host fakes via Interface. |

**How can I relate to my case:**
- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).

---

### Q5. Deep dive 1 — SDK boundary?
**Answer:**

> No leaking UIKit subclasses across boundary unless intentional; dependency inversion for network/analytics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| God SDK? | Split packages — stories core vs UI. |
| DI in SDK? | Accept deps; don’t create global singletons. |

**How can I relate to my case:**
- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).

---

### Q6. Deep dive 2 — Build & launch cost?
**Answer:**

> Budget incremental builds; avoid resource duplication; measure pre-main.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Too many modules? | Coalesce leaf packages; keep Interface stable. |
| CI? | Module-level test targets. |

**How can I relate to my case:**
- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> Size/launch gates in CI; flag to disable SDK entry.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | Stories SDK (Raw / Miami Heat) module thinking. |
| Platform EM? | Day 26/27 can widen to release trains. |

**How can I relate to my case:**
- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).

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
