# 02 — Deep Dive: Deadlocks, Visibility, Barriers, SafeDict Correctness

> Interview depth. Foundations assumed.

---

## 1. Queue targeting and thread hops

### 1.1 async always hops (eventually)

```swift
networkSession.dataTask(...) { data, _, _ in
    // URLSession callback queue — NOT main by default (config-dependent)
    DispatchQueue.main.async {
        self.viewModel.apply(data)
    }
}
```

**Rule:** UI on main. Parse off main when heavy.

### 1.2 sync from background to main

```swift
// Background thread:
DispatchQueue.main.sync {
    // UI touch — works but BLOCKS background until main runs the block
}
```

Prefer `main.async` for UI unless you have a rare need to wait. Blocking a thread pool worker on main can cause stalls under load.

### 1.3 Target queue inversion bugs

Passing your private queue into an API that syncs back onto the caller → re-entrancy surprises. **Hide queues; expose methods.**

---

## 2. Deadlock patterns (memorize)

### 2.1 Main sync-to-main

```swift
// On main:
DispatchQueue.main.sync { print("dead") }
```

### 2.2 Private serial re-entry

```swift
final class Service {
    private let q = DispatchQueue(label: "service")

    func a() {
        q.sync {
            self.b() // b also syncs to q → deadlock
        }
    }

    func b() {
        q.sync { print("hi") }
    }
}
```

**Fix patterns:**

- Use `async` for nested work  
- Factor “already on queue” unsafe internals (`_bUnlocked`) called only from queue  
- Assert queue with `dispatchPrecondition` in debug  

```swift
private func mutateUnlocked() {
    dispatchPrecondition(condition: .onQueue(queue))
    storage["x"] = 1
}
```

### 2.3 Cross-queue ABBA deadlock

```text
Thread1: lock A → wait B
Thread2: lock B → wait A
```

With queues: Queue1 sync waits on Queue2 while Queue2 sync waits on Queue1. Keep a **lock/queue hierarchy** — always acquire in one order.

---

## 3. Ordering and visibility on serial queues

### 3.1 FIFO start order

Serial queues start tasks in submission order. That gives a happens-before between task N and task N+1 **on that queue**.

### 3.2 Async write / sync read — precise statement

```swift
final class SafeDict<Key: Hashable, Value> {
    private var storage: [Key: Value] = [:]
    private let queue = DispatchQueue(label: "safe.dict")

    func setAsync(_ key: Key, value: Value) {
        queue.async { self.storage[key] = value }
    }

    func setSync(_ key: Key, value: Value) {
        queue.sync { self.storage[key] = value }
    }

    func get(_ key: Key) -> Value? {
        queue.sync { storage[key] }
    }
}
```

**Scenario A — sync write then sync read (same thread):**

```swift
dict.setSync("k", value: 1)
let v = dict.get("k") // ✅ sees 1 — write completed before setSync returned
```

**Scenario B — async write then sync read (same thread):**

```swift
dict.setAsync("k", value: 1) // enqueues write; returns immediately
let v = dict.get("k")        // sync: runs after previously enqueued work
```

Usually `v == 1` because the async block was enqueued before `get`’s sync block.  
**But:** documenting “set is fire-and-forget” means callers must not assume immediate visibility across *other* threads without joining, and you should not treat async set as a completed write.

**Scenario C — async write; read from another thread without sync API:**

If someone races on a leaked `storage` reference — undefined. Hence private storage.

**Interview-grade sentence:**  
> “If I need read-after-write on the call site, I use a synchronous set — or one sync transaction — because an async write only guarantees ordering once it’s on the queue, and the caller’s next line isn’t a completion handler.”

### 3.3 Returning values vs mutating in place

Prefer returning **values** (structs, copied Dictionary snapshots). Never hand out `:inout` storage or class wrappers that mutate outside the queue.

---

## 4. Concurrent + barrier deep dive

### 4.1 Mental model

```text
Readers:  R R R R     (may overlap)
Barrier:       |W|    (exclusive)
Readers:           R R
```

### 4.2 Incorrect “concurrent dict”

```swift
// ❌ DATA RACE
concurrent.async { storage[k] = v }  // write without barrier
concurrent.async { _ = storage[k] }
```

### 4.3 Writer starvation

If readers constantly enter, a barrier writer may wait a long time. Mitigations: QoS, batching writes, or fall back to serial if simplicity > read parallelism.

### 4.4 S2 honesty

> “We used serial queues for synchronised dictionaries, and read-write locks where access was read-heavy.”

Don’t claim you always used barriers everywhere.

---

## 5. Designing the SafeDict API (senior)

### 5.1 Checklist

| Requirement | Implementation |
|---|---|
| Hide storage | `private var storage` |
| Hide queue | `private let queue` |
| Thread-safe get | `queue.sync` |
| Thread-safe set | `queue.sync` or carefully documented `async` |
| Snapshot | sync copy |
| No queue escape | never return `DispatchQueue` |
| `final class` | avoid subclassing surprises |

### 5.2 Full teaching implementation

See [`code/SafeDict.swift`](code/SafeDict.swift) — prefer **sync set** for correctness teaching; comment the async alternative.

### 5.3 Stress testing mindset

- Parallel writers + readers via `DispatchQueue.concurrentPerform`  
- Assert invariants  
- Crashlytics watch in prod (S2)  

---

## 6. DispatchGroup pitfalls

| Pitfall | Fix |
|---|---|
| Unbalanced enter/leave | `defer { leave() }` after enter |
| notify on wrong queue | Choose main for UI merge |
| Forever wait | `wait` with timeout in tools; avoid blocking main |

---

## 7. Locks vs queues vs actors

| Tool | When | Cost |
|---|---|---|
| Serial queue wrapper | Simple shared maps (S2) | Sync read latency under load |
| Concurrent + barrier | Read-heavy | Complexity, starvation |
| NSLock / os_unfair_lock | Tiny critical sections | Easy to forget unlock; priority inversion |
| actor | New Swift code (S2-A1) | async API surface; reentrancy across await |

**Migration pitch (not a shipped claim):**  
> “Same safe API — get/set/snapshot — implemented by an actor; callers await. Isolation moves from convention to the type system.”

---

## 8. Mixing GCD with async/await (trap preview)

```swift
func bridge() async -> Int {
    await withCheckedContinuation { cont in
        queue.async {
            cont.resume(returning: self.storage.count)
        }
    }
}
```

Traps:

- Calling `queue.sync` from an async context can block a thread in the cooperative pool — bad.  
- Prefer actors or async wrappers that don’t sync-block.  

Day 05 deepens this; today just know: **don’t casually sync from async world.**

---

## 9. QoS and priority inversion

If a `.background` task holds a lock needed by `.userInteractive`, the UI waits. GCD QoS inheritance helps in some queue designs; locks are easier to get wrong. Another reason “serialize at one queue boundary” is nicer than ad-hoc locks.

---

## 10. Trade-off table (memorize)

| Choice | When | Cost |
|---|---|---|
| Serial queue SafeDict | Default shared maps | Readers queue behind writers |
| RW barrier | Read-heavy large maps | Complexity |
| Sync set | Read-after-write needed | Caller blocks on write |
| Async set | Throughput; eventual visibility OK | Visibility surprises |
| Expose queue | Never for S2-style safety | Call sites reintroduce races |
| Actor rewrite | Greenfield / migrate module | API becomes async |

---

## 11. Whiteboard: 2-minute SafeDict talk

1. Problem: shared dict raced across queues → crashes.  
2. Design: `final class` wrapper; private storage; private serial queue.  
3. API: sync get; sync set (explain why not async if asked visibility).  
4. Alternative: barrier RW for read-heavy.  
5. Trade-off: actor today for new code.  
6. Result: races on that path eliminated; pattern reused.

---

## 12. Anti-patterns

| Anti-pattern | Fix |
|---|---|
| `Final class` spelling | `final class` |
| Public `var storage` | private + snapshot |
| sync to self | unlocked internals / async |
| Concurrent writes w/o barrier | barrier or serial |
| Claiming S2 fixed all app crashes | Path-specific race fix |
| Returning mutable reference | return values |

---

## 13. Code tour

1. [`code/SafeDict.swift`](code/SafeDict.swift) — line-by-line aloud.  
2. [`code/BarrierDict.swift`](code/BarrierDict.swift) — contrast.  
3. Predict: async set + immediate get on another thread using only public API.

---

## 14. Interview micro-scripts (pin)

**SafeDict in 45s:**  
> “final class, private dictionary, private serial queue. Sync get and sync set so read-after-write is defined. Snapshot returns a copy. Call sites never see storage or the queue — that was the BookMyShow fix for raced shared maps.”

**Visibility in 20s:**  
> “Async write then sync read may not see the write until the write runs — for call-site certainty I sync the write.”

**Actor coda in 20s:**  
> “Same API as an actor for new modules — Applied S2-A1, not a claim we rewrote production.”

**Spelling check:** say and type `final class` — never `Final class`.

→ [`03-production-bridge.md`](03-production-bridge.md)
