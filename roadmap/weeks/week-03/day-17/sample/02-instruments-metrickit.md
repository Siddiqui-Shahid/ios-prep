# Sample 02 — Instruments and MetricKit (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. Why must you attribute before optimising?

**Points to:** [Deep dive · §1 Attribution before optimisation](../02-deep-dive.md#1-attribution-before-optimisation)

**Answer:**

> Senior failure mode: micro-optimising JSON encoders when p90 is **network wait**. Name the **bottleneck class** first — high CPU on main, idle/wait CPU, memory climb, field-only spike, launch regression — then pick the tool and fix. Rule: symptom class → attribution → smallest high-leverage fix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| High CPU on main symptom class? | Scroll jank, launch stutter → Time Profiler. |
| Waiting / idle CPU? | “Slow” but clean profiler → Network, backend, lock wait. |
| Field-only p90 spike? | Firebase / MetricKit segment → then lab repro on that class. |

---

### Q2. What are Time Profiler traps?

**Points to:** [Deep dive · §2.1 Time Profiler](../02-deep-dive.md#21-time-profiler)

**Answer:**

> Sampling profiler — heavy **self-time** and **heaviest stacks**. Find unexpected main-thread work: JSON decode, regex, image work, sorting. After fix, confirm the stack shrinks. **Trap:** using Time Profiler to “find” network latency — waiting threads aren’t computing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Post-fix verification? | Same instrument session shape — compare heaviest stack, not vibes. |
| Signposts role? | Mark checkout span — correlate profiler samples to product language. |
| Premature JSON optimisation? | Refuse until profiler proves CPU-bound encode/decode on critical path. |

---

### Q3. How do signposts bridge lab to product language?

**Points to:** [Deep dive · §2.2 Points of Interest](../02-deep-dive.md#22-points-of-interest--os_signpost)

**Answer:**

> `os_signpost` intervals around journeys you care about — “checkout_tap → confirmation.” Makes Instruments timelines speak PM language. Discipline: too many signposts = noise. Pair with Firebase journey traces in field for same span names where possible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Whiteboard three traces? | Listing appear → content; search query → render; checkout CTA → terminal state. |
| Interceptor spans vs journey? | S5-A1: product SLIs as journey traces; per-request spans for debug only — cardinality hygiene. |
| Learning-lab? | [`../code/JourneyTrace.swift`](../code/JourneyTrace.swift) |

---

### Q4. What is the memory tools correctness script?

**Points to:** [Deep dive · §2.7 Memory tools](../02-deep-dive.md#27-memory-tools--correctness-section)

**Answer:**

> Memorize: “A retain cycle keeps objects alive through mutual strong references — abandoned but still reachable, so Leaks often stays clean. I use Memory Graph for ownership edges and Allocations to confirm objects persist across navigation generations.” **Wrong:** “Leaks showed our cycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Allocations alone limitation? | Shows growth — Graph explains *why* (edges). |
| Leaks-only memory pass? | False confidence on cycles — refuse in staff interviews. |
| Perf + memory combined question? | Lead with correctness script; label personal BMS triage Applied unless verified. |

---

### Q5. MetricKit vs Firebase Performance — how together?

**Points to:** [Deep dive · §3 MetricKit](../02-deep-dive.md#3-metrickit-deep-dive) · [§3.3 MetricKit vs Firebase](../02-deep-dive.md#33-metrickit-vs-firebase-performance)

**Answer:**

> **MetricKit:** Apple OS aggregates, fleet device classes, daily-ish delay, hang/hitch/exit diagnostics — weak alone for custom journey SLIs. **Firebase Performance (S5):** your traces on listing/checkout/search with p50/p90. Use together: MetricKit segments older devices; Firebase decides product priority; Instruments attributes in lab.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Privacy note? | OS aggregation — still scrub PII in custom trace attributes. |
| Hang rate field signal? | MetricKit + hang detector concept — may not move CFS (Day 18). |
| Don’t invent? | In-house APM SDK at BMS — S5 is Firebase traces specifically. |

---

### Q6. What is the hang detector concept?

**Points to:** [Deep dive · §5 Hitches vs hangs](../02-deep-dive.md#5-hitches-vs-hangs) · [§5.1 Hang detector](../02-deep-dive.md#51-hang-detector-concept-apm-vocabulary)

**Answer:**

> Background ping thread signals main and waits with timeout (~250ms class). If main doesn’t respond, capture stacks carefully, persist/upload later — not on critical path. NFR: budget overhead, remote kill-switch, batch uploads. **Different from watchdog kill:** detector observes; OS may still kill if unresponsive long enough.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CFS gap? | Hangs may not count against crash-free — users still churn. |
| APM whiteboard shape? | ColdStartTracker, HangDetector, CustomTraces, MetricKitSubscriber, LocalStore → batch upload. |
| Never on happy path? | No sync network during user interaction for APM upload. |

---

### Q7. What are common failure modes in perf interviews?

**Points to:** [Deep dive · §10 Failure modes](../02-deep-dive.md#10-failure-modes--gotchas)

**Answer:**

> Average worship — demand p90/hitch rate. Profiler on wait-bound issue — switch to network/backend. Leaks clean ⇒ no cycles — Graph + Allocations. Launch blame on UI only — check pre-main/dyld. One device proof — segment field data. Trace every raw URL — use templates + scrub PII.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cardinality hygiene? | `/user/:id` templates not raw URLs with ids. |
| Ignore older devices? | MetricKit device-class p90 — where scroll jank clusters. |
| Next sample? | [03-startup-scrolling.md](03-startup-scrolling.md) — launch and scroll playbooks. |

---

Next: [03-startup-scrolling.md](03-startup-scrolling.md)
