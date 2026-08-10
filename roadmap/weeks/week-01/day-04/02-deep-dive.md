# 02 — Deep Dive: Deadlocks, Visibility, Barriers, SafeDict Correctness (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. async always hops (eventually)? `(45–60s)`
**Answer:**

> “swift networkSession.dataTask(...) { data, _, _ in // URLSession callback queue — NOT main by default (config-dependent) DispatchQueue.main.async { self.viewModel.apply(data) } } Rule: UI on main. Parse off main when heavy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. sync from background to main? `(45–60s)`
**Answer:**

> “swift // Background thread: DispatchQueue.main.sync { // UI touch — works but BLOCKS background until main runs the block } Prefer main.async for UI unless you have a rare need to wait. Blocking a thread pool worker on main can cause stalls under load.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Target queue inversion bugs? `(45–60s)`
**Answer:**

> “Passing your private queue into an API that syncs back onto the caller → re-entrancy surprises. Hide queues; expose methods. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Main sync-to-main? `(45–60s)`
**Answer:**

> “swift // On main: DispatchQueue.main.sync { print("dead") }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Private serial re-entry? `(45–60s)`
**Answer:**

> “swift final class Service { private let q = DispatchQueue(label: "service") func a { q.sync { self.b // b also syncs to q → deadlock } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Cross-queue ABBA deadlock? `(45–60s)`
**Answer:**

> “text Thread1: lock A → wait B Thread2: lock B → wait A With queues: Queue1 sync waits on Queue2 while Queue2 sync waits on Queue1. Keep a lock/queue hierarchy — always acquire in one order.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. FIFO start order? `(45–60s)`
**Answer:**

> “Serial queues start tasks in submission order. That gives a happens-before between task N and task N+1 on that queue.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Async write / sync read — precise statement? `(45–60s)`
**Answer:**

> “swift final class SafeDict<Key: Hashable, Value> { private var storage: [Key: Value] = [:] private let queue = DispatchQueue(label: "safe.dict") func setAsync(_ key: Key, value: Value) { queue.async { self.storage[key] = value } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Returning values vs mutating in place? `(45–60s)`
**Answer:**

> “Prefer returning values (structs, copied Dictionary snapshots). Never hand out :inout storage or class wrappers that mutate outside the queue. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Mental model? `(45–60s)`
**Answer:**

> “text Readers: R R R R (may overlap) Barrier: (exclusive) Readers: R R.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Incorrect “concurrent dict”? `(45–60s)`
**Answer:**

> “swift // ❌ DATA RACE concurrent.async { storage[k] = v } // write without barrier concurrent.async { _ = storage[k] }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Writer starvation? `(45–60s)`
**Answer:**

> “If readers constantly enter, a barrier writer may wait a long time. Mitigations: QoS, batching writes, or fall back to serial if simplicity > read parallelism.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. S2 honesty? `(45–60s)`
**Answer:**

> “We used serial queues for synchronised dictionaries, and read-write locks where access was read-heavy.” Don’t claim you always used barriers everywhere.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Checklist? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Full teaching implementation? `(45–60s)`
**Answer:**

> “See code/SafeDict.swift — prefer sync set for correctness teaching; comment the async alternative.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Stress testing mindset? `(45–60s)`
**Answer:**

> “- Parallel writers + readers via DispatchQueue.concurrentPerform - Assert invariants - Crashlytics watch in prod ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. DispatchGroup pitfalls? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Locks vs queues vs actors? `(45–60s)`
**Answer:**

> “Migration pitch (not a shipped claim): “Same safe API — get/set/snapshot — implemented by an actor; callers await. Isolation moves from convention to the type system.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Mixing GCD with async/await (trap preview)? `(45–60s)`
**Answer:**

> “swift func bridge async -> Int { await withCheckedContinuation { cont in queue.async { cont.resume(returning: self.storage.count) } } } Traps:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. QoS and priority inversion? `(45–60s)`
**Answer:**

> “If a .background task holds a lock needed by .userInteractive, the UI waits. GCD QoS inheritance helps in some queue designs; locks are easier to get wrong. Another reason “serialize at one queue boundary” is nicer than ad-hoc locks. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Trade-off table (memorize)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Whiteboard: 2-minute SafeDict talk? `(45–60s)`
**Answer:**

> “1. Problem: shared dict raced across queues → crashes. 2. Design: final class wrapper; private storage; private serial queue. 3. API: sync get; sync set (explain why not async if asked visibility). 4. Alternative: barrier RW for read-heavy. 5. Trade-off: actor today for new code. 6. Result: races on that path eliminated; pattern reused. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Anti-patterns? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q24. Code tour? `(45–60s)`
**Answer:**

> “1. code/SafeDict.swift — line-by-line aloud. 2. code/BarrierDict.swift — contrast. 3. Predict: async set + immediate get on another thread using only public API. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. Interview micro-scripts (pin)? `(45–60s)`
**Answer:**

> “SafeDict in 45s: “final class, private dictionary, private serial queue. Sync get and sync set so read-after-write is defined. Snapshot returns a copy. Call sites never see storage or the queue — that was the BookMyShow fix for raced shared maps.” Visibility in 20s: “Async write then sync read may not see the write until the write runs — for call-site certainty I sync the write.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
