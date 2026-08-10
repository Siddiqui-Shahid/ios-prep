# 01 — Foundations: Lifecycle, Cells, Hybrid — Mental Model (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Plain-English mental model? `(45–60s)`
**Answer:**

> “UIKit screens are objects with a lifetime. If you start a video in viewDidLoad and never pause, it plays in the graveyard behind another tab. If you bind an image in a cell and ignore reuse, yesterday’s poster smiles on today’s movie. Hybrid UI means SwiftUI and UIKit share one product. Each side has rules; bolting UIHostingController without ownership is how deeplinks double-present and state resets.”

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

### Q3. Lifecycle order (say aloud)? `(45–60s)`
**Answer:**

> “init → loadView → viewDidLoad → viewWillAppear → viewIsAppearing (iOS 17+) → viewDidAppear → layout callbacks → viewWillDisappear → viewDidDisappear → deinit.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Cells — intern path? `(45–60s)`
**Answer:**

> “1. cellForItem dequeues recycled cell. 2. Bind model for indexPath; start image task with ID token. 3. User scrolls; cell goes to reuse pool. 4. prepareForReuse cancels task, clears image, clears handlers. 5. Rebound for new model — no stale poster. Wrong image bug: Async completion after reuse assigns old image unless you check ID / cancel.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Prefetch — intern path? `(45–60s)`
**Answer:**

> “System hints upcoming indexPaths → start warm fetches → cancel when cancelPrefetchingForItemsAt fires. Bound concurrency. Not unlimited download.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Hybrid — intern path? `(45–60s)`
**Answer:**

> “One navigation owner. Deeplinks write to that owner only.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. LE Bottom Sheet — product picture (S6)? `(45–60s)`
**Answer:**

> “Lightweight event overview sheet reduced full-screen navigations for 30%+ of user flows. Prefer sheet when overview depth is shallow; push when hierarchy is deep. Cross-functional API/content contracts with PM/Design/Backend.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Production anchors? `(45–60s)`
**Answer:**

> “- Grizzlies: Hybrid architecture; deeplinks; Mixpanel; Airship — interop designed, not bolted. - BMS: LE Bottom Sheet; 30%+ nav reduction metric from resume. - : Ads video lifecycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Self-check? `(45–60s)`
**Answer:**

> “1. Appear vs load distinction 2. prepareForReuse duties 3. Prefetch cancel 4. Why dual nav stacks fail 5. Sheet vs push product rule + 30%+.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Flash preview? `(45–60s)`
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

### Q11. Appearance vs load — tab example? `(45–60s)`
**Answer:**

> “text User opens Tab A → load + didLoad + appear User switches B → A disappear; B load (first time) + appear User back to A → A appear ONLY (didLoad does not rerun) If Tab A fetched only in viewDidLoad, data is stale forever. Throttle refresh on appear (e.g. if older than N seconds).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Cell bind sequence (memorize)? `(45–60s)`
**Answer:**

> “text dequeue → prepareForReuse (previous owner cleanup) → configure(model) → start async with token → on complete: if token matches → apply Never configure without a reuse reset path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Hybrid containment checklist (UIHostingController)? `(45–60s)`
**Answer:**

> “1. addChild(hosting) 2. Add hosting.view constraints 3. hosting.didMove(toParent: self) 4. Forward appearance if needed for nested players 5. On remove: willMove, remove view, removeFromParent Skipping containment breaks rotation, safe area, and appearance forwarding.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Sheet product heuristics? `(45–60s)`
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

### Q15. 90-second teaching script? `(45–60s)`
**Answer:**

> “UIKit lifecycle separates one-time load from every-show appear work — pause and cancel on disappear. Cells must reset and cancel in prepareForReuse; prefetch must cancel and bound concurrency. Hybrid UI needs one navigation owner for deeplinks and push taps. On Grizzlies I designed SwiftUI↔UIKit interop that way; on BookMyShow the LE Bottom Sheet cut full-screen navigations for 30%+ of flows.”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
