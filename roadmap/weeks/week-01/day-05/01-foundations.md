# Day 05 — Foundations: async/await, Tasks, Actors, Sendable (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Why this day exists? `(45–60s)`
**Answer:**

> “Yesterday (Day 04) you learned GCD: queues, sync/async, and how a serial queue can protect a shared dictionary. That pattern shipped at BookMyShow as synchronised dictionaries. Today is the modern language-native half of the same problem:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. “Async” means “I might pause here”? `(45–60s)`
**Answer:**

> “An async function can suspend. Suspension is not the same as blocking a thread.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Tasks are units of asynchronous work? `(45–60s)`
**Answer:**

> “A Task is “a piece of async work the system can schedule.” You will see three common shapes:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Structured concurrency = parent owns children? `(45–60s)`
**Answer:**

> “Structured concurrency means asynchronous work forms a tree: - A parent starts children. - The parent does not finish until children finish (or are cancelled). - Cancellation and error handling can propagate along that tree.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. Actors = a room with one conversation at a time? `(45–60s)`
**Answer:**

> “An actor is a reference type that isolates its mutable state. - Only one task at a time executes on the actor (for its isolated methods/properties). - From outside, calling into an actor usually requires await (you may need to wait your turn). - From inside, you can touch the actor’s state without locks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. `@MainActor` = “this belongs on the UI thread”? `(45–60s)`
**Answer:**

> “UIKit and much of SwiftUI expect UI updates on the main actor/thread. @MainActor marks types or functions as isolated to the main actor. Calling them from elsewhere typically requires await (a hop to main).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Sendable = “safe to hand across concurrency domains”? `(45–60s)`
**Answer:**

> “Sendable means a value can safely cross isolation boundaries (e.g. into an actor, or between tasks) without creating data races. Rough beginner rule (refined in the deep dive):.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. async/await vs GCD callbacks (first contrast)? `(45–60s)`
**Answer:**

> “Both schedule work. Async/await is not automatically faster. It is usually clearer and composable with structured concurrency.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. A tiny end-to-end picture? `(45–60s)`
**Answer:**

> “text [Button tap — sync world] │ ▼ Task { @MainActor in ← unstructured bridge from UI await viewModel.search(query) } [ViewModel @MainActor] cancel previous search Task ← cooperative cancel (-style debounce) store new Task { try await Task.sleep(...) ← debounce delay let results = try await api.search(query) self.results = results ← still on MainActor if VM is }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Glossary (study until these feel boring)? `(45–60s)`
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

### Q11. What “good” sounds like in an interview (preview)? `(45–60s)`
**Answer:**

> “30s definition: “async/await lets a function suspend at await points instead of nesting callbacks. Structured concurrency keeps child tasks under a parent so cancellation propagates. Actors isolate shared mutable state; after an await inside an actor, I re-check state because of reentrancy.” 90s production bridge: “At BookMyShow we fixed shared-dictionary races with GCD serial queues and a closed API — Verified . For greenfield modules I’d expose the same get/set surface on a Swift actor — . For search, debounce isn’t just a timer; you cancel the previous Task so stale responses can’t win — .”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q12. Self-check before deep dive? `(45–60s)`
**Answer:**

> “Answer these aloud in one sentence each: 1. Does await always mean “jump to a background thread”? 2. What happens to child work when a structured parent is cancelled? 3. Can another call interleave on an actor while one method is suspended at await? 4. Are all structs automatically Sendable? 5. Is “Swift 6 defaults everything to MainActor” a safe universal claim?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
