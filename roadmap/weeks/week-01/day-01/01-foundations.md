# 01 — Foundations: Value vs Reference, COW, Enums, Actors (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. What is the one rule to remember for this topic? `(45–60s)`
**Answer:**

> “Prefer value types for data; use reference types when you need identity or shared mutable lifetime; use actors when that shared mutability crosses concurrency. Everything below is unpacking that sentence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Two boxes in your head? `(45–60s)`
**Answer:**

> “Imagine every variable is a name taped to either:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. The intern demo (do this once out loud)? `(45–60s)`
**Answer:**

> “Structs copy their data on assignment. Classes share identity; mutating through one name is visible through the other.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. `let` vs `var` is not value vs reference? `(45–60s)`
**Answer:**

> “For a struct, let p = Point(...) also means you cannot mutate p’s properties (because mutation would reassign the whole value under the hood).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Decision table: struct / class / enum / actor? `(45–60s)`
**Answer:**

> “Senior rule of thumb: Start with struct/enum. Justify every class. Justify every actor with a concurrency boundary.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Why teams love structs for models? `(45–60s)`
**Answer:**

> “swift struct AdCreative: Equatable { let id: String let title: String let clickURL: URL } func decorate(_ ad: AdCreative) -> AdCreative { // Returning a new value — caller keeps the old one unless they assign var copy = ad // mutate copy fields if they were var… return copy }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q7. Structs can contain classes (shallow copy)? `(45–60s)`
**Answer:**

> “swift class ImageCache { var bytes: Data = Data } struct CellModel { var title: String var cache: ImageCache // reference inside a value }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. When a class is the right tool? `(45–60s)`
**Answer:**

> “Use a class when you need identity: - The same service instance shared across the app (APIClient, session managers) - UIKit / AppKit objects (UIViewController, UIView) - “Is this the same object?” checks with === - Legacy KVO / ObjC runtime requirements.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. `==` vs `===`? `(45–60s)`
**Answer:**

> “Structs do not have ===. Asking “are these the same struct instance?” is a category error — they are values, not identities.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Associated values = data that travels with the mode? `(45–60s)`
**Answer:**

> “swift enum LoadState<T> { case idle case loading case loaded(T) case failed(Error) } Compare to boolean soup:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Why this matters for UI? `(45–60s)`
**Answer:**

> “Payment / booking flows are state machines in disguise: swift enum PaymentPopupState { case hidden case processing(message: String) case success(bookingID: String) case failure(message: String) case timedOut(message: String) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q12. Recursive enums need `indirect`? `(45–60s)`
**Answer:**

> “Enums have a fixed size known at compile time. A case that contains another value of the same enum needs a heap box: swift indirect enum CommentThread { case leaf(String) case node(String, replies: [CommentThread]) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. The problem COW solves? `(45–60s)`
**Answer:**

> “If Array truly deep-copied every element on every assignment, large lists would be expensive. If it shared buffers like a class without care, mutations would leak across variables (surprising for a “value type”). COW = share storage until someone writes; then copy if needed.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. The three steps? `(45–60s)`
**Answer:**

> “1. Assign: var b = a — both may share one buffer. Cheap (pointer + refcount). 2. Read: either variable can read freely. Still shared. 3. Mutate: before writing, Swift checks “am I the only owner?” - Yes → mutate in place - No → copy buffer, then mutate the unique copy swift var a = [1, 2, 3] var b = a // share b.append(4) // b unique after copy; a still [1,2,3] print(a) // [1, 2, 3] print(b) // [1, 2, 3, 4].”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. One-sentence junior explanation? `(45–60s)`
**Answer:**

> “Arrays act like values, but under the hood they cheaply share memory until someone changes something — then they copy.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. What problem actors solve? `(45–60s)`
**Answer:**

> “Reference types + concurrency = data races if two tasks mutate the same object without synchronization. An actor is a reference type whose mutable state is isolated. You talk to it with await; the runtime serializes access.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Soft bridge from production? `(45–60s)`
**Answer:**

> “At BookMyShow, shared mutable maps were protected with GCD serial queues. Soft interview line: > “Where we serialized dictionary access with a serial queue, a Swift actor is the language-native equivalent I’d evaluate for new code.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q18. What *not* to say today? `(45–60s)`
**Answer:**

> “- “Actors replace all classes” - “Every ViewModel should be an actor” - Deep hop / reentrancy theory — save for Day 05 Enough for Day 01: isolated reference type; await to touch state; prevents data races.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Glossary (pin)? `(45–60s)`
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

### Q20. Teach-back checklist? `(45–60s)`
**Answer:**

> “Explain each in ≤20s without notes: 1. Struct assignment vs class assignment 2. Why let on a class still allows property mutation 3. Why enums beat boolean flags for UI state 4. COW one-liner 5. Actor one-liner + serial-queue bridge.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Struct vs class mutation? `(45–60s)`
**Answer:**

> “swift struct Ticket { var seat: String } class Hold { var seat: String; init(_ s: String) { seat = s } } var t1 = Ticket(seat: "A1") var t2 = t1 t2.seat = "B2" // t1.seat == "A1”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q22. Enum switch exhaustiveness? `(45–60s)`
**Answer:**

> “swift func title(for state: LoadState<String>) -> String { switch state { case .idle: return "Start" case .loading: return "Loading…" case .loaded(let value): return value case .failed: return "Something went wrong" } } Adding a new case forces every switch to update — that pressure is the feature.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Next? `(45–60s)`
**Answer:**

> “Go to 02-deep-dive.md for COW uniqueness checks, large-struct costs, nested reference traps, payment state machines, and actor vs @MainActor boundaries.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
