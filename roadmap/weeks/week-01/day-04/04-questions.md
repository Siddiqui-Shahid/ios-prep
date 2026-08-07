# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Serial vs concurrent queue? `(30–45s)`

**Answer:**

> A serial queue runs one block at a time in FIFO start order — it’s mutual exclusion via queue. A concurrent queue can run multiple blocks overlapping. The main queue is serial and owns UI work. For synchronised dictionaries at BookMyShow we used a private serial queue as the exclusion boundary so shared map access couldn’t race.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is the main queue? | The serial queue bound to the main thread where UIKit/SwiftUI UI work must run. |
| When prefer concurrent + barrier? | Read-heavy maps where overlapping reads help, and writes need exclusive barrier sections — BookMyShow RW-style dictionaries. |
| How does QoS interact? | Queue/work QoS influences scheduling priority; mismatched high QoS for background work steals from UI responsiveness. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q2. async vs sync? `(30–45s)`

**Answer:**

> `async` enqueues work and returns immediately. `sync` enqueues and waits until the block finishes — useful when you need a return value. The danger is syncing onto the serial queue you’re already on, including `main.sync` from main — that deadlocks. For UI updates after networking I hop with `main.async`, not sync, so I don’t block the callback thread waiting on the main run loop unnecessarily.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why does main.sync from main deadlock? | Main blocks waiting for the synced block, but that block can’t run until main is free — classic self-wait. |
| Can private serial queues deadlock the same way? | Yes — `queue.sync` from a block already running on that same serial queue deadlocks identically. |
| sync from async/await contexts — concern? | Blocking sync inside async code can stall threads and invite priority/deadlock issues; prefer await-friendly APIs. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Why not sync to main from main? `(45s)`

**Answer:**

> If you’re already on the main queue and call `DispatchQueue.main.sync`, the main thread blocks waiting for that block to run, but that block can’t run until main is free — deadlock. The same self-wait happens on any serial queue if you sync re-enter it. So UI work from main should just run directly or via async for deferred work — never main.sync from main.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Show private serial re-entry deadlock. | Outer `queue.sync { queue.sync { … } }` on one serial queue waits forever for itself. |
| How do you structure unlocked internals? | Keep a private unsynchronized helper and only call it from code already on the protecting queue. |
| `dispatchPrecondition` usage? | Assert `.onQueue` / `.notOnQueue` in debug to catch illegal re-entry or wrong-queue assumptions early. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How do you implement a thread-safe dictionary? `(90–120s)`

**Answer:**

> I’d wrap the dictionary in a `final class`, keep storage private, and keep a private serial `DispatchQueue`. Reads go through `queue.sync` so I can return a value and respect prior writes already on the queue. Writes I’d make `queue.sync` when callers need read-after-write — async write is fine for fire-and-forget but the next line’s sync read isn’t a completion handler. Snapshots return a copied dictionary under sync. The critical product lesson from BookMyShow was standardizing that API so call sites couldn’t touch raw storage — that removed races on that path. For read-heavy maps we also used RW locking. Today for new modules I’d evaluate a Swift actor with the same surface.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not return `storage` directly? | Callers would bypass the queue and race; return a copied snapshot under sync instead. |
| Async set then immediate get — visibility? | An async write may not have run yet, so a following sync read can miss it — use sync write when you need read-after-write. |
| Migrate to actor without big-bang? | Keep the same SafeDict-style API, implement with an actor behind async methods, and bridge call sites gradually. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. QoS levels — why care? `(45s)`

**Answer:**

> Quality of Service tells GCD how urgent work is — from userInteractive down to background. It matters for responsiveness and battery. If I classify analytics batching as userInteractive, I compete with real UI work. I pick QoS to match user expectation: fetches the user is waiting on higher; prefetch and cleanup lower.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| List QoS levels roughly. | userInteractive, userInitiated, default, utility, background — from most to least urgent for the user. |
| Priority inversion with locks? | A low-priority holder of a lock can block a high-priority waiter; the system may boost, but design to avoid long critical sections. |
| QoS vs Task priority in Swift concurrency? | GCD QoS labels queue work; Task priority is the concurrency runtime’s knob — map them thoughtfully at bridges. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. DispatchGroup use case? `(45s)`

**Answer:**

> DispatchGroup is for fan-out/fan-in: enter before each async child, leave when it finishes, notify when the count hits zero. I use it for parallel prefetenches then merge results on the main queue. The classic bug is forgetting leave, so notify never fires — I prefer `defer { leave() }` right after enter when the structure allows.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| notify queue choice? | Pick the queue that should own the merge/UI update — often main for binding, a private queue for pure aggregation. |
| wait vs notify? | `wait` blocks the current thread; `notify` schedules a completion without blocking — prefer notify on UI paths. |
| TaskGroup equivalent? | `withTaskGroup` / `async let` fan-out with structured child lifetimes and cancellation. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Barrier flag purpose? `(45s)`

**Answer:**

> A barrier block on a concurrent queue waits for previously started work and runs exclusively — no other blocks overlap it. That’s the GCD reader-writer pattern: normal sync reads may overlap; writes use `.barrier`. If you write without a barrier on a concurrent queue guarding a dictionary, you still have a data race. At BookMyShow we used RW approaches where maps were read-heavy; otherwise serial queues kept the mental model simpler.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Writer starvation? | Continuous overlapping readers can delay barriers indefinitely; cap read concurrency or prefer serial if writes matter. |
| async barrier vs sync barrier visibility? | Sync barrier completes the write before return; async barrier only guarantees order relative to later enqueued work. |
| Serial vs RW trade-off? | Serial is simpler and race-harder to misuse; concurrent+barrier helps read-heavy BookMyShow dictionary paths. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q8. Main thread rule for UI? `(30s)`

**Answer:**

> UIKit and SwiftUI UI updates must happen on the main queue. Networking callbacks often aren’t on main, so I hop with `DispatchQueue.main.async` before binding views. I keep JSON parsing and image decode off the main thread so scrolling stays smooth.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `@MainActor` relationship? | `@MainActor` is the Swift concurrency expression of “this state/UI work belongs on the main actor.” |
| What breaks if you update UI off main? | Undefined UIKit behavior — torn layouts, missing updates, and hard-to-repro crashes/warnings. |
| Instruments for main-thread hangs? | Time Profiler / Hang detection / os_signpost around main-queue work to find long synchronous blocks. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Race vs deadlock? `(45s)`

**Answer:**

> A race is unsynchronized access to shared mutable state — intermittent corruption or crashes. A deadlock is when threads or queues wait on each other forever — including syncing to the serial queue you’re on. At BookMyShow the synchronised-dictionary work targeted races on shared maps; deadlock avoidance is the companion discipline when you introduce queues and locks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How do you detect each in tools? | Races: Thread Sanitizer; deadlocks: hung threads in the debugger and queue/lock ownership graphs. |
| Example of ABBA deadlock? | Thread 1 locks A then B while thread 2 locks B then A — each waits forever for the other’s lock. |
| Actor eliminates which class of bug? | Data races on the actor’s isolated state; you still design carefully around await reentrancy and external locks. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q10. When semaphore over group? `(45s)`

**Answer:**

> Use a group when you have a batch of tasks and need one continuation when they’re all done. Use a semaphore when you need a concurrency limit — at most N image decodes at once. Semaphores are easy to deadlock if you wait on the wrong queue, so I’m cautious; in modern Swift I’d rather reach for task grouping and explicit limits.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| value of semaphore = 1 means? | Mutual exclusion — at most one waiter proceeds, like a binary lock, without being a full reader-writer scheme. |
| Deadly embrace with sync? | Waiting on a semaphore while holding the queue that the signal path needs to run on can deadlock. |
| OperationQueue maxConcurrent? | Caps parallel Operations similarly to a counting semaphore limit, with Operation dependencies as extra structure. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. `DispatchQueue.main.async` after network? `(30s)`

**Answer:**

> URLSession completions typically aren’t on the main queue, so after I parse I dispatch async to main before touching UIKit. That keeps UI work legal without deadlocking via sync. If the view model is `@MainActor`, the hop may be structured differently, but the rule remains: UI affinity on main.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where should parsing happen? | Off the main queue — parse on a background queue/Task, then hop to main only to bind UI. |
| Cancellation if VC gone? | Cancel the task/URLSession task on disappear/deinit and use `[weak self]` so completion doesn’t revive the VC. |
| Combine/async alternatives? | `receive(on: DispatchQueue.main)` or `@MainActor` async functions replace manual `main.async` hops. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

## Timed sets

| Set | Items |
|---|---|
| A | Q4, Q2, T3, T4 |
| B | Q1, Q7, T1, T2 |
| C | Full BookMyShow synchronised dictionaries STAR + T6 + Design: actor SafeDict (not shipped) 90s |

Score with [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md).
