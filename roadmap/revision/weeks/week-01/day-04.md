# Day 04 — GCD: Queues, sync/async, Barriers, Groups; Thread-Safe Structures

> Week 1 · Phase: Concurrency (traditional) · Time budget today: ~4–5 hrs

## 1. Outcome

Explain aloud:

- Serial vs concurrent queues; main vs global QoS
- `sync` vs `async` and the main-queue deadlock
- How a serial queue implements a thread-safe dictionary
- Reader-writer pattern with barrier on concurrent queue
- Exact BMS **synchronised dictionaries** story (S2) in ≤3 min

## 2. Concept deep dive

### 2.1 Queue types

| Queue | Behavior |
|---|---|
| Main (serial) | UI work only |
| Serial private | Mutual exclusion for a resource |
| Concurrent global | Parallelism; QoS userInteractive→background |
| Concurrent private + barrier | Reader-writer |

### 2.2 sync vs async

- `async`: schedule and return
- `sync`: wait for completion — **never `sync` to current queue** (deadlock), especially main

### 2.3 Thread-safe dictionary patterns

**Pattern A — serial queue:**
- writes: `async` to serial queue
- reads: `sync` to serial queue returning copy/value

**Pattern B — concurrent queue + barrier:**
- reads: `sync` concurrent
- writes: `async` flags `.barrier`

**Pattern C — modern:** Swift `actor` (Day 05)

### 2.4 DispatchGroup / semaphore

- Group: fan-out multiple tasks, notify when done (e.g. prefetch)
- Semaphore: limit concurrency (e.g. max 4 image decodes) — easy to misuse; prefer TaskGroup later

### 2.5 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Serial queue wrapper | Simple shared maps | Read latency under load |
| RW barrier | Read-heavy | Harder correctness |
| NSLock | Small critical sections | Priority inversion risk if careless |
| Actor | New Swift code | Migration cost |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Dispatch](https://developer.apple.com/documentation/dispatch) | API truth |
| Must | Day notes + implement sync dict in Playground | Muscle memory |
| Deepen | [cheatsheet.md](../../../ios-system-design/docs/cheatsheet.md) concurrency snippets if any | Interview numbers |
| Repo | Skim race discussion in networking/offline specs as needed | Context |

## 4. Map to your work

**Company / feature:** BookMyShow — synchronised dictionaries  
**What you did:** Introduced GCD serial queues / read-write locks to eliminate race conditions and concurrent-access crashes in shared async state.  
**Interview line (≤20s):** “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.”

→ [S2](../../stories/story-bank.md#s2--synchronised-dictionaries-bookmyshow)

## 5. Normal questions

### Q1. Serial vs concurrent queue? `(30–45s)`
**Skeleton:** One-at-a-time vs parallel tasks.  
**Story:** Sync dict uses serial.

### Q2. async vs sync? `(30–45s)`
**Skeleton:** Fire-and-forget vs wait; deadlock risk.  

### Q3. Why not sync to main from main? `(45s)`
**Skeleton:** Deadlock — main waiting for itself.  

### Q4. How implement thread-safe dictionary? `(90–120s)` conceptual
**Skeleton:** Private serial queue; sync get; async/sync set.  
**Story:** S2.

### Q5. QoS levels — why care? `(45s)`
**Skeleton:** Priority/energy; don’t starve UI.  

### Q6. DispatchGroup use case? `(45s)`
**Skeleton:** Parallel fetches then merge.  

### Q7. Barrier flag purpose? `(45s)`
**Skeleton:** Exclusive write on concurrent queue.  

### Q8. Main thread rule for UI? `(30s)`
**Skeleton:** UIKit/SwiftUI updates on main.  

### Q9. Race vs deadlock? `(45s)`
**Skeleton:** Unsynchronized shared mut vs waiting circle.  

### Q10. When semaphore over group? `(45s)`
**Skeleton:** Limit in-flight work.  

### Q11. `DispatchQueue.main.async` after network? `(30s)`
**Skeleton:** Hop to main for UI bind.  

## 6. Tricky questions

### T1. Read with `sync` + write with `async` on same serial queue — ordering? `(90s)`
**Trap:** Assume writes always visible.  
**Senior answer:** Serial queue orders tasks; sync read waits for prior tasks; design API so callers don’t assume wall-clock without sync.

### T2. Concurrent queue + non-barrier write `(90s)`
**Trap:** “Concurrent is fine for dict.”  
**Senior answer:** Data race UB — need barrier or serial.

### T3. sync from serial queue to itself via nested call `(90s)`
**Trap:** Only main deadlocks.  
**Senior answer:** Any serial queue can deadlock on sync re-entry.

### T4. RW lock vs serial queue — when? `(120s)`
**Trap:** Always RW.  
**Senior answer:** Read-heavy large maps may benefit; complexity + writer starvation; at BMS serial queue was enough for crash fix.

### T5. Priority inversion with locks `(90s)`
**Trap:** Ignore QoS.  
**Senior answer:** Low priority holds lock needed by high; GCD QoS / lock strategies matter.

### T6. Exposing internal queue to callers `(90s)`
**Trap:** Let callers `async` onto your queue freely.  
**Senior answer:** Hide queue; expose safe API methods only (S2).

## 7. Flashcards for today

| Front | Back |
|---|---|
| Serial queue | Mutex via queue · Trap: sync re-entry · Prod: S2 dicts |
| Concurrent + barrier | RW pattern · Trap: write without barrier · Prod: read-heavy caches |
| sync deadlock | Wait on current queue · Trap: only main · Prod: UI hops use async |
| DispatchGroup | Join parallel work · Trap: forget leave · Prod: prefetch |
| QoS | Priority/energy · Trap: always userInteractive · Prod: analytics batch |
| Race | Unsynchronized share · Trap: intermittent ignore · Prod: BMS crashes |
| Safe dict API | Hide storage · Trap: return mutable ref · Prod: S2 |
| Semaphore | Limit concurrency · Trap: deadlock wait · Prefer TaskGroup later |
| Main UI rule | UI on main · Trap: parse JSON on main · Prod: search bind |
| async write / sync read | Common serial pattern · Trap: return unsafely · Prod: S2 |
| Reader-writer | Parallel reads · Trap: writer starve · Prod: optional upgrade |
| Actor vs GCD | Language isolation · Trap: rewrite all now · Prod: new code actors |

## 8. Practice

- **Coding:** Implement `Final class SafeDict<Key: Hashable, Value>` with serial queue; write a race test that fails on plain Dictionary and passes on SafeDict.
- **Story:** Record S2 in ≤3 min with trade-off “I’d consider actor today.”

## 9. Timed drill

1. Q4 (2 min), Q2, T3, T4 — record.
2. Full S2 STAR once.
3. Score; gotchas.
