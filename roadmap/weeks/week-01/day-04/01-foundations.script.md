# Audio script — 01 Foundations
> Listen-only audiobook of `01-foundations.md` (Day 04 — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Read this first. Goal: intern-clear queue mental model, then senior edges for S2 interviews.

## §1 0. One-sentence north star

Next. 0. One-sentence main guiding idea. That means the main guiding idea.

Serialize access to shared mutable state at a clear boundary. don’t sprinkle locks ad hoc. and never block a queue waiting for itself. At BookMyShow that boundary was synchronised dictionaries behind G C D (Verified · S2). Day 05 modernizes the same idea with actors (S2-A1).

## §2 1. Why threads race (intern story)

Next. 1. Why threads race (intern story).

1.1 Shared mutation without rules Here is a simple Swift example, explained in words. var cache: [String: Data] equals [:]. // Thread A. cache["a"] equals Data(). // Thread B (same time). _ equals cache["a"]. What to remember: focus on the idea, not every symbol. Dictionaries are not thread-safe. Concurrent mutation. data races. intermittent crashes / corruption. Hard to reproduce. shows up under load. Remember: “If two threads touch shared mutable memory without synchronization, that’s a race. undefined behavior territory.” 1.2 What we want instead Property: Meaning. Mutual exclusion for writes: No two writers overlap unsafely. Defined read visibility: Readers see a coherent state. Safe A P I: Callers cannot touch raw storage. No self-deadlock: Avoid sync onto the queue you’re on.

## §3 2. Dispatch queues — the boxes

Next. 2. Dispatch queues — the boxes.

2.1 Serial vs concurrent Queue: Behavior, Picture. Serial: One task at a time. FIFO start order, Single checkout lane. Concurrent: Tasks may run overlapping, Many lanes. start order FIFO, finish order varies. Here is a simple Swift example, explained in words. let serial equals DispatchQueue(label: "app.safe.dict"). let concurrent equals DispatchQueue(label: "app.images", attributes:.concurrent). What to remember: focus on the idea, not every symbol. 2.2 Main queue Serial queue tied to the main thread U I kit / Swift U I U. I updates belong here Never do heavy Jason parse / image decode synchronously on main Here is a. simple Swift example, explained in words. DispatchQueue.main.async. self.label.text equals value. What to remember: focus on the idea, not every symbol. 2.3 Global queues + QoS Here is a simple Swift example, explained in words. DispatchQueue.global(qos:.userInitiated).async.... What to remember: focus on the idea, not every symbol. QoS (high. low intuition): Use..userInteractive: Tiny, U I-critical work..userInitiated: User waiting (fetch for screen)..default: General..utility: Progress-visible long work..background: Cleanup. prefetch that can wait. Senior line: Don’t mark everything.userInteractive. you steal energy and starve work.

## §4 3. async vs sync

Next. 3. async vs sync.

3.1 Definitions Call: Meaning. async: Schedule block. return immediately. sync: Schedule block. wait until it finishes. return results. Here is a simple Swift example, explained in words. queue.async. // runs later (soon) on queue. let value equals queue.sync () - Int in. return storage.count. What to remember: focus on the idea, not every symbol. 3.2 Deadlock rule (learn early) Never sync onto the same serial queue you are already executing on. Classic: main thread does DispatchQueue.main.sync {... }. main waits for main. deadlock. Also true for any private serial queue: Here is a simple Swift example, explained in words. serial.async. serial.sync // DEADLOCK. already on serial. print("never"). What to remember: focus on the idea, not every symbol. Remember: “Sync waits. If the waiter is the only worker that can run the work. you freeze.” 3.3 When sync is useful Need a return value from the queue (read) Need happens-before with. prior tasks on that queue Keep critical sections short When async is better: Fire-and-forget updates Avoid blocking callers. (especially main).

## §5 4. Thread-safe dictionary — Pattern A (serial)

Next. 4. Thread-safe dictionary — Pattern A (serial).

4.1 Shape used in interviews (and S2) Here is a simple example with an async function. Async means the function can pause. It pauses at await while waiting. Other work can run during the wait. Why this matters: the U I stays responsive. What to remember: await marks a pause point. Notes: Spell final class (Swift keyword final, lowercase). Queue is private. callers never see it. get uses sync so it can return a value and wait for prior scheduled work. set often uses async so writers don’t block. but see visibility caveat below. 4.2 CRITICAL: async write then sync read Here is a simple Swift example, explained in words. dict.set("k", value: 1) // async. schedules write. let v equals dict.get("k") // sync. may run BEFORE the write if write hasn't started!. What to remember: focus on the idea, not every symbol. Fact: On a serial queue, tasks run in submission order once enqueued. But: If set uses async, the write is only ordered after it has been enqueued. A get that is sync’d immediately after set returns will wait for work already on the queue. In practice, the async block is usually enqueued before get’s sync runs. so you often see the write. Relying on wall-clock assumptions across threads without documenting A P I guarantees is fragile. If the caller needs read-after-write certainty from the same call site. use sync write (or a single sync transaction). Preferred when read-after-write matters: Here is a simple Swift example, explained in words. func set(_ key: Key, value: Value). queue.sync self.storage[key] equals value. What to remember: focus on the idea, not every symbol. Or expose: Here is a simple Swift example, explained in words. func mutate(_ body: (inout [Key: Value]) - Void). queue.sync body(&storage). What to remember: focus on the idea, not every symbol. Interview line: “Async write plus sync read is a common pattern. but if I need the write visible to the next read on that A P I. I sync the write. async write may not have run yet when the caller’s next line executes.” 4.3 Never return a mutable. interior reference Here is a simple Swift example, explained in words. // BAD. func unsafeStorage() - [Key: Value] storage // races + escapes protection. // GOOD. func snapshot() - [Key: Value]. queue.sync storage // value copy (Dictionary copy on write helps). What to remember: focus on the idea, not every symbol.

## §6 5. Pattern B — concurrent queue + barrier (reader-writer)

Next. 5. Pattern B — concurrent queue + barrier (reader-writer).

Here is a simple example with an async function. Async means the function can pause. It pauses at await while waiting. Other work can run during the wait. Why this matters: the U I stays responsive. What to remember: await marks a pause point. Operation: Flag, Effect. Read: plain sync/async, May overlap with other reads. Write:.barrier, Waits for prior reads. excludes others until done. When: Read-heavy maps. Cost: Harder to reason about. writer starvation possible under constant reads. still hide the queue. S2 used serial queues generally. RW locks / barriers where read-heavy. say that honestly.

## §7 6. DispatchGroup (foundations)

Next. 6. DispatchGroup (foundations).

Here is a simple Swift example, explained in words. let group equals DispatchGroup(). for url in urls. group.enter(). download(url) _ in group.leave(). group.notify(queue:.main). What to remember: focus on the idea, not every symbol. Use: fan-out prefetch, then merge on main. Trap: forget leave. notify never fires.

## §8 7. Semaphores (awareness only)

Next. 7. Semaphores (awareness only).

Here is a simple Swift example, explained in words. let sem equals DispatchSemaphore(value: 4) // max 4 in flight. sem.wait(). // work. sem.signal(). What to remember: focus on the idea, not every symbol. Limit concurrency (image decodes). Easy to deadlock if wait on wrong queue. Prefer structured concurrency / TaskGroup in modern code (Day 05).

## §9 8. Race vs deadlock vs priority inversion

Next. 8. Race vs deadlock vs priority inversion.

Term: One-liner. Race: Unsynchronized shared mutable access. Deadlock: Wait circle. including sync to current serial queue. Priority inversion: Low-priority holder blocks high-priority waiter.

## §10 9. Actors preview (one paragraph)

Next. 9. Actors preview (one paragraph).

Swift actor gives language-enforced isolation for the same problem SafeDict solves with a serial queue. For new code you’d evaluate an actor (How I would apply it · S2-A1). Today’s depth is G C D. the production story you shipped.

## §11 10. Glossary

Next. 10. Glossary.

Term: One-liner. Serial queue: Tasks one-at-a-time. Concurrent queue: Tasks may overlap. Barrier: Exclusive section on concurrent queue. QoS: Priority / energy class for work. sync: Wait for block completion. async: Schedule and return. Safe A P I: Hide storage + queue. expose methods. Snapshot: Value copy returned under sync.

## §12 11. First production bridge (short)

Next. 11. First production bridge (short).

Shared async state at BookMyShow was hit from multiple queues. races / intermittent crashes. Fix: synchronised dictionaries gated by G C D serial queues (RW where read-heavy). with a standardized access A P I so call sites couldn’t touch raw storage. ≤20s: “We gated shared dictionaries behind a serial queue A P I so. call sites couldn’t race the storage. crashes went away on that path.” Provenance: Verified · S2 · BookMyShow · synchronised dictionaries.

## §13 12. Self-check before deep dive

Next. 12. Self-check before deep dive.

[ ] Serial vs concurrent in one sentence each? [ ] Why main.sync from main deadlocks? [ ] Sketch SafeDict get/set? [ ] State the async-write / sync-read visibility caveat? [ ] Spell final class correctly?. 02-deep-dive.md.
