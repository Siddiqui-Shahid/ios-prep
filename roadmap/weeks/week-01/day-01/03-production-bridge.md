# 03 — Production Bridge (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Story map for today? `(45–60s)`
**Answer:**

> “Full STAR writeups: ../../../stories/story-bank.md (, , ).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. What you can say (safe)? `(45–60s)`
**Answer:**

> “- Highest-revenue Ads module; safer reusable rendering path - Protocol-oriented contracts + generics for a type-safe pipeline - HeroWidget with explicit pause/play tied to visibility / lifecycle - Prefer models that don’t invite accidental shared mutation across UI surfaces.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. What you must **not** invent? `(45–60s)`
**Answer:**

> “- Fill-rate percentages, revenue deltas, exact crash rates for ads - “Every ad model was a struct” (unless you personally know that).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Interview lines? `(45–60s)`
**Answer:**

> “≤20s pitch (value semantics): “I default to value-friendly DTOs for ad and listing models so accidental shared mutation can’t corrupt revenue UI; classes or actors only at identity or concurrency boundaries.” 45s conceptual with : “On the Ads refactor we pushed type safety with protocols and generics so new creatives plugged into one pipeline. That mindset extends to model choice: structs and enums for render data keep copies independent across cells and widgets, while classes stay at UIKit and shared services. For video, identity and lifecycle mattered — HeroWidget owned pause/play against visibility, which is a reference-type concern.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. What you can say (safe)? `(45–60s)`
**Answer:**

> “- Checkout delays caused drop-off / support load when status was unclear - Designed a lightweight popup for real-time processing status - Clear states: processing / success / failure / timeout messaging - Coordinated with backend signals - Intent: reduce ambiguity → less drop-off / support friction.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. What you must **not** invent? `(45–60s)`
**Answer:**

> “- Measured drop-off %, conversion lift, support ticket deltas - Claiming the shipped code used Swift enum by name.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Interview lines? `(45–60s)`
**Answer:**

> “≤20s: “For payment delays we shipped a processing popup with explicit status so users weren’t staring at a silent spinner.” STAR Action slice (~45–60s) focused on state: “The product problem was uncertainty during booking/payment confirmation. I designed a lightweight popup driven by backend status signals, with distinct processing, success, failure, and timeout messaging. The key was treating communication of state as part of the feature — silent waiting was the bug.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q8. Applied · S7-A1 — Enum state machine (design)? `(45–60s)`
**Answer:**

> “Use this when the interviewer asks how you’d model the states in Swift. Say explicitly that this is the design you’d use / recommend:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Verified · S2 (keep short today)? `(45–60s)`
**Answer:**

> “- Shared async state hit from multiple queues → races / intermittent crashes - Synchronised dictionaries behind GCD serial queues (RW locks where read-heavy) - Standardized access API so call sites couldn’t touch raw storage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Soft Day-01 actor line? `(45–60s)`
**Answer:**

> “Where we serialized dictionary access with a GCD serial queue, a Swift actor is the language-native equivalent I’d evaluate for new code — same API surface, compile-time isolation.” > Provenance: Verified · · BookMyShow · synchronised dictionaries Provenance: How I would apply it · · greenfield shared maps as actor.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. Combining stories without metric inflation? `(45–60s)`
**Answer:**

> “Scale context you may use when relevant (from , not Day 01 core): 30+ lakh DAU, 99.95%+ crash-free — only if the question is about production risk, not as decoration on every answer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Anti-patterns in interviews? `(45–60s)`
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

### Q13. Flash “map to your work” card? `(45–60s)`
**Answer:**

> “Company / feature: BookMyShow — Ads / listing models; Payment processing popup What you did: Kept render models in a type-safe ads pipeline; modeled processing UI as explicit states rather than silent waiting.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q14. Next? `(45–60s)`
**Answer:**

> “Drill spoken answers in sample/07-revision-qna.md. Speak from Answer points first; then compare to Full spoken answer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
