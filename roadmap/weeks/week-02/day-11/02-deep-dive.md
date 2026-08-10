# 02 — Deep Dive: Lifecycle, Reuse, Prefetch, Hybrid, Sheets (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Lifecycle ownership matrix? `(45–60s)`
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

### Q2. Tab bar trap? `(45–60s)`
**Answer:**

> “Tab view controllers often load once and appear many times. Network-only-in-viewDidLoad means stale data forever. Refresh policy belongs in appear (with caching/throttle).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. `viewDidLoad` isn’t called again — bug or feature? `(45–60s)`
**Answer:**

> “Feature when the VC instance is retained in a nav stack. Put repeatable work in appear hooks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Ads / video visibility (S1)? `(45–60s)`
**Answer:**

> “Revenue contract: text visible enough → play below threshold / disappear / background → pause.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. prepareForReuse checklist? `(45–60s)`
**Answer:**

> “See code/CellReuseGuard.swift. 1. Cancel image / network tasks 2. Clear image, text, highlighted state 3. Nil out closures / targets that capture VC 4. Reset swipe/gesture transient UI 5. Invalidate display tokens / generation IDs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Wrong-image anatomy? `(45–60s)`
**Answer:**

> “text cell binds movie A → start download A scroll → reuse for movie B → bind B → start download B download A completes → sets image without ID check → wrong poster Fix: store expectedID on cell; completion checks ID; cancel on reuse.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Diffable benefits? `(45–60s)`
**Answer:**

> “- Identity-based updates; fewer reloadData footguns - Animated diffs when IDs stable - Still need stable Hashable IDs — unstable hashes → flicker/reorder chaos.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Self-sizing jank causes? `(45–60s)`
**Answer:**

> “- Ambiguous Autolayout - Estimated size far from real - Image height changes after bind - Heavy main-thread work in bind Mitigations: better estimates, prefetch images, stable heights when product allows, avoid multi-pass thrash.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Prefetch budgets? `(45–60s)`
**Answer:**

> “See code/PrefetchBudget.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. SwiftUI in UIKit (`UIHostingController`)? `(45–60s)`
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

### Q11. UIKit in SwiftUI (Representable)? `(45–60s)`
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

### Q12. Dual navigation anti-pattern? `(45–60s)`
**Answer:**

> “text NavigationPath ←→ UINavigationController ↑ ↑ deeplink A deeplink B Both mutate → double present, lost back stack, analytics double-count. Pick one root owner; bridge at edges. Grizzlies lesson: design interop + deeplink ownership deliberately.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Deeplinks in hybrid apps? `(45–60s)`
**Answer:**

> “text URL → Parse at app edge → typed Intent → single Router → ensure root ready (cold start queue) → push/present UIKit host OR SwiftUI host → Airship/push taps use SAME router.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Decision? `(45–60s)`
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

### Q15. Delivery notes? `(45–60s)`
**Answer:**

> “- Reusable component integrated in high-traffic flows - API/content contracts with PM/Design/Backend - Detents + VoiceOver focus matter - Metric you may claim: 30%+ of user flows fewer full-screen navigations Why not a new tab? Tabs change IA; sheet fixes local friction in existing flows.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Analytics + push with lifecycle (S13)? `(45–60s)`
**Answer:**

> “- Screen events on appear/disappear — avoid double-count with hybrid hosts - Push notification taps → same deeplink router - Gate SDK init on privacy consent - Don’t fire “viewed” from viewDidLoad for tab VCs that aren’t visible.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Retain cycles — cells & closures? `(45–60s)`
**Answer:**

> “text VC → CollectionView → Cell → closure → VC Use [weak self]; clear handlers in prepareForReuse. Instruments Leaks (Day 03 recall). Crash-free hygiene includes leak discipline under scroll pressure.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q18. Representable `update` storms? `(45–60s)`
**Answer:**

> “Symptoms: updateUIViewController spam; jank; players restart. Causes: parent state churn; non-Equatable inputs; identity resets; heavy work inside update.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Trade-offs? `(45–60s)`
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

### Q20. Whiteboard scripts? `(45–60s)`
**Answer:**

> “A. Lifecycle + ads pause B. Deeplink → single router → UIKit vs SwiftUI host C. Sheet vs push with 30%+ metric Agenda: README opener.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q21. Failure modes? `(45–60s)`
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

### Q22. Decision rule card? `(45–60s)`
**Answer:**

> “text 1. One-time vs every-show → didLoad vs appear 2. Leave screen → pause/cancel 3. Cells: reset + cancel in prepareForReuse 4. Prefetch: warm + cancel + bound 5. Hybrid: one nav owner; stable representable identity 6. Sheet for shallow overview; claim 30%+ only from .”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q23. Optional citations? `(45–60s)`
**Answer:**

> “Apple UIViewController / UIViewControllerRepresentable docs; WWDC demystify identity; in-repo deeplink system design doc — appendix only.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q24. Appearance forwarding in custom containers? `(45–60s)`
**Answer:**

> “If you build a custom container VC that swaps children, you must forward appearance transitions (beginAppearanceTransition / endAppearanceTransition) or child viewWillAppear won’t run — analytics and pause/play break silently. UINavigationController and UITabBarController do this for you. Your clever container might not.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q25. Prefetch + image pipeline interaction? `(45–60s)`
**Answer:**

> “text prefetch(indexPaths) → repository.warm(ids) // decode budgets, lower priority cell configure → repository.image(id) // coalesce with in-flight prefetch cancelPrefetch → cancel warms not yet needed Without coalescing, prefetch and cell bind double-fetch the same URL. Repository single-flight per URL helps (Day 09 cousin idea).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q26. Bottom sheet engineering details? `(45–60s)`
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

### Q27. Mixpanel screen-name discipline? `(45–60s)`
**Answer:**

> “Hybrid risk: UIKit parent and SwiftUI child both fire screen_view. Pick one owner per visible surface. Representable updates must not re-fire viewed events.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q28. Extended decision card? `(45–60s)`
**Answer:**

> “text Lifecycle: load once vs appear many Media: visibility + disappear + background Cells: token + cancel + clear handlers Prefetch: warm + cancel + limit + Low Data Mode Hybrid: containment + sizing + one router Product UI: sheet vs push by depth; 30%+ only.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
