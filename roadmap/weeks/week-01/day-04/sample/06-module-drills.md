# Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)

> Pulled from `01-foundations`, `02-deep-dive`, `05-exercises`, and the day README — anything easy to miss if you only read samples 01–05.  
> Say answers like a conversation. Then do the real coding drills in [`../05-exercises.md`](../05-exercises.md).  
> **Brain puzzles** at the bottom — cover → think → check.

---

### Q1. Walk the concurrentPerform race harness (exercise 2)

**Answer:**

> “I spin two pictures. Picture one: a plain `[String: Int]` mutated from many workers via `DispatchQueue.concurrentPerform` or a pile of `global().async` plus a group notify — conceptually chaos, Thread Sanitizer should scream. Picture two: the same ops through SafeDict — coherent counts, no race on storage. Speak: BookMyShow synchronised dictionaries fixed the API boundary so call sites couldn’t race the map.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why concurrentPerform? | “Easy fan-out of N iterations without hand-rolling N queues.” |
| What do you assert? | “Final counts and invariants under SafeDict; don’t invent crash percentages.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Lab only:** Race harness is Learning-lab — not BMS source.

---

### Q2. Cross-thread async-set → sync-get visibility

**Answer:**

> “Thread A calls setAsync. Thread B immediately sync-gets. There is no call-site completion — B may miss the write until A’s block actually runs. Same-thread FIFO often hides the bug. Interview rule: for read-after-write certainty, sync set or one sync transaction. Don’t document async set as ‘write done.’”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scenario A sync then sync? | “Sees the value — write completed before set returned.” |
| Scenario B async then sync same thread? | “Often sees it due to enqueue order — still not a contract I’d sell.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. `_mutateUnlocked` + `dispatchPrecondition`

**Answer:**

> “Public methods sync onto the queue. Internals that assume you’re already on-queue are named `_mutateUnlocked` or similar. At the top: `dispatchPrecondition(condition: .onQueue(queue))` in debug. That catches illegal re-entry and wrong-queue calls before you ship a silent race or deadlock.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not sync again inside? | “That’s the private serial re-entry deadlock.” |
| Production assert? | “Precondition is a debug/assert tool — still design so unlocked paths are only called on-queue.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Incorrect concurrent dict autopsy (no barrier)

**Answer:**

> “Someone uses a concurrent queue, async-writes `storage[k] = v`, and async-reads `storage[k]` with no `.barrier`. That’s a data race — overlapping unsynchronized mutation. Autopsy: either add barrier writes and document the RW model, or fall back to serial SafeDict. BookMyShow honesty: serial generally; RW where read-heavy and measured.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is concurrent alone enough? | “No — concurrent without exclusive writes is still a race.” |
| Writer starvation angle? | “Even with barriers, constant readers can starve writers — know that trade-off.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Don’t claim:** Barriers were used on every map.

---

### Q5. QoS inheritance / priority inversion depth

**Answer:**

> “If a `.background` task holds a lock or serial section that `.userInteractive` UI needs, the high-priority work waits on the low-priority holder — priority inversion. GCD can inherit QoS in some queue designs; scattered NSLocks make it worse. Prefer one queue boundary for shared maps so you’re not inventing lock order under mixed QoS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mislabel everything userInteractive? | “Steals energy and starves real UI and utility work.” |
| SafeDict help? | “All map ops share one queue — less ad-hoc lock inversion.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. `withCheckedContinuation` double-resume

**Answer:**

> “When bridging GCD to async/await, resume the continuation exactly once. Double-resume crashes. Never resume: hangs forever. Pattern: `queue.async { continuation.resume(returning: value) }` with a clear single path — success or failure, not both.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not queue.sync from async? | “Blocks the cooperative pool — prefer suspension.” |
| Checked vs unsafe? | “Checked catches double-resume in debug — still write for exactly once.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries — keep GCD maps; wrap call sites at async boundaries carefully.

---

### Q7. Three-queue ABBA / lock hierarchy

**Answer:**

> “Queue1 sync-waits Queue2 while Queue2 sync-waits Queue1 — ABBA deadlock. With three queues the same rule scales: pick a global acquire order and never take locks or sync waits out of order. If you must hop, prefer async and avoid holding one queue while syncing another.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom? | “Hung threads; UI may freeze if main is in the circle.” |
| Fix? | “One hierarchy. Or collapse to a single serial owner for that state.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. `group.wait()` on main + semaphore wrong queue

**Answer:**

> “group.wait on main freezes the UI until every leave fires — if leave is forgotten, forever. Prefer notify on main. Semaphore wait on the queue that must run the signal path is a circular wait. Awareness-level: name the traps; for new fan-out prefer TaskGroup.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Safe group pattern? | “enter; defer leave; notify on the right queue.” |
| Semaphore value 1? | “Binary exclusion — still easy to deadlock if waited wrong.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Actor SafeDict reentrancy vs serial-queue + offline sync instinct

**Answer:**

> “Serial SafeDict: sync critical sections — no await in the middle, so that section doesn’t re-enter. Actor SafeDict: another call can enter across await — no data race on storage, logic can still break. Offline SyncEngine actor uses the same single-writer instinct as BookMyShow synchronised dictionaries — one pipeline, coalesce triggers. Design: actor SafeDict is the greenfield map version of that instinct — not a shipped rewrite.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Same API? | “get / set / snapshot — await on actor, sync on GCD.” |
| Big-bang rewrite? | “No — strangler; label design vs shipped.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped); offline SyncEngine as design exercise.

---

### Q10. Flash recall — fire front → back like cards

**Answer:**

> “Serial vs concurrent — one-at-a-time vs overlap.
>
> main.sync from main — deadlock; any serial self-sync same.
>
> SafeDict — final class, private storage, private serial queue, sync get/set, snapshot.
>
> Async write / sync read — may not see write until it runs; prefer sync set.
>
> Barrier — exclusive writer on concurrent queue; without it, race; watch writer starvation.
>
> Hide queue — BookMyShow synchronised dictionaries lesson.
>
> Race vs deadlock vs priority inversion — three different bugs.
>
> DispatchGroup — balanced enter/leave; don’t wait on main.
>
> Continuations — resume exactly once; don’t sync from async pool.
>
> Verified dictionaries — path-specific races gone; don’t invent CFS %.
>
> Actor coda — Design: actor SafeDict, not shipped.
>
> Spelling — final class, never Final class.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Drill how? | “Cover the name, speak the back, uncover, score yourself.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Day close-out — can you check these off?

**Answer:**

> “Without notes: serial vs concurrent in one sentence. Why main.sync from main deadlocks. Sketch SafeDict with final class spelled right. State the async-write / sync-read caveat. Explain barrier RW and writer starvation in under a minute. Deliver BookMyShow synchronised dictionaries STAR under three minutes with honest metric scope. Deliver Design: actor SafeDict as applied design, not a shipped rewrite. Run a timed set from 04-questions including T1–T10. If any box is open, that’s my next drill — not more reading.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where to practice code? | “05-exercises — SafeDict, race harness, deadlock lab, BarrierDict.” |
| Where to time speak? | “04-questions T1–T10.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse after every Day 04 study block.

---

### Q12. What should you be able to do by end of Day 04? (README outcomes)

**Answer:**

> “Contrast serial vs concurrent; main vs global QoS. Explain sync vs async and why sync-to-current-queue deadlocks — not only main. Implement a thread-safe dictionary behind a private serial queue API. Explain reader-writer with barriers. State the async write / sync read visibility rule. Deliver synchronised dictionaries STAR with an actor-migration coda labeled design. Spell final class correctly in code and speech.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timed drill? | “Q4, Q2, T3, T4 — then full STAR plus actor coda.” |

**How can I relate to my case:**
- **Shipped / design** as labeled in provenance — never blur them.

---

## Brain puzzles (cover → think → check)

### Puzzle A — concurrentPerform without SafeDict

`concurrentPerform(iterations: 1000)` does `cache[i] = i` on a shared `[Int: Int]`.

**Ask:** What should TSan say?

**Answer:** Data race. Wrap through SafeDict (or serialize) and re-run — coherent, no race on storage.

---

### Puzzle B — Double-resume continuation

```swift
queue.async {
    cont.resume(returning: 1)
    cont.resume(returning: 2) // oops
}
```

**Ask:** What happens?

**Answer:** Crash — continuation resumed twice. Exactly one resume on every path.

---

### Puzzle C — Returning mutable interior

`func all() -> [Key: Value] { storage }` with no queue.

**Ask:** Why is this fatal?

**Answer:** Callers mutate off-queue. Prefer `snapshot()` under `queue.sync`. Never hand out live storage or escaping inout.

---

### Puzzle D — S2 honesty under a metric grill

“Did synchronised dictionaries get you to 99.95% CFS?”

**Good reply:** “No single path owns that number. Dictionaries eliminated concurrent-access crashes on that shared-map path. App-wide crash-free is a broader reliability culture story — I won’t steal that credit.”
