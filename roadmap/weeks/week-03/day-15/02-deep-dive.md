# 02 — Deep Dive: SPM Graphs, DI, Stories SDK (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Layer responsibilities? `(45–60s)`
**Answer:**

> “Cross-feature navigation: Feature A depends on FeatureBBuildable from B’s Interface; App registered the concrete builder.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. SPM packaging model? `(45–60s)`
**Answer:**

> “text Package.swift targets (illustrative): CheckoutInterface // leaf — rare changes, fast Checkout // Impl — depends on CheckoutInterface + CartInterface + CoreNetwork CartInterface Cart Stories // reusable SDK product CoreNetwork / CoreUI / CoreAnalytics Why Interface/Impl split:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. SPM vs CocoaPods (interview-ready)? `(45–60s)`
**Answer:**

> “Senior line: Packaging ≠ architecture. You can have a clean CocoaPod module or a messy SPM soup.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. DI without hidden globals? `(45–60s)`
**Answer:**

> “Prefer constructor injection or a typed component tree over service locators: swift protocol CheckoutDependency { var network: NetworkProviding { get } var cart: CartProviding { get } // from CartInterface }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Anti-patterns? `(45–60s)`
**Answer:**

> “- NetworkManager.shared inside feature modules - God AppDelegate with 40 singletons - Interface target secretly importing Impl - Locator resolves optional deps — crash in prod on first use.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Locator pragmatism? `(45–60s)`
**Answer:**

> “Admit legacy Swinject bridges exist; migrate feature-by-feature toward constructor/tree DI. Don’t pretend runtime containers are “more senior.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Static vs dynamic linking? `(45–60s)`
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

### Q8. Stories SDK as reusable module (deep)? `(45–60s)`
**Answer:**

> “Treat Stories like a product with a public API, not a folder copied per NBA/WNBA app: 1. Standalone package — host supplies theme, analytics, media loader protocols 2. Stable public API — entry, callbacks, errors; hide internal VCs/SwiftUI 3. Host-agnostic content — inject StoriesContentProviding 4. Versioning — additive minor; breaking = major + notes 5. Adoption — one implementation → portfolio parity.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q9. Shared models without Core junk drawer? `(45–60s)`
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

### Q10. Build times got worse after 80 modules? `(45–60s)`
**Answer:**

> “Causes: chatty Interface changes, over-fine splits, too many dynamic frameworks, poor CI caching. Fix: measure Build Timing Summary; merge leaf packages; stabilize Interfaces; prefer static internals. Tuist/Bazel: mention when monorepo scale demands — not as cargo cult.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Trade-offs summary? `(45–60s)`
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

### Q12. Failure modes? `(45–60s)`
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

### Q13. Optional citations? `(45–60s)`
**Answer:**

> “- Apple: Swift packages / modularizing apps - Uber Needle conceptual model - In-repo: ios-system-design/docs/app-modularization.md (optional skim).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
