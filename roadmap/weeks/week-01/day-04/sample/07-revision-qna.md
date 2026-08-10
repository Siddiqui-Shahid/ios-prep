# Sample 07 — Revision Q&A (day-04) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. Serial vs concurrent queue? `(30–45s)`
**Answer:**

> “A serial queue runs one block at a time in FIFO start order — mutual exclusion via the queue. A concurrent queue can run multiple blocks overlapping. The main queue is serial and owns UI work. For synchronised dictionaries at BookMyShow we used a private serial queue as the exclusion boundary so shared map access couldn’t race.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is the main queue? | “The serial queue bound to the main thread where UIKit/SwiftUI UI work must run.” |
| When prefer concurrent + barrier? | “Read-heavy maps where overlapping reads help, and writes need exclusive barrier sections — BookMyShow RW-style dictionaries.” |
| How does QoS interact? | “Queue QoS influences scheduling priority; mismatched high QoS for background work steals from UI responsiveness.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q2. async vs sync? `(30–45s)`
**Answer:**

> “async enqueues work and returns immediately. sync enqueues and waits until the block finishes — useful when you need a return value. The danger is syncing onto the serial queue you’re already on, including main.sync from main — that deadlocks. For UI updates after networking I hop with main.async, not sync, so I don’t block the callback thread waiting on the main run loop unnecessarily.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why does main.sync from main deadlock? | “Main blocks waiting for the synced block, but that block can’t run until main is free — classic self-wait.” |
| Can private serial queues deadlock the same way? | “Yes — queue.sync from a block already running on that same serial queue deadlocks identically.” |
| sync from async/await contexts — concern? | “Blocking sync inside async code can stall pool threads; prefer await-friendly APIs.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Why not sync to main from main? `(45s)`
**Answer:**

> “If you’re already on the main queue and call DispatchQueue.main.sync, the main thread blocks waiting for that block to run, but that block can’t run until main is free — deadlock. The same self-wait happens on any serial queue if you sync re-enter it. So UI work from main should just run directly or via async for deferred work — never main.sync from main.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Show private serial re-entry deadlock. | “Outer queue.sync nesting another queue.sync on one serial queue waits forever for itself.” |
| How do you structure unlocked internals? | “Keep a private unsynchronized helper and only call it from code already on the protecting queue.” |
| dispatchPrecondition usage? | “Assert onQueue or notOnQueue in debug to catch illegal re-entry early.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How do you implement a thread-safe dictionary? `(90–120s)`
**Answer:**

> “I’d wrap the dictionary in a final class, keep storage private, and keep a private serial DispatchQueue. Reads go through queue.sync so I can return a value and respect prior writes already on the queue. Writes I’d make queue.sync when callers need read-after-write — async write is fine for fire-and-forget but the next line’s sync read isn’t a completion handler. Snapshots return a copied dictionary under sync. The critical product lesson from BookMyShow was standardizing that API so call sites couldn’t touch raw storage — that removed races on that path. For read-heavy maps we also used RW locking. Today for new modules I’d evaluate a Swift actor with the same surface — Design: actor SafeDict, not shipped.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not return storage directly? | “Callers would bypass the queue and race; return a copied snapshot under sync instead.” |
| Async set then immediate get — visibility? | “An async write may not have run yet, so a following sync read can miss it — use sync write when you need read-after-write.” |
| Migrate to actor without big-bang? | “Keep the same SafeDict-style API, implement with an actor behind async methods, and bridge call sites gradually.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. QoS levels — why care? `(45s)`
**Answer:**

> “Quality of Service tells GCD how urgent work is — from userInteractive down to background. It matters for responsiveness and battery. If I classify analytics batching as userInteractive, I compete with real UI work. I pick QoS to match user expectation: fetches the user is waiting on higher; prefetch and cleanup lower.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| List QoS levels roughly. | “userInteractive, userInitiated, default, utility, background — most to least urgent for the user.” |
| Priority inversion with locks? | “A low-priority holder of a lock can block a high-priority waiter; design to avoid long critical sections.” |
| QoS vs Task priority? | “GCD QoS labels queue work; Task priority is the concurrency runtime’s knob — map them thoughtfully at bridges.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. DispatchGroup use case? `(45s)`
**Answer:**

> “DispatchGroup is for fan-out/fan-in: enter before each async child, leave when it finishes, notify when the count hits zero. I use it for parallel prefetches then merge results on the main queue. The classic bug is forgetting leave, so notify never fires — I prefer defer leave right after enter when the structure allows.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| notify queue choice? | “Pick the queue that should own the merge — often main for UI binding.” |
| wait vs notify? | “wait blocks the current thread; notify schedules a completion without blocking — prefer notify on UI paths.” |
| TaskGroup equivalent? | “withTaskGroup or async let fan-out with structured child lifetimes and cancellation.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Barrier flag purpose? `(45s)`
**Answer:**

> “A barrier block on a concurrent queue waits for previously started work and runs exclusively — no other blocks overlap it. That’s the GCD reader-writer pattern: normal sync reads may overlap; writes use barrier. If you write without a barrier on a concurrent queue guarding a dictionary, you still have a data race. At BookMyShow we used RW approaches where maps were read-heavy; otherwise serial queues kept the mental model simpler.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Writer starvation? | “Continuous overlapping readers can delay barriers; cap read concurrency or prefer serial if writes matter.” |
| async barrier vs sync barrier? | “Sync barrier completes the write before return; async barrier only guarantees order relative to later enqueued work.” |
| Serial vs RW trade-off? | “Serial is simpler; concurrent plus barrier helps read-heavy BookMyShow dictionary paths.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q8. Main thread rule for UI? `(30s)`
**Answer:**

> “UIKit and SwiftUI UI updates must happen on the main queue. Networking callbacks often aren’t on main, so I hop with DispatchQueue.main.async before binding views. I keep JSON parsing and image decode off the main thread so scrolling stays smooth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| MainActor relationship? | “MainActor is the Swift concurrency expression of UI-affined work.” |
| What breaks off main? | “Undefined UIKit behavior — torn layouts, missing updates, hard-to-repro crashes.” |
| Instruments? | “Time Profiler and hang detection around main-queue work.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Race vs deadlock? `(45s)`
**Answer:**

> “A race is unsynchronized access to shared mutable state — intermittent corruption or crashes. A deadlock is when threads or queues wait on each other forever — including syncing to the serial queue you’re on. At BookMyShow the synchronised-dictionary work targeted races on shared maps; deadlock avoidance is the companion discipline when you introduce queues and locks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How do you detect each? | “Races: Thread Sanitizer. Deadlocks: hung threads in the debugger and queue ownership graphs.” |
| Example of ABBA deadlock? | “Thread 1 locks A then B while thread 2 locks B then A — each waits forever.” |
| Actor eliminates which bug? | “Data races on the actor’s isolated state; you still design around await reentrancy.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q10. When semaphore over group? `(45s)`
**Answer:**

> “Use a group when you have a batch of tasks and need one continuation when they’re all done. Use a semaphore when you need a concurrency limit — at most N image decodes at once. Semaphores are easy to deadlock if you wait on the wrong queue, so I’m cautious; in modern Swift I’d rather reach for task grouping and explicit limits.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| value of semaphore = 1 means? | “Mutual exclusion — at most one waiter proceeds.” |
| Deadly embrace with sync? | “Waiting on a semaphore while holding the queue the signal path needs can deadlock.” |
| OperationQueue maxConcurrent? | “Caps parallel Operations similarly to a counting semaphore limit.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. `DispatchQueue.main.async` after network? `(30s)`
**Answer:**

> “URLSession completions typically aren’t on the main queue, so after I parse I dispatch async to main before touching UIKit. That keeps UI work legal without deadlocking via sync. If the view model is MainActor, the hop may be structured differently, but the rule remains: UI affinity on main.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where should parsing happen? | “Off the main queue — parse on a background queue or Task, then hop to main only to bind UI.” |
| Cancellation if VC gone? | “Cancel on disappear and use weak self so completion doesn’t revive the VC.” |
| Combine/async alternatives? | “receive(on: main) or MainActor async functions replace manual main.async hops.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “Serial vs concurrent queue?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “A serial queue runs one block at a time in FIFO start order — mutual exclusion via the queue. A concurrent queue can run multiple blocks overlapping. The main queue is serial and owns UI work. For synchronised dictionaries at BookMyShow we used a private serial queue as the exclusion boundary so shared map access couldn’t race.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Serial vs concurrent queue |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “async vs sync” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “async enqueues work and returns immediately. sync enqueues and waits until the block finishes — useful when you need a return value. The danger is syncing onto the serial queue you’re already on, including main.sync from main — that deadlocks. For UI updates after networking I hop with main.async, not sync, so I don’t block the callback thread waiting on the main run loop unnecessarily.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | async vs sync |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “Why not sync to main from main”. How do you diagnose? `(60–90s)`
**Answer:**

> “If you’re already on the main queue and call DispatchQueue.main.sync, the main thread blocks waiting for that block to run, but that block can’t run until main is free — deadlock. The same self-wait happens on any serial queue if you sync re-enter it. So UI work from main should just run directly or via async for deferred work — never main.sync from main.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Why not sync to main from main |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “How do you implement a thread-safe dictionary”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “I’d wrap the dictionary in a final class, keep storage private, and keep a private serial DispatchQueue. Reads go through queue.sync so I can return a value and respect prior writes already on the queue. Writes I’d make queue.sync when callers need read-after-write — async write is fine for fire-and-forget but the next line’s sync read isn’t a completion handler. Snapshots return a copied dictionary under sync. The critical product lesson from BookMyShow was standardizing that API so call sites couldn’t touch raw storage — that removed races on that path. For read-heavy maps we also used RW locking. Today for new modules I’d evaluate a Swift actor with the same surface — Design: actor SafeDict, not shipped.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you implement a thread-safe dictionary |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “QoS levels — why care”? `(60–90s)`
**Answer:**

> “Quality of Service tells GCD how urgent work is — from userInteractive down to background. It matters for responsiveness and battery. If I classify analytics batching as userInteractive, I compete with real UI work. I pick QoS to match user expectation: fetches the user is waiting on higher; prefetch and cleanup lower.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | QoS levels — why care |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “DispatchGroup use case” and how you’d correct it? `(60–90s)`
**Answer:**

> “DispatchGroup is for fan-out/fan-in: enter before each async child, leave when it finishes, notify when the count hits zero. I use it for parallel prefetches then merge results on the main queue. The classic bug is forgetting leave, so notify never fires — I prefer defer leave right after enter when the structure allows.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | DispatchGroup use case |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Barrier flag purpose?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “A barrier block on a concurrent queue waits for previously started work and runs exclusively — no other blocks overlap it. That’s the GCD reader-writer pattern: normal sync reads may overlap; writes use barrier. If you write without a barrier on a concurrent queue guarding a dictionary, you still have a data race. At BookMyShow we used RW approaches where maps were read-heavy; otherwise serial queues kept the mental model simpler.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Barrier flag purpose |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “Main thread rule for UI” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “UIKit and SwiftUI UI updates must happen on the main queue. Networking callbacks often aren’t on main, so I hop with DispatchQueue.main.async before binding views. I keep JSON parsing and image decode off the main thread so scrolling stays smooth.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Main thread rule for UI |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Async set then sync get — do you see the write? `(90s)`
**Answer:**

> “Async set only schedules the write and returns. Sync get waits for work already on that serial queue. On the same thread, FIFO enqueue often means you see the value — but that’s not a completion handler, and across threads you can miss it until the write actually runs. If the call site needs read-after-write, I use sync set or one sync transaction. Interview line: async write then sync read may not see the write until the write runs. At BookMyShow we preferred a closed API with defined visibility, not fire-and-forget guesses.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Document async set as fire-and-forget only. Teaching SafeDict defaults to sync set.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Concept:** Visibility is part of the API contract, not an accident of timing.

---

### T2. Why must queue and storage stay private? `(90s)`
**Answer:**

> “If callers can touch storage, they race. If they get the queue, they invent sync and async around your methods — re-entry deadlocks, target-queue inversion, order you didn’t design. The BookMyShow fix wasn’t ‘add a queue somewhere’ — it was standardize the access API so call sites couldn’t touch raw storage. Snapshot returns a value copy under sync. Hide the queue; expose get, set, snapshot.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Exposing the queue for ‘advanced callers’ is how production races come back.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Don’t claim:** Lab SafeDict.swift was the shipped file.

---

### T3. Private serial re-entry — why deadlock? `(90–120s)`
**Answer:**

> “Same shape as main.sync from main. You’re already executing on a serial queue — maybe inside queue.async or a public sync method — and you call queue.sync again. The inner sync waits for the outer block to finish; the outer block waits for the inner sync. Forever. Fix: unlocked internals called only when already on-queue, with dispatchPrecondition in debug, or nest with async. Not only main — any serial queue.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Method a syncs then calls b which also syncs — same deadlock without an obvious nested block.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T4. Concurrent dict without barrier — autopsy? `(90s)`
**Answer:**

> “Concurrent queue, async write to storage, async read of storage, no barrier — data race. Concurrent means overlap is allowed; it does not mean the dictionary became thread-safe. Fix: barrier on writes for a reader-writer model, or fall back to serial SafeDict. Watch writer starvation under constant readers. BookMyShow honesty: serial generally; RW where read-heavy and measured — don’t claim barriers everywhere.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Race is not deadlock. TSan catches this; barriers fix exclusivity for writers.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Lab only:** BarrierDict.swift — Learning-lab.

---

### T5. `group.wait` on main — what freezes? `(90s)`
**Answer:**

> “wait blocks the calling thread until the group’s enter/leave count hits zero. On main, that freezes UI. If a leave is missing on an error path, it freezes forever. Prefer notify on main for the merge. Pair every enter with defer leave. Semaphores have a cousin trap: wait on the wrong queue that must run the signal. Awareness only — new code leans TaskGroup.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Symptom: spinner forever after a prefetch fan-out — check leave balance and where you waited.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T6. “Rewrite all BMS dictionaries as actors” — your reply? `(90–120s)`
**Answer:**

> “I’d push back on big-bang. Shipped fix was GCD synchronised dictionaries with a closed API — that path is proven. For greenfield shared maps I’d use Design: actor SafeDict with the same get/set/snapshot surface — design judgment, not a claim we rewrote the org. Strangler at module boundaries. New pitfall to train: reentrancy after await, not queue.sync deadlock. And I won’t hang app-wide crash-free percent on either story alone.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Same boundary idea — hide storage, one writer path — different enforcement.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Don’t claim:** Org-wide actor rewrite or CFS ownership from dictionaries alone.

---

### T7. GCD `sync` from async/await — what fails? `(90s)`
**Answer:**

> “The cooperative thread pool can starve if async tasks block on DispatchQueue.sync. Sync to main is especially nasty — deadlock or long stalls. Prefer async façades with withCheckedContinuation, resume exactly once — double-resume crashes. At BookMyShow we still serialize dictionaries on GCD — the rule is don’t bridge with sync from the middle of async/await paths.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Symptom: ‘everything is async’ but the app hangs under load.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Concept:** Serialize at the boundary without blocking the pool.

---

### T8. Target-queue inversion? `(90s)`
**Answer:**

> “You pass your private serial queue into an API as its callback queue. That API later syncs back onto the same queue while you’re already inside a sync or async block on it — re-entrancy deadlock. Or it syncs onto the caller in a way that inverts your intended hop. Fix: never expose the queue. Expose methods; let libraries call you, then you hop with async. Same instinct as hiding storage in BookMyShow synchronised dictionaries.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Related: main.sync from a pool worker blocks that worker until main runs — prefer main.async.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Concept:** Hide queues; expose safe methods.

---

### T9. Writer starvation on concurrent + barrier? `(90s)`
**Answer:**

> “Barrier writers need exclusivity. If readers keep entering on a concurrent queue, the writer can wait a long time — starvation, not a deadlock. Progress exists; it’s just unfair. Mitigations: batch writes, tune QoS, limit read concurrency, or fall back to serial SafeDict when simplicity beats read parallelism. That’s why serial is my default whiteboard answer unless I’ve measured read-heavy contention.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Don’t confuse starvation with race — without barrier you have a race; with barrier you can still starve writers.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries — RW where read-heavy; serial otherwise.
- **Concept:** Measure before choosing barrier complexity.

---

### T10. “We fixed all BMS crashes with SafeDict” — what’s wrong? `(90–120s)`
**Answer:**

> “Scope and honesty. Synchronised dictionaries eliminated concurrent-access crashes on that shared-map path — intermittent races under multi-queue access. Saying fixed all BMS crashes or owning 99.95% CFS alone steals BookMyShow IMOC and crash-free-at-scale culture credit and invents metrics. I say path-specific, Crashlytics watch, pattern reused. Lab SafeDict.swift is Learning-lab, not the shipped file. If they push for a number, I refuse to invent one.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Separate dictionary STAR from reliability-culture stories — different questions, different labels.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Don’t claim:** Exact crash %, org-wide CFS from dictionaries alone, or lab file as production.

---

### T11. Why does the app freeze? `(90–120s)`
**Answer:**

> “Main is serial with one worker. Sync waits for the block to run on main, but main is stuck waiting — classic self-wait deadlock. Same rule on any private serial queue. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T12. Does `"inner"` ever print? `(90–120s)`
**Answer:**

> “No — deadlock. Outer block owns the serial queue; inner sync waits for outer to finish. Fix: call _unlocked helpers already on-queue, or nest with async. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T13. What’s the failure mode under load? `(90–120s)`
**Answer:**

> “You block a pool thread instead of suspending. Under contention the pool starves; hangs look like “everything is async.” Prefer an async façade / continuation that resumes once. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T14. What happens? `(90–120s)`
**Answer:**

> “Re-entrancy deadlock / inversion. Don’t expose the queue. Expose methods; let the library call you on a queue you control with async hops. --- Next: 02-thread-safe-dict.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
