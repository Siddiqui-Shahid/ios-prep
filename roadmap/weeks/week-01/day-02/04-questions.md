# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What is protocol-oriented programming? `(30–45s)`

**Answer:**

> Protocol-oriented programming means designing around capabilities — protocols and extensions — instead of growing a deep inheritance tree. Types opt into what they can do: renderable, trackable, playback-controllable. Structs and classes can both conform, so models stay value-friendly while UIKit views stay classes. On the BookMyShow Ads refactor we used protocol contracts so new creatives plugged into one pipeline instead of forking an AdView subclass hierarchy.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How is composition different from multiple inheritance? | Composition stacks capabilities without inheriting stored state or fragile base implementations from multiple parents. |
| When is a class hierarchy still justified? | When UIKit/ObjC requires a subclass, or you truly need reference identity and framework hooks. |
| How do you unit-test a protocol-based pipeline? | Inject fake conformers for render/track/playback and assert the installer calls the right witnesses. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. associatedtype vs generic parameter? `(45–60s)`

**Answer:**

> A generic parameter is filled in by the caller — `Renderer<ImageCreative>`. An associated type is filled in by the type that conforms to the protocol — `ImageAd` decides what its `ContentView` is. That’s powerful for flexible contracts, but protocols with associated types are awkward as plain existentials, so you often keep APIs generic — `install<R: AdRenderable>` — or erase at a boundary if you need a heterogeneous list.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can you put a protocol with associated types in an array? | Not as a plain existential historically — keep it generic, use primary associated types, or erase to one concrete type. |
| What are primary associated types helping with? | They let you write constrained existentials like `any Collection<String>` instead of always staying fully generic. |
| Show `where` constraining an associated type. | `func install<R: AdRenderable>(_: R) where R.ContentView: UIView` ties the associated view to UIKit. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. `some` vs `any`? `(45s)`

**Answer:**

> `some Protocol` means one concrete type that conforms, but the caller can’t name it — like SwiftUI’s `some View`. `any Protocol` is an existential box that can hold different conforming types, with more dynamic dispatch and limits around Self and associated types. I use opaque or generics when the concrete type is stable and I care about specialization; I use `any` or type erasure when I truly need heterogeneous storage.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why does SwiftUI return `some View`? | The concrete view type stays opaque and stable for the compiler while callers only depend on the `View` contract. |
| What’s the performance intuition? | Opaque/`some` and generics can specialize; `any` boxes and uses more dynamic dispatch. |
| When does `any` refuse an associated-type operation? | When the API needs a specific associated type or `Self`, the existential can’t expose that without constraints/erasure. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Why generics in an ads pipeline? `(45s)`

**Answer:**

> Generics let the ads pipeline stay type-safe as creatives grow. Instead of `Any` and downcasting in bind code — which breaks when a new creative ships — each creative conforms to protocol contracts and flows through a generic installer. That kept the highest-revenue module maintainable: new types plug in without forking the revenue path, and the compiler catches mismatches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What did HeroWidget add on top? | Identity-bound playback/visibility lifecycle on a class, while creatives still flowed through the typed ads pipeline. |
| Would you expose the generic pipeline across modules? | Prefer a narrow public protocol surface; keep heavy generics internal so module boundaries stay stable. |
| When would you introduce type erasure? | At a heterogeneity boundary — arrays of mixed conformers or a single returned type — not inside the hot generic path. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. Protocol extension default methods — dispatch catch? `(60s)`

**Answer:**

> If a method is a protocol requirement, calling it through an existential uses the conformer’s implementation via the witness table. If it’s only defined in a protocol extension and not a requirement, the call can bind to the extension default based on the static type — even if the concrete type defines the same method name. So for behavior that must customize polymorphically, declare it as a requirement. Use extension defaults for truly shared behavior.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Show a minimal surprise example. | Extension-only `describe()` called via `any P` uses the default even if the concrete type defines its own `describe()`. |
| How do you force dynamic dispatch? | Declare the method as a protocol requirement so existential calls go through the witness table. |
| Implications for a shared `track()` helper? | If tracking must customize per creative, make `track()` a requirement; extension defaults only for truly shared behavior. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is type erasure? `(45–60s)`

**Answer:**

> Type erasure means wrapping types that conform to a protocol — especially one with associated types — in a single concrete type that forwards calls, so you can store them in arrays or return one type from APIs. Combine’s `AnyPublisher` is the standard example. The cost is extra allocation and indirection, and you lose generic specialization. I keep generics inside the hot ads pipeline and erase only at boundaries that need heterogeneity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sketch `AnyTrackable` in 30s. | Store a closure or boxed base that forwards `track()`, constructed from any concrete `AdTrackable`. |
| What do you collapse associated views to? | Often a common UIView/AnyView-like surface, or erase the whole renderer so callers never see the associated type. |
| Erasure vs constrained `any` today? | Prefer constrained `any` when primary associated types suffice; hand-rolled erasure when you need a custom boxed API. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. Protocol composition (`A & B`)? `(30s)`

**Answer:**

> Protocol composition means a type must satisfy multiple protocols — `AdRenderable & AdTrackable`. It’s capability intersection, not C++-style multiple inheritance of implementations and stored properties. For hero video ads I’d compose render, track, and playback protocols; image tiles might only need render and track.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Composition vs protocol inheritance? | `A & B` requires both at the use site; inheritance builds a lasting subtype relationship into the protocol graph. |
| How does this interact with generics? | Generic params can be constrained to `R: AdRenderable & AdTrackable` so one installer demands both capabilities. |
| Class-bound + composition for delegates? | `AnyObject & PlaybackDelegate` lets you hold `weak` while still requiring multiple delegate capabilities. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. When is inheritance still OK? `(45s)`

**Answer:**

> I still use inheritance when UIKit requires a subclass — views, cells, view controllers — or when I need reference identity and Objective-C interop. The senior move is to subclass for the platform object and attach capabilities via protocols. HeroWidget is a class because player lifecycle and visibility hooks are identity concerns, while the ads pipeline around it stays protocol- and generic-oriented.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can a UIView subclass conform to your ad protocols? | Yes — HeroWidget-style classes conform for lifecycle while value creatives conform for data-only capabilities. |
| Fragile base class symptoms? | Subclasses break when the base changes hooks/order, forcing overrides that fight shared superclass behavior. |
| Testing UIKit subclasses vs protocol fakes? | Prefer fakes of protocol dependencies; reserve UIKit subclass tests for lifecycle/integration behavior. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q9. Conditional conformance? `(45s)`

**Answer:**

> Conditional conformance means a generic type adopts a protocol only when its parameters meet constraints — Array is Equatable when its Element is. That keeps model layers honest: a Pair of Equatables can be Equatable without forcing Pair to always be Equatable. In pipelines I use the same idea for wrappers that should only be Hashable or Codable when their creative payload is.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Write `Pair` Equatable where clause. | `extension Pair: Equatable where A: Equatable, B: Equatable { … }` so Pair is Equatable only when both sides are. |
| Codable conditional pitfalls? | Synthesis/manual coding can diverge, and optional or existential payloads may not satisfy Codable as expected. |
| Difference from `where` on a function? | Function `where` limits one call site; conditional conformance changes whether the type adopts the protocol at all. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Generics for repository / boundary interfaces? `(45s)`

**Answer:**

> At module boundaries I like protocol interfaces with an associated model or generic methods so call sites stay typed — `Repository` returning a concrete domain model rather than `[String: Any]`. Inside, implementations can vary. That same instinct showed up on a Stories SDK reused across apps: stable protocol-oriented surfaces rather than leaking concretes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| associatedtype Model vs generic method? | Associatedtype fixes Model per conforming type; a generic method lets each call choose its own type parameter. |
| How do you mock in tests? | Provide a test double conforming to the repository protocol with a canned Model, injected at the boundary. |
| Versioning broken contracts? | Add new protocol requirements carefully (defaults/extension), or introduce a v2 protocol rather than silently breaking callers. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q11. `protocol P: AnyObject` vs struct-friendly protocols? `(45s)`

**Answer:**

> Marking a protocol `AnyObject` restricts conformance to classes, which lets you hold `weak` references — classic delegates. Struct-friendly protocols omit that bound so value types can conform. For ads tracking on value creatives I keep protocols struct-friendly; for HeroWidget playback delegates or UIKit-style delegates I use class-bound protocols.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why can’t weak point at a struct? | `weak` needs a reference-counted object; structs have no shared identity to zero out. |
| Closure callbacks vs weak delegates? | Closures need explicit `[weak self]`; class-bound `weak var delegate` is the classic UIKit cycle break. |
| Actor-bound protocols awareness? | Actor-isolated protocol requirements force await/isolation hops — don’t casually mix them with UIKit delegate assumptions. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

## Tricky questions

## Timed set recommendations

| Set | Questions | Focus |
|---|---|---|
| A | Q1, Q4, Q6, T1, T4 | POP + erasure + SDUI |
| B | Q2, Q3, Q5, T2, T3 | Types + dispatch |
| C | Q7, Q8, Q11, T5, BookMyShow Ads pipeline + HeroWidget lifecycle 5-min | Composition + story |

Score with [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md).

---

## Exit criteria for questions module

