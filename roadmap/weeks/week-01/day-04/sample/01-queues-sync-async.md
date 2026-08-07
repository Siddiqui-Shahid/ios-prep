# Sample 01 — Queues, sync/async, deadlock (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the difference between serial and concurrent queues?

**Answer:**

> A **serial** queue runs one task at a time — FIFO start order, like a single checkout lane. A **concurrent** queue may run multiple tasks overlapping — start order is still FIFO, but finish order varies. Serial queues are the default mental model for protecting shared state. Concurrent queues are useful when you want parallel reads with a barrier for exclusive writes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener for an interview? | “Serial is one-at-a-time; concurrent is overlapping execution.” |
| Which does SafeDict Pattern A use? | A **private serial** queue — simple mutual exclusion for every operation. |
| Does concurrent mean “always faster”? | No. Overlap helps read-heavy work with barriers; it adds complexity and starvation risk. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. When do I use the main queue vs global queues?

**Answer:**

> The **main queue** is a serial queue tied to the main thread. All UIKit and SwiftUI UI updates belong here. **Global queues** (`DispatchQueue.global(qos: …)`) are system-managed concurrent pools for background work — network parsing, image decode, file I/O. Rule of thumb: UI on main; heavy work off main, then hop back with `main.async` to apply results.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| URLSession callback — which queue? | Often a background session queue, **not** main by default. Hop to main for UI. |
| Can I create my own serial queue for UI? | No — UI must run on main. Custom serial queues are for protecting your own shared state. |
| What is QoS for? | Priority and energy class — `.userInitiated` for user-waiting work, `.utility` for long progress-visible tasks, etc. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What do `async` and `sync` mean on a queue?

**Answer:**

> **`async`** schedules a block and **returns immediately** — fire-and-forget or “run this later on that queue.” **`sync`** schedules a block and **waits until it finishes** before returning — useful when you need a return value or a happens-before guarantee with prior work on that queue. Sync blocks the calling thread; async does not.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is sync appropriate? | Reading a value from a protected store, short critical sections, read-after-write on the same API. |
| When prefer async? | Fire-and-forget updates, avoiding blocking the caller (especially main). |
| sync from background to main for UI? | Works but **blocks the background thread** until main runs the block — prefer `main.async` unless you must wait. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Why does `DispatchQueue.main.sync` from the main thread deadlock?

**Answer:**

> Main is a **serial** queue with one worker (the main thread). `main.sync` from main says: “wait until this block runs on main.” But main is already busy waiting — it cannot run the block. Nobody progresses → **deadlock**. Same logic applies to **any** private serial queue: never `sync` onto the queue you are already executing on.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Say-aloud line? | “Sync waits. If the waiter is the only worker that can run the work, you freeze.” |
| Fix for nested work on a serial queue? | Use `async` for nested calls, or factor `_unlocked` internals called only from inside the queue. |
| Is this only a main-thread problem? | No — **any** serial queue self-sync deadlocks. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Can a private serial queue deadlock the same way?

**Answer:**

> Yes. If you are inside `queue.async { … }` and call `queue.sync { … }` on the same serial queue, the inner sync waits for the outer block to finish — but the outer block waits for the inner sync. Classic re-entrancy deadlock. Same if method `a()` syncs to the queue and calls `b()`, which also syncs to the queue.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Debug aid? | `dispatchPrecondition(condition: .onQueue(queue))` on unlocked internals. |
| Service design fix? | Split public sync API from `_mutateUnlocked()` that assumes caller is already on queue. |
| Cross-queue deadlock? | ABBA pattern — Queue1 waits on Queue2 while Queue2 waits on Queue1. Keep a lock hierarchy. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is QoS and why does it matter?

**Answer:**

> **Quality of Service** tells the system how urgent and energy-sensitive work is — from `.userInteractive` (tiny UI-critical) down to `.background` (prefetch that can wait). Higher QoS gets CPU sooner under contention. Mislabeling everything `.userInteractive` steals energy and starves other work. QoS also ties into **priority inversion** when low-priority holders block high-priority waiters.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fetch for a screen the user is waiting on? | `.userInitiated` — user is waiting. |
| Bulk cache cleanup? | `.utility` or `.background`. |
| Senior line on QoS abuse? | “Don’t mark everything userInteractive — you steal energy and starve work.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What is the one-sentence north star for this day?

**Answer:**

> **Serialize access to shared mutable state at a clear boundary — don’t sprinkle locks ad hoc — and never block a queue waiting for itself.** That boundary at BookMyShow was synchronised dictionaries behind GCD (BookMyShow synchronised dictionaries). Day 05 modernizes the same idea with actors (Design: actor SafeDict (not shipped)).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why “clear boundary”? | Call sites get a safe API; they cannot touch raw storage and reintroduce races. |
| What’s wrong with ad-hoc locks everywhere? | Easy to invert priority, forget unlock, or deadlock across queues. |
| First self-check item? | Serial vs concurrent in one sentence each. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q8. Why do threads race in the first place?

**Answer:**

> Swift dictionaries (and most mutable collections) are **not** thread-safe. Two threads mutating or reading-while-writing the same storage without synchronization → **data race** → intermittent crashes or corruption under load. What we want: mutual exclusion for writes, defined read visibility, a safe API, and no self-deadlock.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Say-aloud line? | “If two threads touch shared mutable memory without synchronization, that’s a race — undefined behavior territory.” |
| Why hard to reproduce? | Timing-dependent — shows up under concurrency stress or production load. |
| UI symptom? | Intermittent EXC_BAD_ACCESS or corrupted state — not every time. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. How do you mix GCD with async/await safely?

**Answer:**

> Bridge legacy queues with **async façades** — typically `withCheckedContinuation` that resumes exactly once from `queue.async`. Do **not** casually call `queue.sync` from an async context: that can block a cooperative-pool thread and hang under load. Prefer actors or async wrappers for new isolation. Day 04 rule: **don’t casually sync from the async world**; Day 05 deepens the same trap.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why continuation not sync? | Sync blocks a pool thread; continuation suspends cooperatively. |
| Resume how many times? | Exactly once — double-resume crashes. |
| Keep GCD SafeDict? | Yes for stable BookMyShow synchronised dictionaries modules — wrap call sites at boundaries. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q10. What is target-queue inversion / a thread-hop edge case?

**Answer:**

> **Target-queue inversion:** you pass your private queue into an API that later **syncs back onto the caller** (or onto that same queue) → re-entrancy surprises and deadlocks. **Thread-hop edges:** URLSession callbacks are often **not** main — hop with `main.async` for UI; prefer async hops over `main.sync` from a pool worker (blocks the worker until main runs). **Hide queues; expose methods** so call sites never invent sync-back paths.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| UI after network? | Parse off main when heavy; apply on main via async hop. |
| When is main.sync OK? | Rare need to wait — usually prefer main.async. |
| Expose the serial queue? | Never for BookMyShow synchronised dictionaries-style safety — call sites reintroduce races/inversion. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

Next: [02-thread-safe-dict.md](02-thread-safe-dict.md)

---

