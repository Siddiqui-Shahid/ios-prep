# Sample 07 — Revision Q&A (day-17) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. How do you approach an “app feels slow” bug? `(45–60s)`
**Answer:**

> First I clarify which journey feels slow and whether it’s reproducible on a desk device or only in the field. If it’s field-only, I look at Firebase Performance or MetricKit segments before guessing. If I can reproduce, I pick the right Instruments tool — Time Profiler for CPU, Hitches for scroll, App Launch for startup. I attribute the bottleneck class — compute versus wait versus layout versus memory — fix the smallest high-leverage cause, then re-check p50/p90. At BookMyShow we built that percentile culture with Firebase traces on listing, checkout, and search.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Only 5% of users? | Segment device/OS/network; severity × rarity. |
| Clean CPU profile? | Likely wait-bound — network/backend/locks. |
| What do you show PM? | Journey p50/p90 trend, not FPS vanity. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. Why p90 over average? `(30–45s)`
**Answer:**

> Averages hide the tail. The users on older devices, congested networks, or peak sale traffic live in p90 and beyond. We instrumented Firebase Performance for listing, checkout, and search and tracked p50/p90 so optimisation followed real pain, not a flattering mean. p50 still tells me the typical path; p90 tells me who is suffering.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When p99? | Rare critical paths; noisier on mobile. |
| Average FPS ship gate? | No — hitch rate / field percentiles. |
| How communicate to PM? | “10% of sessions slower than X.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. Time Profiler — what do you look for? `(30–45s)`
**Answer:**

> I look for the heaviest stacks and unexpected self-time on the main thread — JSON decode, image work, regex, heavy cell configuration. I treat it as a sampling profiler, so I confirm patterns across a longer capture. After a fix I re-run to see the stack shrink. If the profile is clean but the user still waits, I stop chasing CPU and look at network or lock wait.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sampling bias? | Short captures miss rare spikes — lengthen / repeat. |
| Signposts help how? | Align samples to journey intervals. |
| Release vs Debug? | Optimisations change profiles — test Release-like. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is a hitch? `(30–45s)`
**Answer:**

> A hitch means a frame missed its display deadline — at 60Hz you have roughly sixteen milliseconds of main-thread budget. Scroll jank is the user-facing symptom. Classic causes are main-thread image decode, Auto Layout thrash, or synchronous I/O in cell configure. That’s different from a hang, which is a longer main-thread stall that feels like a freeze.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 120Hz budget? | ~8.3ms — same bugs, less margin. |
| First instrument? | Hitches / Animations, then Time Profiler. |
| Field signal? | MetricKit hitch diagnostics + device class. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. MetricKit vs Firebase Performance? `(30–45s)`
**Answer:**

> MetricKit gives privacy-preserving OS aggregates — CPU, memory, hang and hitch related diagnostics — typically on a delayed cadence. Firebase Performance is where I define custom journey traces and network signals for product SLIs. At BookMyShow we used Firebase traces with p50/p90 on listing, checkout, and search. I use MetricKit for fleet OS truth and Firebase for journey conversations — they’re complementary, not substitutes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Privacy? | Prefer aggregates; scrub custom attributes. |
| Realtime pager? | MetricKit isn’t your only realtime alert path. |
| Journey vs per-request spans? | Prefer journey-level traces; treat noisy per-request interceptor spans as secondary. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Cold start — name the phases? `(30–45s)`
**Answer:**

> I break cold start into pre-main — dyld and static work — then app and scene initialisation, then first frame, then time-to-interactive when the UI is actually data-ready. Optimisations target fewer launch-path frameworks, deferred non-critical SDK init, and no sync disk or network on main. I measure from process start, not only didFinishLaunching. On Aces we treated splash as a server-driven product surface for freshness and cold-start experience — I talk categories and TTI mindset, not a trophy millisecond.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Dynamic frameworks? | dyld cost on pre-main / launch. |
| Crash SDK order? | Early but fast — Day 18. |
| TTFF vs TTI? | First pixels ≠ usable. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. How do you measure checkout latency in production? `(30–45s)`
**Answer:**

> I’d define a Firebase Performance journey from a clear start — screen ready or CTA tap — to a terminal success or failure. I’d avoid turning every poll tick into its own journey. Then I watch p50/p90, segmented by network or device class when needed. That’s the pattern we used across listing, checkout, and search at BookMyShow — percentiles driving prioritisation.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Payment UX during delay? | Surface processing state via the payment-status popup so users aren’t staring at a silent delay. |
| Cardinality? | Template names; scrub PII. |
| Interceptor spans? | Keep journey traces primary; per-request interceptor spans are secondary for chatter. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces; BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q8. Main-thread hang detection — concept? `(30–45s)`
**Answer:**

> A hang detector typically pings the main thread from a background helper and waits with a timeout — on the order of a few hundred milliseconds in many APM designs. If main doesn’t respond, you capture diagnostic stacks carefully and persist for later upload. You must budget overhead and ideally support a remote kill-switch. That’s observing unresponsiveness; the OS watchdog kill is a separate, harsher outcome.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Upload when? | Later / batched — not heavy in-signal style work. |
| CFS relationship? | Hangs may not count as crashes — Day 18. |
| Threshold? | Tool-defined; know your vendor’s definition. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Binary size vs performance? `(30–45s)`
**Answer:**

> Binary size isn’t just a store listing number — it affects download time, dyld work, and page-ins that show up in launch and memory behaviour. I’d put a size budget in CI, use app thinning realities, and keep modularization from dragging unnecessary code onto the launch path. It’s a performance input, not a separate vanity metric.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 15 link? | Dynamic frameworks / modular boundaries. |
| Asset catalogs? | On-demand / thinning strategies. |
| Gate in CI? | Fail PR over budget. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Search feels laggy — checklist? `(30–45s)`
**Answer:**

> I’d check debounce and cancellation so keystrokes don’t stampede the network or apply stale results — that’s the search modernisation pattern we used. Then I’d ask whether JSON parse or cell configure is on main, whether images decode on main, and whether layout is thrashing. Finally I’d look at the search journey p50/p90 so fixes are verified in the field, not just by feel.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Callback tasks? | Explicit cancel + generation guard. |
| Instruments? | Hitches + Time Profiler. |
| Story? | BookMyShow SDUI header/search + BookMyShow journey latency traces. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q11. When is Instruments the wrong first tool? `(30–45s)`
**Answer:**

> If only a slice of the fleet feels it — a device class, an OS version, a region — Instruments on my phone may waste an hour. I start with field percentiles and MetricKit-style aggregates to locate the segment, then reproduce and attribute in lab. Instruments is superb at attribution, not always at discovery.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Premature optimisation? | No SLI movement → don’t micro-opt. |
| Both needed? | Discovery field, attribution lab. |
| Scale context? | 30L+ DAU → distributions matter. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q12. LE Bottom Sheet as performance work? `(30–45s)`
**Answer:**

> Performance is also product architecture. The LE Bottom Sheet reduced full-screen navigations for thirty percent plus of flows — less navigation stack cost and faster access to event overview. That’s UX performance at scale, complementary to CPU profiling. I’d still keep journey traces so we don’t confuse a UX win with unrelated latency regressions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How measure? | Navigation reduction metric + journey p90. |
| Cross-functional? | PM/Design/Backend contracts — same as LE Bottom Sheet work. |
| Tie journey traces? | Same percentile culture validates. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “How do you approach an “app feels slow” bug?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “First I clarify which journey feels slow and whether it’s reproducible on a desk device or only in the field. If it’s field-only, I look at Firebase Performance or MetricKit segments before guessing. If I can reproduce, I pick the right Instruments tool — Time Profiler for CPU, Hitches for scroll, App Launch for startup. I attribute the bottleneck class — compute versus wait versus layout versus memory — fix the smallest high-leverage cause, then re-check p50/p90. At BookMyShow we built that percentile culture with Firebase traces on listing, checkout, and search.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you approach an “app feels slow” bug |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “Why p90 over average” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Averages hide the tail. The users on older devices, congested networks, or peak sale traffic live in p90 and beyond. We instrumented Firebase Performance for listing, checkout, and search and tracked p50/p90 so optimisation followed real pain, not a flattering mean. p50 still tells me the typical path; p90 tells me who is suffering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Why p90 over average |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “Time Profiler — what do you look for”. How do you diagnose? `(60–90s)`
**Answer:**

> “I look for the heaviest stacks and unexpected self-time on the main thread — JSON decode, image work, regex, heavy cell configuration. I treat it as a sampling profiler, so I confirm patterns across a longer capture. After a fix I re-run to see the stack shrink. If the profile is clean but the user still waits, I stop chasing CPU and look at network or lock wait.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Time Profiler — what do you look for |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “What is a hitch”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “A hitch means a frame missed its display deadline — at 60Hz you have roughly sixteen milliseconds of main-thread budget. Scroll jank is the user-facing symptom. Classic causes are main-thread image decode, Auto Layout thrash, or synchronous I/O in cell configure. That’s different from a hang, which is a longer main-thread stall that feels like a freeze.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is a hitch |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “MetricKit vs Firebase Performance”? `(60–90s)`
**Answer:**

> “MetricKit gives privacy-preserving OS aggregates — CPU, memory, hang and hitch related diagnostics — typically on a delayed cadence. Firebase Performance is where I define custom journey traces and network signals for product SLIs. At BookMyShow we used Firebase traces with p50/p90 on listing, checkout, and search. I use MetricKit for fleet OS truth and Firebase for journey conversations — they’re complementary, not substitutes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | MetricKit vs Firebase Performance |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “Cold start — name the phases.” and how you’d correct it? `(60–90s)`
**Answer:**

> “I break cold start into pre-main — dyld and static work — then app and scene initialisation, then first frame, then time-to-interactive when the UI is actually data-ready. Optimisations target fewer launch-path frameworks, deferred non-critical SDK init, and no sync disk or network on main. I measure from process start, not only didFinishLaunching. On Aces we treated splash as a server-driven product surface for freshness and cold-start experience — I talk categories and TTI mindset, not a trophy millisecond.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Cold start — name the phases. |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “How do you measure checkout latency in production?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I’d define a Firebase Performance journey from a clear start — screen ready or CTA tap — to a terminal success or failure. I’d avoid turning every poll tick into its own journey. Then I watch p50/p90, segmented by network or device class when needed. That’s the pattern we used across listing, checkout, and search at BookMyShow — percentiles driving prioritisation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you measure checkout latency in production |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “Main-thread hang detection — concept” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “A hang detector typically pings the main thread from a background helper and waits with a timeout — on the order of a few hundred milliseconds in many APM designs. If main doesn’t respond, you capture diagnostic stacks carefully and persist for later upload. You must budget overhead and ideally support a remote kill-switch. That’s observing unresponsiveness; the OS watchdog kill is a separate, harsher outcome.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Main-thread hang detection — concept |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. They push you to invent a metric you don’t have? `(90–120s)`
**Answer:**

> “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
