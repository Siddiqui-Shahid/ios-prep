# Audio script — Sample 02 — Thread-safe dictionary (Q&A)
> Listen-only sample Q&A from `02-thread-safe-dict.md`. Spoken answers and follow-ups.

## §0 Q1. What is Pattern A — serial queue SafeDict?

Next. Q1. What is Pattern A — serial queue SafeDict? Answer. A final class wrapper with private storage and a private serial DispatchQueue. Reads use queue.sync { storage[key] } so they return a value and wait for prior enqueued work. Writes use queue.sync or carefully documented queue.async. Callers never see the queue or raw dictionary — only safe methods like get, set, and snapshot. Follow-ups. Why final class?: Prevents subclassing surprises; spell final lowercase — never Final class.. Why hide the queue?: If call sites get the queue, they can sync/async around your A P I and reintroduce races.. Teaching code preference?: SafeDict.swift uses sync set for defined read-after-write..

## §1 Q2. Why must storage and queue be private?

Next. Q2. Why must storage and queue be private? Answer. Private storage stops callers from reading or mutating the dictionary outside your synchronization. Private queue stops them from dispatching their own work onto your queue in an order you don’t control. BookMyShow synchronised dictionaries standardized the access A P I precisely so call sites could not touch raw storage — that was the production fix. Follow-ups. What if I expose var storage?: Instant data race — protection bypassed.. Return the queue “for advanced callers”?: Never for BookMyShow synchronised dictionaries-style safety — they will sync in ways that deadlock or race.. Snapshot instead of interior access?: queue.sync { storage } returns a value copy — safe handoff..

## §2 Q3. What is the async write / sync read visibility rule?

Next. Q3. What is the async write / sync read visibility rule? Answer. If set uses async, it only schedules the write and returns immediately. A sync get on the same thread usually sees the write because the async block was enqueued before the sync block — but you must not treat “async set” as “write completed.” For read-after-write certainty at the call site, use sync set or a single sync transaction. Interview line: async write then sync read may not see the write until the write runs. Follow-ups. Scenario: setAsync then get on same thread?: Often works due to FIFO enqueue order — but A P I docs must not promise it without sync set.. Scenario: caller needs next line to see value?: Sync set — or mutate { … } under one sync block.. 20-second visibility script?: “Async write then sync read may not see the write until the write runs — for call-site certainty I sync the write.”.

## §3 Q4. When should set be sync vs async?

Next. Q4. When should set be sync vs async? Answer. Sync set when the caller needs read-after-write, or when correctness beats throughput for that A P I. Async set when fire-and-forget is OK and callers won’t assume immediate visibility — document that clearly. Default teaching and BookMyShow synchronised dictionaries interviews: prefer sync set unless you have a measured reason for async writes. Follow-ups. Cost of sync set?: Caller blocks until write completes — readers queue behind writers on a serial queue.. Batch mutation A P I?: mutate(_ body: (inout [Key: Value]) - Void) under one sync — atomic multi-key update.. Async set on main caller?: Avoid blocking main — but visibility contract still matters for the next read..

## §4 Q5. What is Pattern B — concurrent queue + barrier?

Next. Q5. What is Pattern B — concurrent queue + barrier? Answer. A concurrent queue where reads use plain sync/async (may overlap with other reads) and writes use async(flags:.barrier) for an exclusive section — waits for prior readers, blocks new readers/writers until done. Reader-writer pattern for read-heavy maps. See BarrierDict.swift. Follow-ups. Mental model?: Readers: R R R R (overlap); Barrier: \. What goes wrong without barrier on concurrent queue?: Concurrent async read + write on same storage → data race.. BookMyShow synchronised dictionaries honesty?: “Serial queues generally; read-write locks / barriers where read-heavy” — don’t claim barriers everywhere..

## §5 Q6. What is writer starvation on a barrier queue?

Next. Q6. What is writer starvation on a barrier queue? Answer. If readers constantly enter, a barrier writer may wait a long time — new reads can keep arriving before the writer gets exclusivity. Mitigations: QoS tuning, batching writes, or falling back to a serial queue if simplicity beats read parallelism. Another reason serial SafeDict is the default interview answer. Follow-ups. When is barrier worth it?: Large read-heavy maps where measured contention justifies complexity.. When fall back to serial?: Small maps, write-heavy paths, or team prefers one simple model.. Incorrect “concurrent dict”?: Two concurrent async blocks touching storage without barrier → race..

## §6 Q7. Why never return a mutable interior reference?

Next. Q7. Why never return a mutable interior reference? Answer. Returning [Key: Value] directly or an :inout escape lets callers mutate outside the queue — all synchronization bypassed. Prefer snapshot() — queue.sync { storage } returns a value copy (Dictionary copy-on-write helps). Hand out values, not live storage. Follow-ups. Bad A P I example?: func unsafeStorage() - [Key: Value] { storage }. Good A P I example?: func snapshot() - [Key: Value] { queue.sync { storage } }. Class wrapper that mutates outside?: Same problem — mutation must happen inside queue blocks..

## §7 Q8. How do you whiteboard SafeDict in 45 seconds?

Next. Q8. How do you whiteboard SafeDict in 45 seconds? Answer. “final class, private dictionary, private serial queue. Sync get and sync set so read-after-write is defined. Snapshot returns a copy. Call sites never see storage or the queue — that was the BookMyShow fix for raced shared maps.” Optional coda: barrier RW for read-heavy; actor for greenfield (Design: actor SafeDict (not shipped)). Follow-ups. Problem statement?: Shared dict raced across queues → intermittent crashes.. Result line (BookMyShow synchronised dictionaries)?: Races on that path eliminated; pattern reused for similar maps.. Visibility follow-up if asked?: Async set vs sync set — teach the caveat, prefer sync for certainty..
