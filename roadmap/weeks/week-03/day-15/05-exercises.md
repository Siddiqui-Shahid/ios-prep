# 05 — Exercises (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. A1. Draw the graph? `(45–60s)`
**Answer:**

> “Ticketing app: App, Checkout, Search, Ads, MediaStories, CoreNetwork. Mark Interface vs Impl and one protocol-only nav arrow. Solution: Impls hang under App; cross arrows only to Interface; App wires builders. MediaStories/Stories is a reusable product module ( shape).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. A2. Forbidden import? `(45–60s)`
**Answer:**

> “CheckoutImpl imports CartImpl to push a VC. Fix? Solution: Depend on CartBuildable in CartInterface; App provides CartImpl builder.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. A3. Interface smell? `(45–60s)`
**Answer:**

> “CheckoutInterface imports UIKit and exposes CheckoutViewController subclass. What’s wrong + fix? Solution: Interfaces should stay lean. Prefer CheckoutBuildable returning opaque UIViewController from Impl, or keep UI types in Impl only.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. A4. Provenance rewrite? `(45–60s)`
**Answer:**

> “Bad: “I built Needle at Raw and cut build times 70% with 80 SPM modules.” Solution: “I designed a standalone Stories SDK with a public API and host-injected deps, adopted across portfolio apps. I don’t have a verified 70% build-time metric to quote.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. A5. Packaging vs architecture? `(45–60s)`
**Answer:**

> “One sentence each: CocoaPods vs SPM; modular architecture. Solution: Packaging = how you distribute targets. Architecture = Interface/Impl graph + DI + public API. Clean pods and messy SPM both exist.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. B. Coding? `(45–60s)`
**Answer:**

> “1. Read code/Package.swift — explain target deps aloud; name the forbidden edge. 2. Read code/StoriesPublicAPI.swift — list public protocols hosts must supply. 3. Read code/CompositionRoot.swift — where is the composition root? Why isn’t network a feature singleton? 4. Optional: add CartBuildable protocol + register a fake in AppComponent. 5. Optional: sketch how StoriesConfiguration would be built inside AppComponent for Heat vs Aces themes. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. C. Speaking drills? `(45–60s)`
**Answer:**

> “1. STAR ≤ 3 min (record). 2. Q4 composition root ≤ 45s. 3. Q9 extract Stories ≤ 60s. 4. T1 folders vs packages ≤ 120s. 5. T2 locator vs constructor ≤ 120s. 6. T6 pod vs architecture ≤ 120s. 7. T8 portfolio versioning ≤ 120s. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. D. Whiteboard (10–12 min)? `(45–60s)`
**Answer:**

> “Agenda first, then draw: 1. App composition root 2. Two features with Interface-only cross nav 3. Stories SDK box with injected ImageLoading / analytics 4. Static vs dynamic callout in one sentence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. E. Timed drill? `(45–60s)`
**Answer:**

> “Record Q4, Q9, Q6 + T1, T6. Score via timing guide. Revision twin: ../../../revision/weeks/week-03/day-15.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
