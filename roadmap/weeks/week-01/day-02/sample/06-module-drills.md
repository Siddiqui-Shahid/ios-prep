# Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)

> Pulled from `01-foundations`, `02-deep-dive`, `03-production-bridge`, `05-exercises`, and the day README — anything easy to miss if you only read samples 01–05.  
> Say answers like a conversation. Then do the real coding drills in [`../05-exercises.md`](../05-exercises.md).

---

### Q1. Walk the mini ads pipeline aloud (exercise 1)

**Answer:**

> “Capabilities first — Creative with associated Body, plus AdTrackable. ImageCreative is a struct; VideoCreative is a class that also adopts PlaybackControllable. AdPipeline of C constrained to Creative and AdTrackable installs type-safe — track then makeBody. bindPlayback only for Creative and PlaybackControllable. Stretch: CarouselCreative plugs in by conformance without touching pipeline body.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why VideoCreative is a class? | “Playback identity — player and lifecycle need a reference type.” |
| Agenda before coding? | “Capabilities first, then generic pipeline, then video-only composition.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab — not shipped BMS source.
- **Shipped if asked:** BookMyShow Ads pipeline + HeroWidget lifecycle (shape, not this file).

---

### Q2. Type eraser drill — speak costs in ≤30s (exercise 2)

**Answer:**

> “AnyTrackable stores id and a _track closure. Banner and Interstitial both land in one array. Costs: heap allocation, indirection, lost specialization, narrower API. Prefer generic install inside; erase at mixed list or boundary. Honesty: learning-lab, not shipped BMS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Same as Combine? | “AnyPublisher — same motive for nested generics.” |
| Upcast? | “Renderers often collapse associated views to UIView.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q3. Extension dispatch surprise — predict then fix (exercise 3)

**Answer:**

> “I write Greeter with wave only in an extension, Person defines its own wave, call through any Greeter — I predict default, not person. Fix: promote wave to a protocol requirement so witness-table dispatch hits Person. Speak: requirements witness-dispatch; extension-only methods may bind statically.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ads angle? | “Custom track per creative must be a requirement; identical default click log can stay extension-only.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. HeroWidget lifecycle sketch (exercise 4)

**Answer:**

> “HeroWidget owns a video creative or player façade. didEnterVisibleViewport plays; didLeave pauses. Conform to PlaybackControllable. Ninety-second Action slice ties widget to the typed ads pipeline. Honesty: no fill-rate percent — lifecycle-correct video is the claim.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Class vs protocol? | “Class for identity; protocol for pause/play capability.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. Open vs closed registry (exercise 5)

**Answer:**

> “Sketch enum AdKind image/video with switch renderer — simple, exhaustive, release for every new case. Sketch AdRegistry with AdComponentFactory and unknown fallback placeholder — open, CMS-friendly. Ninety seconds: trade-offs; soft mention backend-driven header; unknown fallback as design when Applied.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI parallel? | “ComponentRegistry — same open-factory instinct.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow backend-driven header & search
- **Design if asked:** Unknown-component fallback — label design.

---

### Q6. Stories SDK boundary bullets (exercise 7)

**Answer:**

> “Five rules: expose protocols not a forest of concretes; carefully chosen value models; version breaking requirements with defaults or a v2 protocol; don’t leak internal player types; document unknown/fallback policy for host apps. Twenty-second soft bridge after writing — portfolio reuse, no invented client counts. Don’t let Stories steal the Ads answer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When to mention? | “Reusable module API questions — not ads-specific.” |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented client counts or latency %.

---

### Q7. Flash recall — fire front → back like cards

**Answer:**

> “POP — capabilities over inheritance; trap is never use classes; prod is Ads pipeline contracts.
>
> Generic parameter — caller picks T; trap is confusing with associated type; prod is typed installer.
>
> Associated type — adopter picks; trap is plain mixed array; stay generic or erase.
>
> some vs any — opaque concrete vs existential box; trap is any is free; Self and associated types block.
>
> Primary associated types — pin part of shape; trap is they fix every mixed array; still need a plan.
>
> Witness vs static vs @objc — requirements via existential vs extension-only vs message send.
>
> Type erasure — one concrete box; trap is free; costs allocation and lost specialization.
>
> YAGNI vs revenue — don’t abstract two forever-types; Ads scale justified POP.
>
> HeroWidget — class identity plus playback protocol; trap is POP forbids classes.
>
> Open registry — CMS growth plus unknown fallback; closed enum for tiny stable sets.
>
> rethrows — throws only if closure throws; pipeline mapper ergonomics.
>
> Conditional conformance — type adopts when params allow; vs function where at one call site.
>
> Stories soft bridge — contracts at boundary; don’t steal Ads credit.
>
> Honesty — no invented fill-rate %.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Drill how? | “Cover the name, speak the back, uncover, score yourself.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Day close-out — can you check these off?

**Answer:**

> “Without notes: I can explain POP versus inheritance with an ads example. I contrast associated type versus generic parameter in twenty seconds. I name four erasure costs. I demo the extension-default trap. I deliver Ads plus HeroWidget Action under three minutes without inventing fill-rate. I soft-bridge Stories without replacing Ads. I walk AdsPipeline and TypeErasureDemo as lab. I ran a timed set from 04-questions including T1 through T5. If any box is open, that’s my next drill — not more reading.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where to practice code? | [../05-exercises.md](../05-exercises.md) exercises 1–5 |
| Where to time speak? | [../04-questions.md](../04-questions.md) T1–T10 |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse after every Day 02 study block.

---

### Q9. What should you be able to do by end of Day 02? (README outcomes)

**Answer:**

> “Explain protocol-oriented design versus inheritance for UI and ad pipelines. Use generics, associated types, and where clauses and say when each belongs. Contrast some versus any, and when associated types force generics or type erasure. Explain type erasure and its cost. Deliver a five-minute architecture talk on BookMyShow Ads and HeroWidget without inventing fill-rate metrics. Soft-bridge to Stories SDK for reusable protocol APIs at a boundary.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timed drill? | “Q1, Q4, Q6, T1, T5 on a timer; then five-minute Ads whiteboard.” |

**How can I relate to my case:**
- **Shipped / design / lab** as labeled in provenance — never blur them.

---

### Q10. Static / witness / @objc triad in one breath

**Answer:**

> “Concrete, final, or specialized generics can static-dispatch. Protocol requirements called through an existential go through a witness table. @objc uses Objective-C message send. Extension-only methods that aren’t requirements may bind to the static type — that’s why any Greeter can miss Person.wave.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fix polymorphic wave? | “Make it a protocol requirement.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Conditional conformance vs function where

You need Pair to be Equatable only when both sides are — and also a one-off helper that only runs when View is UIImageView.

**Ask:** Which tool for which?

**Answer:** Conditional conformance (`extension Pair: Equatable where …`) makes the *type* adopt Equatable. Function `where C.View: UIImageView` constrains one call site. Don’t confuse them.

---

### Puzzle B — Protocol inheritance hierarchy

```swift
protocol VideoAdRenderable: AdRenderable, PlaybackControllable {
    var duration: TimeInterval { get }
}
```

**Ask:** Is this a class hierarchy?

**Answer:** No — you refined capabilities in the protocol graph without inventing AdView subclasses. Image ads never inherit video APIs.

---

### Puzzle C — rethrows ceremony

Every pipeline helper is marked `rethrows` even when no closure can throw.

**Ask:** What’s wrong?

**Answer:** Noise. Use `rethrows` when the higher-order function throws only if the passed transform throws. Don’t sprinkle it as ceremony.
