# Audio script — Sample 07 — Revision Q&A (day-17) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. How do you approach an “app feels slow” bug? `(45–60s)`

Next. Q1. How do you approach an “app feels slow” bug? `(45–60s)` Answer. First I clarify which journey feels slow and whether it’s reproducible on a desk device or only in the field. If it’s field-only, I look at Firebase Performance or MetricKit segments before guessing. If I can reproduce, I pick the right Instruments tool — Time Profiler for CPU, Hitches for scroll, App Launch for startup. I attribute the bottleneck class — compute versus wait versus layout versus memory — fix the smallest high-leverage cause, then re-check p50/p90. At BookMyShow we built that percentile culture with Firebase traces on listing, checkout, and search. Follow-ups. Only 5% of users?: Segment device/OS/network; severity × rarity.. Clean CPU profile?: Likely wait-bound — network/backend/locks.. What do you show PM?: Journey p50/p90 trend, not FPS vanity..

## §1 Q2. Why p90 over average? `(30–45s)`

Next. Q2. Why p90 over average? `(30–45s)` Answer. Averages hide the tail. The users on older devices, congested networks, or peak sale traffic live in p90 and beyond. We instrumented Firebase Performance for listing, checkout, and search and tracked p50/p90 so optimisation followed real pain, not a flattering mean. p50 still tells me the typical path; p90 tells me who is suffering. Follow-ups. When p99?: Rare critical paths; noisier on mobile.. Average FPS ship gate?: No — hitch rate / field percentiles.. How communicate to PM?: “10% of sessions slower than X.”.

## §2 Q3. Time Profiler — what do you look for? `(30–45s)`

Next. Q3. Time Profiler — what do you look for? `(30–45s)` Answer. I look for the heaviest stacks and unexpected self-time on the main thread — JSON decode, image work, regex, heavy cell configuration. I treat it as a sampling profiler, so I confirm patterns across a longer capture. After a fix I re-run to see the stack shrink. If the profile is clean but the user still waits, I stop chasing CPU and look at network or lock wait. Follow-ups. Sampling bias?: Short captures miss rare spikes — lengthen / repeat.. Signposts help how?: Align samples to journey intervals.. Release vs Debug?: Optimisations change profiles — test Release-like..

## §3 Q4. What is a hitch? `(30–45s)`

Next. Q4. What is a hitch? `(30–45s)` Answer. A hitch means a frame missed its display deadline — at 60Hz you have roughly sixteen milliseconds of main-thread budget. Scroll jank is the user-facing symptom. Classic causes are main-thread image decode, Auto Layout thrash, or synchronous I/O in cell configure. That’s different from a hang, which is a longer main-thread stall that feels like a freeze. Follow-ups. 120Hz budget?: ~8.3ms — same bugs, less margin.. First instrument?: Hitches / Animations, then Time Profiler.. Field signal?: MetricKit hitch diagnostics + device class..

## §4 Q5. MetricKit vs Firebase Performance? `(30–45s)`

Next. Q5. MetricKit vs Firebase Performance? `(30–45s)` Answer. MetricKit gives privacy-preserving OS aggregates — CPU, memory, hang and hitch related diagnostics — typically on a delayed cadence. Firebase Performance is where I define custom journey traces and network signals for product SLIs. At BookMyShow we used Firebase traces with p50/p90 on listing, checkout, and search. I use MetricKit for fleet OS truth and Firebase for journey conversations — they’re complementary, not substitutes. Follow-ups. Privacy?: Prefer aggregates; scrub custom attributes.. Realtime pager?: MetricKit isn’t your only realtime alert path.. Journey vs per-request spans?: Prefer journey-level traces; treat noisy per-request interceptor spans as secondary..

## §5 Q6. Cold start — name the phases? `(30–45s)`

Next. Q6. Cold start — name the phases? `(30–45s)` Answer. I break cold start into pre-main — dyld and static work — then app and scene initialisation, then first frame, then time-to-interactive when the U I is actually data-ready. Optimisations target fewer launch-path frameworks, deferred non-critical S D K init, and no sync disk or network on main. I measure from process start, not only didFinishLaunching. On Aces we treated splash as a server-driven product surface for freshness and cold-start experience — I talk categories and TTI mindset, not a trophy millisecond. Follow-ups. Dynamic frameworks?: dyld cost on pre-main / launch.. Crash S D K order?: Early but fast — Day 18.. TTFF vs TTI?: First pixels ≠ usable..

## §6 Q7. How do you measure checkout latency in production? `(30–45s)`

Next. Q7. How do you measure checkout latency in production? `(30–45s)` Answer. I’d define a Firebase Performance journey from a clear start — screen ready or CTA tap — to a terminal success or failure. I’d avoid turning every poll tick into its own journey. Then I watch p50/p90, segmented by network or device class when needed. That’s the pattern we used across listing, checkout, and search at BookMyShow — percentiles driving prioritisation. Follow-ups. Payment UX during delay?: Surface processing state via the payment-status popup so users aren’t staring at a silent delay.. Cardinality?: Template names; scrub PII.. Interceptor spans?: Keep journey traces primary; per-request interceptor spans are secondary for chatter..

## §7 Q8. Main-thread hang detection — concept? `(30–45s)`

Next. Q8. Main-thread hang detection — concept? `(30–45s)` Answer. A hang detector typically pings the main thread from a background helper and waits with a timeout — on the order of a few hundred milliseconds in many APM designs. If main doesn’t respond, you capture diagnostic stacks carefully and persist for later upload. You must budget overhead and ideally support a remote kill-switch. That’s observing unresponsiveness; the OS watchdog kill is a separate, harsher outcome. Follow-ups. Upload when?: Later / batched — not heavy in-signal style work.. crash free sessions relationship?: Hangs may not count as crashes — Day 18.. Threshold?: Tool-defined; know your vendor’s definition..

## §8 Q9. Binary size vs performance? `(30–45s)`

Next. Q9. Binary size vs performance? `(30–45s)` Answer. Binary size isn’t just a store listing number — it affects download time, dyld work, and page-ins that show up in launch and memory behaviour. I’d put a size budget in CI, use app thinning realities, and keep modularization from dragging unnecessary code onto the launch path. It’s a performance input, not a separate vanity metric. Follow-ups. Day 15 link?: Dynamic frameworks / modular boundaries.. Asset catalogs?: On-demand / thinning strategies.. Gate in CI?: Fail PR over budget..

## §9 Q10. Search feels laggy — checklist? `(30–45s)`

Next. Q10. Search feels laggy — checklist? `(30–45s)` Answer. I’d check debounce and cancellation so keystrokes don’t stampede the network or apply stale results — that’s the search modernisation pattern we used. Then I’d ask whether JSON parse or cell configure is on main, whether images decode on main, and whether layout is thrashing. Finally I’d look at the search journey p50/p90 so fixes are verified in the field, not just by feel. Follow-ups. Callback tasks?: Explicit cancel + generation guard.. Instruments?: Hitches + Time Profiler.. Story?: BookMyShow S D U I header/search + BookMyShow journey latency traces..

## §10 Q11. When is Instruments the wrong first tool? `(30–45s)`

Next. Q11. When is Instruments the wrong first tool? `(30–45s)` Answer. If only a slice of the fleet feels it — a device class, an OS version, a region — Instruments on my phone may waste an hour. I start with field percentiles and MetricKit-style aggregates to locate the segment, then reproduce and attribute in lab. Instruments is superb at attribution, not always at discovery. Follow-ups. Premature optimisation?: No SLI movement → don’t micro-opt.. Both needed?: Discovery field, attribution lab.. Scale context?: 30L+ daily active users → distributions matter..

## §11 Q12. LE Bottom Sheet as performance work? `(30–45s)`

Next. Q12. LE Bottom Sheet as performance work? `(30–45s)` Answer. Performance is also product architecture. The LE Bottom Sheet reduced full-screen navigations for thirty percent plus of flows — less navigation stack cost and faster access to event overview. That’s UX performance at scale, complementary to CPU profiling. I’d still keep journey traces so we don’t confuse a UX win with unrelated latency regressions. Follow-ups. How measure?: Navigation reduction metric + journey p90.. Cross-functional?: PM/Design/Backend contracts — same as LE Bottom Sheet work.. Tie journey traces?: Same percentile culture validates.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “How do you approach an “app feels slow” bug?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “How do you approach an “app feels slow” bug?” — how do you answer without jargon? `(60–90s)` Answer. “First I clarify which journey feels slow and whether it’s reproducible on a desk device or only in the field. If it’s field-only, I look at Firebase Performance or MetricKit segments before guessing. If I can reproduce, I pick the right Instruments tool — Time Profiler for CPU, Hitches for scroll, App Launch for startup. I attribute the bottleneck class — compute versus wait versus layout versus memory — fix the smallest high-leverage cause, then re-check p50/p90. At BookMyShow we built that percentile culture with Firebase traces on listing, checkout, and search.” Follow-ups. What concept is this really?: How do you approach an “app feels slow” bug. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “Why p90 over average” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Why p90 over average” just broke under load. What do you check first? `(60–90s)` Answer. “Averages hide the tail. The users on older devices, congested networks, or peak sale traffic live in p90 and beyond. We instrumented Firebase Performance for listing, checkout, and search and tracked p50/p90 so optimisation followed real pain, not a flattering mean. p50 still tells me the typical path; p90 tells me who is suffering.” Follow-ups. What concept is this really?: Why p90 over average. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Time Profiler — what do you look for”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Time Profiler — what do you look for”. How do you diagnose? `(60–90s)` Answer. “I look for the heaviest stacks and unexpected self-time on the main thread — JSON decode, image work, regex, heavy cell configuration. I treat it as a sampling profiler, so I confirm patterns across a longer capture. After a fix I re-run to see the stack shrink. If the profile is clean but the user still waits, I stop chasing CPU and look at network or lock wait.” Follow-ups. What concept is this really?: Time Profiler — what do you look for. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “What is a hitch”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “What is a hitch”. What do you say and what fix do you propose? `(60–90s)` Answer. “A hitch means a frame missed its display deadline — at 60Hz you have roughly sixteen milliseconds of main-thread budget. Scroll jank is the user-facing symptom. Classic causes are main-thread image decode, Auto Layout thrash, or synchronous I/O in cell configure. That’s different from a hang, which is a longer main-thread stall that feels like a freeze.” Follow-ups. What concept is this really?: What is a hitch. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “MetricKit vs Firebase Performance”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “MetricKit vs Firebase Performance”? `(60–90s)` Answer. “MetricKit gives privacy-preserving OS aggregates — CPU, memory, hang and hitch related diagnostics — typically on a delayed cadence. Firebase Performance is where I define custom journey traces and network signals for product SLIs. At BookMyShow we used Firebase traces with p50/p90 on listing, checkout, and search. I use MetricKit for fleet OS truth and Firebase for journey conversations — they’re complementary, not substitutes.” Follow-ups. What concept is this really?: MetricKit vs Firebase Performance. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “Cold start — name the phases.” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Cold start — name the phases.” and how you’d correct it? `(60–90s)` Answer. “I break cold start into pre-main — dyld and static work — then app and scene initialisation, then first frame, then time-to-interactive when the U I is actually data-ready. Optimisations target fewer launch-path frameworks, deferred non-critical S D K init, and no sync disk or network on main. I measure from process start, not only didFinishLaunching. On Aces we treated splash as a server-driven product surface for freshness and cold-start experience — I talk categories and TTI mindset, not a trophy millisecond.” Follow-ups. What concept is this really?: Cold start — name the phases.. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “How do you measure checkout latency in production?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “How do you measure checkout latency in production?” — how do you answer without jargon? `(60–90s)` Answer. “I’d define a Firebase Performance journey from a clear start — screen ready or CTA tap — to a terminal success or failure. I’d avoid turning every poll tick into its own journey. Then I watch p50/p90, segmented by network or device class when needed. That’s the pattern we used across listing, checkout, and search at BookMyShow — percentiles driving prioritisation.” Follow-ups. What concept is this really?: How do you measure checkout latency in production. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Main-thread hang detection — concept” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Main-thread hang detection — concept” just broke under load. What do you check first? `(60–90s)` Answer. “A hang detector typically pings the main thread from a background helper and waits with a timeout — on the order of a few hundred milliseconds in many APM designs. If main doesn’t respond, you capture diagnostic stacks carefully and persist for later upload. You must budget overhead and ideally support a remote kill-switch. That’s observing unresponsiveness; the OS watchdog kill is a separate, harsher outcome.” Follow-ups. What concept is this really?: Main-thread hang detection — concept. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. Cache invalidation trap? `(90–120s)`

Next. T1. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. Security theater vs real pinning? `(90–120s)`

Next. T2. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. SDUI unknown component in prod? `(90–120s)`

Next. T3. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. DI vs singletons under test? `(90–120s)`

Next. T4. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. Prefetch that hurts scrolling? `(90–120s)`

Next. T5. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. Actor reentrancy surprise? `(90–120s)`

Next. T6. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. They push you to invent a metric you don’t have? `(90–120s)`

Next. T7. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T8. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. They want a one-tool forever answer? `(90–120s)`

Next. T9. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T10. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
