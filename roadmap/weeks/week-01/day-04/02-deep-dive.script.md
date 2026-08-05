# Audio script — 02 Deep Dive
> Listen-only audiobook of `02-deep-dive.md` (Day 04 — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Interview depth. Foundations assumed.

## §1 1. Queue targeting and thread hops

Next. 1. Queue targeting and thread hops.

1.1 async always hops (eventually) Here is a simple Swift example, explained in words. networkSession.dataTask(...) data, _, _ in. // URLSession callback queue. NOT main by default (config-dependent). DispatchQueue.main.async. self.viewModel.apply(data). What to remember: focus on the idea, not every symbol. Rule: U I on main. Parse off main when heavy. 1.2 sync from background to main Here is a simple Swift example, explained in words. // Background thread:. DispatchQueue.main.sync. // U I touch. works but BLOCKS background until main runs the block. What to remember: focus on the idea, not every symbol. Prefer main.async for U I unless you have a rare need to wait. Blocking a thread pool worker on main can cause stalls under load. 1.3 Target queue inversion bugs Passing your private queue into an A P I that syncs back onto. the caller. re-entrancy surprises. Hide queues. expose methods.

## §2 2. Deadlock patterns (memorize)

Next. 2. Deadlock patterns (memorize).

2.1 Main sync-to-main Here is a simple Swift example, explained in words. // On main:. DispatchQueue.main.sync print("dead"). What to remember: focus on the idea, not every symbol. 2.2 Private serial re-entry Here is a simple Swift example, explained in words. final class Service. private let q equals DispatchQueue(label: "service"). func a(). q.sync. self.b() // b also syncs to q. deadlock. What to remember: focus on the idea, not every symbol. Fix patterns: Use async for nested work Factor “already on queue” unsafe internals (_bUnlocked) called only from queue. Assert queue with dispatchPrecondition in debug Here is a simple Swift example. explained in words. private func mutateUnlocked(). dispatchPrecondition(condition:.onQueue(queue)). storage["x"] equals 1. What to remember: focus on the idea, not every symbol. 2.3 Cross-queue ABBA deadlock Here is a simple code example, explained in words. Thread1: lock A. wait B. Thread2: lock B. wait A. What to remember: focus on the idea, not every symbol. With queues: Queue1 sync waits on Queue2 while Queue2 sync waits on Queue1. Keep a lock/queue hierarchy. always acquire in one order.

## §3 3. Ordering and visibility on serial queues

Next. 3. Ordering and visibility on serial queues.

3.1 FIFO start order Serial queues start tasks in submission order. That gives a happens-before between task N and task N+1 on that queue. 3.2 Async write / sync read. precise statement Here is a simple example with an async function. Async means the function can pause. It pauses at await while waiting. Other work can run during the wait. Why this matters: the U I stays responsive. What to remember: await marks a pause point. Scenario A. sync write then sync read (same thread): Here is a simple Swift example, explained in words. dict.setSync("k", value: 1). let v equals dict.get("k") // ✅ sees 1. write completed before setSync returned. What to remember: focus on the idea, not every symbol. Scenario B. async write then sync read (same thread): Here is a simple Swift example, explained in words. dict.setAsync("k", value: 1) // enqueues write returns immediately. let v equals dict.get("k") // sync: runs after previously enqueued work. What to remember: focus on the idea, not every symbol. Usually v == 1 because the async block was enqueued before get’s sync block. But: documenting “set is fire-and-forget” means callers must not assume immediate visibility across other threads without joining. and you should not treat async set as a completed write. Scenario C. async write. read from another thread without sync A P I: If someone races on a leaked storage reference. undefined. Hence private storage. Interview-grade sentence: “If I need read-after-write on the call site, I use a synchronous set. or one sync transaction. because an async write only guarantees ordering once it’s on the queue. and the caller’s next line isn’t a completion handler.” 3.3 Returning values vs mutating in place Prefer returning. values (structs, copied Dictionary snapshots). Never hand out :inout storage or class wrappers that mutate outside the queue.

## §4 4. Concurrent + barrier deep dive

Next. 4. Concurrent + barrier deep dive.

4.1 Mental model Here is a simple code example, explained in words. Readers: R R R R (may overlap). Barrier: |W| (exclusive). Readers: R R. What to remember: focus on the idea, not every symbol. 4.2 Incorrect “concurrent dict” Here is a simple Swift example, explained in words. // ❌ DATA RACE. concurrent.async storage[k] equals v // write without barrier. concurrent.async _ equals storage[k]. What to remember: focus on the idea, not every symbol. 4.3 Writer starvation If readers constantly enter, a barrier writer may wait a long time. Mitigations: QoS, batching writes, or fall back to serial if simplicity > read parallelism. 4.4 S2 honesty “We used serial queues for synchronised dictionaries. and read-write locks where access was read-heavy.” Don’t claim you always used barriers everywhere.

## §5 5. Designing the SafeDict API (senior)

Next. 5. Designing the SafeDict A P I (senior).

5.1 Checklist Requirement: Implementation. Hide storage: private var storage. Hide queue: private let queue. Thread-safe get: queue.sync. Thread-safe set: queue.sync or carefully documented async. Snapshot: sync copy. No queue escape: never return DispatchQueue. final class: avoid subclassing surprises. 5.2 Full teaching implementation See code/SafeDict.swift. prefer sync set for correctness teaching. comment the async alternative. 5.3 Stress testing mindset Parallel writers + readers via DispatchQueue.concurrentPerform Assert invariants Crashlytics watch in prod (S2).

## §6 6. DispatchGroup pitfalls

Next. 6. DispatchGroup pitfalls.

Pitfall: Fix. Unbalanced enter/leave: defer { leave() } after enter. notify on wrong queue: Choose main for U I merge. Forever wait: wait with timeout in tools. avoid blocking main.

## §7 7. Locks vs queues vs actors

Next. 7. Locks vs queues vs actors.

Tool: When, Cost. Serial queue wrapper: Simple shared maps (S2), Sync read latency under load. Concurrent + barrier: Read-heavy, Complexity, starvation. NSLock / os_unfair_lock: Tiny critical sections, Easy to forget unlock. priority inversion. actor: New Swift code (S2-A1), async A P I surface. reentrancy across await. Migration pitch (not a shipped claim): “Same safe A P I. get/set/snapshot. implemented by an actor. callers await. Isolation moves from convention to the type system.”.

## §8 8. Mixing GCD with async/await (trap preview)

Next. 8. Mixing G C D with async/await (trap preview).

Here is a simple example with an async function. Async means the function can pause. It pauses at await while waiting. Other work can run during the wait. Why this matters: the U I stays responsive. What to remember: await marks a pause point. Traps: Calling queue.sync from an async context can block a thread in the cooperative pool. bad. Prefer actors or async wrappers that don’t sync-block. Day 05 deepens this. today just know: don’t casually sync from async world.

## §9 9. QoS and priority inversion

Next. 9. QoS and priority inversion.

If a.background task holds a lock needed by.userInteractive, the U I waits. G C D QoS inheritance helps in some queue designs. locks are easier to get wrong. Another reason “serialize at one queue boundary” is nicer than ad-hoc locks.

## §10 10. Trade-off table (memorize)

Next. 10. Trade-off table (memorize).

Choice: When, Cost. Serial queue SafeDict: Default shared maps, Readers queue behind writers. RW barrier: Read-heavy large maps, Complexity. Sync set: Read-after-write needed, Caller blocks on write. Async set: Throughput. eventual visibility , Visibility surprises. Expose queue: Never for S2-style safety, Call sites reintroduce races. Actor rewrite: Greenfield / migrate module, A P I becomes async.

## §11 11. Whiteboard: 2-minute SafeDict talk

Next. 11. Whiteboard: 2-minute SafeDict talk.

Problem: shared dict raced across queues. crashes. Design: final class wrapper. private storage. private serial queue. A P I: sync get. sync set (explain why not async if asked visibility). Alternative: barrier RW for read-heavy. Trade-off: actor today for new code. Result: races on that path eliminated. pattern reused.

## §12 12. Anti-patterns

Next. 12. Anti-patterns.

Anti-pattern: Fix. Final class spelling: final class. Public var storage: private + snapshot. sync to self: unlocked internals / async. Concurrent writes w/o barrier: barrier or serial. Claiming S2 fixed all app crashes: Path-specific race fix. Returning mutable reference: return values.

## §13 13. Code tour

Next. 13. Code tour.

code/SafeDict.swift. line-by-line aloud. code/BarrierDict.swift. contrast. Predict: async set + immediate get on another thread using only public A P I.

## §14 14. Interview micro-scripts (pin)

Next. 14. Interview micro-scripts (pin).

SafeDict in 45s: “final class, private dictionary, private serial queue. Sync get and sync set so read-after-write is defined. Snapshot returns a copy. Call sites never see storage or the queue. that was the BookMyShow fix for raced shared maps.” Visibility in 20s: “Async write then. sync read may not see the write until the write runs. for call-site certainty I sync the write.” Actor coda in 20s: “Same A P I as an actor. for new modules. Applied S2-A1, not a claim we rewrote production.” Spelling check: say and type final class. never Final class.. 03-production-bridge.md.
