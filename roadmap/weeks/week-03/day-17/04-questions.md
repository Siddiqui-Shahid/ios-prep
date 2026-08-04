# 04 — Questions (two-layer Q&A)

> **How to practice:** Cover **Full spoken answer**. Speak from **Answer points** only. Uncover and compare.  
> Timing: Normal ≈ 30–45s (some 45–60s) · Tricky ≈ 90–120s.  
> Totals: **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. How do you approach an “app feels slow” bug? `(45–60s)`

**Answer points:**
- Clarify journey + reproduce lab vs field-only
- Pull percentiles if field; Instruments if lab
- Attribute bottleneck class before fix
- Re-verify p50/p90
- Hook S5 culture

**Agenda opener:** “Clarify journey → lab vs field → attribute → fix → verify percentiles…”

**Full spoken answer:**
> “First I clarify which journey feels slow and whether it’s reproducible on a desk device or only in the field. If it’s field-only, I look at Firebase Performance or MetricKit segments before guessing. If I can reproduce, I pick the right Instruments tool — Time Profiler for CPU, Hitches for scroll, App Launch for startup. I attribute the bottleneck class — compute versus wait versus layout versus memory — fix the smallest high-leverage cause, then re-check p50/p90. At BookMyShow we built that percentile culture with Firebase traces on listing, checkout, and search.”

**Common wrong answer:** “Open Time Profiler and optimise the first hot function I see.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Only 5% of users? | Segment device/OS/network; severity × rarity. |
| L2 | Clean CPU profile? | Likely wait-bound — network/backend/locks. |
| L3 | What do you show PM? | Journey p50/p90 trend, not FPS vanity. |

**Provenance:** Verified · S5 · Firebase Performance culture

---

### Q2. Why p90 over average? `(30–45s)`

**Answer points:**
- Averages hide tails
- Weak devices / peak traffic live in p90+
- BMS journeys used percentiles
- p50 still useful for “typical”

**Agenda opener:** “Tail latency is where real pain lives…”

**Full spoken answer:**
> “Averages hide the tail. The users on older devices, congested networks, or peak sale traffic live in p90 and beyond. We instrumented Firebase Performance for listing, checkout, and search and tracked p50/p90 so optimisation followed real pain, not a flattering mean. p50 still tells me the typical path; p90 tells me who is suffering.”

**Common wrong answer:** “p90 is only for backend SLOs; mobile just uses FPS.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | When p99? | Rare critical paths; noisier on mobile. |
| L2 | Average FPS ship gate? | No — hitch rate / field percentiles. |
| L3 | How communicate to PM? | “10% of sessions slower than X.” |

**Provenance:** Verified · S5

---

### Q3. Time Profiler — what do you look for? `(30–45s)`

**Answer points:**
- Heaviest self-time / stacks
- Unexpected main-thread work
- Confirm after fix
- Sampling bias awareness

**Agenda opener:** “I’m hunting main-thread self-time that surprises me…”

**Full spoken answer:**
> “I look for the heaviest stacks and unexpected self-time on the main thread — JSON decode, image work, regex, heavy cell configuration. I treat it as a sampling profiler, so I confirm patterns across a longer capture. After a fix I re-run to see the stack shrink. If the profile is clean but the user still waits, I stop chasing CPU and look at network or lock wait.”

**Common wrong answer:** “Time Profiler shows network latency hotspots.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Sampling bias? | Short captures miss rare spikes — lengthen / repeat. |
| L2 | Signposts help how? | Align samples to journey intervals. |
| L3 | Release vs Debug? | Optimisations change profiles — test Release-like. |

**Provenance:** Learning-lab · Instruments

---

### Q4. What is a hitch? `(30–45s)`

**Answer points:**
- Missed frame vs vsync / deadline
- ~16ms @ 60Hz budget
- Decode/layout on main common
- ≠ hang (longer freeze)

**Agenda opener:** “A hitch is a missed frame deadline…”

**Full spoken answer:**
> “A hitch means a frame missed its display deadline — at 60Hz you have roughly sixteen milliseconds of main-thread budget. Scroll jank is the user-facing symptom. Classic causes are main-thread image decode, Auto Layout thrash, or synchronous I/O in cell configure. That’s different from a hang, which is a longer main-thread stall that feels like a freeze.”

**Common wrong answer:** “Low CPU usage means no hitches.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | 120Hz budget? | ~8.3ms — same bugs, less margin. |
| L2 | First instrument? | Hitches / Animations, then Time Profiler. |
| L3 | Field signal? | MetricKit hitch diagnostics + device class. |

**Provenance:** Learning-lab

---

### Q5. MetricKit vs Firebase Performance? `(30–45s)`

**Answer points:**
- MetricKit = OS aggregates / hangs / histograms
- Firebase = custom journey/network traces you define
- Use both
- MetricKit delayed; Firebase for product SLIs

**Agenda opener:** “OS aggregates versus product journey SLIs…”

**Full spoken answer:**
> “MetricKit gives privacy-preserving OS aggregates — CPU, memory, hang and hitch related diagnostics — typically on a delayed cadence. Firebase Performance is where I define custom journey traces and network signals for product SLIs. At BookMyShow we used Firebase traces with p50/p90 on listing, checkout, and search. I use MetricKit for fleet OS truth and Firebase for journey conversations — they’re complementary, not substitutes.”

**Common wrong answer:** “MetricKit replaces the need for custom traces.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Privacy? | Prefer aggregates; scrub custom attributes. |
| L2 | Realtime pager? | MetricKit isn’t your only realtime alert path. |
| L3 | S5-A1? | Journey traces vs noisy per-request spans. |

**Provenance:** Verified · S5 · + MetricKit teaching

---

### Q6. Cold start — name the phases. `(30–45s)`

**Answer points:**
- Pre-main → app/scene init → first frame → TTI
- Optimise dyld + defer work
- Don’t invent fake ms
- Soft S12 splash product

**Agenda opener:** “Pre-main, init, first frame, then interactive…”

**Full spoken answer:**
> “I break cold start into pre-main — dyld and static work — then app and scene initialisation, then first frame, then time-to-interactive when the UI is actually data-ready. Optimisations target fewer launch-path frameworks, deferred non-critical SDK init, and no sync disk or network on main. I measure from process start, not only didFinishLaunching. On Aces we treated splash as a server-driven product surface for freshness and cold-start experience — I talk categories and TTI mindset, not a trophy millisecond.”

**Common wrong answer:** “Cold start is just time until didFinishLaunching returns.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Dynamic frameworks? | dyld cost on pre-main / launch. |
| L2 | Crash SDK order? | Early but fast — Day 18. |
| L3 | TTFF vs TTI? | First pixels ≠ usable. |

**Provenance:** Verified · S12 · soft bridge; Learning-lab phases

---

### Q7. How do you measure checkout latency in production? `(30–45s)`

**Answer points:**
- Custom journey span appear/CTA → terminal state
- Segment network/device
- p50/p90 dashboards
- Don’t average-only

**Agenda opener:** “I’d define a journey trace with clear start and stop…”

**Full spoken answer:**
> “I’d define a Firebase Performance journey from a clear start — screen ready or CTA tap — to a terminal success or failure. I’d avoid turning every poll tick into its own journey. Then I watch p50/p90, segmented by network or device class when needed. That’s the pattern we used across listing, checkout, and search at BookMyShow — percentiles driving prioritisation.”

**Common wrong answer:** “Log print timestamps in debug builds only.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Payment UX during delay? | S7 popup — communicate state. |
| L2 | Cardinality? | Template names; scrub PII. |
| L3 | Interceptor spans? | S5-A1 — secondary for chatter. |

**Provenance:** Verified · S5 · (+ S7 if UX asked)

---

### Q8. Main-thread hang detection — concept? `(30–45s)`

**Answer points:**
- Ping main from another thread
- Threshold capture stacks
- Overhead + kill-switch
- ≠ watchdog kill itself

**Agenda opener:** “Watchdog-style ping of the main thread…”

**Full spoken answer:**
> “A hang detector typically pings the main thread from a background helper and waits with a timeout — on the order of a few hundred milliseconds in many APM designs. If main doesn’t respond, you capture diagnostic stacks carefully and persist for later upload. You must budget overhead and ideally support a remote kill-switch. That’s observing unresponsiveness; the OS watchdog kill is a separate, harsher outcome.”

**Common wrong answer:** “Hang detection is just Crashlytics.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Upload when? | Later / batched — not heavy in-signal style work. |
| L2 | CFS relationship? | Hangs may not count as crashes — Day 18. |
| L3 | Threshold? | Tool-defined; know your vendor’s definition. |

**Provenance:** Learning-lab · APM vocabulary

---

### Q9. Binary size vs performance? `(30–45s)`

**Answer points:**
- Download time + dyld + page-ins
- CI budget gates
- Thinning / modularization
- Not only “disk MB vanity”

**Agenda opener:** “Size hits download, dyld, and page-in cost…”

**Full spoken answer:**
> “Binary size isn’t just a store listing number — it affects download time, dyld work, and page-ins that show up in launch and memory behaviour. I’d put a size budget in CI, use app thinning realities, and keep modularization from dragging unnecessary code onto the launch path. It’s a performance input, not a separate vanity metric.”

**Common wrong answer:** “Size only matters for users on cellular.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Day 15 link? | Dynamic frameworks / modular boundaries. |
| L2 | Asset catalogs? | On-demand / thinning strategies. |
| L3 | Gate in CI? | Fail PR over budget. |

**Provenance:** Learning-lab

---

### Q10. Search feels laggy — checklist? `(30–45s)`

**Answer points:**
- Debounce + cancel in-flight
- Main-thread parse?
- Layout thrash / images
- Search journey traces

**Agenda opener:** “Cancel and debounce first, then profile…”

**Full spoken answer:**
> “I’d check debounce and cancellation so keystrokes don’t stampede the network or apply stale results — that’s the search modernisation pattern we used. Then I’d ask whether JSON parse or cell configure is on main, whether images decode on main, and whether layout is thrashing. Finally I’d look at the search journey p50/p90 so fixes are verified in the field, not just by feel.”

**Common wrong answer:** “Add a bigger loading spinner.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Callback tasks? | Explicit cancel + generation guard. |
| L2 | Instruments? | Hitches + Time Profiler. |
| L3 | Story? | S3 + S5. |

**Provenance:** Verified · S3 · S5

---

### Q11. When is Instruments the wrong first tool? `(30–45s)`

**Answer points:**
- Rare field-only regressions
- Need segment from MetricKit/Firebase first
- Then lab to attribute
- Avoid premature micro-opts

**Agenda opener:** “When the desk can’t see the pain…”

**Full spoken answer:**
> “If only a slice of the fleet feels it — a device class, an OS version, a region — Instruments on my phone may waste an hour. I start with field percentiles and MetricKit-style aggregates to locate the segment, then reproduce and attribute in lab. Instruments is superb at attribution, not always at discovery.”

**Common wrong answer:** “Always Instruments first — field tools are marketing.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | Premature optimisation? | No SLI movement → don’t micro-opt. |
| L2 | Both needed? | Discovery field, attribution lab. |
| L3 | Scale context? | 30L+ DAU → distributions matter. |

**Provenance:** Verified · S5 · field culture

---

### Q12. LE Bottom Sheet as performance work? `(30–45s)`

**Answer points:**
- Fewer full-screen pushes
- 30%+ flows metric
- Product perf ≠ only CPU
- Still measure journeys

**Agenda opener:** “Not all performance is Instruments…”

**Full spoken answer:**
> “Performance is also product architecture. The LE Bottom Sheet reduced full-screen navigations for thirty percent plus of flows — less navigation stack cost and faster access to event overview. That’s UX performance at scale, complementary to CPU profiling. I’d still keep journey traces so we don’t confuse a UX win with unrelated latency regressions.”

**Common wrong answer:** “If it isn’t Time Profiler, it isn’t performance.”

**Follow-up ladder:**
| Level | Ask | Point |
|---|---|---|
| L1 | How measure? | Navigation reduction metric + journey p90. |
| L2 | Cross-functional? | PM/Design/Backend contracts — S6. |
| L3 | Tie S5? | Same percentile culture validates. |

**Provenance:** Verified · S6 · (+ S5 culture)

---

## Tricky questions

### T1. “We improved average FPS — ship it?” `(90–120s)`

**Answer points:**
- Average vanity
- Hitch rate / p90 frame / MetricKit
- Device-class tails
- Refuse ship on average alone

**Trap:** Average worship.

**Full spoken answer:**
> “I wouldn’t ship on average FPS alone. Averages can look healthy while hitch rate and the slowest devices tank. I’d ask for hitch metrics, p90 frame time if we have it, and field signals segmented by device class. At scale, the tail is the product experience for a lot of people. Show me percentile movement on the journeys that matter — listing, checkout, search style SLIs — then we talk ship.”

**Follow-up:** What dashboard do you show PM? → Small SLI set, not one score.

**Provenance:** Verified · S5 · judgment

---

### T2. Trace shows network p90 high but Time Profiler clean. `(90–120s)`

**Answer points:**
- Waiting ≠ computing
- Payloads, fan-out, cache, backend
- Firebase network/journey traces help
- Don’t micro-opt UI

**Trap:** Optimise client CPU anyway.

**Full spoken answer:**
> “That’s a classic wait-bound case. A clean Time Profiler means I’m probably not CPU-bound on device — I’m waiting on network, backend queues, or lock/contention elsewhere. I’d inspect payload size, request fan-out, caching, and backend latency with the same journey traces. Client micro-optimisations won’t move that p90. Firebase Performance helps separate network time inside the journey so we don’t blame the wrong layer.”

**Follow-up:** How coordinate with backend? → Shared trace IDs / percentile ownership.

**Provenance:** Verified · S5

---

### T3. Launch regression after adding analytics SDKs. `(90–120s)`

**Answer points:**
- App Launch pre vs post main
- Defer non-critical init
- Keep crash SDK early + fast
- Feature-flag costly SDKs

**Trap:** Delete all analytics immediately as only answer.

**Full spoken answer:**
> “I’d measure with the App Launch template to see whether cost landed pre-main or post-main. Then I’d defer non-critical SDK initialisation off the first-frame path, keep crash reporting early because launch crashes matter, and make sure anything heavy is flag-gated. The answer isn’t ‘never analytics’ — it’s ordered, measured init with a launch budget. If needed we stage rollout and watch cold-start field percentiles.”

**Follow-up:** Ordering vs Day 18? → Crash SDK early; heavy SDKs later.

**Provenance:** Learning-lab · launch discipline

---

### T4. Only Android-like “ANR” thinking on iOS. `(90–120s)`

**Answer points:**
- Use hang / watchdog / main-block language
- MetricKit hang diagnostics
- Same idea: don’t block main
- Know tool thresholds

**Trap:** Copy Android terms blindly / dismiss the concept.

**Full spoken answer:**
> “I’d translate to iOS vocabulary — hangs, watchdog kills, main-thread stalls — rather than forcing ANR as a term. The engineering idea is the same: don’t block main. MetricKit hang diagnostics and an APM hang detector are how we observe it. I also separate hitches — frame misses — from longer hangs. Thresholds are tool-defined; I learn the vendor’s definition instead of pretending there’s one universal number.”

**Follow-up:** 250ms vs multi-second? → Detector vs OS kill vs UX freeze.

**Provenance:** Learning-lab

---

### T5. p50 improved, p90 worsened after caching. `(90–120s)`

**Answer points:**
- Don’t celebrate p50 alone
- Stampede / locks / miss penalty
- Main-thread disk on miss
- Inspect miss path distribution

**Trap:** Ship because median looks great.

**Full spoken answer:**
> “That’s a red flag that the cache helps the happy path and punishes the miss path or creates contention. I’d look for stampede on expiry, lock contention around the cache, or main-thread disk hits on miss — especially if decode landed on main. p50 can improve while p90 burns. I’d profile the miss path and watch field p90 until both move the right way — same discipline we used for journey percentiles.”

**Follow-up:** Day 16 decode on miss? → Off-main decode + downsample.

**Provenance:** Verified · S5 · judgment

---

### T6. How much overhead may an APM SDK add? `(90–120s)`

**Answer points:**
- Budget it; literature ~1% class targets
- Batch uploads; sample
- Kill-switch
- Never sync I/O on crash-free path casually

**Trap:** “Negligible always.”

**Full spoken answer:**
> “I treat APM overhead as a first-class NFR, not vibes. You budget CPU and wakeups, batch and compress uploads, sample where needed, and keep a remote kill-switch. You don’t do synchronous network on the hot path, and you especially don’t make the crash-free experience worse with a chatty telemetry layer. If overhead shows in launch or hitch metrics, the observability tool became the problem.”

**Follow-up:** Design batch uploader? → SQLite WAL buffer → GZIP → bg upload.

**Provenance:** Learning-lab · APM NFR

---

### T7. Scroll jank only on older devices — ship to 100%? `(90–120s)`

**Answer points:**
- Segment MetricKit / field by device class
- Protect tails
- Gated rollout
- More aggressive downsample on memory class

**Trap:** “Most users are fine.”

**Full spoken answer:**
> “I wouldn’t shrug off older-device tails at consumer scale. I’d segment field hitch and journey metrics by device class, protect those tails with gated rollout, and tune the image/layout path more aggressively on lower memory classes. Shipping to 100% because flagship devices are smooth is how you donate one-star reviews. Percentile culture means the slow cohort still counts.”

**Follow-up:** Phased release + gates? → Day 20 / Day 18 pause criteria.

**Provenance:** Verified · S5 · scale judgment

---

### T8. Stakeholder wants a single “performance score.” `(90–120s)`

**Answer points:**
- Offer small SLI set
- Cold start p90, journey p90, hitch, CFS
- Composite hides actionability
- BMS percentile conversations

**Trap:** One number to rule them all.

**Full spoken answer:**
> “I’d push back gently and offer a small SLI set instead — cold-start p90, critical journey p90 like checkout, hitch rate, and crash-free as a reliability sibling. A single composite score hides which lever to pull and invites gaming. At BookMyShow we moved conversations to journey percentiles for listing, checkout, and search — that’s actionable for PM and engineering. Scores are fine as executive summaries only if the underlying SLIs stay visible.”

**Follow-up:** How you ran BMS conversations? → S5 STAR.

**Provenance:** Verified · S5

---

## Timed set recommendation

Record: **Q1, Q2, Q6** + **T2, T5**. Then deliver **S5** in ≤3 min with explicit p50/p90 language.
