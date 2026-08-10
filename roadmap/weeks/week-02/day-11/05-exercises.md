# 05 — Exercises (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. A1. Lifecycle placement table? `(45–60s)`
**Answer:**

> “For each: start video, refresh list, screen analytics, cancel search — pick hooks. Solution: start video → didAppear+visibility; refresh → willAppear (throttled); analytics → didAppear/disappear; cancel search → willDisappear.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. A2. T/F? `(45–60s)`
**Answer:**

> “1. viewDidLoad runs every tab switch. 2. prepareForReuse should cancel image tasks. 3. Dual NavigationPath + UINav is fine if you sync hard. 4. metric is 30%+ fewer full-screen navs. 5. Pause ads only in deinit. Solution: 1F 2T 3F 4T 5F.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. A3. Provenance rewrite? `(45–60s)`
**Answer:**

> “I rebuilt Grizzlies in pure SwiftUI and cut navigation 50%.” Solution: “I architected SwiftUI↔UIKit interop on Grizzlies with deeplink ownership plus Mixpanel/Airship. Separately, on BookMyShow the LE Bottom Sheet reduced full-screen navigations for 30%+ of user flows — I don’t claim a 50% Grizzlies nav metric or a pure-SwiftUI rewrite.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. B1. CellReuseGuard? `(45–60s)`
**Answer:**

> “Explain why generation token is updated in prepareForReuse. Solution: Invalidates in-flight completions tied to prior bind.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. B2. PrefetchBudget? `(45–60s)`
**Answer:**

> “What happens if cancel isn’t called? Solution: Tasks keep running → data/battery burn.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. B3. DeeplinkInbox? `(45–60s)`
**Answer:**

> “Write a sequence: enqueue before ready, markReady, assert order.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. C. Speaking? `(45–60s)`
**Answer:**

> “ 20s; 20s; full 2–3m; T3 dual nav 120s; T5 tab vs sheet 90s.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. D. Whiteboard? `(45–60s)`
**Answer:**

> “Deeplink → router → UIKit host vs SwiftUI host; annotate cold-start queue.”

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

> “Q7, Q8, Q5 + T3, T5. Timing guide. Log dual-nav + hosting sizing misses.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. F. Flashcards? `(45–60s)`
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

### Q11. G. Deeper? `(45–60s)`
**Answer:**

> “1. Visibility threshold policy paragraph for in-feed ads. 2. List three Mixpanel double-count risks in hybrid hosting. 3. Sketch LE sheet API: inputs, dismiss, analytics events.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. H1. In-feed ad visibility (90s speak)? `(45–60s)`
**Answer:**

> “Write a threshold policy: play above 50% visible for 250ms; pause below 50% or on VC disappear or background.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. H2. Cold-start deeplink + push simultaneously? `(45–60s)`
**Answer:**

> “Both fire for the same game screen. How does DeeplinkInbox + dedupe behave? Solution sketch: Queue until ready; identical route intents within short window collapse to one present; analytics once.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. H3. LE sheet API sketch? `(45–60s)`
**Answer:**

> “text LEBottomSheet(eventId, summaryDTO, onOpenTickets, onShare, onDismiss) detents: [.medium, .large] analytics: le_sheet_open / cta / dismiss.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. H4. Hosting height war story (60s)? `(45–60s)`
**Answer:**

> “Speak: intrinsic bridging, one scroll owner, avoid recreating hosting VC.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. H5. Cell closure cycle diagram? `(45–60s)`
**Answer:**

> “Draw VC → CV → Cell → closure → VC; mark weak + prepareForReuse clear.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
