# Sample 02 — Identity traps (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is SwiftUI view identity?

**Points to:** [Foundations · §4 Identity](../01-foundations.md#4-identity--the-senior-differentiator) · [Deep dive · §3 Identity mechanics](../02-deep-dive.md#3-identity-mechanics)

**Answer:**

> Identity is how SwiftUI decides “same view” vs “new view.” **Structural identity:** same type + position in hierarchy. **Explicit identity:** `.id("profile")` or `ForEach` with stable `Identifiable` ids. **`@State` lifetime follows identity** — change the id and state resets as if you cast a new actor.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Theater metaphor? | Recasting every night → actor forgets lines (`@State` amnesia). |
| Intentional reset? | Logout → `.id(userSessionID)` to clear forms — deliberate, not accidental. |
| Representable link? | Parent identity churn → `makeUIViewController` storms (Day 11). |

---

### Q2. What is the UUID-in-`body` bug?

**Points to:** [Foundations · §4 Classic bug](../01-foundations.md#4-identity--the-senior-differentiator) · [code/IdentityTraps.swift](../code/IdentityTraps.swift)

**Answer:**

> Writing `.id(UUID())` inside `body` creates a **new identity every render**. Effects: text fields clear while typing, timers restart, Stories page resets mid-swipe, representables remake. Never generate UUIDs per body pass. Use **stable model keys** unless you intentionally want a full reset.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symptom in search field? | Text clears on every keystroke — classic identity churn. |
| Stories SDK (S10)? | Page identity must survive progress ticks — stable ids on pages. |
| Fix? | Stable `Identifiable` from server or model — not random UUID(). |

---

### Q3. Structural vs explicit identity — when to use which?

**Points to:** [Deep dive · §3 Structural identity](../02-deep-dive.md#structural-identity) · [Explicit identity](../02-deep-dive.md#explicit-identity)

**Answer:**

> **Structural** works when view type and position stay stable in the tree. **Explicit** when you conditionally swap branches, drive `ForEach` from data, or need intentional reset. Swapping `Header` and `Content` order without ids may make SwiftUI treat views as different → state jumps. SDUI leaves should use **server-stable node ids** (Day 10), not array indices.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CMS inserts banner above? | Index-based ids break — use stable server node id. |
| ForEach `id: \.self` trap? | Bad when value equality changes often — unstable list behavior. |
| Conditional branches? | Consider explicit `.id` when swapping substantially different subtrees. |

---

### Q4. How does identity affect `@State` and animations?

**Points to:** [Deep dive · §6 Animation & transitions](../02-deep-dive.md#6-animation--transitions) · [Foundations · §4 @State lifetime](../01-foundations.md#4-identity--the-senior-differentiator)

**Answer:**

> Identity-preserving updates animate smoothly. Destroy/recreate via identity change feels like jump cuts. Drive Stories progress from a **model timeline**, not scattered `onAppear` timers in each page view. Use explicit `withAnimation` / transactions for intentional motion — not `.animation` on the entire universe.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Progress bar desync? | Timers in views + id reset — move timeline to player model. |
| List jump on update? | Unstable ForEach ids — fix identity before blaming LazyVStack. |
| Logout form reset? | Intentional `.id(session)` — document why. |

---

### Q5. How does identity connect to UIKit representables?

**Points to:** [Deep dive · §3 Representable link](../02-deep-dive.md#representable-link-day-11) · [Day 11 · update storms](../02-deep-dive.md#13-failure-modes)

**Answer:**

> Parent `.id` churn forces representables through `make` again — players restart, delegates rewire, jank. Stabilize parent identity; use `update` to push prop changes. Same UUID-in-body bug hurts UIHostingController hosts and UIViewControllerRepresentable wrappers alike.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hybrid Grizzlies (S13)? | Identity + lifecycle designed together — not bolted hosting. |
| Fix priority? | Reduce observed state at parent; stable ids; Equatable inputs if measured. |
| SDK public API? | Should not force host to churn identity every progress tick. |

---

### Q6. What identity failures show up in production SDKs?

**Points to:** [Deep dive · §13 Failure modes](../02-deep-dive.md#13-failure-modes) · [Foundations · §5 Stories SDK implication](../01-foundations.md#4-identity--the-senior-differentiator)

**Answer:**

> Text clears while typing (identity churn). Progress desync (timers in views / id reset). List jump (unstable ForEach ids). Whole screen redraws (separate issue — god observable). Representable remake (parent id churn). Background audio (scene-phase pause missing — lifecycle cousin to S1). Stories pages need **stable page IDs** across progress updates.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S10 lesson? | Stable identity/state for pages/progress is SDK quality. |
| Testing identity bugs? | Reproduce with fast state updates + typing in field. |
| WWDC topic? | Demystify SwiftUI identity — optional citation at deep dive end. |

---

### Q7. What is the identity decision card?

**Points to:** [Deep dive · §14 Decision rule card](../02-deep-dive.md#14-decision-rule-card)

**Answer:**

> IDs stable unless intentional reset. Never `.id(UUID())` in body. ForEach uses stable `Identifiable` model keys. Logout/session change may force reset deliberately. Representables: stabilize parent; update props. SDUI: server node ids. Stories: page identity survives progress ticks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Intentional vs accidental reset? | Session logout vs UUID() every render — only former is OK. |
| `@State` rule? | Lifetime follows identity — say this in every senior SwiftUI answer. |
| Next topic? | Lists and performance — [03-lists-performance.md](03-lists-performance.md). |

---

Next: [03-lists-performance.md](03-lists-performance.md)
