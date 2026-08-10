# 02 — Deep Dive: Brief A & Brief B (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Prompt (use as-is)? `(45–60s)`
**Answer:**

> “Build a mobile screen that loads a paginated remote list (cursor or page number). Show loading / empty / error. Support pull-to-refresh and next-page on scroll. Add a cache so revisiting shows last-good data quickly, then refresh. Include unit tests for pagination and cache policy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Suggested architecture? `(45–60s)`
**Answer:**

> “text ListView (SwiftUI or UIKit) → ListViewModel (items, page/cursor, isLoading, error) → ListRepository protocol → RemoteDataSource (URLSession or stub) → CacheDataSource (memory + optional disk).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Must-have acceptance? `(45–60s)`
**Answer:**

> “1. First page renders from network (or stub). 2. Next page appends without wiping. 3. Failure on page 2 keeps page 1 visible. 4. Cache: cold open can show stale then refresh (define policy aloud). 5. Tests: pagination reducer / repository with mock — not only UI snapshots.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Cache policy options (pick one, say why)? `(45–60s)`
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

### Q5. Cut lines (OK)? `(45–60s)`
**Answer:**

> “Fancy skeletons, Diffable animations, image pipeline, auth refresh, perfect offline merge. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Prompt (use as-is)? `(45–60s)`
**Answer:**

> “Build a server-driven UI renderer: JSON document of components (type, props, optional children) → native views. Support ≥3 types (e.g. text, image, button / vstack). Unknown type → safe fallback. Include schemaVersion check. Unit-test decoding + unknown-type fallback.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Suggested architecture? `(45–60s)`
**Answer:**

> “text JSON Data → SDUIDocument (Codable, schemaVersion) → ComponentNode enum / protocol + factory → SDUIRenderer → AnyView / UIView → Feature flag / default fallback leaf.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Must-have acceptance? `(45–60s)`
**Answer:**

> “1. Decode sample JSON. 2. Render ≥3 types. 3. Unknown type does not crash — placeholder + analytics stub. 4. Nested children for one container. 5. Tests: decoder + factory fallback.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Cut lines? `(45–60s)`
**Answer:**

> “Full CMS tooling, live reload, expression language, rich actions, Figma pixel parity. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Rubrics (1–5)? `(45–60s)`
**Answer:**

> “Pass bar: average ≥3.5, correctness ≥4, tests ≥3.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Trade-offs? `(45–60s)`
**Answer:**

> “→ 03-production-bridge.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Brief A — 90s plan? `(45–60s)`
**Answer:**

> “SwiftUI List + ListViewModel. Repository protocol with stub remote and memory SWR cache. Page-based pagination with in-flight guard and request generation id. Acceptance: page1, append page2, failed page2 keeps page1, stale-then-refresh, three unit tests. Cut: images, disk, auth.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Brief B — 90s plan? `(45–60s)`
**Answer:**

> “Codable SDUIDocument with schemaVersion. Factory for text, image, vstack. Recursive renderer. Unknown → PlaceholderView + log stub. Tests: decode fixture, three types, unknown doesn’t throw. Cut: actions DSL, live reload.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Brief A — state machine (teach)? `(45–60s)`
**Answer:**

> “text idle → loadingFirst loadingFirst → loaded loaded (keep stale + error) Stale response rule: each fetch captures generation; commit only if generation == viewModel.generation.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Brief B — decode + factory sketch (interview whiteboard)? `(45–60s)`
**Answer:**

> “swift struct SDUIDocument: Codable { let schemaVersion: Int let root: ComponentDTO } struct ComponentDTO: Codable { let type: String let props: [String: String]? let children: [ComponentDTO]? } enum ComponentNode { case text(String) case image(URL?) case vstack([ComponentNode]) case unknown(type: String) } Factory: switch type → known cases; default: .unknown(type). Renderer never force-unwraps.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Communication rubric cues (what graders hear)? `(45–60s)`
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
