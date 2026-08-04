# 01 — Foundations: GCD Queues, sync/async, Thread Safety

> Read this first. Goal: intern-clear queue mental model, then senior edges for S2 interviews.

---

## 0. One-sentence north star

**Serialize access to shared mutable state at a clear boundary — don’t sprinkle locks ad hoc — and never block a queue waiting for itself.**

At BookMyShow that boundary was synchronised dictionaries behind GCD (Verified · S2). Day 05 modernizes the same idea with actors (S2-A1).

---

## 1. Why threads race (intern story)

### 1.1 Shared mutation without rules

```swift
var cache: [String: Data] = [:]

// Thread A
cache["a"] = Data()

// Thread B (same time)
_ = cache["a"]
```

Dictionaries are **not** thread-safe. Concurrent mutation → data races → intermittent crashes / corruption. Hard to reproduce; shows up under load.

**Say aloud:** “If two threads touch shared mutable memory without synchronization, that’s a race — undefined behavior territory.”

### 1.2 What we want instead

| Property | Meaning |
|---|---|
| Mutual exclusion for writes | No two writers overlap unsafely |
| Defined read visibility | Readers see a coherent state |
| Safe API | Callers cannot touch raw storage |
| No self-deadlock | Avoid sync onto the queue you’re on |

---

## 2. Dispatch queues — the boxes

### 2.1 Serial vs concurrent

| Queue | Behavior | Picture |
|---|---|---|
| **Serial** | One task at a time; FIFO start order | Single checkout lane |
| **Concurrent** | Tasks may run overlapping | Many lanes; start order FIFO, finish order varies |

```swift
let serial = DispatchQueue(label: "app.safe.dict")
let concurrent = DispatchQueue(label: "app.images", attributes: .concurrent)
```

### 2.2 Main queue

- Serial queue tied to the main thread  
- **UIKit / SwiftUI UI updates belong here**  
- Never do heavy JSON parse / image decode synchronously on main  

```swift
DispatchQueue.main.async {
    self.label.text = value
}
```

### 2.3 Global queues + QoS

```swift
DispatchQueue.global(qos: .userInitiated).async { ... }
```

| QoS (high → low intuition) | Use |
|---|---|
| `.userInteractive` | Tiny, UI-critical work |
| `.userInitiated` | User waiting (fetch for screen) |
| `.default` | General |
| `.utility` | Progress-visible long work |
| `.background` | Cleanup, prefetch that can wait |

**Senior line:** Don’t mark everything `.userInteractive` — you steal energy and starve work.

---

## 3. async vs sync

### 3.1 Definitions

| Call | Meaning |
|---|---|
| `async` | Schedule block; **return immediately** |
| `sync` | Schedule block; **wait until it finishes**; return results |

```swift
queue.async {
    // runs later (soon) on queue
}

let value = queue.sync { () -> Int in
    return storage.count
}
```

### 3.2 Deadlock rule (learn early)

**Never `sync` onto the same serial queue you are already executing on.**

Classic: main thread does `DispatchQueue.main.sync { ... }` → main waits for main → deadlock.

Also true for **any** private serial queue:

```swift
serial.async {
    serial.sync {  // DEADLOCK — already on serial
        print("never")
    }
}
```

**Say aloud:** “Sync waits. If the waiter is the only worker that can run the work, you freeze.”

### 3.3 When sync is useful

- Need a **return value** from the queue (read)  
- Need **happens-before** with prior tasks on that queue  
- Keep critical sections short  

When async is better:

- Fire-and-forget updates  
- Avoid blocking callers (especially main)  

---

## 4. Thread-safe dictionary — Pattern A (serial)

### 4.1 Shape used in interviews (and S2)

```swift
final class SafeDict<Key: Hashable, Value> {
    private var storage: [Key: Value] = [:]
    private let queue = DispatchQueue(label: "safe.dict")

    func get(_ key: Key) -> Value? {
        queue.sync { storage[key] }
    }

    func set(_ key: Key, value: Value) {
        queue.async { self.storage[key] = value }
    }
}
```

Notes:

- Spell **`final class`** (Swift keyword `final`, lowercase).  
- Queue is **private** — callers never see it.  
- `get` uses `sync` so it can return a value and wait for prior scheduled work.  
- `set` often uses `async` so writers don’t block — **but see visibility caveat below**.

### 4.2 CRITICAL: async write then sync read

```swift
dict.set("k", value: 1)   // async — schedules write
let v = dict.get("k")     // sync — may run BEFORE the write if write hasn't started!
```

**Fact:** On a serial queue, tasks run in submission order *once enqueued*. But:

- If `set` uses `async`, the write is only ordered **after it has been enqueued**.  
- A `get` that is `sync`’d **immediately** after `set` returns will wait for work **already on the queue**.  
- In practice, the async block is usually enqueued before `get`’s sync runs — so you often see the write.  
- Relying on wall-clock assumptions across threads without documenting API guarantees is fragile.  
- **If the caller needs read-after-write certainty from the same call site, use sync write (or a single sync transaction).**

**Preferred when read-after-write matters:**

```swift
func set(_ key: Key, value: Value) {
    queue.sync { self.storage[key] = value }
}
```

Or expose:

```swift
func mutate(_ body: (inout [Key: Value]) -> Void) {
    queue.sync { body(&storage) }
}
```

**Interview line:**  
> “Async write plus sync read is a common pattern, but if I need the write visible to the next read on that API, I sync the write — async write may not have run yet when the caller’s next line executes.”

### 4.3 Never return a mutable interior reference

```swift
// BAD
func unsafeStorage() -> [Key: Value] { storage } // races + escapes protection

// GOOD
func snapshot() -> [Key: Value] {
    queue.sync { storage } // value copy (Dictionary COW helps)
}
```

---

## 5. Pattern B — concurrent queue + barrier (reader-writer)

```swift
final class BarrierDict<Key: Hashable, Value> {
    private var storage: [Key: Value] = [:]
    private let queue = DispatchQueue(label: "rw.dict", attributes: .concurrent)

    func get(_ key: Key) -> Value? {
        queue.sync { storage[key] }           // concurrent readers OK
    }

    func set(_ key: Key, value: Value) {
        queue.async(flags: .barrier) {        // exclusive writer
            self.storage[key] = value
        }
    }
}
```

| Operation | Flag | Effect |
|---|---|---|
| Read | plain `sync`/`async` | May overlap with other reads |
| Write | `.barrier` | Waits for prior reads; excludes others until done |

**When:** Read-heavy maps.  
**Cost:** Harder to reason about; writer starvation possible under constant reads; still hide the queue.

S2 used serial queues generally; RW locks / barriers where read-heavy — say that honestly.

---

## 6. DispatchGroup (foundations)

```swift
let group = DispatchGroup()

for url in urls {
    group.enter()
    download(url) { _ in group.leave() }
}

group.notify(queue: .main) {
    // all done
}
```

Use: fan-out prefetch, then merge on main.  
Trap: forget `leave` → notify never fires.

---

## 7. Semaphores (awareness only)

```swift
let sem = DispatchSemaphore(value: 4) // max 4 in flight
sem.wait()
// work
sem.signal()
```

Limit concurrency (image decodes). Easy to deadlock if `wait` on wrong queue. Prefer structured concurrency / TaskGroup in modern code (Day 05).

---

## 8. Race vs deadlock vs priority inversion

| Term | One-liner |
|---|---|
| **Race** | Unsynchronized shared mutable access |
| **Deadlock** | Wait circle — including sync to current serial queue |
| **Priority inversion** | Low-priority holder blocks high-priority waiter |

---

## 9. Actors preview (one paragraph)

Swift `actor` gives language-enforced isolation for the same problem SafeDict solves with a serial queue. For **new** code you’d evaluate an actor (How I would apply it · S2-A1). Today’s depth is GCD — the production story you shipped.

---

## 10. Glossary

| Term | One-liner |
|---|---|
| Serial queue | Tasks one-at-a-time |
| Concurrent queue | Tasks may overlap |
| Barrier | Exclusive section on concurrent queue |
| QoS | Priority / energy class for work |
| sync | Wait for block completion |
| async | Schedule and return |
| Safe API | Hide storage + queue; expose methods |
| Snapshot | Value copy returned under sync |

---

## 11. First production bridge (short)

Shared async state at BookMyShow was hit from multiple queues → races / intermittent crashes. Fix: synchronised dictionaries gated by GCD serial queues (RW where read-heavy), with a standardized access API so call sites couldn’t touch raw storage.

**≤20s:**  
> “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.”

> **Provenance:** Verified · S2 · BookMyShow · synchronised dictionaries

---

## 12. Self-check before deep dive

- [ ] Serial vs concurrent in one sentence each?  
- [ ] Why main.sync from main deadlocks?  
- [ ] Sketch SafeDict get/set?  
- [ ] State the async-write / sync-read visibility caveat?  
- [ ] Spell `final class` correctly?

→ [`02-deep-dive.md`](02-deep-dive.md)
