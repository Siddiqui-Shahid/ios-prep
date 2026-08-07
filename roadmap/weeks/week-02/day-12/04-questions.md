# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. @State vs @Observable — when each? `(30–45s)`

**Answer:**

> I use @State for view-local ephemeral UI like chrome toggles. For feature-level async and state shared across children I use an @Observable model on iOS 17+, with @Bindable when controls write into that model. On older deployment targets I’d use ObservableObject and @Published. Stories player timeline belongs in the model; local overlay chrome can stay @State.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Stories progress timers live in the @Observable player model; a local mute toggle can stay @State on the chrome view. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What is view identity? `(45–60s)`

**Answer:**

> View identity is how SwiftUI decides two renders are the same view. Structural identity comes from type and position; explicit identity uses .id or ForEach identifiers. @State storage follows identity — change the id and state resets. That’s why stable Stories page IDs matter and why UUID-in-body is catastrophic.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Changing .id or ForEach keys resets @State — minting UUID() in body rebuilds the view every render and drops progress. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. Why did my Representable reset? `(45s)`

**Answer:**

> Usually the parent’s identity changed or an .id churned, so SwiftUI remade the representable instead of calling update. Stabilize identifiers and push prop changes through updateUIViewController. Recreate only when you truly need a fresh controller — hybrid apps feel this cost immediately.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | If the parent’s identity churns, SwiftUI remakes the Representable instead of calling update — stabilize IDs and push props through update. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. ForEach best practices? `(45s)`

**Answer:**

> ForEach needs stable Identifiable keys from your models. Don’t use indices when rows reorder, and never mint UUID ids inside body. Duplicate IDs cause undefined weirdness. Stories pages should carry host/server ids that survive progress updates.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Stories pages carry host/server IDs that survive progress ticks; index-based ForEach breaks when pages reorder. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. Make a long list smooth. `(60–90s)`

**Answer:**

> Use List or LazyVStack, keep Identifiable IDs stable, make row body cheap with precomputed formatting, load images asynchronously with size budgets, paginate when needed, and don’t observe a giant catalog from every row. If it’s still janky, profile decode and main-thread work — Lazy alone isn’t a silver bullet.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | LazyVStack alone won’t save you if every row observes a giant catalog — pass slices and precompute formatting in the model. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. How do you design Stories SDK API? `(60–90s)`

**Answer:**

> I’d expose a StoriesPlayer entry point, a data source protocol so hosts supply story groups, event callbacks for open/close/CTA, and injectable image/video loaders so networking stays host-owned where needed. The module is versioned and theming-hooked. That’s how we kept a reusable Stories SDK isolatable across portfolio apps instead of hardcoding one app’s networking.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Expose StoriesPlayer plus a host data-source protocol and injectable loaders so networking stays host-owned across portfolio apps. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Pause stories on background/disappear? `(45s)`

**Answer:**

> On disappear and background scene phase I pause the player model — timers and AVPlayer — with an explicit resume policy when returning. Views shouldn’t keep rogue timers alive. It’s the same lifecycle discipline as Ads HeroWidget pause/play: media without visibility policy wastes resources and surprises users.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | On disappear and background scene phase, pause timers and AVPlayer in the player model — views must not keep rogue timers. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. Environment for DI — good idea? `(45s)`

**Answer:**

> Environment is great for theme and layout direction. It’s a poor service locator for NetworkClient everywhere — hidden dependencies hurt tests and SDK hosts. Stories SDK should take injectable loaders through init so hosts see the graph. That matches Day 08’s constructor DI default.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Theme via Environment is fine; NetworkClient-only-in-Environment hides the graph from SDK hosts and makes tests brittle. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q9. Animation causes list jump — causes? `(45–60s)`

**Answer:**

> List jumps usually come from identity changes, row height changes without a careful transaction, or scroll position loss when IDs reshuffle. Fix stable Identifiable keys, animate data changes carefully, and avoid applying animation modifiers to entire giant trees.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | List jumps usually mean IDs reshuffled or row heights changed under a broad animation — fix Identifiable keys before tweaking spring curves. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. body called often — is that a problem? `(45s)`

**Answer:**

> body being called often is normal — SwiftUI diffs descriptions. It becomes a problem when body does heavy formatting, sorting, or side effects like networking. Keep body cheap and pure-ish; precompute in the model. Fetching in body is an interview classic fail.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | body being called often is normal; networking or sorting 10k rows inside body is the failure mode — move side effects to .task/model. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. Cross-app reuse challenges for Stories? `(45–60s)`

**Answer:**

> Portfolio reuse hits theming, analytics, media formats, how CTAs exit into host navigation, and dependency versions. You solve it with protocols, sensible defaults, and a versioned module — not by forking the SDK per team. That’s the modularity lesson behind the Stories SDK adoption across apps.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Cross-app Stories reuse needs theming hooks, CTA exit protocols, and a versioned module — not a fork per team. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q12. SwiftUI + SDUI registry? `(45–60s)`

**Answer:**

> An SDUI registry can return SwiftUI views keyed by type while the ViewModel owns payload lifecycle. Keep leaf views dumb. Give each node a server-stable id so ForEach identity doesn’t break when CMS inserts content — same identity rules as Stories pages.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | SDUI registry leaves return SwiftUI views keyed by type with server-stable node IDs so ForEach identity survives CMS inserts. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

## Tricky questions

