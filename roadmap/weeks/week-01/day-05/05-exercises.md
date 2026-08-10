# Day 05 — Exercises (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. A1. Reentrancy storyboard? `(45–60s)`
**Answer:**

> “Draw or list steps for: 1. Task A enters actor Wallet.spend 2. Sees insufficient balance, await refresh 3. Task B enters spend or applyRemoteBalance before A resumes 4. Task A resumes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. A2. Sendable true/false? `(45–60s)`
**Answer:**

> “Mark true/false and fix false ones: 1. “Every struct is Sendable.” 2. “A struct whose only stored property is let name: String can be Sendable.” 3. “A struct storing var cache: NSMutableDictionary is Sendable because it’s a value type.” 4. “@unchecked Sendable proves thread safety.” 5. “Default MainActor isolation is always on in all Swift 6.2 apps.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. A3. Cancellation checklist for search? `(45–60s)`
**Answer:**

> “List 6 concrete code/actions for debounce search correctness. Solution sketch: 1. Store searchTask 2. Cancel previous on each query change 3. Cancellable debounce sleep 4. try Task.checkCancellation before/after network 5. Ignore CancellationError for UX 6. Publish results on @MainActor; optional generation token.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. B1. Implement / extend `SafeDictActor`? `(45–60s)`
**Answer:**

> “Open code/SafeDictActor.swift. Tasks: 1. Explain aloud why Key and Value require Sendable. 2. Add func merge(_ other: [Key: Value]) that replaces keys from other. 3. Add a broken commented method that awaits a simulated network fetch mid-update and documents the reentrancy hazard in comments. 4. Write a brief comment contrasting this API with Day 04 GCD sync get / async set.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. B2. Debounced search Task (Learning-lab)? `(45–60s)`
**Answer:**

> “In a Playground or scratch file, write a @MainActor class: swift @MainActor final class SearchLab { private var task: Task<Void, Never>? private(set) var latest: String = ”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. B3. async let vs TaskGroup? `(45–60s)`
**Answer:**

> “Implement two functions that fetch three fake resources: - loadFixed using async let - loadDynamic(_ ids: [String]) using withThrowingTaskGroup.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. C1. Symptom: intermittent wrong search results? `(45–60s)`
**Answer:**

> “Given: Debounce sleep exists; Tasks are not stored. Find: Root cause + fix in two sentences.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. C2. Symptom: “Impossible” actor invariant break? `(45–60s)`
**Answer:**

> “Given: Actor method sets isRefreshing = true, awaits network, sets result, clears flag. Sometimes two refreshes interleave oddly. Find: Name the concurrency concept + one fix.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. C3. Symptom: Swift 6 errors on crossing a class into an actor? `(45–60s)`
**Answer:**

> “Find: What to change architecturally (not just @unchecked). Solution: Send Sendable DTO values; keep class inside MainActor/actor isolation; avoid unchecked unless proven.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. D. Speaking drills (record)? `(45–60s)`
**Answer:**

> “Score each on: agenda opener, mechanism, trade-off, provenance honesty, timing.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. E. Flash recall (cover / uncover)? `(45–60s)`
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

### Q12. F. Day close-out checklist? `(45–60s)`
**Answer:**

> “- [ ] Explained reentrancy without notes - [ ] Stated Sendable stored-property rule correctly - [ ] Delivered STAR ≤3 min with honest metrics scope - [ ] Delivered migration as applied, not shipped rewrite - [ ] Tied debounce cancellation to - [ ] Qualified Swift 6 / Approachable Concurrency / default MainActor as settings when enabled - [ ] Read SafeDictActor.swift aloud line-by-line once - [ ] Completed timed set from sample/07-revision-qna.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
