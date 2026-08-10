# Audio script — Sample 07 — Revision Q&A (day-18) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. How does Crashlytics get a readable stack? `(30–45s)`

Next. Q1. How does Crashlytics get a readable stack? `(30–45s)` Answer. The client persists a crash report with addresses and the build UUID, then uploads on a later launch. The backend matches that UUID to a dSYM and symbolicates frames into functions and lines. If CI forgets to upload symbols, triage sees unreadable stacks — so dSYM upload is part of the release pipeline, not a local-only step. Follow-ups. Bitcode legacy?: Modern: always upload dSYMs you ship.. App Store Connect vs Firebase?: Both can matter — know your pipeline.. Re-upload?: Possible for missing symbols on a build..

## §1 Q2. What is async-signal-safe and why care? `(30–45s)`

Next. Q2. What is async-signal-safe and why care? `(30–45s)` Answer. Async-signal-safe means only a tiny set of operations are legal inside a signal handler. You can’t malloc, take locks, or call into Objective-C or much of the Swift runtime — those can deadlock or crash again. So we preallocate a crash buffer at init and write with safe primitives. The goal is persist-the-report, not a full-featured logger in-handler. Follow-ups. What can you call?: Limited async-signal-safe syscalls.. Breadcrumbs?: Filled on happy path into lock-free ring.. Upload in handler?: No — next launch..

## §2 Q3. Breadcrumbs — what do you log? `(30–45s)`

Next. Q3. Breadcrumbs — what do you log? `(30–45s)` Answer. I keep a short ring of recent navigations, key user actions, and coarse network status codes — enough to reconstruct the path to a crash. Tokens and PII get scrubbed at the source. The buffer is designed so a crash mid-write doesn’t depend on taking locks casually. Breadcrumbs are context, not a second analytics product. Follow-ups. Why ring?: Bound memory; last-N relevance.. Privacy Sev?: Rotate credentials; treat as incident.. SQLite in handler?: No — happy-path only..

## §3 Q4. Crash vs OOM vs hang? `(30–45s)`

Next. Q4. Crash vs OOM vs hang? `(30–45s)` Answer. A crash is a fatal signal or uncaught fatal path we can often report with a stack. OOM is frequently jetsam — SIGKILL territory — so we lean on heuristics and MetricKit exit reasons. A hang is the main thread stuck; users feel a freeze even when crash-free looks fine. I refuse to treat those as one bucket. Follow-ups. Day 17 hang detector?: Ping main; threshold capture.. Cycles tool?: Graph/Allocations, not Leaks.. crash free sessions gap?: Freezes can hide under healthy crash free sessions..

## §4 Q5. CFS drop during a sale — response? `(45–60s)`

Next. Q5. CFS drop during a sale — response? `(45–60s)` Answer. I’d run I M O C playbook: confirm the spike is real, declare ownership and a channel, map blast radius by version and feature, then mitigate — pause phased release or kill-switch the path — before perfect root cause. Cadence communications to stakeholders, ship a fix or hotfix as needed, and write a blameless postmortem with alert and test actions. That’s how we operated P0/P1s at BookMyShow scale. Follow-ups. Who do you page?: i O S + backend + QA as needed.. Flag vs hotfix?: Flag when possible; hotfix if mandatory native path.. Story?: BookMyShow I M O C / crash free sessions incident response..

## §5 Q6. How do you talk about 99.95% CFS? `(30–45s)`

Next. Q6. How do you talk about 99.95% CFS? `(30–45s)` Answer. I talk about it as a sustained operational bar at thirty-plus lakh daily active users — Crashlytics triage workflows plus I M O C during peak events, backed by engineering fixes across the app. It’s not a vanity slide from one PR. When I mention synchronised dictionaries, I frame them as removing race crashes on a specific shared-state path — a contributor to reliability, not the sole cause of ninety-nine point nine five. Follow-ups. What threatens crash free sessions next?: New S D K, races, missing dSYM, bad rollout.. Hangs?: Separate metrics.. synchronised dictionaries role?: BookMyShow synchronised dictionaries are path-scoped reliability — not the whole crash free sessions story..

## §6 Q7. Crash only on iOS beta, 2% users — ship? `(30–45s)`

Next. Q7. Crash only on iOS beta, 2% users — ship? `(30–45s)` Answer. I multiply severity by rarity. Two percent on a beta might be trackable if it’s a non-critical screen. If it’s checkout or payments, I mitigate immediately — flag, pause, or block the path — even at low percentage. Rare times critical still makes P0. Follow-ups. How do you weigh severity vs rarity?: Severity × rarity: rare-but-checkout-critical still ships as P0 mitigation even at ~2%.. When is beta-only enough to wait?: Only if the path is non-critical and trackable; otherwise flag/pause before waiting on OS fixes..

## §7 Q8. dSYM missing — symptoms? `(30–45s)`

Next. Q8. dSYM missing — symptoms? `(30–45s)` Answer. You see addresses instead of symbols, triage slows to a crawl, and duplicate issues fragment. The fix is pipeline discipline — upload dSYMs for every shipped build and re-upload if a build slipped through. I treat missing symbols as an incident for the reliability process, not a ‘Swift bug.’ Follow-ups. What do triage engineers see?: Addresses instead of symbols, slow grouping, and fragmented duplicate issues.. How do you remediate?: Upload dSYMs for every shipped build and re-upload any build that slipped the pipeline..

## §8 Q9. How did synchronised dictionaries help CFS? `(30–45s)`

Next. Q9. How did synchronised dictionaries help CFS? `(30–45s)` Answer. Shared dictionaries were hit from multiple queues, which caused intermittent race crashes. We serialized access with G C D serial queues and read-write locks behind a safe A P I so call sites couldn’t touch raw storage. That eliminated concurrent-access crashes on that path and improved reliability. I don’t claim that fix alone produced our ninety-nine point nine five crash-free rate — that bar was sustained by triage, I M O C, and many fixes. Follow-ups. Actor today?: For greenfield shared maps, prefer a Swift actor (SafeDict design) over sprinkling locks.. How validate?: Concurrency stress + Crashlytics watch.. Sprinkle locks?: No — boundary A P I..

## §9 Q10. Non-fatals flooding the dashboard? `(30–45s)`

Next. Q10. Non-fatals flooding the dashboard? `(30–45s)` Answer. I’d sample and group, fix the top noisy offenders, and keep non-fatals conceptually separate from crash-free sessions. If a non-fatal represents broken checkout UX, I escalate on user impact even without a fatal. Volume alone isn’t severity. Follow-ups. How do you cut noise?: Sample and group, fix the top noisy offenders, and keep non-fatals separate from crash-free.. When escalate a non-fatal?: When user impact is checkout-breaking even without a fatal crash..

## §10 Q11. What belongs in a crash postmortem? `(30–45s)`

Next. Q11. What belongs in a crash postmortem? `(30–45s)` Answer. Timeline, user impact, root cause, what mitigation bought us time, and concrete action items — tests, alerts, runbooks — written blamelessly. The goal is preventing repeat, not finding a villain. That’s part of how I M O C closes the loop. Follow-ups. What sections are mandatory?: Timeline, impact, root cause, mitigation, and blameless action items for tests/alerts/runbooks.. What’s the goal?: Prevent repeat failures — close the I M O C loop, not assign blame..

## §11 Q12. Crash SDK before analytics? `(30–45s)`

Next. Q12. Crash SDK before analytics? `(30–45s)` Answer. I prefer crash reporting early so launch failures still report, but initialisation must stay cheap. Heavy analytics and non-critical SDKs defer off the first-frame path. Reliability and launch performance are a joint budget, not a fight. Follow-ups. Why early crash S D K?: So launch failures still report — but init must stay cheap on the first-frame path.. What defers?: Heavy analytics and non-critical SDKs move off the cold-start critical path.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “How does Crashlytics get a readable stack?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “How does Crashlytics get a readable stack?” — how do you answer without jargon? `(60–90s)` Answer. “The client persists a crash report with addresses and the build UUID, then uploads on a later launch. The backend matches that UUID to a dSYM and symbolicates frames into functions and lines. If CI forgets to upload symbols, triage sees unreadable stacks — so dSYM upload is part of the release pipeline, not a local-only step.” Follow-ups. What concept is this really?: How does Crashlytics get a readable stack. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “What is async-signal-safe and why care” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “What is async-signal-safe and why care” just broke under load. What do you check first? `(60–90s)` Answer. “Async-signal-safe means only a tiny set of operations are legal inside a signal handler. You can’t malloc, take locks, or call into Objective-C or much of the Swift runtime — those can deadlock or crash again. So we preallocate a crash buffer at init and write with safe primitives. The goal is persist-the-report, not a full-featured logger in-handler.” Follow-ups. What concept is this really?: What is async-signal-safe and why care. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Breadcrumbs — what do you log”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Breadcrumbs — what do you log”. How do you diagnose? `(60–90s)` Answer. “I keep a short ring of recent navigations, key user actions, and coarse network status codes — enough to reconstruct the path to a crash. Tokens and PII get scrubbed at the source. The buffer is designed so a crash mid-write doesn’t depend on taking locks casually. Breadcrumbs are context, not a second analytics product.” Follow-ups. What concept is this really?: Breadcrumbs — what do you log. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “Crash vs OOM vs hang”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Crash vs OOM vs hang”. What do you say and what fix do you propose? `(60–90s)` Answer. “A crash is a fatal signal or uncaught fatal path we can often report with a stack. OOM is frequently jetsam — SIGKILL territory — so we lean on heuristics and MetricKit exit reasons. A hang is the main thread stuck; users feel a freeze even when crash-free looks fine. I refuse to treat those as one bucket.” Follow-ups. What concept is this really?: Crash vs OOM vs hang. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “CFS drop during a sale — response”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “CFS drop during a sale — response”? `(60–90s)` Answer. “I’d run I M O C playbook: confirm the spike is real, declare ownership and a channel, map blast radius by version and feature, then mitigate — pause phased release or kill-switch the path — before perfect root cause. Cadence communications to stakeholders, ship a fix or hotfix as needed, and write a blameless postmortem with alert and test actions. That’s how we operated P0/P1s at BookMyShow scale.” Follow-ups. What concept is this really?: crash free sessions drop during a sale — response. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “How do you talk about 99.95% CFS” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “How do you talk about 99.95% CFS” and how you’d correct it? `(60–90s)` Answer. “I talk about it as a sustained operational bar at thirty-plus lakh daily active users — Crashlytics triage workflows plus I M O C during peak events, backed by engineering fixes across the app. It’s not a vanity slide from one PR. When I mention synchronised dictionaries, I frame them as removing race crashes on a specific shared-state path — a contributor to reliability, not the sole cause of ninety-nine point nine five.” Follow-ups. What concept is this really?: How do you talk about 99.95% crash free sessions. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “Crash only on iOS beta, 2% users — ship?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Crash only on iOS beta, 2% users — ship?” — how do you answer without jargon? `(60–90s)` Answer. “I multiply severity by rarity. Two percent on a beta might be trackable if it’s a non-critical screen. If it’s checkout or payments, I mitigate immediately — flag, pause, or block the path — even at low percentage. Rare times critical still makes P0.” Follow-ups. What concept is this really?: Crash only on i O S beta, 2% users — ship. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “dSYM missing — symptoms” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “dSYM missing — symptoms” just broke under load. What do you check first? `(60–90s)` Answer. “You see addresses instead of symbols, triage slows to a crawl, and duplicate issues fragment. The fix is pipeline discipline — upload dSYMs for every shipped build and re-upload if a build slipped through. I treat missing symbols as an incident for the reliability process, not a ‘Swift bug.’.” Follow-ups. What concept is this really?: dSYM missing — symptoms. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. Security theater vs real pinning? `(90–120s)`

Next. T1. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. SDUI unknown component in prod? `(90–120s)`

Next. T2. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. DI vs singletons under test? `(90–120s)`

Next. T3. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. Prefetch that hurts scrolling? `(90–120s)`

Next. T4. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. Actor reentrancy surprise? `(90–120s)`

Next. T5. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. They push you to invent a metric you don’t have? `(90–120s)`

Next. T6. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T7. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. They want a one-tool forever answer? `(90–120s)`

Next. T8. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T9. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. Main-thread rule under pressure? `(90–120s)`

Next. T10. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
