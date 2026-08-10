# Day 05 — Production Bridge: S2, S2-A1, S3 (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Verified · S2 — Synchronised dictionaries (BookMyShow)? `(45–60s)`
**Answer:**

> “Provenance: Verified · · BookMyShow · synchronised dictionaries via GCD serial queues and RW locks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. Situation / Task? `(45–60s)`
**Answer:**

> “Shared async state was hit from multiple queues. Unsynchronized dictionary mutation produced data races and intermittent crashes on that path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Action (what you can claim)? `(45–60s)`
**Answer:**

> “1. Introduced synchronised dictionaries gated by GCD serial queues (and read-write locks where read-heavy). 2. Standardized a closed access API so call sites could not touch raw storage. 3. Validated under concurrency stress and watched Crashlytics for that failure mode.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Result (honest scope)? `(45–60s)`
**Answer:**

> “Eliminated concurrent-access crashes on that shared-state path. Pattern reused where mutable maps were shared across async work. Do not say: “This alone produced 99.95% crash-free.” Crash-free is an app-wide reliability culture metric ( adjacency). owns the race fix on the dictionary path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Lesson? `(45–60s)`
**Answer:**

> “Serialize mutation at the boundary. Don’t sprinkle locks ad hoc across call sites.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Timed opener (≤15s)? `(45–60s)`
**Answer:**

> “We had races on shared dictionaries — I’ll cover the serial-queue design and trade-offs vs actors.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. –120s STAR spine (practice aloud)? `(45–60s)`
**Answer:**

> “Shared maps were read and written from multiple async contexts, which caused intermittent crashes. We hid the storage behind a synchronised-dictionary API: writes scheduled on a serial queue, reads synchronized for a safe snapshot, and where reads dominated we used a reader-writer approach. Call sites never touched the raw dictionary. That removed the race class on that path. Trade-off: sync reads can deadlock if misused on the same queue, and under extreme read contention you revisit the locking strategy. Today, for greenfield modules, I’d consider a Swift actor with the same API surface.” Full story text: story-bank .

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q8. How I would apply it · S2-A1 — Actor migration for greenfield? `(45–60s)`
**Answer:**

> “Provenance: How I would apply it · · greenfield shared maps → Swift actor This is design judgment, not a claim that BMS rewrote all dictionaries to actors.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Migration pitch (interview-ready)? `(45–60s)`
**Answer:**

> “Goal: Keep the same safe API ideas (hide storage, serialize mutation), change the implementation to language-native isolation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Strangler strategy (say this if asked “how do you migrate?”)? `(45–60s)`
**Answer:**

> “1. Don’t big-bang rewrite every call site in a revenue app. 2. Introduce actor SafeDict for new modules / new shared maps. 3. Optionally wrap the actor behind an async façade that matches domain needs. 4. Leave stable GCD dictionaries alone until a feature touch requires change. 5. Teach the team the reentrancy rule so “we moved to actors” doesn’t create logic bugs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. API shape to defend? `(45–60s)`
**Answer:**

> “See code/SafeDictActor.swift: - Generic Key: Hashable & Sendable, Value: Sendable - get / set / remove / snapshot - Never return a mutable interior reference that callers can race.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. –60s applied answer? `(45–60s)`
**Answer:**

> “Production fix was GCD serial-queue dictionaries — Verified . For greenfield shared maps I’d expose an actor with the same get/set surface so isolation is compiler-checked. I wouldn’t rewrite a stable module just for fashion; I’d strangler-migrate at boundaries and train on actor reentrancy so state is re-validated after await.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Verified · S3 — Search debounce and Task cancellation? `(45–60s)`
**Answer:**

> “Provenance: Verified · · BookMyShow · backend-driven header; search debounce, state, MVVM is broader (SDUI header + search UX). For this day, the concurrency slice is:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Concurrency lesson from S3? `(45–60s)`
**Answer:**

> “Debounce is not only sleep(300ms). The senior piece is cancel the previous Task (and treat CancellationError as normal).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Interview line (≤20s)? `(45–60s)`
**Answer:**

> “For search we debounced and cancelled the previous in-flight Task so slower older responses couldn’t overwrite fresher results.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Tie-back to Day 05 vocabulary? `(45–60s)`
**Answer:**

> “Full story: story-bank .”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q17. What not to invent? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q18. Bridge A — GCD → actors (S2 → S2-A1)? `(45–60s)`
**Answer:**

> “We serialized dictionary access with GCD. Actors are the language-native equivalent for new code: same boundary idea, compiler isolation, but revalidate after await.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Bridge B — Cancellation (S3)? `(45–60s)`
**Answer:**

> “Unstructured Tasks need ownership. In search, I store the Task and cancel on each query change so cancellation is part of the product behavior, not an afterthought.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Bridge C — Settings humility (Swift 6)? `(45–60s)`
**Answer:**

> “Under Swift 6 checking when enabled, Sendable and isolation violations become errors. Default MainActor isolation is a setting, not something I assert as universal.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Social feed / SD adjacent note (light)? `(45–60s)`
**Answer:**

> “If Week 1 social-feed HLD asks where concurrency fits: - Image/poster prefetch → TaskGroup with a bound - Feed pagination → cancel in-flight page on pull-to-refresh - In-memory metadata maps → actor or GCD-safe store ( / ).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
