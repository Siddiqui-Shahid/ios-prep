# Sample 02 — Thread-safe dictionary (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is Pattern A — serial queue SafeDict?

**Answer:**

> A **`final class`** wrapper with **private** `storage` and a **private serial** `DispatchQueue`. Reads use `queue.sync { storage[key] }` so they return a value and wait for prior enqueued work. Writes use `queue.sync` or carefully documented `queue.async`. Callers never see the queue or raw dictionary — only safe methods like `get`, `set`, and `snapshot`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why `final class`? | Prevents subclassing surprises; spell **`final`** lowercase — never `Final class`. |
| Why hide the queue? | If call sites get the queue, they can sync/async around your API and reintroduce races. |
| Teaching code preference? | [`SafeDict.swift`](../code/SafeDict.swift) uses **sync set** for defined read-after-write. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries — same boundary idea (safe API, hidden queue).
- **Design if asked:** Actor SafeDict for greenfield modules — label design, not shipped.
- **Lab only:** [`SafeDict.swift`](../code/SafeDict.swift) teaching demo — not BMS source.
- **Don’t claim:** Lab file was the production implementation.

---

### Q2. Why must storage and queue be private?

**Answer:**

> **Private storage** stops callers from reading or mutating the dictionary outside your synchronization. **Private queue** stops them from dispatching their own work onto your queue in an order you don’t control. BookMyShow synchronised dictionaries standardized the access API precisely so call sites **could not touch raw storage** — that was the production fix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if I expose `var storage`? | Instant data race — protection bypassed. |
| Return the queue “for advanced callers”? | Never for BookMyShow synchronised dictionaries-style safety — they will sync in ways that deadlock or race. |
| Snapshot instead of interior access? | `queue.sync { storage }` returns a **value copy** — safe handoff. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q3. What is the async write / sync read visibility rule?

**Answer:**

> If `set` uses **`async`**, it only **schedules** the write and returns immediately. A **`sync` get** on the same thread usually sees the write because the async block was enqueued before the sync block — but you must not treat “async set” as “write completed.” For **read-after-write certainty** at the call site, use **sync set** or a single sync transaction. Interview line: async write then sync read **may not** see the write until the write runs.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scenario: setAsync then get on same thread? | Often works due to FIFO enqueue order — but API docs must not promise it without sync set. |
| Scenario: caller needs next line to see value? | **Sync set** — or `mutate { … }` under one sync block. |
| 20-second visibility script? | “Async write then sync read may not see the write until the write runs — for call-site certainty I sync the write.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. When should set be sync vs async?

**Answer:**

> **Sync set** when the caller needs read-after-write, or when correctness beats throughput for that API. **Async set** when fire-and-forget is OK and callers won’t assume immediate visibility — document that clearly. Default teaching and BookMyShow synchronised dictionaries interviews: prefer **sync set** unless you have a measured reason for async writes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cost of sync set? | Caller blocks until write completes — readers queue behind writers on a serial queue. |
| Batch mutation API? | `mutate(_ body: (inout [Key: Value]) -> Void)` under one sync — atomic multi-key update. |
| Async set on main caller? | Avoid blocking main — but visibility contract still matters for the next read. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. What is Pattern B — concurrent queue + barrier?

**Answer:**

> A **concurrent** queue where **reads** use plain `sync`/`async` (may overlap with other reads) and **writes** use `async(flags: .barrier)` for an **exclusive** section — waits for prior readers, blocks new readers/writers until done. Reader-writer pattern for **read-heavy** maps. See [`BarrierDict.swift`](../code/BarrierDict.swift).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mental model? | Readers: R R R R (overlap); Barrier: \|W\| (exclusive); then more readers. |
| What goes wrong without barrier on concurrent queue? | Concurrent async read + write on same storage → **data race**. |
| BookMyShow synchronised dictionaries honesty? | “Serial queues generally; read-write locks / barriers where read-heavy” — don’t claim barriers everywhere. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q6. What is writer starvation on a barrier queue?

**Answer:**

> If readers constantly enter, a **barrier writer** may wait a long time — new reads can keep arriving before the writer gets exclusivity. Mitigations: QoS tuning, batching writes, or falling back to a **serial** queue if simplicity beats read parallelism. Another reason serial SafeDict is the default interview answer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is barrier worth it? | Large read-heavy maps where measured contention justifies complexity. |
| When fall back to serial? | Small maps, write-heavy paths, or team prefers one simple model. |
| Incorrect “concurrent dict”? | Two concurrent async blocks touching storage without barrier → race. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Why never return a mutable interior reference?

**Answer:**

> Returning `[Key: Value]` directly or an `:inout` escape lets callers mutate **outside** the queue — all synchronization bypassed. Prefer **`snapshot()`** — `queue.sync { storage }` returns a value copy (Dictionary copy-on-write helps). Hand out **values**, not live storage.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bad API example? | `func unsafeStorage() -> [Key: Value] { storage }` |
| Good API example? | `func snapshot() -> [Key: Value] { queue.sync { storage } }` |
| Class wrapper that mutates outside? | Same problem — mutation must happen inside queue blocks. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How do you whiteboard SafeDict in 45 seconds?

**Answer:**

> “**final class**, private dictionary, private serial queue. **Sync get** and **sync set** so read-after-write is defined. **Snapshot** returns a copy. Call sites never see storage or the queue — that was the BookMyShow fix for raced shared maps.” Optional coda: barrier RW for read-heavy; actor for greenfield (Design: actor SafeDict (not shipped)).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Problem statement? | Shared dict raced across queues → intermittent crashes. |
| Result line (BookMyShow synchronised dictionaries)? | Races on that path eliminated; pattern reused for similar maps. |
| Visibility follow-up if asked? | Async set vs sync set — teach the caveat, prefer sync for certainty. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

Next: [03-groups-races.md](03-groups-races.md)

---

