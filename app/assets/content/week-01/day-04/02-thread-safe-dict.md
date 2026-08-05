# Sample 02 — Thread-safe dictionary (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is Pattern A — serial queue SafeDict?

**Points to:** [Foundations · §4 Thread-safe dictionary — Pattern A](../01-foundations.md#4-thread-safe-dictionary--pattern-a-serial) · [Deep dive · §5 Designing the SafeDict API](../02-deep-dive.md#5-designing-the-safedict-api-senior) · [code/SafeDict.swift](../code/SafeDict.swift)

**Answer:**

> A **`final class`** wrapper with **private** `storage` and a **private serial** `DispatchQueue`. Reads use `queue.sync { storage[key] }` so they return a value and wait for prior enqueued work. Writes use `queue.sync` or carefully documented `queue.async`. Callers never see the queue or raw dictionary — only safe methods like `get`, `set`, and `snapshot`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why `final class`? | Prevents subclassing surprises; spell **`final`** lowercase — never `Final class`. |
| Why hide the queue? | If call sites get the queue, they can sync/async around your API and reintroduce races. |
| Teaching code preference? | [`SafeDict.swift`](../code/SafeDict.swift) uses **sync set** for defined read-after-write. |

---

### Q2. Why must storage and queue be private?

**Points to:** [Deep dive · §5.1 Checklist](../02-deep-dive.md#51-checklist) · [Deep dive · §12 Anti-patterns](../02-deep-dive.md#12-anti-patterns) · [Production bridge · §4 Mapping](../03-production-bridge.md#4-mapping-concepts--lines)

**Answer:**

> **Private storage** stops callers from reading or mutating the dictionary outside your synchronization. **Private queue** stops them from dispatching their own work onto your queue in an order you don’t control. S2 standardized the access API precisely so call sites **could not touch raw storage** — that was the production fix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if I expose `var storage`? | Instant data race — protection bypassed. |
| Return the queue “for advanced callers”? | Never for S2-style safety — they will sync in ways that deadlock or race. |
| Snapshot instead of interior access? | `queue.sync { storage }` returns a **value copy** — safe handoff. |

---

### Q3. What is the async write / sync read visibility rule?

**Points to:** [Foundations · §4.2 CRITICAL: async write then sync read](../01-foundations.md#42-critical-async-write-then-sync-read) · [Deep dive · §3.2 Async write / sync read](../02-deep-dive.md#32-async-write--sync-read--precise-statement)

**Answer:**

> If `set` uses **`async`**, it only **schedules** the write and returns immediately. A **`sync` get** on the same thread usually sees the write because the async block was enqueued before the sync block — but you must not treat “async set” as “write completed.” For **read-after-write certainty** at the call site, use **sync set** or a single sync transaction. Interview line: async write then sync read **may not** see the write until the write runs.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scenario: setAsync then get on same thread? | Often works due to FIFO enqueue order — but API docs must not promise it without sync set. |
| Scenario: caller needs next line to see value? | **Sync set** — or `mutate { … }` under one sync block. |
| 20-second visibility script? | “Async write then sync read may not see the write until the write runs — for call-site certainty I sync the write.” |

---

### Q4. When should set be sync vs async?

**Points to:** [Foundations · §3.3 When sync is useful](../01-foundations.md#33-when-sync-is-useful) · [Deep dive · §10 Trade-off table](../02-deep-dive.md#10-trade-off-table-memorize)

**Answer:**

> **Sync set** when the caller needs read-after-write, or when correctness beats throughput for that API. **Async set** when fire-and-forget is OK and callers won’t assume immediate visibility — document that clearly. Default teaching and S2 interviews: prefer **sync set** unless you have a measured reason for async writes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cost of sync set? | Caller blocks until write completes — readers queue behind writers on a serial queue. |
| Batch mutation API? | `mutate(_ body: (inout [Key: Value]) -> Void)` under one sync — atomic multi-key update. |
| Async set on main caller? | Avoid blocking main — but visibility contract still matters for the next read. |

---

### Q5. What is Pattern B — concurrent queue + barrier?

**Points to:** [Foundations · §5 Pattern B](../01-foundations.md#5-pattern-b--concurrent-queue--barrier-reader-writer) · [Deep dive · §4 Concurrent + barrier](../02-deep-dive.md#4-concurrent--barrier-deep-dive) · [code/BarrierDict.swift](../code/BarrierDict.swift)

**Answer:**

> A **concurrent** queue where **reads** use plain `sync`/`async` (may overlap with other reads) and **writes** use `async(flags: .barrier)` for an **exclusive** section — waits for prior readers, blocks new readers/writers until done. Reader-writer pattern for **read-heavy** maps. See [`BarrierDict.swift`](../code/BarrierDict.swift).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mental model? | Readers: R R R R (overlap); Barrier: \|W\| (exclusive); then more readers. |
| What goes wrong without barrier on concurrent queue? | Concurrent async read + write on same storage → **data race**. |
| S2 honesty? | “Serial queues generally; read-write locks / barriers where read-heavy” — don’t claim barriers everywhere. |

---

### Q6. What is writer starvation on a barrier queue?

**Points to:** [Deep dive · §4.3 Writer starvation](../02-deep-dive.md#43-writer-starvation) · [Deep dive · §10 Trade-off table](../02-deep-dive.md#10-trade-off-table-memorize)

**Answer:**

> If readers constantly enter, a **barrier writer** may wait a long time — new reads can keep arriving before the writer gets exclusivity. Mitigations: QoS tuning, batching writes, or falling back to a **serial** queue if simplicity beats read parallelism. Another reason serial SafeDict is the default interview answer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is barrier worth it? | Large read-heavy maps where measured contention justifies complexity. |
| When fall back to serial? | Small maps, write-heavy paths, or team prefers one simple model. |
| Incorrect “concurrent dict”? | Two concurrent async blocks touching storage without barrier → race. |

---

### Q7. Why never return a mutable interior reference?

**Points to:** [Foundations · §4.3 Never return a mutable interior reference](../01-foundations.md#43-never-return-a-mutable-interior-reference) · [Deep dive · §3.3 Returning values](../02-deep-dive.md#33-returning-values-vs-mutating-in-place)

**Answer:**

> Returning `[Key: Value]` directly or an `:inout` escape lets callers mutate **outside** the queue — all synchronization bypassed. Prefer **`snapshot()`** — `queue.sync { storage }` returns a value copy (Dictionary copy-on-write helps). Hand out **values**, not live storage.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bad API example? | `func unsafeStorage() -> [Key: Value] { storage }` |
| Good API example? | `func snapshot() -> [Key: Value] { queue.sync { storage } }` |
| Class wrapper that mutates outside? | Same problem — mutation must happen inside queue blocks. |

---

### Q8. How do you whiteboard SafeDict in 45 seconds?

**Points to:** [Deep dive · §11 Whiteboard](../02-deep-dive.md#11-whiteboard-2-minute-safedict-talk) · [Deep dive · §14 Interview micro-scripts](../02-deep-dive.md#14-interview-micro-scripts-pin)

**Answer:**

> “**final class**, private dictionary, private serial queue. **Sync get** and **sync set** so read-after-write is defined. **Snapshot** returns a copy. Call sites never see storage or the queue — that was the BookMyShow fix for raced shared maps.” Optional coda: barrier RW for read-heavy; actor for greenfield (S2-A1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Problem statement? | Shared dict raced across queues → intermittent crashes. |
| Result line (S2)? | Races on that path eliminated; pattern reused for similar maps. |
| Visibility follow-up if asked? | Async set vs sync set — teach the caveat, prefer sync for certainty. |

---

Next: [03-groups-races.md](03-groups-races.md)
