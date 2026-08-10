# 01 — Foundations: Why Modules Exist (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Plain-English mental model? `(45–60s)`
**Answer:**

> “A growing iOS app becomes a traffic jam if everything imports everything: - Slow incremental builds - Merge conflicts in the project file - Hidden singletons (NetworkManager.shared) - Impossible reuse across apps (copy-paste Stories UI per brand).”

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

### Q3. Golden dependency rule? `(45–60s)`
**Answer:**

> “text App ├─ FeatureA Impl ──► FeatureB Interface ──► Core ├─ FeatureB Impl ──► FeatureA Interface ──► Core └─ wires concrete builders at composition root Forbidden: FeatureA Impl imports FeatureB Impl.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Why interviewers care? `(45–60s)`
**Answer:**

> “- Scale (teams, build time) without hand-waving - Compile-time safety vs runtime locator surprises - SDK reuse proof ( Stories) - Linking/launch trade-offs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. 60-second HLD to draw? `(45–60s)`
**Answer:**

> “text +------------ App (DI root, deeplink routing) -------------+ +----------------------------------------------------------+.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Checkpoint? `(45–60s)`
**Answer:**

> “1. Interface vs Impl in one sentence each 2. Where does DI live? 3. Why folders ≠ modules? → 02-deep-dive.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
