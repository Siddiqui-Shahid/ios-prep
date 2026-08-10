# 02 — Deep Dive: Mechanics, Traps, Trade-offs (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. What the compiler actually does (mental model)? `(45–60s)`
**Answer:**

> “For small structs stored in registers / stack, assignment often is a bitwise copy of stored properties. For larger values, Swift may still copy stored properties eagerly — unless the type implements COW internally (std collections do). Your own struct Huge with ten large non-COW properties pays copy cost on each assignment / pass-by-value.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. `inout` and exclusivity? `(45–60s)`
**Answer:**

> “swift func bumpX(_ p: inout Point) { p.x += 1 } var point = Point(x: 0, y: 0) bumpX(&point) // mutate in place — no conceptual “return a copy”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Mutation through `mutating` methods? `(45–60s)`
**Answer:**

> “swift struct Counter { private(set) var value = 0 mutating func increment { value += 1 } } var c = Counter c.increment.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Uniqueness? `(45–60s)`
**Answer:**

> “Stdlib collections store a reference to a buffer object. Before mutating, they ask roughly: “is this buffer uniquely referenced?” Swift exposes a related primitive for your COW types:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. When does A change after mutating B? `(45–60s)`
**Answer:**

> “swift var a = [1, 2, 3] var b = a b.append(4) // a is still [1,2,3] — COW copied for b Trap answer: “Always shared” or “Always copied on assign.” Correct: shared until a write forces uniqueness.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Wrapping arrays in a class kills COW *across* that wrapper? `(45–60s)`
**Answer:**

> “swift final class ArrayBox { var values: [Int] init(_ values: [Int]) { self.values = values } } let box1 = ArrayBox([1, 2]) let box2 = box1 box2.values.append(3) // box1.values also [1,2,3] — the box is shared.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Performance interview answer (90s shape)? `(45–60s)`
**Answer:**

> “1. Claim: COW makes value-typed collections cheap to pass until mutation. 2. Mechanism: shared buffer + uniqueness check on write. 3. Trade-off: unexpected copies if you mutate while aliases exist; profiling matters for huge buffers. 4. Prod: listing/search arrays — avoid defensive deep copies in hot paths; let COW work; don’t wrap in classes “for safety” without thinking. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Struct + class property? `(45–60s)`
**Answer:**

> “Already covered in foundations — deepen the failure mode: swift struct UserSession { var token: String var profiler: Profiler // class }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Closures capture references? `(45–60s)`
**Answer:**

> “swift final class Loader { var label = "x" func makePrinter -> -> Void { { print(self.label) } // captures self strongly by default } } Closures are reference-ish for captures. Pair with ARC / retain-cycle day — but for this day, know that “I used a struct” does not eliminate shared mutable state if you capture classes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Impossible states are bugs you don’t ship? `(45–60s)`
**Answer:**

> “Boolean flags explode combinatorially:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Mapping network `Result` → UI state? `(45–60s)`
**Answer:**

> “Keep Result at the networking edge; map to a UI-facing enum: swift enum LoadState<T> { case idle case loading case loaded(T) case failed(Error) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Payment popup machine (Applied · S7-A1)? `(45–60s)`
**Answer:**

> “swift enum PaymentPopupState: Equatable { case hidden case processing(message: String) case success(bookingID: String) case failure(code: String, message: String) case timedOut(message: String) mutating func apply(_ event: PaymentEvent) { switch (self, event) { case (.hidden, .userStartedCheckout): self = .processing(message: "Confirming payment…") case (.processing, .backendSuccess(let id)): self = .success(bookingID: id) case (.processing, .backendFailure(let code, let message)): self = .failure(code: code, message: message) case (.processing, .timeout): self = .timedOut(message: "Still working — check your bookings.") case (.success, .dismiss), (.failure, .dismiss), (.timedOut, .dismiss): self = .hidden default: break // ignore illegal transitions; or assert in DEBUG } } }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Versioning new cases (SDUI / backend-driven adjacent)? `(45–60s)`
**Answer:**

> “When backend can add modes: swift enum HeaderComponent { case banner(BannerPayload) case spacer(height: CGFloat) case unknown(type: String, raw: [String: String]) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Recursive / nested domain trees? `(45–60s)`
**Answer:**

> “swift indirect enum FeedNode { case ad(AdCreative) case event(EventSummary) case section(title: String, children: [FeedNode]) } Useful for nested listings / comment threads. Mention indirect when asked about recursive enums.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Hashing classes? `(45–60s)`
**Answer:**

> “If you put class instances in a Set / Dictionary key: - Prefer stable ID-based Hashable or identity via ObjectIdentifier - Never mutate fields that participate in hash(into:) while the object is in the collection — undefined behavior / lost entries.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. When a model *should* be a class? `(45–60s)`
**Answer:**

> “Rare but real: - Shared mutable cache entry with intentional identity - ObjC interop / UIKit subclass - “One session object” everyone must see updates on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Actor vs class? `(45–60s)`
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

### Q18. Actor vs serial queue (S2 bridge)? `(45–60s)`
**Answer:**

> “Soft pitch:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q19. Why not every ViewModel is an actor? `(45–60s)`
**Answer:**

> “UI must update on the main actor. Common pattern: swift @MainActor final class SearchViewModel: ObservableObject { @Published private(set) var state: LoadState<[String]> = .idle }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Actor reentrancy (awareness only)? `(45–60s)`
**Answer:**

> “While an actor awaits, other work may run on that actor before your method continues. Don’t assume “I set flag X, awaited, flag X still means what I think” without care. Deep dive = Day 05. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Type choice? `(45–60s)`
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

### Q22. State modeling? `(45–60s)`
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

### Q23. Failure modes checklist? `(45–60s)`
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

### Q24. Struct vs class (45s)? `(45–60s)`
**Answer:**

> “Agenda: semantics → mutation → example. Structs have value semantics — copies are independent. Classes share identity — mutation is visible everywhere. I default to structs for ad/listing models; classes for UIKit and true shared services.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. COW (45s)? `(45–60s)`
**Answer:**

> “Agenda: share → uniqueness → mutate. Assignment of Array is cheap because buffers are shared. On mutation, if the buffer isn’t uniquely referenced, Swift copies first. So value semantics stay intact without paying full copy on every assign.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q26. Enum state (45s)? `(45–60s)`
**Answer:**

> “Agenda: impossible states → exhaustiveness → payload. Booleans allow illegal combinations. An associated-value enum makes each mode carry only the data it needs, and switches stay exhaustive. That’s how I’d model payment processing UI.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q27. Actor intro (45s)? `(45–60s)`
**Answer:**

> “Agenda: race → isolation → bridge. An actor is a reference type that serializes access to its state. Call sites await. It’s the modern equivalent of the serial-queue boundary we used around shared dictionaries. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q28. Diagram: decision flow? `(45–60s)`
**Answer:**

> “text Do you need identity or ObjC/UIKit inheritance? │ ├─ yes → class (or @MainActor class for UI) │ │ │ └─ shared mutable across tasks? │ ├─ yes → actor (or isolate behind actor) │ └─ no → plain class / main-actor type │ └─ no → is it a finite mode + payload? ├─ yes → enum └─ no → struct │ └─ large / shared buffer needs? └─ rely on std COW or implement COW ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q29. Connect to code in this chapter? `(45–60s)`
**Answer:**

> “Read both before questions.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q30. Next? `(45–60s)`
**Answer:**

> “03-production-bridge.md — turn / / into tight interview lines without inventing metrics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
