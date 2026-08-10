# 02 — Deep Dive: Observation, Identity, Lists, Stories SDK (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. State ownership decision tree? `(45–60s)`
**Answer:**

> “text Is it pure ephemeral UI for one view? yes → @State no ↓ Do child controls need to write it? yes → @Binding into parent/@Bindable model no ↓ Is it screen/feature async or shared across children? yes → @Observable model (iOS 17+) / ObservableObject (legacy) no ↓ Is it tree-wide theme/locale? yes → Environment no → You’re over-abstracting — keep it simple.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Anti-patterns? `(45–60s)`
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

### Q3. Observation vs ObservableObject? `(45–60s)`
**Answer:**

> “Interview sentence: Prefer Observation on modern targets; still explain @Published when asked about legacy codebases.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Granularity and storms? `(45–60s)`
**Answer:**

> “A monolithic observable with 50 fields used by a root view can invalidate huge trees when any field changes. Split models (player vs chrome vs catalog). Pass slices into children.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Structural identity? `(45–60s)`
**Answer:**

> “swift VStack { Header // structural position 0 Content // structural position 1 } Swap order conditionally without IDs → SwiftUI may treat views as different → state jumps.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Explicit identity? `(45–60s)`
**Answer:**

> “swift ForEach(pages) { page in // Identifiable stable id StoryPageView(page: page) }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Forced new identity (intentional)? `(45–60s)`
**Answer:**

> “Logout → .id(userSessionID) so forms reset. Intentional reset ≠ accidental UUID churn.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Representable link (Day 11)? `(45–60s)`
**Answer:**

> “Parent identity churn → makeUIViewController storms → players restart. Stabilize IDs; update props.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Container choice? `(45–60s)`
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

### Q10. Row rules? `(45–60s)`
**Answer:**

> “1. Stable Identifiable — never UUID per body 2. Avoid id: \.self when value equality changes often 3. Don’t observe entire catalog inside each row — pass row models 4. Precompute formatted strings in model 5. Images: async + decode/size budgets (Week 3) 6. Scope animations — don’t .animation the universe.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. When Lazy still janks? `(45–60s)`
**Answer:**

> “Profile: image decode, main-thread JSON, overlapping observations, expensive shadows, unbounded prefetch. Fix data path, not only container choice.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. `body` purity? `(45–60s)`
**Answer:**

> “body is called often — that’s normal. Problem is heavy work or side effects inside.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Animation & transitions? `(45–60s)`
**Answer:**

> “- Prefer identity-preserving updates for smooth animation - Destroy/recreate (identity change) feels like jump cuts - Drive Stories progress from model timeline, not scattered onAppear timers - Use explicit withAnimation / transactions for intentional motion.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Public API sketch? `(45–60s)`
**Answer:**

> “text StoriesPlayer ├─ DataSource protocol (host supplies groups/pages) ├─ ImageLoading / VideoLoading protocols (injectable) ├─ Event callbacks (onOpen, onClose, onCTA, onPage) ├─ Theming hooks └─ Versioned module boundary.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. State machine? `(45–60s)`
**Answer:**

> “text idle → loading → playing ⇄ paused → finished ↓ failed (retry) Pause on: onDisappear, scene background, user hold — same lifecycle discipline as Ads video ( cousin).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Why not hardcode networking? `(45–60s)`
**Answer:**

> “Portfolio apps differ (Heat / other Raw apps). Injectable clients → testability + host variance. SDK quality = independence from host shortcuts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. UIKit hosts? `(45–60s)`
**Answer:**

> “SwiftUI-first OK; offer UIHostingController façade for legacy. Public API shouldn’t force one nav paradigm ( hosts).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. SDUI leaf identity (Day 10 crossover)? `(45–60s)`
**Answer:**

> “Registry views should use server-stable node ids for ForEach / .id. Array indices break when CMS inserts a banner above.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Testing SwiftUI logic? `(45–60s)`
**Answer:**

> “Theater UITests with sleep are AI smell (Day 08/ culture).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q20. Equatable View — micro-opt? `(45–60s)`
**Answer:**

> “Useful for expensive rare-changing subtrees. Don’t sprinkle early. Prefer smaller observed state first. Measure.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Trade-offs? `(45–60s)`
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

### Q22. Whiteboard scripts? `(45–60s)`
**Answer:**

> “A. State ownership table + one wrong placement B. Identity: UUID trap vs stable page ids C. Stories SDK boundary + state machine + pause Agenda: README opener.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Failure modes? `(45–60s)`
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

### Q24. Decision rule card? `(45–60s)`
**Answer:**

> “text 1. Pure UI → @State; async/domain → @Observable (iOS 17+) 2. IDs stable unless intentional reset 3. Large lists → lazy + cheap body + stable ids 4. Split models to avoid invalidation storms 5. SDK: protocols in, events out, pause on disappear 6. Say the iOS 17+ caveat aloud.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. Optional citations? `(45–60s)`
**Answer:**

> “Apple State and Data Flow; Observation framework; WWDC Demystify SwiftUI / SwiftUI performance; app-modularization.md — appendix only.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
