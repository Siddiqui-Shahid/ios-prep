# Sample 02 — Instruments and MetricKit (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. Why must you attribute before optimising?
**Answer:**

> Senior failure mode: micro-optimising JSON encoders when p90 is **network wait**. Name the **bottleneck class** first — high CPU on main, idle/wait CPU, memory climb, field-only spike, launch regression — then pick the tool and fix. Rule: symptom class → attribution → smallest high-leverage fix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| High CPU on main symptom class? | Scroll jank, launch stutter → Time Profiler. |
| Waiting / idle CPU? | “Slow” but clean profiler → Network, backend, lock wait. |
| Field-only p90 spike? | Firebase / MetricKit segment → then lab repro on that class. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What are Time Profiler traps?
**Answer:**

> Sampling profiler — heavy **self-time** and **heaviest stacks**. Find unexpected main-thread work: JSON decode, regex, image work, sorting. After fix, confirm the stack shrinks. **Trap:** using Time Profiler to “find” network latency — waiting threads aren’t computing.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Post-fix verification? | Same instrument session shape — compare heaviest stack, not vibes. |
| Signposts role? | Mark checkout span — correlate profiler samples to product language. |
| Premature JSON optimisation? | Refuse until profiler proves CPU-bound encode/decode on critical path. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do signposts bridge lab to product language?
**Answer:**

> `os_signpost` intervals around journeys you care about — “checkout_tap → confirmation.” Makes Instruments timelines speak PM language. Discipline: too many signposts = noise. Pair with Firebase journey traces in field for same span names where possible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Whiteboard three traces? | Listing appear → content; search query → render; checkout CTA → terminal state. |
| Interceptor spans vs journey? | BookMyShow Firebase Performance traces-A1: product SLIs as journey traces; per-request spans for debug only — cardinality hygiene. |
| Learning-lab? | [`../code/JourneyTrace.swift`](../code/JourneyTrace.swift) |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What is the memory tools correctness script?
**Answer:**

> Memorize: “A retain cycle keeps objects alive through mutual strong references — abandoned but still reachable, so Leaks often stays clean. I use Memory Graph for ownership edges and Allocations to confirm objects persist across navigation generations.” **Wrong:** “Leaks showed our cycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Allocations alone limitation? | Shows growth — Graph explains *why* (edges). |
| Leaks-only memory pass? | False confidence on cycles — refuse in staff interviews. |
| Perf + memory combined question? | Lead with correctness script; label personal BMS triage Applied unless verified. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. MetricKit vs Firebase Performance — how together?
**Answer:**

> **MetricKit:** Apple OS aggregates, fleet device classes, daily-ish delay, hang/hitch/exit diagnostics — weak alone for custom journey SLIs. **Firebase Performance (BookMyShow Firebase Performance traces):** your traces on listing/checkout/search with p50/p90. Use together: MetricKit segments older devices; Firebase decides product priority; Instruments attributes in lab.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Privacy note? | OS aggregation — still scrub PII in custom trace attributes. |
| Hang rate field signal? | MetricKit + hang detector concept — may not move CFS (Day 18). |
| Don’t invent? | In-house APM SDK at BMS — BookMyShow Firebase Performance traces is Firebase traces specifically. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What is the hang detector concept?
**Answer:**

> Background ping thread signals main and waits with timeout (~250ms class). If main doesn’t respond, capture stacks carefully, persist/upload later — not on critical path. NFR: budget overhead, remote kill-switch, batch uploads. **Different from watchdog kill:** detector observes; OS may still kill if unresponsive long enough.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CFS gap? | Hangs may not count against crash-free — users still churn. |
| APM whiteboard shape? | ColdStartTracker, HangDetector, CustomTraces, MetricKitSubscriber, LocalStore → batch upload. |
| Never on happy path? | No sync network during user interaction for APM upload. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What are common failure modes in perf interviews?
**Answer:**

> Average worship — demand p90/hitch rate. Profiler on wait-bound issue — switch to network/backend. Leaks clean ⇒ no cycles — Graph + Allocations. Launch blame on UI only — check pre-main/dyld. One device proof — segment field data. Trace every raw URL — use templates + scrub PII.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cardinality hygiene? | `/user/:id` templates not raw URLs with ids. |
| Ignore older devices? | MetricKit device-class p90 — where scroll jank clusters. |
| Next sample? | [03-startup-scrolling.md](03-startup-scrolling.md) — launch and scroll playbooks. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How do you translate Android-style “ANR” thinking to iOS?
**Answer:**

> Translate to iOS vocabulary — **hangs**, **watchdog kills**, **main-thread stalls** — rather than forcing “ANR” as a term. Engineering idea is the same: **don’t block main**. Observe with MetricKit hang diagnostics and an APM hang detector (ping main, timeout, capture stacks later). Separate **hitches** (frame misses / jank) from longer **hangs** (freeze). Thresholds are **tool-defined** — learn the vendor’s definition; don’t invent one universal number. Detector observes; OS watchdog kill is a separate, harsher outcome.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 250ms vs multi-second? | Detector threshold (~250ms class) vs UX freeze vs OS kill — related ladder, not identical. |
| CFS relationship? | Hangs may not count as crashes — Day 18 honesty. |
| Trap? | Copy Android terms blindly, or dismiss the concept as “not an iOS thing.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. When do you reach for Core Animation / overdraw attribution?
**Answer:**

> Use **Core Animation** when GPU / commit cost dominates — **offscreen rendering**, **blending**, **masks**, **shadows**, overdraw. Useful for visual jank that isn’t explained by main-thread CPU alone. Less common than **main-thread image decode** as the hitch culprit — still name it so you don’t force Time Profiler when the cost is compositing. Pair with Hitches: if frames miss and CPU is light, suspect layer effects next.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Classic CA traps? | Shadows, masks, shouldRasterize misuse, translucent stacking. |
| First check still? | Main-thread decode / layout / sync I/O — then CA overdraw. |
| Lab verification? | Core Animation instrument + before/after hitch rate. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-startup-scrolling.md](03-startup-scrolling.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What are Time Profiler traps

**Ask yourself:** What are Time Profiler traps?

**Answer:** “Sampling profiler — heavy **self-time** and **heaviest stacks**. Find unexpected main-thread work: JSON decode, regex, image work, sorting. After fix, confirm the stack shrinks. **Trap:** using Time Profiler to “find” network latency — waiting threads aren’t computing.”

### Puzzle B — How do signposts bridge lab to product language

**Ask yourself:** How do signposts bridge lab to product language?

**Answer:** “`os_signpost` intervals around journeys you care about — “checkout_tap → confirmation.” Makes Instruments timelines speak PM language. Discipline: too many signposts = noise. Pair with Firebase journey traces in field for same span names where possible.”

### Puzzle C — What is the memory tools correctness script

**Ask yourself:** What is the memory tools correctness script?

**Answer:** “Memorize: “A retain cycle keeps objects alive through mutual strong references — abandoned but still reachable, so Leaks often stays clean. I use Memory Graph for ownership edges and Allocations to confirm objects persist across navigation generations.” **Wrong:** “Leaks showed our cycle.”
