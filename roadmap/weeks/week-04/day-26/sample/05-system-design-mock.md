# Sample 05 — System-design mock: Mobile Platform Engineering (EM/Staff) (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/mobile-platform-engineering-em.md`](../../../../ios-system-design/docs/mobile-platform-engineering-em.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 26 behavioral day — **platform EM** SD mock (leadership via systems).

---

### Q1. Interviewer: “Design Mobile Platform Engineering (EM/Staff).” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Phased rollout gates** and **Sev-1 triage**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Release train + feature-flag kill switches?
> 2. Crash-free gate for phased rollout?
> 3. Monorepo Interface/Impl?
> 4. Sev-1 expectations?
> 5. Out: product feature HLD?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** Phased 1→100% rollout; auto-pause gates; flag kill <5m; Sev-1 playbook; build budgets.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> Platform view: monorepo modules → CI budgets → ASC phased release → Remote Config kill → IMOC.
> **Load/governance:** weekly train; flags mandatory on new surfaces; pause if CFS <99.85% class.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Product SD instead? | Redirect — this prompt is platform/EM. |
| AI tooling? | District envelope — review bar, not platform train. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> Remote Config kill-switch; ASC halt rollout; expedited review path (process).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who flips kill? | On-call + EM; SLA <5m. |
| Canary metrics? | CFS, hang, 5xx ≥3× baseline → pause. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.

---

### Q5. Deep dive 1 — Phased rollout gates?

**Answer:**

> 1→2→5→10→20→50→100%; auto pause; don’t vibe-ship.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hotfix during phase? | Halt; flag; expedite. |
| CI flaky? | <1.5% flaky budget. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.

---

### Q6. Deep dive 2 — Sev-1 triage?

**Answer:**

> Flag kill <5m → halt ASC → communicate → hotfix train. Breadcrumbs from crash SDK.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Blame? | Systems first — IMOC culture. |
| Mentorship? | Standards via architecture envelopes — Day 26 STAR. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> CFS >99.9% target, hang <0.1%, kill SLA, CI time. This *is* the ops-heavy prompt.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | IMOC + crash-free culture participation; Ads protocol standards as leadership. |
| Invent Sev counts? | Forbidden. |

**How can I relate to my case:**
- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.

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

