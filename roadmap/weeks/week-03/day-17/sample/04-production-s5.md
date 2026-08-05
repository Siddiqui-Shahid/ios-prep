# Sample 04 — Production S5 (Q&A)

> Guided teaching. Separates **Verified** resume facts from **How I would apply it** and technical correctness vocabulary.

---

### Q1. What can you claim under Verified · S5?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map-for-today) · [§2 Verified S5 STAR](../03-production-bridge.md#2-verified-s5--star-2-3-min)

**Answer:**

> Instrumented **Firebase Performance** traces around **listing, checkout, and search**. Reported **p50 and p90**, not averages — tails on weak devices and peak traffic stayed visible. Used traces to prioritise optimisation with PM and backend. Treated traces as **observability across releases**. You may **not** claim in-house APM SDK, invented ms SLAs, or “Leaks showed retain cycles” as Verified BMS workflow.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | Verified · S5 · BookMyShow · Firebase Performance p50/p90 |
| ≤20s line? | “I instrumented Firebase Performance for listing, checkout, and search — p50/p90 so release decisions followed real tails, not averages.” |
| What S5 is not? | MetricKit subscriber as personal shipped work without evidence. |

---

### Q2. Walk the S5 STAR spine

**Points to:** [Production bridge · §2 Verified S5](../03-production-bridge.md#2-verified-s5--star-2-3-min)

**Answer:**

> **Opener:** Journey-level observability with Firebase Performance. **S/T:** Data-driven latency visibility on business-critical journeys — desk anecdotes insufficient at scale. **Action:** Traces on listing/checkout/search; p50/p90 reporting; PM/backend prioritisation; regression watch across releases. **Result:** Observability layer grounded in percentiles. **Lesson:** p90 > average for user-perceived pain; lab attributes, field decides priority.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Situation scale signal? | Consumer app — “feels slow” insufficient for prioritisation. |
| Backend conversation example? | Checkout p90 high, CPU clean → network/backend investigation. |
| Release culture? | Traces as regression watch — Day 20 CI gates bridge. |

---

### Q3. Journey traces vs interceptor spans (S5-A1)?

**Points to:** [Production bridge · Journey vs interceptor](../03-production-bridge.md#journey-vs-interceptor--s5-a1) · [Deep dive · §7.2 Placement judgment](../02-deep-dive.md#72-placement-judgment-s5-a1)

**Answer:**

> **Journey-level traces** for product SLIs and PM conversations — clear start/stop tied to user outcome. **Per-request interceptor spans** for debugging API chatter — carefully, with cardinality hygiene. Label **How I would apply it · S5-A1** when describing placement judgment beyond Verified Firebase journey work.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cardinality example? | URL templates `/user/:id` — not raw URLs with PII. |
| Unbounded interceptor risk? | Noise, cost, alert fatigue. |
| When add interceptor? | During targeted API chatter investigation — not default everywhere. |

---

### Q4. How do S12, S6, and S3 hook adjacent?

**Points to:** [Production bridge · §4 Adjacent hooks](../03-production-bridge.md#4-adjacent-hooks-keep-honest)

**Answer:**

> **S12 Verified:** server-driven splash / cold-start product — TTI mindset, no fake ms. **S6 Verified:** LE Bottom Sheet — **30%+** flows fewer full-screen navigations — UX performance. **S3 Verified:** search debounce/cancel — pair with search journey traces. Keep S5 as hero observability story; adjacent hooks answer pivots.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S6 one-liner? | Performance isn’t only CPU — fewer navigations cut stack cost. |
| S3 search checklist? | Debounce, cancel in-flight, ignore stale results. |
| Collapse into one STAR? | No — match hook to question; S5 stays Firebase p50/p90 core. |

---

### Q5. What Instruments correctness do you say in perf interviews?

**Points to:** [Production bridge · §5 Instruments correctness](../03-production-bridge.md#5-instruments-correctness-say-in-perf-interviews)

**Answer:**

> “For abandoned VCs / retain cycles I use Memory Graph and Allocations. Leaks is for unreachable memory — cycles usually won’t show there.” Label as **technical correctness** — Applied/Learning when implying personal BMS triage unless you add evidence. Do not claim Leaks found cycles at BMS as Verified.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why mention in perf day? | Interviewers blend memory + perf — correctness trap. |
| Pair with S5? | Field p90 for priority; Graph/Allocations for lab memory attribution. |
| Day 03 depth? | ARC cycles — today only Instruments trap. |

---

### Q6. What anti-patterns must you refuse?

**Points to:** [Production bridge · §7 Anti-patterns](../03-production-bridge.md#7-anti-patterns-to-refuse)

**Answer:**

> Average-only wins. FPS vanity without hitch rate/device class. Time Profiler on wait-bound latency. Single “performance score” instead of SLI set. Invented cold-start ms or internal alert thresholds as Verified facts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Small SLI set to name? | Cold start p90, journey p90 (listing/checkout/search), hitch, CFS — with hang gap (Day 18). |
| PM-friendly metric? | p90 checkout latency movement — not average. |
| Lab without field? | Insufficient for fleet-only regressions. |

---

### Q7. Give a full honest S5 + correctness answer

**Points to:** [Production bridge · §3 Interview line](../03-production-bridge.md#3-interview-line-20s) · [§5 Instruments](../03-production-bridge.md#5-instruments-correctness-say-in-perf-interviews)

**Answer:**

> “I instrumented Firebase Performance on listing, checkout, and search with p50/p90 (Verified S5) — release and optimisation discussions followed tails, not averages. In lab, I attribute CPU with Time Profiler and hitches; for memory cycles I’d use Memory Graph and Allocations, not Leaks (Applied correctness). Field percentiles decide priority; Instruments names the bottleneck class.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified portion? | Firebase traces, three journeys, p50/p90. |
| Applied portion? | Memory tool order when cycles suspected. |
| After this sample? | [`../04-questions.md`](../04-questions.md), [`../05-exercises.md`](../05-exercises.md). |

---

## After this sample

1. Skim [`../code/JourneyTrace.swift`](../code/JourneyTrace.swift) and [`../code/InstrumentsToolMap.swift`](../code/InstrumentsToolMap.swift).
2. Time S5 STAR from [`../04-questions.md`](../04-questions.md).
3. Practice tool-selection drills in [`../05-exercises.md`](../05-exercises.md).
