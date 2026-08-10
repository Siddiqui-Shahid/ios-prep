# Audio script — Sample 07 — Revision Q&A (day-07) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. struct vs class — when do you choose each?

Next. Q1. struct vs class — when do you choose each? Answer. Struct for models and state you want copied by default — value semantics, less accidental shared mutation. Class when you need identity, inheritance (UIKit), or reference sharing. Payment states as enums with associated values (Design: payment status pattern (not shipped) design) fit value types. Say “value semantics” and one UIKit class example. Follow-ups. Enum with associated values?: Value type — good for closed state machines.. UIView model?: Class — UIKit hierarchy requires it.. copy on write related?: Structs may share storage until mutated — next card..

## §1 Q2. What is copy-on-write (COW)?

Next. Q2. What is copy-on-write (COW)? Answer. Swift value types may share backing storage until one copy mutates — then copy happens. Saves memory for large arrays/dicts passed around read-only. Trap: isKnownUniquelyReferenced / holding shared mutable buffers through class wrappers can surprise you. One sentence is enough in warm-up. Follow-ups. Always a full copy on assign?: No — copy on write, not on assign.. Interview depth today?: Definition + “mutation triggers copy” suffices in warm-up.. Deep pool?: copy on write uniqueness traps — see deep section in 04..

## §2 Q3. POP in the ads pipeline — one minute?

Next. Q3. POP in the ads pipeline — one minute? Answer. Protocol-oriented design: capabilities (render, track) instead of a deep AdView subclass tree. Generic pipeline over AdRenderable; type erasure at boundaries when mixing concrete types. Verified BookMyShow Ads pipeline + HeroWidget lifecycle: new creatives plug in without forking revenue path. No invented fill-rate metrics. Follow-ups. Generics vs associated type?: Caller picks T; adopter picks associated type.. Type erasure cost?: Allocation + indirection + lost specialization.. Optional encore today?: BookMyShow Ads pipeline + HeroWidget lifecycle ≤5 min preview Mock #2..

## §3 Q4. weak vs unowned — one sentence each?

Next. Q4. weak vs unowned — one sentence each? Answer. Weak does not keep alive; optional; zeroes to nil — use when the other object may die first (async U I, network callbacks). Unowned does not keep alive; not optional; crashes if used after deinit — only when lifetime is provably shorter. Default interview stance: [weak self] for escaping work. Follow-ups. Memory Graph vs Leaks?: Graph finds cycles (reachable abandoned); Leaks finds unreachable memory.. Timer trap?: Target-selector retains target until invalidate.. BookMyShow I M O C + crash-free at scale tie-in?: Reliability culture — do not invent Memory Graph war stories..

## §4 Q5. Serial vs concurrent queue?

Next. Q5. Serial vs concurrent queue? Answer. Serial: one task at a time — order preserved; good for protecting mutable state. Concurrent: multiple tasks run — order not guaranteed unless you add barriers or external sync. SafeDict uses a serial queue so dictionary mutations never overlap. Main queue is serial — deadlock risk on nested sync. Follow-ups. Reader-writer?: Concurrent queue + barrier writes — read many, write exclusive.. Main-queue deadlock?: DispatchQueue.main.sync from main thread hangs forever.. vs actor?: Actor serializes access with async/await — Day 05..

## §5 Q6. async/await vs GCD — when which?

Next. Q6. async/await vs GCD — when which? Answer. G C D is queue-based callbacks — still everywhere in UIKit legacy. async/await structures suspension and errors in Swift concurrency — better for new modules. Production BookMyShow synchronised dictionaries was G C D; Design: actor SafeDict (not shipped) says you’d expose an actor today with await. Do not claim a full prod rewrite unless verified. Follow-ups. Actor reentrancy?: After await, another task may run on the actor — state can change.. Task cancellation?: Cooperative — check Task.isCancelled at suspension points.. Sendable?: Types safe to pass across concurrency domains..

## §6 Q7. Thread-safe dictionary — 60s design?

Next. Q7. Thread-safe dictionary — 60s design? Answer. Hide storage behind a serial queue A P I (or actor today): get/set/snapshot methods dispatch work so callers cannot race the raw dictionary. Avoid sync re-entry on the same queue. Mention async-write / sync-read visibility caveat if asked. Verified BookMyShow synchronised dictionaries is the production proof point. Follow-ups. Why hide the queue?: Call sites cannot forget to synchronize — fewer races.. final class wrapper?: Common pattern for reference-type container.. Migration?: Parallel actor façade — deep pool D4..

## §7 Q8. DSA from Day 06 — what to recall today?

Next. Q8. DSA from Day 06 — what to recall today? Answer. Say-this-first: clarify → brute → optimize → edges. Pattern IDs: hash, opposite pointers, variable window, Kadane, prefix/suffix, write pointer. Swift String: not O(1) index — state cost. Light D S A block today — one timed problem, not a full contest. Communication grade silent clever solve. Follow-ups. Minimum 8 problems?: From Day 06 — recall names + pattern, not full re-solve all.. Mock includes coding?: Mock #1 is concurrency/memory/high level design — D S A is light exercise 5.. Flashcard deck?:../../../flashcards/week-01.md.

## §8 Q9. What is the ≤20s elevator pitch for BookMyShow synchronised dictionaries?

Next. Q9. What is the ≤20s elevator pitch for BookMyShow synchronised dictionaries? Answer. “We gated shared dictionaries behind a serial queue A P I so call sites couldn’t race the storage — crashes went away on that path.” Label BookMyShow synchronised dictionaries · BookMyShow · synchronised dictionaries. Do not claim sole ownership of 99.95% crash free sessions from this story alone. Follow-ups. Must-not?: Fake crash-percent drop you cannot prove.. Scale context?: 30L+ daily active users / crash free sessions culture is BookMyShow I M O C + crash-free at scale — cite softly, do not paste onto every beat.. vs generic “I fixed a race”?: Named mechanism: serial A P I around shared dicts..

## §9 Q10. Walk the ≤3 min STAR beats?

Next. Q10. Walk the ≤3 min STAR beats? Answer. Situation: Shared dictionaries accessed from many threads on a high-traffic path — intermittent races/crashes. Task: Stop callers from touching unsynchronized storage. Action: Serial queue (or RW pattern) behind get/set/snapshot A P I; stress testing; Crashlytics to confirm path fixed. Result: Crashes eliminated on that path — qualitative, path-specific. Lesson: Hide concurrency; don’t trust every call site to dispatch correctly. Follow-ups. Missing beat?: Interviewer scores STAR table in deep dive — fill each row.. Crashlytics role?: Confirm fix on the affected crash signature — not invented %.. Actor coda?: One sentence at end — leads to Design: actor SafeDict (not shipped) follow-up..

## §10 Q11. Required follow-up: “How would you design this today?”?

Next. Q11. Required follow-up: “How would you design this today?”? Answer. Design: actor SafeDict (not shipped): Expose an actor with the same get/set/snapshot surface — callers await; isolation moves into the type system. Production was G C D; this is migration language, not “we rewrote everything as actors last quarter.” Follow-ups. Named-case label?: Say “Applied” or “how I’d apply it” — not Verified for actor rewrite.. A P I surface?: Keep safe methods — don’t expose raw dict + external locks.. Big-bang?: Module-by-module façade — deep pool D4..

## §11 Q12. Why hide the queue instead of documenting “always dispatch here”?

Next. Q12. Why hide the queue instead of documenting “always dispatch here”? Answer. Documentation does not survive scale — new call sites forget, copy-paste wrong queue, or mix sync/async. An A P I forces synchronization at compile/link boundaries. Same reason actors beat “please don’t touch my dict”: the type enforces the contract. Follow-ups. Performance?: Serial queue contention — acceptable vs data races on hot path fix.. Reader-writer variant?: Many reads, barrier writes — if profiling showed read dominance.. Test strategy?: Stress + thread sanitizer mindset — path-specific validation..

## §12 Q13. What must you NOT claim in BookMyShow synchronised dictionaries?

Next. Q13. What must you NOT claim in BookMyShow synchronised dictionaries? Answer. Do not invent fill-rate, crash-percent, or “I single-handedly raised crash free sessions to 99.95%.” Do not say Memory Graph was your primary prod tool unless labeled Applied. Honest result: path-specific crash reduction after serializing dictionary access. Use BookMyShow I M O C + crash-free at scale only for scale/reliability culture context. Follow-ups. Interviewer cut line?: “Don’t invent a metric — what’s the honest result?”. Qualitative OK?: Yes — “crashes on this signature stopped” is strong.. BookMyShow Ads pipeline + HeroWidget lifecycle confusion?: BookMyShow Ads pipeline + HeroWidget lifecycle is ads P O P — different story; optional encore..

## §13 Q14. How is BookMyShow IMOC + crash-free at scale adjacent without stealing the story?

Next. Q14. How is BookMyShow IMOC + crash-free at scale adjacent without stealing the story? Answer. When asked why races matter at BMS scale: 30L+ daily active users, 99.95%+ crash-free culture, Crashlytics / I M O C — BookMyShow I M O C + crash-free at scale. One or two sentences max. Do not paste crash free sessions onto every answer or imply BookMyShow synchronised dictionaries alone delivered company-wide crash free sessions. Follow-ups. I M O C?: Incident management on-call culture — reliability spine.. Every mock answer?: No — use when risk/scale question appears.. vs BookMyShow synchronised dictionaries result?: BookMyShow synchronised dictionaries = specific fix; BookMyShow I M O C + crash-free at scale = environment why it mattered..

## §14 Q15. Score yourself on BookMyShow synchronised dictionaries — what earns a 4 or 5?

Next. Q15. Score yourself on BookMyShow synchronised dictionaries — what earns a 4 or 5? Answer. 4: On time (≤3 min), clear STAR, trade-off or prod hook, honest provenance. 5: All of 4 + crisp Verified vs Applied labels + ready for actor follow-up. 2 or below: invented metrics, missing action mechanism, or crash free sessions ownership theft. Target BookMyShow synchronised dictionaries ≥4 for Mock #1 pass. Follow-ups. Time box?: 3 min story + ~90s actor follow-up in mock script.. Record yourself?: Self-mock mode in deep dive §7.. Weak story?: Re-drill production bridge before full mock.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §15 I1. A junior asks you in standup: “struct vs class — when do you choose each?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “struct vs class — when do you choose each?” — how do you answer without jargon? `(60–90s)` Answer. “Struct for models and state you want copied by default — value semantics, less accidental shared mutation. Class when you need identity, inheritance (UIKit), or reference sharing. Payment states as enums with associated values (Design: payment status pattern (not shipped) design) fit value types. Say “value semantics” and one UIKit class example.” Follow-ups. What concept is this really?: struct vs class — when do you choose each. How do you prove it?: Give a tiny example or production boundary..

## §16 I2. Production symptom: something related to “What is copy-on-write (COW)” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “What is copy-on-write (COW)” just broke under load. What do you check first? `(60–90s)` Answer. “Swift value types may share backing storage until one copy mutates — then copy happens. Saves memory for large arrays/dicts passed around read-only. Trap: isKnownUniquelyReferenced / holding shared mutable buffers through class wrappers can surprise you. One sentence is enough in warm-up.” Follow-ups. What concept is this really?: What is copy-on-write (copy on write). How do you prove it?: Give a tiny example or production boundary..

## §17 I3. Interviewer never names the topic. They describe a mess that maps to “POP in the ads pipeline — one minute”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “POP in the ads pipeline — one minute”. How do you diagnose? `(60–90s)` Answer. “Protocol-oriented design: capabilities (render, track) instead of a deep AdView subclass tree. Generic pipeline over AdRenderable; type erasure at boundaries when mixing concrete types. Verified BookMyShow Ads pipeline + HeroWidget lifecycle: new creatives plug in without forking revenue path. No invented fill-rate metrics.” Follow-ups. What concept is this really?: P O P in the ads pipeline — one minute. How do you prove it?: Give a tiny example or production boundary..

## §18 I4. Code review: you spot a smell around “weak vs unowned — one sentence each”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “weak vs unowned — one sentence each”. What do you say and what fix do you propose? `(60–90s)` Answer. “Weak does not keep alive; optional; zeroes to nil — use when the other object may die first (async U I, network callbacks). Unowned does not keep alive; not optional; crashes if used after deinit — only when lifetime is provably shorter. Default interview stance: [weak self] for escaping work.” Follow-ups. What concept is this really?: weak vs unowned — one sentence each. How do you prove it?: Give a tiny example or production boundary..

## §19 I5. What happens if a teammate ignores the rule behind “Serial vs concurrent queue”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Serial vs concurrent queue”? `(60–90s)` Answer. “Serial: one task at a time — order preserved; good for protecting mutable state. Concurrent: multiple tasks run — order not guaranteed unless you add barriers or external sync. SafeDict uses a serial queue so dictionary mutations never overlap. Main queue is serial — deadlock risk on nested sync.” Follow-ups. What concept is this really?: Serial vs concurrent queue. How do you prove it?: Give a tiny example or production boundary..

## §20 I6. Walk me through a failed interview answer on “async/await vs GCD — when which” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “async/await vs GCD — when which” and how you’d correct it? `(60–90s)` Answer. “G C D is queue-based callbacks — still everywhere in UIKit legacy. async/await structures suspension and errors in Swift concurrency — better for new modules. Production BookMyShow synchronised dictionaries was G C D; Design: actor SafeDict (not shipped) says you’d expose an actor today with await. Do not claim a full prod rewrite unless verified.” Follow-ups. What concept is this really?: async/await vs G C D — when which. How do you prove it?: Give a tiny example or production boundary..

## §21 I7. A junior asks you in standup: “Thread-safe dictionary — 60s design?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Thread-safe dictionary — 60s design?” — how do you answer without jargon? `(60–90s)` Answer. “Hide storage behind a serial queue A P I (or actor today): get/set/snapshot methods dispatch work so callers cannot race the raw dictionary. Avoid sync re-entry on the same queue. Mention async-write / sync-read visibility caveat if asked. Verified BookMyShow synchronised dictionaries is the production proof point.” Follow-ups. What concept is this really?: Thread-safe dictionary — 60s design. How do you prove it?: Give a tiny example or production boundary..

## §22 I8. Production symptom: something related to “DSA from Day 06 — what to recall today” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “DSA from Day 06 — what to recall today” just broke under load. What do you check first? `(60–90s)` Answer. “Say-this-first: clarify → brute → optimize → edges. Pattern IDs: hash, opposite pointers, variable window, Kadane, prefix/suffix, write pointer. Swift String: not O(1) index — state cost. Light D S A block today — one timed problem, not a full contest. Communication grade silent clever solve.” Follow-ups. What concept is this really?: D S A from Day 06 — what to recall today. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §23 T1. SDUI unknown component in prod? `(90–120s)`

Next. T1. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T2. DI vs singletons under test? `(90–120s)`

Next. T2. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T3. Prefetch that hurts scrolling? `(90–120s)`

Next. T3. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T4. Actor reentrancy surprise? `(90–120s)`

Next. T4. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T5. They push you to invent a metric you don’t have? `(90–120s)`

Next. T5. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T6. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T6. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T7. They want a one-tool forever answer? `(90–120s)`

Next. T7. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §30 T8. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T8. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §31 T9. Main-thread rule under pressure? `(90–120s)`

Next. T9. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §32 T10. Cancellation honesty? `(90–120s)`

Next. T10. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
