# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What is protocol-oriented programming? `(30–45s)`

**Answer:**

> “Protocol-oriented programming means designing around capabilities — protocols and extensions — instead of growing a deep inheritance tree. Types opt into what they can do: renderable, trackable, playback-controllable. Structs and classes can both conform, so models stay value-friendly while UIKit views stay classes. On the BookMyShow Ads refactor we used protocol contracts so new creatives plugged into one pipeline instead of forking an AdView subclass hierarchy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How is composition different from multiple inheritance? | “Composition stacks capabilities without inheriting stored state or fragile base implementations from multiple parents.” |
| When is a class hierarchy still justified? | “When UIKit or ObjC requires a subclass, or you truly need reference identity and framework hooks.” |
| How do you unit-test a protocol-based pipeline? | “Inject fake conformers for render, track, playback and assert the installer calls the right witnesses.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. associatedtype vs generic parameter? `(45–60s)`

**Answer:**

> “A generic parameter is filled in by the caller — Renderer of ImageCreative. An associated type is filled in by the type that conforms to the protocol — ImageAd decides what its ContentView is. That’s powerful for flexible contracts, but protocols with associated types are awkward as plain existentials, so I often keep APIs generic — install of R where R is AdRenderable — or erase at a boundary if I need a heterogeneous list.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can you put a protocol with associated types in an array? | “Not as a plain existential historically — keep it generic, use primary associated types, or erase to one concrete type.” |
| What are primary associated types helping with? | “They let you write constrained existentials like any Collection of String — they don’t fix every mixed array.” |
| Show where constraining an associated type. | “install of R where R is AdRenderable and R.ContentView is UIView.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q3. some vs any? `(45s)`

**Answer:**

> “some Protocol means one concrete type that conforms, but the caller can’t name it — like SwiftUI’s some View. any Protocol is an existential box that can hold different conforming types, with more dynamic dispatch and limits around Self and associated types. I use opaque or generics when the concrete type is stable and I care about specialization; I use any or type erasure when I truly need heterogeneous storage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why does SwiftUI return some View? | “The concrete view type stays opaque and stable for the compiler while callers only depend on the View contract.” |
| What’s the performance intuition? | “Opaque some and generics can specialize; any boxes and uses more dynamic dispatch.” |
| When does any refuse an associated-type operation? | “When the API needs a specific associated type or Self, the existential can’t expose that without constraints or erasure.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Why generics in an ads pipeline? `(45s)`

**Answer:**

> “Generics let the ads pipeline stay type-safe as creatives grow. Instead of Any and downcasting in bind code — which breaks when a new creative ships — each creative conforms to protocol contracts and flows through a generic installer. That kept the highest-revenue module maintainable: new types plug in without forking the revenue path, and the compiler catches mismatches. I don’t invent fill-rate percentages.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What did HeroWidget add on top? | “Identity-bound playback and visibility lifecycle on a class, while creatives still flowed through the typed ads pipeline.” |
| Would you expose the generic pipeline across modules? | “Prefer a narrow public protocol surface; keep heavy generics internal so module boundaries stay stable.” |
| When would you introduce type erasure? | “At a heterogeneity boundary — arrays of mixed conformers or a single returned type — not inside the hot generic path.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. Protocol extension default methods — dispatch catch? `(60s)`

**Answer:**

> “If a method is a protocol requirement, calling it through an existential uses the conformer’s implementation via the witness table. If it’s only defined in a protocol extension and not a requirement, the call can bind to the extension default based on the static type — even if the concrete type defines the same method name. So for behavior that must customize polymorphically, declare it as a requirement. Use extension defaults for truly shared behavior.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Show a minimal surprise example. | “Extension-only describe called via any P uses the default even if the concrete type defines its own describe.” |
| How do you force dynamic dispatch? | “Declare the method as a protocol requirement so existential calls go through the witness table.” |
| Implications for a shared track helper? | “If tracking must customize per creative, make track a requirement; extension defaults only for truly shared behavior.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is type erasure? `(45–60s)`

**Answer:**

> “Type erasure means wrapping types that conform to a protocol — especially one with associated types — in a single concrete type that forwards calls, so you can store them in arrays or return one type from APIs. Combine’s AnyPublisher is the standard example. Hand-rolled, I store closures like _track and often upcast views to UIView. The cost is extra allocation and indirection, and you lose generic specialization. I keep generics inside the hot ads pipeline and erase only at boundaries that need heterogeneity.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sketch AnyTrackable in 30s. | “Store a closure or boxed base that forwards track, constructed from any concrete AdTrackable.” |
| What do you collapse associated views to? | “Often a common UIView-like surface, or erase the whole renderer so callers never see the associated type.” |
| Erasure vs constrained any today? | “Prefer constrained any when primary associated types suffice; hand-rolled erasure when you need a custom boxed API.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. Protocol composition (A & B)? `(30s)`

**Answer:**

> “Protocol composition means a type must satisfy multiple protocols — AdRenderable and AdTrackable. It’s capability intersection, not C++-style multiple inheritance of implementations and stored properties. For hero video ads I’d compose render, track, and playback protocols; image tiles might only need render and track.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Composition vs protocol inheritance? | “A and B requires both at the use site; inheritance builds a lasting subtype relationship into the protocol graph.” |
| How does this interact with generics? | “Generic params can be constrained to R: AdRenderable and AdTrackable so one installer demands both capabilities.” |
| Class-bound plus composition for delegates? | “AnyObject and PlaybackDelegate lets you hold weak while still requiring multiple delegate capabilities.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q8. When is inheritance still OK? `(45s)`

**Answer:**

> “I still use inheritance when UIKit requires a subclass — views, cells, view controllers — or when I need reference identity and Objective-C interop. The senior move is to subclass for the platform object and attach capabilities via protocols. HeroWidget is a class because player lifecycle and visibility hooks are identity concerns, while the ads pipeline around it stays protocol- and generic-oriented.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can a UIView subclass conform to your ad protocols? | “Yes — HeroWidget-style classes conform for lifecycle while value creatives conform for data-only capabilities.” |
| Fragile base class symptoms? | “Subclasses break when the base changes hooks or order, forcing overrides that fight shared superclass behavior.” |
| Testing UIKit subclasses vs protocol fakes? | “Prefer fakes of protocol dependencies; reserve UIKit subclass tests for lifecycle and integration behavior.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q9. Conditional conformance? `(45s)`

**Answer:**

> “Conditional conformance means a generic type adopts a protocol only when its parameters meet constraints — Array is Equatable when its Element is. That keeps model layers honest: a Pair of Equatables can be Equatable without forcing Pair to always be Equatable. Function where limits one call site; conditional conformance changes whether the type adopts the protocol at all. In pipelines I use the same idea for wrappers that should only be Hashable or Codable when their creative payload is.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Write Pair Equatable where clause. | “extension Pair: Equatable where A: Equatable, B: Equatable.” |
| Codable conditional pitfalls? | “Synthesis and manual coding can diverge, and optional or existential payloads may not satisfy Codable as expected.” |
| Difference from where on a function? | “Function where limits one call site; conditional conformance changes whether the type adopts the protocol at all.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Generics for repository / boundary interfaces? `(45s)`

**Answer:**

> “At module boundaries I like protocol interfaces with an associated model or generic methods so call sites stay typed — Repository returning a concrete domain model rather than string-keyed Any. Inside, implementations can vary. That same instinct showed up on a Stories SDK reused across apps: stable protocol-oriented surfaces rather than leaking concretes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| associatedtype Model vs generic method? | “Associatedtype fixes Model per conforming type; a generic method lets each call choose its own type parameter.” |
| How do you mock in tests? | “Provide a test double conforming to the repository protocol with a canned Model, injected at the boundary.” |
| Versioning broken contracts? | “Add new protocol requirements carefully with defaults, or introduce a v2 protocol rather than silently breaking callers.” |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); District Free Parking + Clean/MVVM + AI tooling
- **Don’t claim:** Invented metrics or claiming design-only work as shipped.

---

### Q11. protocol P: AnyObject vs struct-friendly protocols? `(45s)`

**Answer:**

> “Marking a protocol AnyObject restricts conformance to classes, which lets you hold weak references — classic delegates. Struct-friendly protocols omit that bound so value types can conform. For ads tracking on value creatives I keep protocols struct-friendly; for HeroWidget playback delegates or UIKit-style delegates I use class-bound protocols.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why can’t weak point at a struct? | “weak needs a reference-counted object; structs have no shared identity to zero out.” |
| Closure callbacks vs weak delegates? | “Closures need explicit weak self; class-bound weak var delegate is the classic UIKit cycle break.” |
| Actor-bound protocols awareness? | “Actor-isolated protocol requirements force await hops — don’t casually mix them with UIKit delegate assumptions.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These are the ones that separate “I read a blog” from “I’ve been burned.”

---

### T1. Why can’t I put `[AdRenderable]` in an array when View is associated? `(90s)`

**Answer:**

> “Each adopter picks its own ContentView — image might return UIImageView, video another view type. A plain mixed array typed as the protocol doesn’t know a single view shape. Historically protocols with associated types weren’t free existentials. Modern Swift helps with constrained any and primary associated types, but pinning Model doesn’t magically unify different Views. My plan: stay generic on the hot path, erase to a common surface at the list boundary, use constrained any when it works, or a closed enum for a tiny stable set.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Say ‘protocol with associated type’ — not unexplained PAT letter-soup — and name the four strategies.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Lab only:** Learning-lab erasure demos
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### T2. Extension-only wave through any Greeter — what prints? `(90s)`

```swift
protocol Greeter {}
extension Greeter {
    func wave() { print("default") }
}
struct Person: Greeter {
    func wave() { print("person") }
}
let g: any Greeter = Person()
g.wave()
```

**Answer:**

> “Often default — not person. wave was never a protocol requirement, so the call binds to the extension based on the static type any Greeter. Requirements go through the witness table; extension-only methods may bind statically. Fix: declare wave in the protocol body if polymorphic override matters. Ads angle: identical default click log can stay extension-only; custom per-creative track must be a requirement.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Tie to the triad — static vs witness vs @objc message send.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T3. Stay generic vs erase vs closed enum — pick for a mixed feed `(90–120s)`

**Answer:**

> “If the hot bind sees one concrete creative at a time, I stay generic so the compiler specializes. If the feed truly mixes shapes or I cross a plugin boundary, I erase to one concrete box and pay allocation, indirection, lost specialization, and a narrower API. If the set is tiny and stable, a closed enum with exhaustive switches is fine — every new case is an app release. CMS weekly growth pushes open registry plus unknown fallback, not a forever-closed enum. Primary associated types help pin part of the shape; they don’t replace that decision.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Wrong default is erasing every generic just in case.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow backend-driven header & search
- **Design if asked:** Unknown-component fallback — label design.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### T4. Cost of type erasure — four costs aloud `(90s)`

**Answer:**

> “Allocation — the box and closures often land on the heap. Indirection — every call goes through a stored function like _track. Lost specialization — the compiler sees AnyAd, not VideoAd. Narrower API — rich associated types collapse to a common denominator, often UIView. Erasure is not free. I keep generics inside the revenue pipeline and erase at mixed lists or module edges. Learning-lab AnyTrackable teaches the mechanics; I don’t invent that we erased every renderer in production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Same motive as AnyPublisher — hide nested generics at a boundary.” |

**How can I relate to my case:**
- **Lab only:** TypeErasureDemo.swift — not claimed BMS source
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle (prefer generics claim)
- **Don’t claim:** Invented fill-rate % or “we erased everything.”

---

### T5. Always POP everything / inventing fill-rate % — your reply? `(90–120s)`

**Answer:**

> “I push back on always POP everything. Two similar types forever — maybe don’t abstract yet. Highest-revenue growing creatives — abstraction pays. At BookMyShow ads scale, variants justified a protocol-and-generics pipeline plus HeroWidget lifecycle. What I never do is invent fill-rate percentages, revenue deltas, or CTR to sell the story. Honest claim: maintainable type-safe pipeline and lifecycle-correct video — fewer playback glitches qualitatively. YAGNI and revenue scale are the same decision lens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Senior answer: introduce POP when variants or test seams demand it.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### T6. HeroWidget — class identity + protocol capability `(90s)`

**Answer:**

> “People hear POP and think never use classes. HeroWidget is still a class because view lifecycle and player identity are reference concerns — pause and play tied to visibility. The ads pipeline around it stays protocol- and generic-oriented. PlaybackControllable is often AnyObject-bound for weak ownership. Class identity plus protocol capability isn’t a contradiction — it’s the senior UIKit pattern.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Subclass for the platform object; attach capabilities via protocols.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### T7. Static vs witness-table vs @objc triad `(90s)`

**Answer:**

> “Three dispatch stories. Concrete, final, or specialized generics can static-dispatch — the compiler knows the exact type. Protocol requirements called through an existential go through a witness table — dynamic, protocol-scoped. @objc uses Objective-C message send. Extension-only methods that aren’t requirements may bind to the static type, which is why any Greeter can miss Person.wave. I don’t conflate witness tables with ObjC messaging.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Ads: shared identical defaults can stay extension-only; polymorphic overrides must be requirements.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T8. Self / associated types blocking unconstrained any + primary AT limits `(90–120s)`

**Answer:**

> “Unconstrained any P can fail when APIs need Self or associated types — the existential doesn’t expose a concrete shape. Primary associated types let me pin part of it — any AdRenderable of HeroModel — which helps some call sites. They don’t make every associated-type protocol free as a mixed array when ContentView still differs. Plan: generics, constrained any, erasure, or closed enum — not wishful unconstrained any for everything.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “some still means one hidden concrete type — great for returns, not for swapping adopters.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T9. Hand-rolled eraser internals (_track / upcast) `(90s)`

**Answer:**

> “AnyTrackable stores id and a _track closure. The generic init captures the concrete Banner or Interstitial into that box so both fit in one array. For renderers I’d upcast associated views to UIView as the common surface. Costs stay real — heap, indirection, lost specialization. Prefer func install of T where T is Trackable inside the pipeline. This is learning-lab mechanics unless I personally shipped that eraser.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Same idea as AnyPublisher — hide nested generics at the edge.” |

**How can I relate to my case:**
- **Lab only:** TypeErasureDemo.swift — not claimed BMS source
- **Don’t claim:** “We type-erased every renderer in production.”

---

### T10. Stories SDK soft bridge without stealing Ads credit / open registry `(90–120s)`

**Answer:**

> “On ads questions I lead with BookMyShow Ads pipeline plus HeroWidget — type-safe protocol-and-generics path, lifecycle-correct video, no invented fill-rate. Soft bridge only if they ask about reusable SDKs: Stories SDK across a portfolio used contracts at the boundary, concretes inside — no invented client counts. For CMS or SDUI pivots I talk open ComponentRegistry with unknown-type fallback to EmptyView — design judgment when Applied — without abandoning the Ads spine. Fragile base class AdView trees are what we left behind.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Trap: spending the whole answer on Stories when they asked about ads.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Stories SDK (Raw / Miami Heat); BookMyShow backend-driven header & search
- **Design if asked:** Unknown-component fallback — label design.
- **Don’t claim:** Invented fill-rate %, client counts, or sole credit for ads revenue.

---

## Timed set suggestions

| Drill | Questions | Focus |
|---|---|---|
| Core 10 min | Q1, Q4, Q6, T1, T4 | POP + generics + erasure |
| Types 8 min | Q2, Q3, Q5, T2, T3 | Associated types + dispatch + strategy |
| Honesty 8 min | Q8, T5, T6, T10 | HeroWidget + YAGNI + Stories soft bridge |
| Brain-puzzle sprint 12 min | T1, T2, T3, T4, T5 | Mixed array + Greeter + strategy + cost + fill-rate honesty |
| Architecture 5 min | T5 whiteboard spine from sample 03 / Q8 Action | Ads 5-min agenda |

Score with [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md).

---

## Exit criteria for questions module

- [ ] Spoke Q1–Q6 without notes in budget
- [ ] Spoke T1–T5 on a timer (timed sets cite these)
- [ ] Delivered Ads + HeroWidget Action ≤3 min with no invented fill-rate %
- [ ] Named four erasure costs and the Greeter trap
