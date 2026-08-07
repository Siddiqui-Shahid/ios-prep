# Audio script — Sample 01 — Week 1 active recall (Q&A)
> Listen-only sample Q&A from `01-week1-recall.md`. Spoken answers and follow-ups.

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
