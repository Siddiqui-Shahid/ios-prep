# Sample 02 — Identity traps (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is SwiftUI view identity?
**Answer:**

> Identity is how SwiftUI decides “same view” vs “new view.” **Structural identity:** same type + position in hierarchy. **Explicit identity:** `.id("profile")` or `ForEach` with stable `Identifiable` ids. **`@State` lifetime follows identity** — change the id and state resets as if you cast a new actor.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Theater metaphor? | Recasting every night → actor forgets lines (`@State` amnesia). |
| Intentional reset? | Logout → `.id(userSessionID)` to clear forms — deliberate, not accidental. |
| Representable link? | Parent identity churn → `makeUIViewController` storms (Day 11). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is the UUID-in-`body` bug?
**Answer:**

> Writing `.id(UUID)` inside `body` creates a **new identity every render**. Effects: text fields clear while typing, timers restart, Stories page resets mid-swipe, representables remake. Never generate UUIDs per body pass. Use **stable model keys** unless you intentionally want a full reset.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom in search field? | Text clears on every keystroke — classic identity churn. |
| Stories SDK (Stories SDK (Raw / Miami Heat))? | Page identity must survive progress ticks — stable ids on pages. |
| Fix? | Stable `Identifiable` from server or model — not random UUID. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. Structural vs explicit identity — when to use which?
**Answer:**

> **Structural** works when view type and position stay stable in the tree. **Explicit** when you conditionally swap branches, drive `ForEach` from data, or need intentional reset. Swapping `Header` and `Content` order without ids may make SwiftUI treat views as different → state jumps. SDUI leaves should use **server-stable node ids** (Day 10), not array indices.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CMS inserts banner above? | Index-based ids break — use stable server node id. |
| ForEach `id: \.self` trap? | Bad when value equality changes often — unstable list behavior. |
| Conditional branches? | Consider explicit `.id` when swapping substantially different subtrees. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How does identity affect `@State` and animations?
**Answer:**

> Identity-preserving updates animate smoothly. Destroy/recreate via identity change feels like jump cuts. Drive Stories progress from a **model timeline**, not scattered `onAppear` timers in each page view. Use explicit `withAnimation` / transactions for intentional motion — not `.animation` on the entire universe.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Progress bar desync? | Timers in views + id reset — move timeline to player model. |
| List jump on update? | Unstable ForEach ids — fix identity before blaming LazyVStack. |
| Logout form reset? | Intentional `.id(session)` — document why. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How does identity connect to UIKit representables?
**Answer:**

> Parent `.id` churn forces representables through `make` again — players restart, delegates rewire, jank. Stabilize parent identity; use `update` to push prop changes. Same UUID-in-body bug hurts UIHostingController hosts and UIViewControllerRepresentable wrappers alike.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hybrid Grizzlies (Hybrid UI / deeplinks)? | Identity + lifecycle designed together — not bolted hosting. |
| Fix priority? | Reduce observed state at parent; stable ids; Equatable inputs if measured. |
| SDK public API? | Should not force host to churn identity every progress tick. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What identity failures show up in production SDKs?
**Answer:**

> Text clears while typing (identity churn). Progress desync (timers in views / id reset). List jump (unstable ForEach ids). Whole screen redraws (separate issue — god observable). Representable remake (parent id churn). Background audio (scene-phase pause missing — lifecycle cousin to BookMyShow Ads pipeline + HeroWidget lifecycle). Stories pages need **stable page IDs** across progress updates.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Stories SDK (Raw / Miami Heat) lesson? | Stable identity/state for pages/progress is SDK quality. |
| Testing identity bugs? | Reproduce with fast state updates + typing in field. |
| WWDC topic? | Demystify SwiftUI identity — optional citation at deep dive end. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. What is the identity decision card?
**Answer:**

> IDs stable unless intentional reset. Never `.id(UUID)` in body. ForEach uses stable `Identifiable` model keys. Logout/session change may force reset deliberately. Representables: stabilize parent; update props. SDUI: server node ids. Stories: page identity survives progress ticks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Intentional vs accidental reset? | Session logout vs UUID every render — only former is OK. |
| `@State` rule? | Lifetime follows identity — say this in every senior SwiftUI answer. |
| Next topic? | Lists and performance — [03-lists-performance.md](03-lists-performance.md). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Animation causes a list jump — what are the causes?
**Answer:**

> List jumps usually come from **identity changes**, **row height changes** without a careful transaction, or **scroll position loss** when IDs reshuffle. Fix stable `Identifiable` keys, animate data changes carefully, and avoid applying animation modifiers to entire giant trees. Images loading without reserved height also bounce layout. Stories progress must not change page identity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| `.animation` on root? | Scope it — local transactions. |
| Images loading? | Reserve height / placeholders. |
| Stories progress? | Progress shouldn’t change page id. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-lists-performance.md](03-lists-performance.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the UUID-in-`body` bug

**Ask yourself:** What is the UUID-in-`body` bug?

**Answer:** “Writing `.id(UUID)` inside `body` creates a **new identity every render**. Effects: text fields clear while typing, timers restart, Stories page resets mid-swipe, representables remake. Never generate UUIDs per body pass. Use **stable model keys** unless you intentionally want a full reset.”

### Puzzle B — Structural vs explicit identity — when to use which

**Ask yourself:** Structural vs explicit identity — when to use which?

**Answer:** “**Structural** works when view type and position stay stable in the tree. **Explicit** when you conditionally swap branches, drive `ForEach` from data, or need intentional reset. Swapping `Header` and `Content` order without ids may make SwiftUI treat views as different → state jumps. SDUI leaves should use **server-stable node ids** (Day 10), not array indices.”

### Puzzle C — How does identity affect `@State` and animations

**Ask yourself:** How does identity affect `@State` and animations?

**Answer:** “Identity-preserving updates animate smoothly. Destroy/recreate via identity change feels like jump cuts. Drive Stories progress from a **model timeline**, not scattered `onAppear` timers in each page view. Use explicit `withAnimation` / transactions for intentional motion — not `.animation` on the entire universe.”
