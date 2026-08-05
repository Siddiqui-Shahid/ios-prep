# Audio script — 02 Deep Dive
> Listen-only audiobook of `02-deep-dive.md` (Day 07 — Week 1 Revision + Mock Interview #1). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Print or split-screen this. Interviewer reads bold prompts. Timing visible. Candidate answers without notes. After each answer, optional follow-up from the ladder.

## §1 0. Setup (2 min)

Next. 0. Setup (2 min).

Interviewer says: “This is Mock #1. Week 1 concurrency and memory. Agenda: short definitions, a deep dive, your synchronised-dictionaries story, then a social-feed HLD sketch. I’ll cut you off if you’re 2× over time. self-correct and continue. Ready?” Start timer for the whole mock.

## §2 1. Warm-up definitions (10 min)

Next. 1. Warm-up definitions (10 min).

Ask any 5 from the list. Budget ~45. 60s each. Full model answers: 04-questions.md W1. W12. Scripted set A (default) #: Prompt, Budget. 1: “Struct versus class. when do you choose each?”, 45s. 2: “What is copy-on-write?”, 45s. 3: “weak versus unowned?”, 45s. 4: “Serial versus concurrent queue?”, 45s. 5: “In one minute: how would you design a thread-safe dictionary?”, 60. 90s. Alternate set B P O P in ads · Main-queue deadlock · Actor isolation · Sendable · Task. cancellation Interviewer notes: Mark agenda? trade-off? provenance honesty?

## §3 2. Deep dive (25 min)

Next. 2. Deep dive (25 min).

Ask 4. 5 items. Allow follow-ups. Budgets 90. 120s unless noted. D1. Actor reentrancy (120s) “You await inside an actor method. Can another task mutate the actor’s state before you resume? What breaks if you assume continuity?” Follow-ups: How do you harden load-if-missing? Contrast with G C D serial queue (no await suspension in the same way) D2. Serial sync re-entry (90s) “You’re on a private serial queue and call queue.sync again from nested code. What happens? Is this only a main-queue issue?” Follow-ups: Unlocked internal pattern? dispatchPrecondition? D3. Memory Graph vs Leaks (90s) “Memory Graph shows a retain cycle but Leaks shows nothing. Why aren’t those tools synonyms?” Follow-ups: Abandoned memory vs leak? What do you do next in X code? D4. G C D. actor migration (120s) “You have a G C D SafeDict in production. How would you migrate a module to an actor without a big-bang rewrite?” Follow-ups: A P I surface. stay sync somehow? (adapters / async façade) Label Verified S2 vs Applied S2-A1 D5. Pick one stretch Choose based on misses: @unchecked Sendable ethics (90s) Type erasure cost in ads renderer (90s). Async write then sync read visibility (90s) Mixing queue.sync inside async functions (90s) Model answers: 04-questions.md deep section.

## §4 3. Story — S2 `(10 min)`

Next. 3. Story — S2 `(10 min)`.

Prompt “Tell me about a concurrency bug you fixed in production. You have three minutes.” Listen for STAR. Score with story rubric: Beat: Present?. Situation: shared dicts raced. Action: serial queues / RW / safe A P I. Result: path-specific crash reduction. Lesson + actor coda. No CFS ownership theft / no fake crash %. Required follow-up (90s) “How would you design this today with Swift concurrency?” Expect How I would apply it. · S2-A1. actor, same safe A P I, await, not “we rewrote everything as actors.” Optional follow-up “Why hide the. queue instead of letting callers dispatch onto it?”.

## §5 4. Mini system design — Social Feed `(20 min)`

Next. 4. Mini system design — Social Feed `(20 min)`.

Prompt “Design the client side of a social/listing feed for a large consumer app. think BookMyShow-scale traffic. Clarify first, then high-level design only. No need for full LLD today.” Good clarifying questions (candidate should ask ~4. 6) Organic vs ads mixing rules? Pagination model (cursor vs offset)? Offline / stale content expectations? Image / video autoplay policy? Realtime invalidation vs pull-to-refresh? Approximate DAU / latency targets? (candidate may cite 30L+ DAU as Verified · S8 scale context. not invent new numbers) HLD bullets interviewer wants to hear Area: Expect. A P I: Cursor pagination request/response. Caching: Memory + disk tiers. TTL/invalidation sketch. Images: Prefetch. cancel on scroll away. Concurrency: Don’t block main. cancel in-flight. Failure: Empty/error/retry states. Ads: Slot injection without forking feed pipeline (S1 instinct ). Interviewer: Cut at 20 min even if incomplete. note what was missing.

## §6 5. Retro `(10–15 min)`

Next. 5. Retro `(10–15 min)`.

Fill code/MockScorecard.md. Average deep-dive scores. List top 5 weak cards. pin to Week 2 warm-ups. Optional encore: S1 Ads P O P talk ≤5 min (preview Mock #2).

## §7 6. Interlocutor “cut” lines (use sparingly)

Next. 6. Interlocutor “cut” lines (use sparingly).

“You’re at 2×. give me the trade-off in one sentence.” “Don’t invent a metric. what’s the honest result?” “Agenda first.” “Is that Verified or how you’d apply it?”.

## §8 7. Self-mock mode

Next. 7. Self-mock mode.

If solo: record voice memo. play back against 04-questions Full spoken answers. still fill scorecard honestly.
