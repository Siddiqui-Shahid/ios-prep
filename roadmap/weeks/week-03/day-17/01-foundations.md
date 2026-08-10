# 01 — Foundations: Performance Investigation (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. What is the one rule to remember for this topic? `(45–60s)`
**Answer:**

> “Define a user journey SLI, measure with percentiles in the field, attribute with the right lab tool, fix the smallest high-leverage cause, then re-verify p50/p90. Everything below unpacks that sentence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. The performance loop (senior habit)? `(45–60s)`
**Answer:**

> “I never optimize from a single desk iPhone anecdote at 30L+ DAU scale — field distributions lie differently than my device.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Lab vs field? `(45–60s)`
**Answer:**

> “Staff signal: Start where the signal lives. Rare field-only regressions → field first to locate the segment, then lab to attribute.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Why p50 / p90 (not averages)? `(45–60s)`
**Answer:**

> “Interview line: “At BookMyShow we instrumented Firebase Performance for listing, checkout, and search and tracked p50/p90 so prioritisation followed real tails, not averages.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. Glossary (intern → mid)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Instruments — name with purpose (first pass)? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Critical correctness — retain cycles vs Leaks? `(45–60s)`
**Answer:**

> “text Retain cycle / abandoned VC → objects still REACHABLE (they point at each other) → Leaks instrument usually CLEAN → Use Memory Graph (edges) + Allocations (persistent growth).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. MetricKit (field OS aggregates)? `(45–60s)`
**Answer:**

> “Subscribe via MXMetricManager / MXMetricManagerSubscriber: - Hang diagnostics / hitch metrics - CPU / memory histograms - Disk write exceptions - Exit reasons (pairs with Day 18 crash/OOM narratives).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Startup anatomy (names you must say)? `(45–60s)`
**Answer:**

> “text Pre-main (dyld, static init, +load-class work) → main / App / Scene setup → First frame (TTFF) → Time-to-interactive (data-ready UI) Optimizations interviewers expect:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Scrolling & hitches (first pass)? `(45–60s)`
**Answer:**

> “- Budget: ~16.7ms per frame @ 60Hz; ~8.3ms @ 120Hz - Hitch: work missed the deadline → jank - Common causes: main-thread image decode, Auto Layout thrash, sync file I/O, lock contention, huge cell configure - Fixes preview: downsample/prefetch (Day 16), reuse hygiene, flatten hierarchies, parse off main, debounce search ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Firebase Performance at BMS (production proof — preview)? `(45–60s)`
**Answer:**

> “Instrumented p50/p90 traces across listing, checkout, search — an observability layer for data-driven optimisation. Interview structure:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Mini decision tree — which tool first? `(45–60s)`
**Answer:**

> “text “App feels slow” ├─ Can you reproduce on desk? → Instruments (Time Profiler / Hitches / Launch) ├─ Only some users / devices? → Field first (Firebase p90 segment, MetricKit) ├─ Memory climbs on navigate? → Allocations + Memory Graph (not Leaks-first for cycles) ├─ Scroll jank? → Hitches / Time Profiler on main └─ Checkout/search latency? → Journey traces + Network instrument if lab ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Teach-back checklist? `(45–60s)`
**Answer:**

> “Before deep dive, say without notes: 1. Perf loop in five steps 2. Why p90 over average 3. Lab vs field 4. Cold-start four phases 5. Hitch vs hang (one sentence each) 6. Retain cycles → Graph/Allocations, not Leaks 7. one-liner with p50/p90.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. What’s next? `(45–60s)`
**Answer:**

> “02-deep-dive.md expands Instruments failure modes, MetricKit subscriber shape, hang detector concept, APM upload NFRs, and scroll attribution playbooks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
