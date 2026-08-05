# Sample 03 — Pipeline shape and code demos (Q&A)

> Guided teaching. Walk the learning-lab files aloud — they are teaching shape, not shipped BMS source.

---

### Q1. What is the preferred ads pipeline shape?

**Points to:** [Deep dive · §2.1 Preferred shape](../02-deep-dive.md#21-preferred-shape) · [code · AdPipeline](../code/AdsPipeline.swift)

**Answer:**

> Keep the outer API **generic** so the compiler still sees a concrete creative type. Compose video-only behavior as an **extra capability** (`PlaybackControllable`) — do not force image creatives to pretend they play video. Avoid `as? VideoCreative` on the revenue path. New types plug in by conforming, not by casting.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Demo type? | `AdPipeline<C: Creative & AdTrackable>` in [`AdsPipeline.swift`](../code/AdsPipeline.swift). |
| What does `install()` do? | Track impression, then `makeBody()` — type-safe end to end. |
| Why not `Any` cast ladder? | Casts hide bugs until a new creative ships Friday night. |

---

### Q2. How do `where` clauses help with associated types?

**Points to:** [Deep dive · §2.2 where clauses](../02-deep-dive.md#22-where-clauses-for-associated-types) · [Foundations · §3.3 where](../01-foundations.md#33-where-clauses-first-pass)

**Answer:**

> `where` lets you say “only when the associated view is this kind” — for example `where C.View: UIImageView`. You keep specialization and avoid casting. Use typealiases for long `A & B & C` contracts so whiteboard signatures stay readable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Example typealias? | `TrackedCreative = AdRenderable & AdTrackable`. |
| Array helper idea? | `renderAll` only when every element’s associated `View` is the same `V`. |
| Interview signal? | You constrain associated types instead of force-casting. |

---

### Q3. How does HeroWidget mix POP with UIKit identity?

**Points to:** [Deep dive · §7 Mixing POP with UIKit](../02-deep-dive.md#7-mixing-pop-with-uikit-identity-herowidget)

**Answer:**

> HeroWidget needs three things: a real view lifecycle (class identity), pause/play when visibility changes, and clean contracts so the ads pipeline does not care about player internals. Make it a `UIView` (or similar) that adopts `PlaybackControllable`. POP gave the pipeline; the widget stays a class because lifecycle and player identity are reference concerns.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview line? | “POP for the pipeline; HeroWidget is still a class — pause/play tied to visibility.” |
| Why `: AnyObject` on playback? | Often weak ownership / class identity for the player surface. |
| Provenance? | Verified · S1 · HeroWidget pause/play lifecycle. |

---

### Q4. What should you explain when reading `AdsPipeline.swift`?

**Points to:** [Deep dive · §13 Code tour](../02-deep-dive.md#13-code-tour-do-before-questions) · [AdsPipeline.swift](../code/AdsPipeline.swift)

**Answer:**

> Point at each capability protocol (`AdTrackable`, `Creative`, `PlaybackControllable`). Show image vs video conformers. Explain why the pipeline is generic. Note that extension defaults on `trackClick` are for identical behavior — polymorphic overrides belong in requirements. Say aloud: this is Learning-lab teaching shape, not claimed BMS source.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why is `VideoCreative` a class? | Playback / identity — also adopts `PlaybackControllable`. |
| Why is `ImageCreative` a struct? | Value-friendly model with no player identity need. |
| `bindPlayback` idea? | Only types that are `Creative & PlaybackControllable` get pause/play. |

---

### Q5. What should you explain when reading `TypeErasureDemo.swift`?

**Points to:** [TypeErasureDemo.swift](../code/TypeErasureDemo.swift) · [Deep dive · §5](../02-deep-dive.md#5-type-erasure--full-mental-model)

**Answer:**

> `AnyTrackable` is one concrete type that stores an `id` and a `_track` closure. `Banner` and `Interstitial` both fit in `[AnyTrackable]`. Cost is heap/closure indirection and lost specialization. Prefer `func install<T: Trackable>(_ t: T)` inside the pipeline; erase only for mixed lists or boundaries. Same motive as Combine’s `AnyPublisher`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not claim this shipped at BMS? | Learning-lab — teaching mechanics. Prefer Applied/lab for erasure demos unless personally true. |
| What does `init<T: Trackable>` do? | Captures the concrete adopter’s behavior into the box. |
| When skip erasure? | When the hot path can stay generic end-to-end. |

---

### Q6. What trade-offs should you memorize for architecture choices?

**Points to:** [Deep dive · §8 Trade-off tables](../02-deep-dive.md#8-trade-off-tables-memorize-the-decisions)

**Answer:**

> POP + generics: many variants and revenue safety — cost is learning curve and associated-type friction. Inheritance tree: rare shared UIKit identity — cost is fragile base. Type erasure: mixed arrays / boundaries — cost is allocation. `any Protocol`: flexibility — existential overhead and associated-type limits. Closed enum: stable small set — app release for every new case.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| YAGNI vs BMS ads scale? | Two similar types forever — maybe don’t abstract yet. Highest-revenue growing creatives — abstraction pays (S1 justification). |
| Trap answer? | “Always POP everything.” |
| Senior answer? | Introduce POP when variants or test seams demand it. |

---

### Q7. What is a 5-minute whiteboard flow for Day 02?

**Points to:** [Deep dive · §11 Whiteboard flow](../02-deep-dive.md#11-common-interview-whiteboard-flow-5-min)

**Answer:**

> Agenda: revenue ads path — inheritance problems → POP contracts → generics pipeline → HeroWidget lifecycle → trade-offs. Problem: new creatives forking render code; video lifecycle bugs. Design: capability protocols + `Pipeline<C>`. Lifecycle: pause/play on visibility. Trade-off: generics inside; erasure only if mixed feed requires it. Honesty: no invented fill-rate %; maintainable type-safe pipeline is the claim.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 15s agenda opener? | “Highest-revenue Ads path — protocols, generics, and video lifecycle.” |
| Anti-pattern to avoid? | Diving into Generics Manifesto trivia instead of safety → pipeline → lifecycle → trade-off. |
| Next practice after code tour? | Production bridge sample, then timed questions. |

---

### Q8. Name five anti-patterns and their fixes

**Points to:** [Deep dive · §12 Anti-patterns checklist](../02-deep-dive.md#12-anti-patterns-checklist)

**Answer:**

> (1) `Any` + cast ladder → generic constraint or typed factory. (2) Deep `AdView` tree → capability protocols. (3) Erasing every generic → erase at boundary only. (4) Extension-only overrides → promote to requirements. (5) “Structs can’t do POP” → structs are first-class adopters. Bonus: forgetting UIKit subclass needs → class for view identity, POP for capabilities.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Claiming `any` is free? | Know existential + associated-type limits. |
| Claiming every creative was a struct? | Don’t invent — video/player identity often needs a class. |
| Done with code sample? | Move to Verified S1 / S10 language. |

---

Next: [04-production-s1.md](04-production-s1.md)
