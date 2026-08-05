# Audio script — Sample 03 — Groups, races, concurrency traps (Q&A)
> Listen-only sample Q&A from `03-groups-races.md`. Spoken answers and follow-ups.

## §0 Q1. What is DispatchGroup for?

Next. Q1. What is DispatchGroup for? Answer. A DispatchGroup tracks in-flight async work. Call enter() before starting work and leave() when done — counts must balance. Use notify(queue:) to run a completion when all work finishes — typical pattern: fan-out downloads on background queues, merge results on main. Use case: prefetch multiple URLs, then update U I once all complete. Follow-ups. Classic trap?: Forget leave() → notify never fires; group stuck forever.. Safe pattern?: group.enter(); defer { group.leave() } immediately after enter.. Where to notify for U I?: DispatchQueue.main for the merge/update block..

## §1 Q2. What are common DispatchGroup pitfalls?

Next. Q2. What are common DispatchGroup pitfalls? Answer. Unbalanced enter/leave — every enter needs exactly one leave on all paths (use defer). notify on wrong queue — U I merge belongs on main. Blocking main with wait() — can freeze U I; prefer notify or avoid waiting on main entirely. Double leave — also breaks the count. Follow-ups. Error path in download callback?: Still leave() in defer — success or failure.. wait() vs notify?: wait() blocks the calling thread; notify schedules async completion.. Timeout in tools?: Some code uses timed wait for diagnostics — don’t block main in production U I..

## §2 Q3. What is a semaphore (awareness level)?

Next. Q3. What is a semaphore (awareness level)? Answer. A DispatchSemaphore limits how many tasks run concurrently — e.g. value: 4 means at most four in flight. wait() decrements (blocks if zero); signal() increments. Classic use: cap parallel image decodes. Easy to deadlock if you wait on the wrong queue or forget to signal. Modern Swift prefers structured concurrency / TaskGroup (Day 05). Follow-ups. Interview depth for today?: Awareness only — name it, know the deadlock risk, point to TaskGroup for new code.. Semaphore vs serial queue?: Semaphore limits parallelism; serial queue enforces one-at-a-time on that queue’s tasks.. Wrong-queue wait trap?: Waiting on a queue that must run the signaling work → circular wait..

## §3 Q4. What is a data race?

Next. Q4. What is a data race? Answer. Unsynchronized shared mutable access — two threads touch the same memory without a happens-before rule, at least one writing. Swift dictionaries aren’t thread-safe; concurrent mutation → undefined behavior, intermittent crashes. Fix: serialize at a boundary (serial queue, lock, actor). Follow-ups. One-liner?: “Race = unsynchronized shared mutable access.”. vs logic bug?: Race is timing-dependent; may pass tests, fail in production under load.. SafeDict fixes which problem?: Race on shared dictionary storage — not deadlock by itself..

## §4 Q5. What is deadlock (in GCD terms)?

Next. Q5. What is deadlock (in GCD terms)? Answer. A wait circle — threads or queues waiting on each other forever. Classic G C D cases: sync to the serial queue you’re already on (including main.sync from main), private serial re-entrancy (outer block waits for inner sync), and cross-queue ABBA (Queue1 sync-waits Queue2 while Queue2 sync-waits Queue1). Follow-ups. One-liner?: “Deadlock = wait circle — including sync to current serial queue.”. Main-thread symptom?: U I frozen, spinner forever, watchdog may kill app.. Fix hierarchy for ABBA?: Always acquire queues/locks in one global order..

## §5 Q6. What is priority inversion?

Next. Q6. What is priority inversion? Answer. A low-priority task holds a resource (lock, queue, serial section) that a high-priority task needs — so high-priority work waits on low-priority work. Example:.background task holds a lock while.userInteractive U I waits. G C D QoS inheritance helps in some designs; ad-hoc locks make this easier to get wrong — another reason to serialize at one queue boundary. Follow-ups. One-liner?: “Priority inversion = low-priority holder blocks high-priority waiter.”. SafeDict on serial queue?: All work same queue — less ad-hoc lock inversion than scattered NSLocks.. U I feels janky under load?: Check if background work holds contended locks U I needs..

## §6 Q7. How do race, deadlock, and priority inversion differ?

Next. Q7. How do race, deadlock, and priority inversion differ? Answer. Race — overlapping unsynchronized access; wrong data or crash, timing-dependent. Deadlock — everyone waiting, no progress, often reproducible once you see the sync pattern. Priority inversion — progress possible but wrong priority order; high-priority starved by low-priority holder. Three distinct interview terms — don’t conflate them. Follow-ups. SafeDict prevents?: Races on the dictionary path — if used correctly.. main.sync from main causes?: Deadlock — not a race.. Low QoS lock + high QoS U I?: Priority inversion risk..

## §7 Q8. What is the actors preview for Day 04?

Next. Q8. What is the actors preview for Day 04? Answer. A Swift actor gives language-enforced isolation for the same problem SafeDict solves with a serial queue — one executor, serialized access. For new code you’d evaluate an actor with get/set/snapshot and await (How I would apply it · S 2-A1). Today’s depth is G C D — the production story you shipped. Don’t claim production was rewritten as actors for S 2. Follow-ups. Actor vs serial queue trade-off?: Actor: isolation in type system; A P I surface becomes async; watch reentrancy across await.. Migration pitch (not shipped claim)?: “Same safe A P I — get/set/snapshot — implemented by an actor; callers await.”. Day 05 pointer?:../day-05/code/SafeDictActor.swift as Learning-lab.. Next: 04-production-s2.md.
