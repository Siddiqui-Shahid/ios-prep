# Sample 04 — Firebase Performance traces (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow Firebase Performance traces?

**Answer:**

> Instrumented **Firebase Performance** traces around **listing, checkout, and search**. Reported **p50 and p90**, not averages — tails on weak devices and peak traffic stayed visible. Used traces to prioritise optimisation with PM and backend. Treated traces as **observability across releases**. You may **not** claim in-house APM SDK, invented ms SLAs, or “Leaks showed retain cycles” as Verified BMS workflow.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag? | BookMyShow Firebase Performance traces · BookMyShow · Firebase Performance p50/p90 |
| ≤20s line? | “I instrumented Firebase Performance for listing, checkout, and search — p50/p90 so release decisions followed real tails, not averages.” |
| What BookMyShow Firebase Performance traces is not? | MetricKit subscriber as personal shipped work without evidence. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. Walk the BookMyShow Firebase Performance traces STAR spine

**Answer:**

> **Opener:** Journey-level observability with Firebase Performance. **S/T:** Data-driven latency visibility on business-critical journeys — desk anecdotes insufficient at scale. **Action:** Traces on listing/checkout/search; p50/p90 reporting; PM/backend prioritisation; regression watch across releases. **Result:** Observability layer grounded in percentiles. **Lesson:** p90 > average for user-perceived pain; lab attributes, field decides priority.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Situation scale signal? | Consumer app — “feels slow” insufficient for prioritisation. |
| Backend conversation example? | Checkout p90 high, CPU clean → network/backend investigation. |
| Release culture? | Traces as regression watch — Day 20 CI gates bridge. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. Journey traces vs interceptor spans (BookMyShow Firebase Performance traces-A1)?

**Answer:**

> **Journey-level traces** for product SLIs and PM conversations — clear start/stop tied to user outcome. **Per-request interceptor spans** for debugging API chatter — carefully, with cardinality hygiene. Label **Design: BookMyShow Firebase Performance traces-A1** when describing placement judgment beyond Verified Firebase journey work.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cardinality example? | URL templates `/user/:id` — not raw URLs with PII. |
| Unbounded interceptor risk? | Noise, cost, alert fatigue. |
| When add interceptor? | During targeted API chatter investigation — not default everywhere. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How do Audio streaming + server-driven splash (Aces), BookMyShow LE Bottom Sheet, and BookMyShow backend-driven header & search hook adjacent?

**Answer:**

> **Audio streaming + server-driven splash (Aces) Verified:** server-driven splash / cold-start product — TTI mindset, no fake ms. **BookMyShow LE Bottom Sheet Verified:** LE Bottom Sheet — **30%+** flows fewer full-screen navigations — UX performance. **BookMyShow backend-driven header & search Verified:** search debounce/cancel — pair with search journey traces. Keep BookMyShow Firebase Performance traces as hero observability story; adjacent hooks answer pivots.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow LE Bottom Sheet one-liner? | Performance isn’t only CPU — fewer navigations cut stack cost. |
| BookMyShow backend-driven header & search search checklist? | Debounce, cancel in-flight, ignore stale results. |
| Collapse into one STAR? | No — match hook to question; BookMyShow Firebase Performance traces stays Firebase p50/p90 core. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search; BookMyShow Firebase Performance traces; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What Instruments correctness do you say in perf interviews?

**Answer:**

> “For abandoned VCs / retain cycles I use Memory Graph and Allocations. Leaks is for unreachable memory — cycles usually won’t show there.” Label as **technical correctness** — Applied/Learning when implying personal BMS triage unless you add evidence. Do not claim Leaks found cycles at BMS as Verified.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why mention in perf day? | Interviewers blend memory + perf — correctness trap. |
| Pair with BookMyShow Firebase Performance traces? | Field p90 for priority; Graph/Allocations for lab memory attribution. |
| Day 03 depth? | ARC cycles — today only Instruments trap. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What anti-patterns must you refuse?

**Answer:**

> Average-only wins. FPS vanity without hitch rate/device class. Time Profiler on wait-bound latency. Single “performance score” instead of SLI set. Invented cold-start ms or internal alert thresholds as Verified facts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Small SLI set to name? | Cold start p90, journey p90 (listing/checkout/search), hitch, CFS — with hang gap (Day 18). |
| PM-friendly metric? | p90 checkout latency movement — not average. |
| Lab without field? | Insufficient for fleet-only regressions. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Give a full honest BookMyShow Firebase Performance traces + correctness answer

**Answer:**

> “I instrumented Firebase Performance on listing, checkout, and search with p50/p90 (BookMyShow Firebase Performance traces) — release and optimisation discussions followed tails, not averages. In lab, I attribute CPU with Time Profiler and hitches; for memory cycles I’d use Memory Graph and Allocations, not Leaks (Applied correctness). Field percentiles decide priority; Instruments names the bottleneck class.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified portion? | Firebase traces, three journeys, p50/p90. |
| Applied portion? | Memory tool order when cycles suspected. |
| After this sample? | [`../04-questions.md`](../04-questions.md), [`../05-exercises.md`](../05-exercises.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

## After this sample

1. Skim [`../code/JourneyTrace.swift`](../code/JourneyTrace.swift) and [`../code/InstrumentsToolMap.swift`](../code/InstrumentsToolMap.swift).
2. Time BookMyShow Firebase Performance traces STAR from [`../04-questions.md`](../04-questions.md).
3. Practice tool-selection drills in [`../05-exercises.md`](../05-exercises.md).

---

