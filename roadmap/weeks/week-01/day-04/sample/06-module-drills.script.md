# Audio script — Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)
> Listen-only sample Q&A from `06-module-drills.md`. Spoken answers and follow-ups.

## §0 Q1. Walk the concurrentPerform race harness (exercise 2)

Next. Q1. Walk the concurrentPerform race harness (exercise 2) Answer. “I spin two pictures. Picture one: a plain [String: Int] mutated from many workers via DispatchQueue.concurrentPerform or a pile of global().async plus a group notify — conceptually chaos, Thread Sanitizer should scream. Picture two: the same ops through SafeDict — coherent counts, no race on storage. Speak: BookMyShow synchronised dictionaries fixed the A P I boundary so call sites couldn’t race the map.” Follow-ups. Why concurrentPerform?: “Easy fan-out of N iterations without hand-rolling N queues.”. What do you assert?: “Final counts and invariants under SafeDict; don’t invent crash percentages.”.

## §1 Q2. Cross-thread async-set → sync-get visibility

Next. Q2. Cross-thread async-set → sync-get visibility Answer. “Thread A calls setAsync. Thread B immediately sync-gets. There is no call-site completion — B may miss the write until A’s block actually runs. Same-thread FIFO often hides the bug. Interview rule: for read-after-write certainty, sync set or one sync transaction. Don’t document async set as ‘write done.’” Follow-ups. Scenario A sync then sync?: “Sees the value — write completed before set returned.”. Scenario B async then sync same thread?: “Often sees it due to enqueue order — still not a contract I’d sell.”.

## §2 Q3. `_mutateUnlocked` + `dispatchPrecondition`

Next. Q3. `_mutateUnlocked` + `dispatchPrecondition` Answer. “Public methods sync onto the queue. Internals that assume you’re already on-queue are named _mutateUnlocked or similar. At the top: dispatchPrecondition(condition:.onQueue(queue)) in debug. That catches illegal re-entry and wrong-queue calls before you ship a silent race or deadlock.” Follow-ups. Why not sync again inside?: “That’s the private serial re-entry deadlock.”. Production assert?: “Precondition is a debug/assert tool — still design so unlocked paths are only called on-queue.”.

## §3 Q4. Incorrect concurrent dict autopsy (no barrier)

Next. Q4. Incorrect concurrent dict autopsy (no barrier) Answer. “Someone uses a concurrent queue, async-writes storage[k] = v, and async-reads storage[k] with no.barrier. That’s a data race — overlapping unsynchronized mutation. Autopsy: either add barrier writes and document the RW model, or fall back to serial SafeDict. BookMyShow honesty: serial generally; RW where read-heavy and measured.” Follow-ups. Is concurrent alone enough?: “No — concurrent without exclusive writes is still a race.”. Writer starvation angle?: “Even with barriers, constant readers can starve writers — know that trade-off.”.

## §4 Q5. QoS inheritance / priority inversion depth

Next. Q5. QoS inheritance / priority inversion depth Answer. “If a.background task holds a lock or serial section that.userInteractive U I needs, the high-priority work waits on the low-priority holder — priority inversion. G C D can inherit QoS in some queue designs; scattered NSLocks make it worse. Prefer one queue boundary for shared maps so you’re not inventing lock order under mixed QoS.” Follow-ups. Mislabel everything userInteractive?: “Steals energy and starves real U I and utility work.”. SafeDict help?: “All map ops share one queue — less ad-hoc lock inversion.”.

## §5 Q6. `withCheckedContinuation` double-resume

Next. Q6. `withCheckedContinuation` double-resume Answer. “When bridging G C D to async/await, resume the continuation exactly once. Double-resume crashes. Never resume: hangs forever. Pattern: queue.async { continuation.resume(returning: value) } with a clear single path — success or failure, not both.” Follow-ups. Why not queue.sync from async?: “Blocks the cooperative pool — prefer suspension.”. Checked vs unsafe?: “Checked catches double-resume in debug — still write for exactly once.”.

## §6 Q7. Three-queue ABBA / lock hierarchy

Next. Q7. Three-queue ABBA / lock hierarchy Answer. “Queue1 sync-waits Queue2 while Queue2 sync-waits Queue1 — ABBA deadlock. With three queues the same rule scales: pick a global acquire order and never take locks or sync waits out of order. If you must hop, prefer async and avoid holding one queue while syncing another.” Follow-ups. Symptom?: “Hung threads; U I may freeze if main is in the circle.”. Fix?: “One hierarchy. Or collapse to a single serial owner for that state.”.

## §7 Q8. `group.wait()` on main + semaphore wrong queue

Next. Q8. `group.wait()` on main + semaphore wrong queue Answer. “group.wait on main freezes the U I until every leave fires — if leave is forgotten, forever. Prefer notify on main. Semaphore wait on the queue that must run the signal path is a circular wait. Awareness-level: name the traps; for new fan-out prefer TaskGroup.” Follow-ups. Safe group pattern?: “enter; defer leave; notify on the right queue.”. Semaphore value 1?: “Binary exclusion — still easy to deadlock if waited wrong.”.

## §8 Q9. Actor SafeDict reentrancy vs serial-queue + offline sync instinct

Next. Q9. Actor SafeDict reentrancy vs serial-queue + offline sync instinct Answer. “Serial SafeDict: sync critical sections — no await in the middle, so that section doesn’t re-enter. Actor SafeDict: another call can enter across await — no data race on storage, logic can still break. Offline SyncEngine actor uses the same single-writer instinct as BookMyShow synchronised dictionaries — one pipeline, coalesce triggers. Design: actor SafeDict is the greenfield map version of that instinct — not a shipped rewrite.” Follow-ups. Same A P I?: “get / set / snapshot — await on actor, sync on G C D.”. Big-bang rewrite?: “No — strangler; label design vs shipped.”.

## §9 Q10. Flash recall — fire front → back like cards

Next. Q10. Flash recall — fire front → back like cards Answer. “Serial vs concurrent — one-at-a-time vs overlap. main.sync from main — deadlock; any serial self-sync same. SafeDict — final class, private storage, private serial queue, sync get/set, snapshot. Async write / sync read — may not see write until it runs; prefer sync set. Barrier — exclusive writer on concurrent queue; without it, race; watch writer starvation. Hide queue — BookMyShow synchronised dictionaries lesson. Race vs deadlock vs priority inversion — three different bugs. DispatchGroup — balanced enter/leave; don’t wait on main. Continuations — resume exactly once; don’t sync from async pool. Verified dictionaries — path-specific races gone; don’t invent crash free sessions %. Actor coda — Design: actor SafeDict, not shipped. Spelling — final class, never Final class.” Follow-ups. Drill how?: “Cover the name, speak the back, uncover, score yourself.”.

## §10 Q11. Day close-out — can you check these off?

Next. Q11. Day close-out — can you check these off? Answer. “Without notes: serial vs concurrent in one sentence. Why main.sync from main deadlocks. Sketch SafeDict with final class spelled right. State the async-write / sync-read caveat. Explain barrier RW and writer starvation in under a minute. Deliver BookMyShow synchronised dictionaries STAR under three minutes with honest metric scope. Deliver Design: actor SafeDict as applied design, not a shipped rewrite. Run a timed set from 04-questions including T1–T10. If any box is open, that’s my next drill — not more reading.” Follow-ups. Where to practice code?: “05-exercises — SafeDict, race harness, deadlock lab, BarrierDict.”. Where to time speak?: “04-questions T1–T10.”.

## §11 Q12. What should you be able to do by end of Day 04? (README outcomes)

Next. Q12. What should you be able to do by end of Day 04? (README outcomes) Answer. “Contrast serial vs concurrent; main vs global QoS. Explain sync vs async and why sync-to-current-queue deadlocks — not only main. Implement a thread-safe dictionary behind a private serial queue A P I. Explain reader-writer with barriers. State the async write / sync read visibility rule. Deliver synchronised dictionaries STAR with an actor-migration coda labeled design. Spell final class correctly in code and speech.” Follow-ups. Timed drill?: “Q4, Q2, T3, T4 — then full STAR plus actor coda.”.
