# Sample 03 — Groups, races, concurrency traps (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is DispatchGroup for?

**Answer:**

> A **DispatchGroup** tracks in-flight async work. Call **`enter()`** before starting work and **`leave()`** when done — counts must balance. Use **`notify(queue:)`** to run a completion when all work finishes — typical pattern: fan-out downloads on background queues, merge results on **main**. Use case: prefetch multiple URLs, then update UI once all complete.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Classic trap? | Forget **`leave()`** → notify never fires; group stuck forever. |
| Safe pattern? | `group.enter(); defer { group.leave() }` immediately after enter. |
| Where to notify for UI? | **`DispatchQueue.main`** for the merge/update block. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What are common DispatchGroup pitfalls?

**Answer:**

> **Unbalanced enter/leave** — every enter needs exactly one leave on all paths (use `defer`). **notify on wrong queue** — UI merge belongs on main. **Blocking main with `wait()`** — can freeze UI; prefer `notify` or avoid waiting on main entirely. **Double leave** — also breaks the count.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Error path in download callback? | Still `leave()` in `defer` — success or failure. |
| `wait()` vs `notify`? | `wait()` blocks the calling thread; `notify` schedules async completion. |
| Timeout in tools? | Some code uses timed wait for diagnostics — don’t block main in production UI. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is a semaphore (awareness level)?

**Answer:**

> A **DispatchSemaphore** limits how many tasks run concurrently — e.g. `value: 4` means at most four in flight. **`wait()`** decrements (blocks if zero); **`signal()`** increments. Classic use: cap parallel image decodes. Easy to **deadlock** if you `wait` on the wrong queue or forget to `signal`. Modern Swift prefers structured concurrency / `TaskGroup` (Day 05).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview depth for today? | **Awareness only** — name it, know the deadlock risk, point to TaskGroup for new code. |
| Semaphore vs serial queue? | Semaphore limits parallelism; serial queue enforces one-at-a-time on that queue’s tasks. |
| Wrong-queue wait trap? | Waiting on a queue that must run the signaling work → circular wait. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is a data race?

**Answer:**

> **Unsynchronized shared mutable access** — two threads touch the same memory without a happens-before rule, at least one writing. Swift dictionaries aren’t thread-safe; concurrent mutation → undefined behavior, intermittent crashes. Fix: serialize at a boundary (serial queue, lock, actor).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Race = unsynchronized shared mutable access.” |
| vs logic bug? | Race is timing-dependent; may pass tests, fail in production under load. |
| SafeDict fixes which problem? | Race on shared dictionary storage — not deadlock by itself. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is deadlock (in GCD terms)?

**Answer:**

> A **wait circle** — threads or queues waiting on each other forever. Classic GCD cases: **`sync` to the serial queue you’re already on** (including main.sync from main), private serial re-entrancy (outer block waits for inner sync), and **cross-queue ABBA** (Queue1 sync-waits Queue2 while Queue2 sync-waits Queue1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Deadlock = wait circle — including sync to current serial queue.” |
| Main-thread symptom? | UI frozen, spinner forever, watchdog may kill app. |
| Fix hierarchy for ABBA? | Always acquire queues/locks in one global order. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is priority inversion?

**Answer:**

> A **low-priority** task holds a resource (lock, queue, serial section) that a **high-priority** task needs — so high-priority work waits on low-priority work. Example: `.background` task holds a lock while `.userInteractive` UI waits. GCD QoS inheritance helps in some designs; ad-hoc locks make this easier to get wrong — another reason to serialize at **one queue boundary**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-liner? | “Priority inversion = low-priority holder blocks high-priority waiter.” |
| SafeDict on serial queue? | All work same queue — less ad-hoc lock inversion than scattered `NSLock`s. |
| UI feels janky under load? | Check if background work holds contended locks UI needs. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. How do race, deadlock, and priority inversion differ?

**Answer:**

> **Race** — overlapping unsynchronized access; wrong data or crash, timing-dependent. **Deadlock** — everyone waiting, no progress, often reproducible once you see the sync pattern. **Priority inversion** — progress possible but wrong priority order; high-priority starved by low-priority holder. Three distinct interview terms — don’t conflate them.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SafeDict prevents? | **Races** on the dictionary path — if used correctly. |
| main.sync from main causes? | **Deadlock** — not a race. |
| Low QoS lock + high QoS UI? | **Priority inversion** risk. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What is the actors preview for Day 04?

**Answer:**

> A Swift **`actor`** gives **language-enforced isolation** for the same problem SafeDict solves with a serial queue — one executor, serialized access. For **new** code you’d evaluate an actor with get/set/snapshot and `await` (Design: **Design: actor SafeDict (not shipped)**). Today’s depth is **GCD** — the production story you shipped. Don’t claim production was rewritten as actors for BookMyShow synchronised dictionaries.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor vs serial queue trade-off? | Actor: isolation in type system; API surface becomes async; watch reentrancy across `await`. |
| Migration pitch (not shipped claim)? | “Same safe API — get/set/snapshot — implemented by an actor; callers await.” |
| Day 05 pointer? | [`../day-05/code/SafeDictActor.swift`](../day-05/code/SafeDictActor.swift) as Learning-lab. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q9. Locks vs queues vs actors — how do you compare them?

**Answer:**

> **Serial queue wrapper** — simple shared maps (BookMyShow synchronised dictionaries); cost is sync-read latency under load and `sync` deadlock if misused. **Concurrent + barrier** — read-heavy maps; cost is complexity and writer starvation. **NSLock / os_unfair_lock** — tiny critical sections; easy to forget unlock and hit **priority inversion**. **`actor`** — greenfield / Design: actor SafeDict (not shipped); compiler isolation, async API, reentrancy across `await`. Pitch (not a shipped claim): same get/set/snapshot surface on an actor; isolation moves from convention to the type system.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default for shared maps today? | Serial-queue SafeDict for legacy BookMyShow synchronised dictionaries; actor for new modules. |
| Why not locks everywhere? | Ordering bugs, forgotten unlock, inversion under QoS. |
| Barrier when? | Read-dominated large maps — measure; watch writer starvation. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

Next: [04-production-s2.md](04-production-s2.md)

---

