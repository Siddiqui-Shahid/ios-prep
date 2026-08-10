# 03 — Production Bridge: Firebase Performance (S5) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Provenance map for today? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. Forbidden overclaims? `(45–60s)`
**Answer:**

> “- Invented cold-start milliseconds or hitch SLA numbers as “what we hit” - “Leaks instrument showed our retain cycle” - “I built an in-house APM SDK at BMS” ( is Firebase Performance traces) - Claiming MetricKit subscriber code as shipped personal work without evidence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Timed opener (~10s)? `(45–60s)`
**Answer:**

> “I’ll walk through building journey-level observability with Firebase Performance at BookMyShow — listing, checkout, and search with p50/p90.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Situation / Task (~20s)? `(45–60s)`
**Answer:**

> “We needed data-driven latency visibility across business-critical journeys. Anecdotes from desk devices weren’t enough at consumer scale.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Action (~90s)? `(45–60s)`
**Answer:**

> “1. Instrumented Firebase Performance traces around key journeys: listing, checkout, search. 2. Reported p50 and p90, not averages — so tails on weak devices and peak traffic stayed visible. 3. Used traces to prioritise optimisation work with PM and backend — conversations shifted from “feels slow” to percentile movement. 4. Treated traces as an observability layer across releases — watch regressions, not one-off screenshots.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Result (~20–30s)? `(45–60s)`
**Answer:**

> “An observability layer for journey latency; release and optimisation discussions grounded in percentiles.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Lesson (~15–20s)? `(45–60s)`
**Answer:**

> “p90 matters more than average for user-perceived pain under load. Lab Instruments attribute; field percentiles decide priority.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Interview line (≤20s)? `(45–60s)`
**Answer:**

> “I instrumented Firebase Performance traces for listing, checkout, and search — we tracked p50/p90 so release decisions followed real tails, not averages.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Cold start product — S12? `(45–60s)`
**Answer:**

> “Splash is a product surface — server-driven content can improve freshness and cold-start experience; I talk TTI mindset, not a fake millisecond trophy.” > Provenance: Verified · · Aces server-driven splash.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q10. UX performance — S6? `(45–60s)`
**Answer:**

> “Performance isn’t only CPU — reducing full-screen navigations for 30%+ flows with the LE Bottom Sheet cut stack cost for high-traffic journeys.” > Provenance: Verified · · LE Bottom Sheet 30%+ flows.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. Search lag checklist — S3? `(45–60s)`
**Answer:**

> “Debounce, cancel in-flight, don’t apply stale results; pair with search journey traces. > Provenance: Verified · · search debounce/cancel.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q12. Journey vs interceptor — S5-A1? `(45–60s)`
**Answer:**

> “When asked where to put spans: > “I’d keep product SLIs as journey traces, and use finer interceptor spans for debugging chatter — carefully, with cardinality hygiene.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Instruments correctness (say in perf interviews)? `(45–60s)`
**Answer:**

> “If memory comes up during a performance discussion: > “For abandoned view controllers / retain cycles I use Memory Graph and Allocations. Leaks is for unreachable memory — cycles usually won’t show there.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Whiteboard — where you’d place 3 traces? `(45–60s)`
**Answer:**

> “text Listing: viewDidAppear / onAppear → first content bind Search: debounced query fire → results render (ignore cancel) Checkout: CTA tap → terminal success/fail (not every polling tick as separate journey).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Anti-patterns to refuse? `(45–60s)`
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

### Q16. Bridge to Days 18–20? `(45–60s)`
**Answer:**

> “- Day 18: hangs/OOM may not move CFS — don’t trust crash-free alone for “freezes” - Day 19: security work must not silently add launch/main cost without measurement - Day 20: release trains pause on perf/CFS gates — culture feeds ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
