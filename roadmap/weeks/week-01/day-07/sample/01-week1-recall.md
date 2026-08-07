# Sample 01 — Week 1 active recall (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. struct vs class — when do you choose each?

**Answer:**

> **Struct** for models and state you want copied by default — value semantics, less accidental shared mutation. **Class** when you need identity, inheritance (UIKit), or reference sharing. Payment states as enums with associated values (Design: payment status pattern (not shipped) design) fit value types. Say “value semantics” and one UIKit class example.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Enum with associated values? | Value type — good for closed state machines. |
| UIView model? | Class — UIKit hierarchy requires it. |
| COW related? | Structs may share storage until mutated — next card. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Design: payment status pattern (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q2. What is copy-on-write (COW)?

**Answer:**

> Swift value types may share backing storage until one copy **mutates** — then copy happens. Saves memory for large arrays/dicts passed around read-only. Trap: `isKnownUniquelyReferenced` / holding shared mutable buffers through class wrappers can surprise you. One sentence is enough in warm-up.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always a full copy on assign? | No — copy on write, not on assign. |
| Interview depth today? | Definition + “mutation triggers copy” suffices in warm-up. |
| Deep pool? | COW uniqueness traps — see deep section in 04. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. POP in the ads pipeline — one minute?

**Answer:**

> Protocol-oriented design: capabilities (render, track) instead of a deep `AdView` subclass tree. Generic pipeline over `AdRenderable`; type erasure at boundaries when mixing concrete types. Verified **BookMyShow Ads pipeline + HeroWidget lifecycle**: new creatives plug in without forking revenue path. No invented fill-rate metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generics vs associated type? | Caller picks `T`; adopter picks associated type. |
| Type erasure cost? | Allocation + indirection + lost specialization. |
| Optional encore today? | BookMyShow Ads pipeline + HeroWidget lifecycle ≤5 min preview Mock #2. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q4. weak vs unowned — one sentence each?

**Answer:**

> **Weak** does not keep alive; optional; zeroes to `nil` — use when the other object may die first (async UI, network callbacks). **Unowned** does not keep alive; not optional; crashes if used after deinit — only when lifetime is provably shorter. Default interview stance: `[weak self]` for escaping work.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Memory Graph vs Leaks? | Graph finds cycles (reachable abandoned); Leaks finds unreachable memory. |
| Timer trap? | Target-selector retains target until `invalidate`. |
| BookMyShow IMOC + crash-free at scale tie-in? | Reliability culture — do not invent Memory Graph war stories. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q5. Serial vs concurrent queue?

**Answer:**

> **Serial:** one task at a time — order preserved; good for protecting mutable state. **Concurrent:** multiple tasks run — order not guaranteed unless you add barriers or external sync. SafeDict uses a **serial** queue so dictionary mutations never overlap. Main queue is serial — deadlock risk on nested `sync`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Reader-writer? | Concurrent queue + barrier writes — read many, write exclusive. |
| Main-queue deadlock? | `DispatchQueue.main.sync` from main thread hangs forever. |
| vs actor? | Actor serializes access with async/await — Day 05. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. async/await vs GCD — when which?

**Answer:**

> **GCD** is queue-based callbacks — still everywhere in UIKit legacy. **async/await** structures suspension and errors in Swift concurrency — better for new modules. Production BookMyShow synchronised dictionaries was GCD; **Design: actor SafeDict (not shipped)** says you’d expose an **actor** today with await. Do not claim a full prod rewrite unless verified.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor reentrancy? | After `await`, another task may run on the actor — state can change. |
| Task cancellation? | Cooperative — check `Task.isCancelled` at suspension points. |
| Sendable? | Types safe to pass across concurrency domains. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. Thread-safe dictionary — 60s design?

**Answer:**

> Hide storage behind a **serial queue API** (or actor today): get/set/snapshot methods dispatch work so callers cannot race the raw dictionary. Avoid `sync` re-entry on the same queue. Mention async-write / sync-read visibility caveat if asked. Verified **BookMyShow synchronised dictionaries** is the production proof point.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why hide the queue? | Call sites cannot forget to synchronize — fewer races. |
| `final class` wrapper? | Common pattern for reference-type container. |
| Migration? | Parallel actor façade — deep pool D4. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q8. DSA from Day 06 — what to recall today?

**Answer:**

> Say-this-first: clarify → brute → optimize → edges. Pattern IDs: hash, opposite pointers, variable window, Kadane, prefix/suffix, write pointer. Swift String: not O(1) index — state cost. Light DSA block today — one timed problem, not a full contest. Communication grade > silent clever solve.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Minimum 8 problems? | From Day 06 — recall names + pattern, not full re-solve all. |
| Mock includes coding? | Mock #1 is concurrency/memory/HLD — DSA is light exercise 5. |
| Flashcard deck? | [`../../../flashcards/week-01.md`](../../../flashcards/week-01.md) |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-story-s2.md](02-story-s2.md)

---

