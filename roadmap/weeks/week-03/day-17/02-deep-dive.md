# 02 — Deep Dive: Instruments, MetricKit, Startup, Scrolling (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Attribution before optimisation? `(45–60s)`
**Answer:**

> “Senior failure mode: micro-optimising JSON encoders when p90 is network wait.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Time Profiler? `(45–60s)`
**Answer:**

> “- Sampling profiler — heavy self-time and heaviest stacks - Look for unexpected main-thread work: JSON decode, regex, image work, sorting - After fix: confirm the stack shrinks (don’t trust vibes) Trap: Using Time Profiler to “find” network latency. Waiting ≠ computing.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Points of Interest / `os_signpost`? `(45–60s)`
**Answer:**

> “- Custom intervals around journeys you care about - Bridge lab to product language (“checkout_tap → confirmation”) - Discipline: too many signposts = noise.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Animations / Hitches? `(45–60s)`
**Answer:**

> “- Hitch = frame late vs display link - Correlate hitch regions with Time Profiler samples on main - 120Hz devices tighten the budget — same bugs, less margin.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. App Launch? `(45–60s)`
**Answer:**

> “- Separates pre-main (dyld, static) from post-main - Classic regressions: dynamic framework load, sync Keychain, eager analytics SDKs - Pair with “defer non-critical init” plans (keep crash SDK early — Day 18).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Network instrument? `(45–60s)`
**Answer:**

> “- Payload sizes, chatter, DNS, TLS, request fan-out - When Firebase network/journey p90 is high and CPU is clean → stay here / backend.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Core Animation? `(45–60s)`
**Answer:**

> “- Offscreen rendering, blending, masks, shadows - Useful when GPU/commit cost dominates — less common than main-thread decode.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Memory tools — **correctness section**? `(45–60s)`
**Answer:**

> “Interview script (memorize):.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. What you get? `(45–60s)`
**Answer:**

> “- Aggregated CPU, memory, hang/hitch-related diagnostics - Exit / diagnostic payloads useful with crash narratives - Delivered on a delay (think ~24h class aggregates) — not a live pager by itself.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. How you use it in speech? `(45–60s)`
**Answer:**

> “1. Fleet-level OS truth across device classes 2. Segment older devices when scroll jank is class-specific 3. Combine with custom journey traces for product SLIs 4. Privacy: OS aggregation — still scrub anything you add in custom layers.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. MetricKit vs Firebase Performance? `(45–60s)`
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

### Q12. Measure correctly? `(45–60s)`
**Answer:**

> “- Process start ≠ didFinishLaunching — pre-main happens earlier - APM designs often use sysctl / process start + first-frame markers - Break into: preMain + appInit + firstFrame (+ TTI if you define data-ready).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Optimisation playbook (say 4–5)? `(45–60s)`
**Answer:**

> “1. Reduce work before first frame (defer SDKs, avoid sync I/O) 2. Watch dynamic framework / dyld cost 3. Don’t block main on network for splash content when cacheable 4. Parallelize safe init carefully (ordering: crash SDK early) 5. Product: server-driven splash freshness without blocking forever ( soft bridge).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Soft production bridges? `(45–60s)`
**Answer:**

> “- : server-driven splash as cold-start product surface — measure TTI mindset, don’t invent ms. - : LE Bottom Sheet cut full-screen navigations for 30%+ flows — UX performance, not only CPU. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Hitches vs hangs? `(45–60s)`
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

### Q16. Hang detector concept (APM vocabulary)? `(45–60s)`
**Answer:**

> “text Background ping thread → signal main → wait with timeout (~250ms class) → if main doesn’t respond, capture stacks (carefully) → persist / upload later (not heavy work on critical path) NFR mindset: Overhead must be budgeted; remote kill-switch for APM features; batch uploads; never sync network on the happy path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Scrolling attribution playbook? `(45–60s)`
**Answer:**

> “text Scroll jank reported → Reproduce with Hitches instrument → Time Profiler: main-thread decode? layout? lock? → Check cell configure cost / Auto Layout → Check image pipeline (downsample, decode off main — Day 16) → Check search path debounce/cancel if search list → Verify with hitch rate + field device-class segment Trap: “FPS average is 58 — ship it.” Check hitch rate / p90 frame time / older devices.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. What to trace? `(45–60s)`
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

### Q19. Placement judgment (S5-A1)? `(45–60s)`
**Answer:**

> “> Provenance: How I would apply it · · journey traces vs interceptor spans.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Cardinality hygiene? `(45–60s)`
**Answer:**

> “- Prefer URL templates (/user/:id) over raw URLs in metrics - Avoid PII in trace names/attributes - Sample if needed; watch SDK overhead ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. APM SDK shape (whiteboard in 10 minutes)? `(45–60s)`
**Answer:**

> “Useful when interview pivots to “design an APM”: text App ├─ ColdStartTracker (process start → first frame) ├─ HangDetector (main ping) ├─ CustomTraces (journey API) ├─ MetricKitSubscriber └─ LocalStore (SQLite WAL) → batch GZIP upload (bg / threshold).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q22. Trade-offs table? `(45–60s)`
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

### Q23. Failure modes & gotchas? `(45–60s)`
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

### Q24. Cross-day links (light)? `(45–60s)`
**Answer:**

> “- Day 16 — image decode on main as hitch cause - Day 18 — hang/OOM vs crash; crash SDK init order vs launch budget - Day 20 — perf/CFS gates on release trains - Day 03 — ARC/cycles deep; today only Instruments correctness ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. Optional citations (end only)? `(45–60s)`
**Answer:**

> “- Apple MetricKit / Understanding hitches / App launch documentation - Repo mirror: ios-system-design/docs/app-performance-monitoring.md - Story: story-bank.md , , , This chapter remains self-contained without those opens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
