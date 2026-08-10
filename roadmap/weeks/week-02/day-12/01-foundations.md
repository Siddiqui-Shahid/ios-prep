# 01 — Foundations: SwiftUI State & Identity Mental Model (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Plain-English mental model? `(45–60s)`
**Answer:**

> “SwiftUI is a state → UI engine. You describe views as a function of state; the framework diffs and updates. Most “SwiftUI is buggy” reports are state in the wrong place or identity that resets. Think of a theater:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Glossary? `(45–60s)`
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

### Q3. State ownership table (memorize)? `(45–60s)`
**Answer:**

> “Rule: View-local for pure UI; hoist async/domain to observable VM (Day 08). Don’t duplicate every toggle into VM.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Identity — the senior differentiator? `(45–60s)`
**Answer:**

> “SwiftUI recognizes “same view” by identity: - Structural: type + place in hierarchy - Explicit: .id("profile") / ForEach(stories) with stable Identifiable.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Intern path: happy Stories player? `(45–60s)`
**Answer:**

> “1. Host app supplies story groups via data source protocol. 2. StoriesPlayerModel (@Observable) owns timeline: idle → loading → playing → paused → finished. 3. Views render progress from model — not ad-hoc view timers alone. 4. onDisappear / scene phase → pause AV + timers. 5. Adjacent media prefetch carefully (budget — Day 11 lesson). 6. Host gets callbacks: open/close/CTA — injectable analytics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Lists — intern path? `(45–60s)`
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

### Q7. `@Observable` version note (say this)? `(45–60s)`
**Answer:**

> “For new code on iOS 17+ I prefer @Observable. On older deployment targets I’d use ObservableObject and @Published. In interviews I can explain both.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Environment DI — light touch? `(45–60s)`
**Answer:**

> “: SDK prefers explicit injectable networking/image loading protocols.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Production anchor — S10? `(45–60s)`
**Answer:**

> “Standalone reusable Stories SDK; clear public API; isolation from app-specific networking where possible; adopted across portfolio apps. SDK quality = API surface + versioning + independence from host shortcuts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Self-check? `(45–60s)`
**Answer:**

> “1. @State vs @Observable placement 2. Why UUID in .id breaks state 3. Lazy vs eager lists 4. iOS 17+ note for Observation 5. Stories pause + stable page IDs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Flash preview? `(45–60s)`
**Answer:**

> “'''.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Observation access tracking (intuition)? `(45–60s)`
**Answer:**

> “With @Observable, SwiftUI tracks which properties body read. Changing an unread property shouldn’t invalidate that view. Stuffing unused fields onto a model the root reads widely still causes storms — split models. Legacy ObservableObject often broadcasts more coarsely via objectWillChange.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Stories UI chrome vs domain? `(45–60s)`
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

### Q14. 90-second teaching script? `(45–60s)`
**Answer:**

> “SwiftUI state belongs either view-local or in an observable feature model — @Observable on iOS 17+, ObservableObject when you must support older OS. Identity preserves @State and representables; UUID-in-body resets everything. Lists need lazy containers and stable IDs. The Stories SDK I built exposes a clear API with injectable loading and host isolation so portfolio apps share one player — pause on disappear, stable page ids, progress owned by the model.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
