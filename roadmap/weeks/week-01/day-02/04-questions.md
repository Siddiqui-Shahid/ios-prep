# 04 — Questions (two-layer Q&A)

> **How to practice:** Cover **Full spoken answer**. Speak from **Answer points** only. Uncover and compare.  
> Timing: Normal ≈ 30–60s · Tricky ≈ 90–120s.  
> Every question uses the same shape.

---

## Normal questions

### Q1. What is protocol-oriented programming? `(30–45s)`

**Answer points (frame first):**
- Design by composing capabilities (protocols + extensions)
- Prefer over deep class inheritance for variants
- Structs and classes can both conform
- Ads pipeline hook: render / track / playback as capabilities

**Agenda opener:**  
> “Compose capabilities with protocols — prefer that over deep inheritance.”

**Full spoken answer:**  
> “Protocol-oriented programming means designing around capabilities — protocols and extensions — instead of growing a deep inheritance tree. Types opt into what they can do: renderable, trackable, playback-controllable. Structs and classes can both conform, so models stay value-friendly while UIKit views stay classes. On the BookMyShow Ads refactor we used protocol contracts so new creatives plugged into one pipeline instead of forking an AdView subclass hierarchy.”

**Common wrong answer:**  
> “POP means never use classes or inheritance.” (UIKit + HeroWidget still need class identity.)

**Follow-up ladder:**
- **L1:** How is composition different from multiple inheritance?
- **L2:** When is a class hierarchy still justified?
- **L3:** How do you unit-test a protocol-based pipeline?

**Provenance:** Verified · S1 · BookMyShow · Ads POP pipeline

---

### Q2. associatedtype vs generic parameter? `(45–60s)`

**Answer points (frame first):**
- Generic parameter: caller chooses
- associatedtype: conforming type chooses
- PATs complicate simple existentials / arrays
- Pipeline stays generic to avoid that pain

**Agenda opener:**  
> “Associated type is chosen by the conformer; generic param by the caller.”

**Full spoken answer:**  
> “A generic parameter is filled in by the caller — `Renderer<ImageCreative>`. An associated type is filled in by the type that conforms to the protocol — `ImageAd` decides what its `ContentView` is. That’s powerful for flexible contracts, but protocols with associated types are awkward as plain existentials, so you often keep APIs generic — `install<R: AdRenderable>` — or erase at a boundary if you need a heterogeneous list.”

**Common wrong answer:**  
> “They’re the same thing” or “just write `var x: [AdRenderable]` with associated types and move on.”

**Follow-up ladder:**
- **L1:** Can you put a PAT in an array?
- **L2:** What are primary associated types helping with?
- **L3:** Show `where` constraining an associated type.

**Provenance:** Learning-lab · PAT mental model; Verified · S1 pipeline shape

---

### Q3. `some` vs `any`? `(45s)`

**Answer points (frame first):**
- `some` = opaque — one concrete hidden type
- `any` = existential — may hold different conformers
- Performance: opaque/generics specialize better
- Use `any` when you need heterogeneity

**Agenda opener:**  
> “Opaque concrete versus existential box.”

**Full spoken answer:**  
> “`some Protocol` means one concrete type that conforms, but the caller can’t name it — like SwiftUI’s `some View`. `any Protocol` is an existential box that can hold different conforming types, with more dynamic dispatch and limits around Self and associated types. I use opaque or generics when the concrete type is stable and I care about specialization; I use `any` or type erasure when I truly need heterogeneous storage.”

**Common wrong answer:**  
> “They’re synonyms” or “`any` is always better because it’s flexible.”

**Follow-up ladder:**
- **L1:** Why does SwiftUI return `some View`?
- **L2:** What’s the performance intuition?
- **L3:** When does `any` refuse an associated-type operation?

**Provenance:** Learning-lab · language mechanics

---

### Q4. Why generics in an ads pipeline? `(45s)`

**Answer points (frame first):**
- Compile-time type safety
- Avoid `Any` cast ladders on revenue path
- New creatives conform and plug in
- Specialization in hot bind paths

**Agenda opener:**  
> “Type safety on the revenue path — no cast ladders.”

**Full spoken answer:**  
> “Generics let the ads pipeline stay type-safe as creatives grow. Instead of `Any` and downcasting in bind code — which breaks when a new creative ships — each creative conforms to protocol contracts and flows through a generic installer. That kept the highest-revenue module maintainable: new types plug in without forking the revenue path, and the compiler catches mismatches.”

**Common wrong answer:**  
> “Generics make everything faster automatically” (semantics/safety first; measure perf).

**Follow-up ladder:**
- **L1:** What did HeroWidget add on top?
- **L2:** Would you expose the generic pipeline across modules?
- **L3:** When would you introduce type erasure?

**Provenance:** Verified · S1 · BookMyShow · type-safe ads pipeline

---

### Q5. Protocol extension default methods — dispatch catch? `(60s)`

**Answer points (frame first):**
- Requirements dispatch via witness table
- Extension-only methods bind to static/existential type
- Customization that must override → declare as requirement
- Shared identical defaults can live in extensions

**Agenda opener:**  
> “Defaults are handy — until you expect polymorphic override.”

**Full spoken answer:**  
> “If a method is a protocol requirement, calling it through an existential uses the conformer’s implementation via the witness table. If it’s only defined in a protocol extension and not a requirement, the call can bind to the extension default based on the static type — even if the concrete type defines the same method name. So for behavior that must customize polymorphically, declare it as a requirement. Use extension defaults for truly shared behavior.”

**Common wrong answer:**  
> “Everything in a protocol extension is dynamically dispatched like Java default interfaces.”

**Follow-up ladder:**
- **L1:** Show a minimal surprise example.
- **L2:** How do you force dynamic dispatch?
- **L3:** Implications for a shared `track()` helper?

**Provenance:** Learning-lab · dispatch trap

---

### Q6. What is type erasure? `(45–60s)`

**Answer points (frame first):**
- Wrap disparate conformers in one concrete box
- Needed when PATs block easy existentials / heterogeneous arrays
- AnyPublisher / AnySequence same idea
- Cost: allocation, indirection, lost specialization

**Agenda opener:**  
> “Box a PAT into one type — pay for the convenience.”

**Full spoken answer:**  
> “Type erasure means wrapping types that conform to a protocol — especially one with associated types — in a single concrete type that forwards calls, so you can store them in arrays or return one type from APIs. Combine’s `AnyPublisher` is the standard example. The cost is extra allocation and indirection, and you lose generic specialization. I keep generics inside the hot ads pipeline and erase only at boundaries that need heterogeneity.”

**Common wrong answer:**  
> “Type erasure is free abstraction” or “always erase for clean APIs.”

**Follow-up ladder:**
- **L1:** Sketch `AnyTrackable` in 30s.
- **L2:** What do you collapse associated views to?
- **L3:** Erasure vs constrained `any` today?

**Provenance:** Learning-lab · `TypeErasureDemo.swift`; pattern applies to S1 boundaries

---

### Q7. Protocol composition (`A & B`)? `(30s)`

**Answer points (frame first):**
- Require multiple capabilities at once
- Not multiple inheritance of stored state
- `Renderable & Trackable` ads example
- Typealias for readability

**Agenda opener:**  
> “And-together capabilities — one type must satisfy both.”

**Full spoken answer:**  
> “Protocol composition means a type must satisfy multiple protocols — `AdRenderable & AdTrackable`. It’s capability intersection, not C++-style multiple inheritance of implementations and stored properties. For hero video ads I’d compose render, track, and playback protocols; image tiles might only need render and track.”

**Common wrong answer:**  
> “Swift supports multiple inheritance via protocol composition.”

**Follow-up ladder:**
- **L1:** Composition vs protocol inheritance?
- **L2:** How does this interact with generics?
- **L3:** Class-bound + composition for delegates?

**Provenance:** Verified · S1 · capability composition on ads

---

### Q8. When is inheritance still OK? `(45s)`

**Answer points (frame first):**
- UIKit / AppKit required subclasses
- Shared identity / ObjC runtime
- Mix: class for view, protocols for capabilities
- HeroWidget as lifecycle class

**Agenda opener:**  
> “Inheritance where the platform demands identity — POP for capabilities.”

**Full spoken answer:**  
> “I still use inheritance when UIKit requires a subclass — views, cells, view controllers — or when I need reference identity and Objective-C interop. The senior move is to subclass for the platform object and attach capabilities via protocols. HeroWidget is a class because player lifecycle and visibility hooks are identity concerns, while the ads pipeline around it stays protocol- and generic-oriented.”

**Common wrong answer:**  
> “POP means rewrite UIKit without subclasses.”

**Follow-up ladder:**
- **L1:** Can a UIView subclass conform to your ad protocols?
- **L2:** Fragile base class symptoms?
- **L3:** Testing UIKit subclasses vs protocol fakes?

**Provenance:** Verified · S1 · HeroWidget lifecycle class

---

### Q9. Conditional conformance? `(45s)`

**Answer points (frame first):**
- Type conforms only when constraints hold
- `Array: Equatable where Element: Equatable`
- Keeps generics honest in model layers
- Useful for wrapper types in pipelines

**Agenda opener:**  
> “Conform only when the pieces allow it.”

**Full spoken answer:**  
> “Conditional conformance means a generic type adopts a protocol only when its parameters meet constraints — Array is Equatable when its Element is. That keeps model layers honest: a Pair of Equatables can be Equatable without forcing Pair to always be Equatable. In pipelines I use the same idea for wrappers that should only be Hashable or Codable when their creative payload is.”

**Common wrong answer:**  
> “Conditional conformance is automatic for every generic.”

**Follow-up ladder:**
- **L1:** Write `Pair` Equatable where clause.
- **L2:** Codable conditional pitfalls?
- **L3:** Difference from `where` on a function?

**Provenance:** Learning-lab · model-layer Swift

---

### Q10. Generics for repository / boundary interfaces? `(45s)`

**Answer points (frame first):**
- Associated Model or generic methods at boundaries
- Keeps domain types explicit
- Prefer protocols at SDK edges
- Stories SDK soft bridge

**Agenda opener:**  
> “Boundaries expose contracts; concretes stay inside.”

**Full spoken answer:**  
> “At module boundaries I like protocol interfaces with an associated model or generic methods so call sites stay typed — `Repository` returning a concrete domain model rather than `[String: Any]`. Inside, implementations can vary. That same instinct showed up on a Stories SDK reused across apps: stable protocol-oriented surfaces rather than leaking concretes.”

**Common wrong answer:**  
> “Always expose concrete view models across packages.”

**Follow-up ladder:**
- **L1:** associatedtype Model vs generic method?
- **L2:** How do you mock in tests?
- **L3:** Versioning broken contracts?

**Provenance:** Verified · S10 soft bridge; Clean/MVVM instinct · S9 optional if asked District

---

### Q11. `protocol P: AnyObject` vs struct-friendly protocols? `(45s)`

**Answer points (frame first):**
- AnyObject = class-bound
- Enables `weak` delegates
- Structs cannot conform to class-bound protocols
- Choose based on identity / weak needs

**Agenda opener:**  
> “Class-bound when you need weak identity — otherwise keep it value-friendly.”

**Full spoken answer:**  
> “Marking a protocol `AnyObject` restricts conformance to classes, which lets you hold `weak` references — classic delegates. Struct-friendly protocols omit that bound so value types can conform. For ads tracking on value creatives I keep protocols struct-friendly; for HeroWidget playback delegates or UIKit-style delegates I use class-bound protocols.”

**Common wrong answer:**  
> “All protocols should be AnyObject because UIKit.”

**Follow-up ladder:**
- **L1:** Why can’t weak point at a struct?
- **L2:** Closure callbacks vs weak delegates?
- **L3:** Actor-bound protocols awareness?

**Provenance:** Learning-lab · weak delegate rules; S1 HeroWidget class-bound playback

---

## Tricky questions

### T1. Why can’t you freely write `var x: [AdRenderable]` with associated types? `(120s)`

**Answer points (frame first):**
- Each conformer may pick different associated types
- Existential can’t present one uniform associated shape
- Options: generics, type erasure, constrained `any`, closed enum
- Prefer generics in pipeline; erase at heterogeneous edge

**Trap:**  
> “Just use the protocol name like Java interfaces.”

**Full spoken answer:**  
> “If `AdRenderable` has associated types like `Model` and `ContentView`, each conformer can choose different concrete types. A homogeneous array existential would need one shared shape for those associated types, which you don’t have. Historically that blocked easy `[AdRenderable]`. Today I’d keep the installer generic, or erase to something like `AnyRenderable` that collapses views to `UIView`, or use constrained `any` when the language lets me fix part of the shape. On a revenue pipeline I prefer generics inside and erasure only if the feed must be heterogeneous.”

**Follow-up ladder:**
- **L1:** How does `AnyPublisher` relate?
- **L2:** Primary associated types — what improves?
- **L3:** Would an enum of creatives be better?

**Provenance:** Learning-lab · PAT + erasure; applies to S1 feed boundaries

---

### T2. Default implementation in extension vs requirement — override surprise `(90s)`

**Answer points (frame first):**
- Non-requirement extension methods: static binding risk
- Requirements: witness-table dispatch
- Promote customized APIs to requirements
- Demo mental model with greet/wave

**Trap:**  
> Expect polymorphic call to concrete override via existential for extension-only methods.

**Full spoken answer:**  
> “If `wave` lives only in a protocol extension and isn’t a requirement, calling `wave` on an `any Greeter` can hit the extension default even when the concrete type defines `wave`. Requirements like `greet` dispatch to the conformer. The surprise bites teams who put ‘overridable’ behavior only in extensions. Fix: declare polymorphic methods as requirements; keep extensions for true shared defaults.”

**Follow-up ladder:**
- **L1:** Does generics calling a concrete type avoid the surprise?
- **L2:** Interaction with inherited protocol defaults?
- **L3:** How would you unit-test dispatch expectations?

**Provenance:** Learning-lab · dispatch trap

---

### T3. Type-erasing a generic renderer — when is it worth it? `(90s)`

**Answer points (frame first):**
- Worth it: heterogeneous lists, plugin registries, API boundaries
- Not worth it: inside a monomorphic hot pipeline
- Cost: allocation, indirection, lost specialization
- S1 instinct: generics first

**Trap:**  
> Erase everything for ‘cleaner’ types.

**Full spoken answer:**  
> “I’d type-erase a renderer when I must store different creatives in one collection or cross a module boundary that can’t be generic end-to-end. Inside the hot ads bind path I’d keep `Pipeline<C: Creative>` so the compiler specializes and types stay precise. Erasure pays heap and witness-style indirection and collapses associated richness — fine at the edge, expensive if you wrap every call. At BMS ads scale the justified abstraction was POP + generics; erasure is a boundary tool, not the architecture.”

**Follow-up ladder:**
- **L1:** What common denominator do you erase views to?
- **L2:** Class-based eraser vs struct-of-closures?
- **L3:** Measuring the cost in Instruments?

**Provenance:** How I would apply it · S1 boundary design; Learning-lab eraser

---

### T4. POP for SDUI component registry vs enums `(120s)`

**Answer points (frame first):**
- Enum = closed world, exhaustive, app release to extend
- Protocol registry = open world for CMS growth
- Need unknown fallback + versioning
- Soft S3 / S3-A1 honesty

**Trap:**  
> Enum of all components forever as the only design.

**Full spoken answer:**  
> “An enum of every component is a closed set — great exhaustiveness, painful when CMS invents types. A protocol-oriented registry lets factories register for type strings and construct components, which matches backend-driven UI growth. The trade-off is handling unknowns: you need a fallback component and schema versioning so old apps don’t crash on new types. At BookMyShow we did protocol-driven header work; the explicit unknown-fallback design is how I’d apply versioning — I’m not claiming a particular fallback implementation shipped.”

**Follow-up ladder:**
- **L1:** What does the fallback render?
- **L2:** How do you version JSON schemas?
- **L3:** Mixing ads creatives into SDUI slots?

**Provenance:** Verified · S3 soft; How I would apply it · S3-A1

---

### T5. Generics overkill for two ad types? `(90s)`

**Answer points (frame first):**
- YAGNI for tiny stable sets
- Revenue + growing variants justified abstraction at BMS
- Introduce when third variant or test seams demand
- Don’t abstract for fashion

**Trap:**  
> Always abstract on day one / never abstract because YAGNI.

**Full spoken answer:**  
> “If you truly have two stable ad types forever, a small enum or shared function might be enough — YAGNI applies. On the highest-revenue Ads module, creatives and lifecycle concerns were growing, and forking bind code was the risk. That’s when POP and generics paid off: type-safe plug-in points and testable contracts. I’d introduce the abstraction when a third variant or a painful test seam appears — or earlier on a revenue path where a cast bug is expensive. It’s judgment, not dogma.”

**Follow-up ladder:**
- **L1:** What signals say ‘time to abstract’?
- **L2:** How do you migrate an inheritance tree incrementally?
- **L3:** Metrics you’d watch after refactor (honest: qualitative + crash/stability, not fake fill-rate)?

**Provenance:** Verified · S1 · justified abstraction on revenue module

---

### T6. `rethrows` + generic higher-order functions `(90s)`

**Answer points (frame first):**
- Function only throws if closure throws
- Clean mapper APIs
- Avoid forcing try on non-throwing call sites
- Useful in generic transform pipelines

**Trap:**  
> Mark everything `throws` or ignore error propagation.

**Full spoken answer:**  
> “`rethrows` lets a higher-order function declare that it throws only when its function argument throws. So a generic `map` over creatives can take a throwing transform without forcing every non-throwing caller to write `try`. That keeps pipeline APIs clean: errors propagate when real, stay silent when not. I’d use it on generic mappers at module boundaries; I wouldn’t sprinkle `throws` on APIs that never fail.”

**Follow-up ladder:**
- **L1:** Difference between `throws` and `rethrows`?
- **L2:** async + throws interaction at a high level?
- **L3:** Typed throws awareness (newer Swift) — optional?

**Provenance:** Learning-lab · API design fluency

---

## Timed set recommendations

| Set | Questions | Focus |
|---|---|---|
| A | Q1, Q4, Q6, T1, T4 | POP + erasure + SDUI |
| B | Q2, Q3, Q5, T2, T3 | Types + dispatch |
| C | Q7, Q8, Q11, T5, S1 5-min | Composition + story |

Score with [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md).

---

## Exit criteria for questions module

- [ ] 8+ normals spoken from Answer points without reading Full  
- [ ] 3+ trickies with trap named explicitly  
- [ ] S1 ≤20s + ≤5 min architecture dry-run once  
- [ ] Zero invented fill-rate metrics in any recording  
