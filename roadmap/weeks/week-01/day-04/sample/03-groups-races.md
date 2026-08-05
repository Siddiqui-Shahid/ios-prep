# Sample 03 — Groups, races, concurrency traps (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is DispatchGroup for?

**Points to:** [Foundations · §6 DispatchGroup](../01-foundations.md#6-dispatchgroup-foundations) · [Deep dive · §6 DispatchGroup pitfalls](../02-deep-dive.md#6-dispatchgroup-pitfalls)

**Answer:**

> A **DispatchGroup** tracks in-flight async work. Call **`enter()`** before starting work and **`leave()`** when done — counts must balance. Use **`notify(queue:)`** to run a completion when all work finishes — typical pattern: fan-out downloads on background queues, merge results on **main**. Use case: prefetch multiple URLs, then update UI once all complete.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Classic trap? | Forget **`leave()`** → notify never fires; group stuck forever. |
| Safe pattern? | `group.enter(); defer { group.leave() }` immediately after enter. |
| Where to notify for UI? | **`DispatchQueue.main`** for the merge/update block. |

---

### Q2. What are common DispatchGroup pitfalls?

**Points to:** [Deep dive · §6 DispatchGroup pitfalls](../02-deep-dive.md#6-dispatchgroup-pitfalls)

**Answer:**

> **Unbalanced enter/leave** — every enter needs exactly one leave on all paths (use `defer`). **notify on wrong queue** — UI merge belongs on main. **Blocking main with `wait()`** — can freeze UI; prefer `notify` or avoid waiting on main entirely. **Double leave** — also breaks the count.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Error path in download callback? | Still `leave()` in `defer` — success or failure. |
| `wait()` vs `notify`? | `wait()` blocks the calling thread; `notify` schedules async completion. |
| Timeout in tools? | Some code uses timed wait for diagnostics — don’t block main in production UI. |

---

### Q3. What is a semaphore (awareness level)?

**Points to:** [Foundations · §7 Semaphores](../01-foundations.md#7-semaphores-awareness-only)

**Answer:**

> A **DispatchSemaphore** limits how many tasks run concurrently — e.g. `value: 4` means at most four in flight. **`wait()`** decrements (blocks if zero); **`signal()`** increments. Classic use: cap parallel image decodes. Easy to **deadlock** if you `wait` on the wrong queue or forget to `signal`. Modern Swift prefers structured concurrency / `TaskGroup` (Day 05).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview depth for today? | **Awareness only** — name it, know the deadlock risk, point to TaskGroup for new code. |
| Semaphore vs serial queue? | Semaphore limits parallelism; serial queue enforces one-at-a-time on that queue’s tasks. |
| Wrong-queue wait trap? | Waiting on a queue that must run the signaling work → circular wait. |

---

### Q4. What is a data race?

**Points to:** [Foundations · §1 Why threads race](../01-foundations.md#1-why-threads-race-intern-story) · [Foundations · §8 Race vs deadlock](../01-foundations.md#8-race-vs-deadlock-vs-priority-inversion)

**Answer:**

> **Unsynchronized shared mutable access** — two threads touch the same memory without a happens-before rule, at least one writing. Swift dictionaries aren’t thread-safe; concurrent mutation → undefined behavior, intermittent crashes. Fix: serialize at a boundary (serial queue, lock, actor).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Race = unsynchronized shared mutable access.” |
| vs logic bug? | Race is timing-dependent; may pass tests, fail in production under load. |
| SafeDict fixes which problem? | Race on shared dictionary storage — not deadlock by itself. |

---

### Q5. What is deadlock (in GCD terms)?

**Points to:** [Foundations · §3.2 Deadlock rule](../01-foundations.md#32-deadlock-rule-learn-early) · [Deep dive · §2 Deadlock patterns](../02-deep-dive.md#2-deadlock-patterns-memorize)

**Answer:**

> A **wait circle** — threads or queues waiting on each other forever. Classic GCD cases: **`sync` to the serial queue you’re already on** (including main.sync from main), private serial re-entrancy (outer block waits for inner sync), and **cross-queue ABBA** (Queue1 sync-waits Queue2 while Queue2 sync-waits Queue1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Deadlock = wait circle — including sync to current serial queue.” |
| Main-thread symptom? | UI frozen, spinner forever, watchdog may kill app. |
| Fix hierarchy for ABBA? | Always acquire queues/locks in one global order. |

---

### Q6. What is priority inversion?

**Points to:** [Foundations · §8 Race vs deadlock vs priority inversion](../01-foundations.md#8-race-vs-deadlock-vs-priority-inversion) · [Deep dive · §9 QoS and priority inversion](../02-deep-dive.md#9-qos-and-priority-inversion)

**Answer:**

> A **low-priority** task holds a resource (lock, queue, serial section) that a **high-priority** task needs — so high-priority work waits on low-priority work. Example: `.background` task holds a lock while `.userInteractive` UI waits. GCD QoS inheritance helps in some designs; ad-hoc locks make this easier to get wrong — another reason to serialize at **one queue boundary**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Priority inversion = low-priority holder blocks high-priority waiter.” |
| SafeDict on serial queue? | All work same queue — less ad-hoc lock inversion than scattered `NSLock`s. |
| UI feels janky under load? | Check if background work holds contended locks UI needs. |

---

### Q7. How do race, deadlock, and priority inversion differ?

**Points to:** [Foundations · §8 Race vs deadlock vs priority inversion](../01-foundations.md#8-race-vs-deadlock-vs-priority-inversion) · [Deep dive · §10 Trade-off table](../02-deep-dive.md#10-trade-off-table-memorize)

**Answer:**

> **Race** — overlapping unsynchronized access; wrong data or crash, timing-dependent. **Deadlock** — everyone waiting, no progress, often reproducible once you see the sync pattern. **Priority inversion** — progress possible but wrong priority order; high-priority starved by low-priority holder. Three distinct interview terms — don’t conflate them.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SafeDict prevents? | **Races** on the dictionary path — if used correctly. |
| main.sync from main causes? | **Deadlock** — not a race. |
| Low QoS lock + high QoS UI? | **Priority inversion** risk. |

---

### Q8. What is the actors preview for Day 04?

**Points to:** [Foundations · §9 Actors preview](../01-foundations.md#9-actors-preview-one-paragraph) · [Deep dive · §7 Locks vs queues vs actors](../02-deep-dive.md#7-locks-vs-queues-vs-actors) · [Production bridge · §3 S2-A1](../03-production-bridge.md#3-how-i-would-apply-it--s2-a1)

**Answer:**

> A Swift **`actor`** gives **language-enforced isolation** for the same problem SafeDict solves with a serial queue — one executor, serialized access. For **new** code you’d evaluate an actor with get/set/snapshot and `await` (How I would apply it · **S2-A1**). Today’s depth is **GCD** — the production story you shipped. Don’t claim production was rewritten as actors for S2.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor vs serial queue trade-off? | Actor: isolation in type system; API surface becomes async; watch reentrancy across `await`. |
| Migration pitch (not shipped claim)? | “Same safe API — get/set/snapshot — implemented by an actor; callers await.” |
| Day 05 pointer? | [`../day-05/code/SafeDictActor.swift`](../day-05/code/SafeDictActor.swift) as Learning-lab. |

---

Next: [04-production-s2.md](04-production-s2.md)
