# Sample 03 — Groups, races, concurrency traps (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer. 
> Each answer ends with **How can I relate to my case** using named work — never S-codes. 
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What is DispatchGroup for?
**Answer:**

> “A DispatchGroup tracks in-flight async work. Call enter before starting work and leave when done — counts must balance. Use notify to run a completion when all work finishes — typical pattern: fan-out downloads on background queues, merge results on main. Use case: prefetch multiple URLs, then update UI once all complete.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Classic trap? | “Forget leave — notify never fires; group stuck forever.” |
| Safe pattern? | “group.enter; defer { group.leave } immediately after enter.” |
| Where to notify for UI? | “DispatchQueue.main for the merge/update block.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What are common DispatchGroup pitfalls?
**Answer:**

> “Unbalanced enter/leave — every enter needs exactly one leave on all paths; use defer. Notify on the wrong queue — UI merge belongs on main. Blocking main with wait — can freeze UI; prefer notify or avoid waiting on main entirely. Double leave also breaks the count.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Error path in download callback? | “Still leave in defer — success or failure.” |
| wait vs notify? | “wait blocks the calling thread; notify schedules async completion.” |
| Timeout in tools? | “Timed wait for diagnostics is fine — don’t block main in production UI.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is a semaphore (awareness level)?
**Answer:**

> “A DispatchSemaphore limits how many tasks run concurrently — value four means at most four in flight. wait decrements and blocks if zero; signal increments. Classic use: cap parallel image decodes. Easy to deadlock if you wait on the wrong queue or forget to signal. Modern Swift prefers structured concurrency and TaskGroup — Day 05.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview depth for today? | “Awareness only — name it, know the deadlock risk, point to TaskGroup for new code.” |
| Semaphore vs serial queue? | “Semaphore limits parallelism; serial queue enforces one-at-a-time on that queue’s tasks.” |
| Wrong-queue wait trap? | “Waiting on a queue that must run the signaling work → circular wait.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is a data race?
**Answer:**

> “Unsynchronized shared mutable access — two threads touch the same memory without a happens-before rule, at least one writing. Swift dictionaries aren’t thread-safe; concurrent mutation is undefined behavior and intermittent crashes. Fix: serialize at a boundary — serial queue, lock, or actor.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Race equals unsynchronized shared mutable access.” |
| vs logic bug? | “Race is timing-dependent; may pass tests, fail in production under load.” |
| SafeDict fixes which problem? | “Race on shared dictionary storage — not deadlock by itself.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is deadlock (in GCD terms)?
**Answer:**

> “A wait circle — threads or queues waiting on each other forever. Classic GCD cases: sync to the serial queue you’re already on — including main.sync from main — private serial re-entrancy, and cross-queue ABBA where Queue1 sync-waits Queue2 while Queue2 sync-waits Queue1.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Deadlock equals wait circle — including sync to current serial queue.” |
| Main-thread symptom? | “UI frozen, spinner forever, watchdog may kill the app.” |
| Fix hierarchy for ABBA? | “Always acquire queues or locks in one global order.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is priority inversion?
**Answer:**

> “A low-priority task holds a resource — lock, queue, serial section — that a high-priority task needs, so high-priority work waits on low-priority work. Example: a background task holds a lock while userInteractive UI waits. GCD QoS inheritance helps in some designs; ad-hoc locks make this easier to get wrong — another reason to serialize at one queue boundary.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Priority inversion equals low-priority holder blocks high-priority waiter.” |
| SafeDict on serial queue? | “All work same queue — less ad-hoc lock inversion than scattered NSLocks.” |
| UI feels janky under load? | “Check if background work holds contended locks UI needs.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. How do race, deadlock, and priority inversion differ?
**Answer:**

> “Race — overlapping unsynchronized access; wrong data or crash, timing-dependent. Deadlock — everyone waiting, no progress, often reproducible once you see the sync pattern. Priority inversion — progress possible but wrong priority order; high-priority starved by a low-priority holder. Three distinct interview terms — don’t conflate them.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SafeDict prevents? | “Races on the dictionary path — if used correctly.” |
| main.sync from main causes? | “Deadlock — not a race.” |
| Low QoS lock plus high QoS UI? | “Priority inversion risk.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What is the actors preview for Day 04?
**Answer:**

> “A Swift actor gives language-enforced isolation for the same problem SafeDict solves with a serial queue — one executor, serialized access. For new code I’d evaluate an actor with get/set/snapshot and await — Design: actor SafeDict, not shipped. Today’s depth is GCD — the production story you shipped. Don’t claim BookMyShow synchronised dictionaries were rewritten as actors.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor vs serial queue trade-off? | “Actor: isolation in the type system; API becomes async; watch reentrancy across await.” |
| Migration pitch? | “Same safe API — get/set/snapshot — implemented by an actor; callers await. Design only.” |
| Day 05 pointer? | “SafeDictActor.swift as Learning-lab.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q9. Locks vs queues vs actors — how do you compare them?
**Answer:**

> “Serial queue wrapper — simple shared maps like BookMyShow synchronised dictionaries; cost is sync-read latency and sync deadlock if misused. Concurrent plus barrier — read-heavy maps; cost is complexity and writer starvation. NSLock — tiny critical sections; easy to forget unlock and hit priority inversion. Actor — greenfield Design: actor SafeDict; compiler isolation, async API, reentrancy across await. Same get/set/snapshot surface; isolation moves from convention to the type system — that’s a design pitch, not a shipped claim.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default for shared maps today? | “Serial-queue SafeDict for legacy BookMyShow synchronised dictionaries; actor for new modules.” |
| Why not locks everywhere? | “Ordering bugs, forgotten unlock, inversion under QoS.” |
| Barrier when? | “Read-dominated large maps — measure; watch writer starvation.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Forgot leave / wait on main

```swift
group.enter
download { _ in /* forgot leave */ }
group.wait // called on main
```

**Ask yourself:** What does the user see?

**Answer:** Forever spinner / frozen UI. wait blocks main; leave never happens so the group never completes. Prefer notify on main, and `defer { leave }` after every enter.

---

### Puzzle B — Race vs deadlock vs priority inversion

Three bugs: (1) two threads mutate a shared dict with no sync; (2) `main.sync` from main; (3) `.background` holds a lock UI needs at `.userInteractive`.

**Ask yourself:** Name each.

**Answer:** (1) data race, (2) deadlock, (3) priority inversion. Don’t conflate them in an interview.

---

### Puzzle C — Semaphore wait on wrong queue

You `sem.wait` on the same serial queue that must run the work that eventually `signal`s.

**Ask yourself:** What happens?

**Answer:** Deadlock — the waiter owns the queue that can’t run the signal path. Cap concurrency carefully; prefer TaskGroup for new code.

---

### Puzzle D — Actor SafeDict reentrancy vs serial-queue

Serial SafeDict: every get/set is sync on one queue — no await in the middle. Actor SafeDict: method awaits network mid-update; another call enters.

**Ask yourself:** Same bug class?

**Answer:** No. Serial queue blocks re-entry of that critical section. Actor allows reentrancy across await — no data race on storage, but logic can break. Different traps; same “single writer” instinct.

---

Next: [04-production-s2.md](04-production-s2.md)
