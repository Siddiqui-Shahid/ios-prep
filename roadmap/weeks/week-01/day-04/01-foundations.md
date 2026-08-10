# 01 — Foundations: GCD Queues, sync/async, Thread Safety (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. What is the one rule to remember for this topic? `(45–60s)`
**Answer:**

> “Serialize access to shared mutable state at a clear boundary — don’t sprinkle locks ad hoc — and never block a queue waiting for itself. At BookMyShow that boundary was synchronised dictionaries behind GCD. Day 05 modernizes the same idea with actors.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. What goes wrong if two threads mutate a dictionary with no lock? `(45–60s)`
**Answer:**

> “If two threads touch shared mutable memory without synchronization, that’s a race — undefined behavior territory.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. What we want instead? `(45–60s)`
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

### Q4. Serial vs concurrent? `(45–60s)`
**Answer:**

> “swift let serial = DispatchQueue(label: "app.safe.dict") let concurrent = DispatchQueue(label: "app.images", attributes: .concurrent).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Main queue? `(45–60s)`
**Answer:**

> “- Serial queue tied to the main thread - UIKit / SwiftUI UI updates belong here - Never do heavy JSON parse / image decode synchronously on main swift DispatchQueue.main.async { self.label.text = value }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Global queues + QoS? `(45–60s)`
**Answer:**

> “swift DispatchQueue.global(qos: .userInitiated).async { ... }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Definitions? `(45–60s)`
**Answer:**

> “swift queue.async { // runs later (soon) on queue }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Deadlock rule (learn early)? `(45–60s)`
**Answer:**

> “Sync waits. If the waiter is the only worker that can run the work, you freeze.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. When sync is useful? `(45–60s)`
**Answer:**

> “- Need a return value from the queue (read) - Need happens-before with prior tasks on that queue - Keep critical sections short When async is better:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Shape used in interviews (and S2)? `(45–60s)`
**Answer:**

> “swift final class SafeDict<Key: Hashable, Value> { private var storage: [Key: Value] = [:] private let queue = DispatchQueue(label: "safe.dict") func get(_ key: Key) -> Value? { queue.sync { storage[key] } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. CRITICAL: async write then sync read? `(45–60s)`
**Answer:**

> “swift dict.set("k", value: 1) // async — schedules write let v = dict.get("k") // sync — may run BEFORE the write if write hasn't started! Fact: On a serial queue, tasks run in submission order once enqueued. But:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Never return a mutable interior reference? `(45–60s)`
**Answer:**

> “swift // BAD func unsafeStorage -> [Key: Value] { storage } // races + escapes protection // GOOD func snapshot -> [Key: Value] { queue.sync { storage } // value copy (Dictionary COW helps) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Pattern B — concurrent queue + barrier (reader-writer)? `(45–60s)`
**Answer:**

> “swift final class BarrierDict<Key: Hashable, Value> { private var storage: [Key: Value] = [:] private let queue = DispatchQueue(label: "rw.dict", attributes: .concurrent) func get(_ key: Key) -> Value? { queue.sync { storage[key] } // concurrent readers OK }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. DispatchGroup (foundations)? `(45–60s)`
**Answer:**

> “swift let group = DispatchGroup for url in urls { group.enter download(url) { _ in group.leave } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Semaphores (awareness only)? `(45–60s)`
**Answer:**

> “swift let sem = DispatchSemaphore(value: 4) // max 4 in flight sem.wait // work sem.signal Limit concurrency (image decodes). Easy to deadlock if wait on wrong queue. Prefer structured concurrency / TaskGroup in modern code (Day 05).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Race vs deadlock vs priority inversion? `(45–60s)`
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

### Q17. Actors preview (one paragraph)? `(45–60s)`
**Answer:**

> “Swift actor gives language-enforced isolation for the same problem SafeDict solves with a serial queue. For new code you’d evaluate an actor (How I would apply it · ). Today’s depth is GCD — the production story you shipped. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Glossary? `(45–60s)`
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

### Q19. First production bridge (short)? `(45–60s)`
**Answer:**

> “Shared async state at BookMyShow was hit from multiple queues → races / intermittent crashes. Fix: synchronised dictionaries gated by GCD serial queues (RW where read-heavy), with a standardized access API so call sites couldn’t touch raw storage. ≤20s: “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q20. Self-check before deep dive? `(45–60s)`
**Answer:**

> “- [ ] Serial vs concurrent in one sentence each? - [ ] Why main.sync from main deadlocks? - [ ] Sketch SafeDict get/set? - [ ] State the async-write / sync-read visibility caveat? - [ ] Spell final class correctly? → 02-deep-dive.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
