# Sample 07 — Revision Q&A (day-12) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

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
| Probe deeper? | Changing .id or ForEach keys resets @State — minting UUID in body rebuilds the view every render and drops progress. |

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

### Q5. Make a long list smooth? `(60–90s)`
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


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “@State vs @Observable — when each?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I use @State for view-local ephemeral UI like chrome toggles. For feature-level async and state shared across children I use an @Observable model on iOS 17+, with @Bindable when controls write into that model. On older deployment targets I’d use ObservableObject and @Published. Stories player timeline belongs in the model; local overlay chrome can stay @State.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | @State vs @Observable — when each |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “What is view identity” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “View identity is how SwiftUI decides two renders are the same view. Structural identity comes from type and position; explicit identity uses .id or ForEach identifiers. @State storage follows identity — change the id and state resets. That’s why stable Stories page IDs matter and why UUID-in-body is catastrophic.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is view identity |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “Why did my Representable reset”. How do you diagnose? `(60–90s)`
**Answer:**

> “Usually the parent’s identity changed or an .id churned, so SwiftUI remade the representable instead of calling update. Stabilize identifiers and push prop changes through updateUIViewController. Recreate only when you truly need a fresh controller — hybrid apps feel this cost immediately.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Why did my Representable reset |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “ForEach best practices”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “ForEach needs stable Identifiable keys from your models. Don’t use indices when rows reorder, and never mint UUID ids inside body. Duplicate IDs cause undefined weirdness. Stories pages should carry host/server ids that survive progress updates.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | ForEach best practices |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “Make a long list smooth.”? `(60–90s)`
**Answer:**

> “Use List or LazyVStack, keep Identifiable IDs stable, make row body cheap with precomputed formatting, load images asynchronously with size budgets, paginate when needed, and don’t observe a giant catalog from every row. If it’s still janky, profile decode and main-thread work — Lazy alone isn’t a silver bullet.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Make a long list smooth. |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “How do you design Stories SDK API” and how you’d correct it? `(60–90s)`
**Answer:**

> “I’d expose a StoriesPlayer entry point, a data source protocol so hosts supply story groups, event callbacks for open/close/CTA, and injectable image/video loaders so networking stays host-owned where needed. The module is versioned and theming-hooked. That’s how we kept a reusable Stories SDK isolatable across portfolio apps instead of hardcoding one app’s networking.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you design Stories SDK API |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Pause stories on background/disappear?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “On disappear and background scene phase I pause the player model — timers and AVPlayer — with an explicit resume policy when returning. Views shouldn’t keep rogue timers alive. It’s the same lifecycle discipline as Ads HeroWidget pause/play: media without visibility policy wastes resources and surprises users.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Pause stories on background/disappear |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “Environment for DI — good idea” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Environment is great for theme and layout direction. It’s a poor service locator for NetworkClient everywhere — hidden dependencies hurt tests and SDK hosts. Stories SDK should take injectable loaders through init so hosts see the graph. That matches Day 08’s constructor DI default.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Environment for DI — good idea |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
