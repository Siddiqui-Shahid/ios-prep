# Sample 01 — POP and generics (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer. 
> Each answer ends with **How can I relate to my case** using named work — never S-codes. 
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What is protocol-oriented programming (POP)?
**Answer:**

> “POP means I design around capabilities — protocols and extensions — instead of growing a deep inheritance tree. Types opt into what they can do: renderable, trackable, playback-controllable. Structs and classes can both adopt. On a revenue UI path that lets new ad types plug into one pipeline instead of forking an AdView subclass hierarchy.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence contrast with inheritance? | “Inheritance models what you are. Protocols model what you can do.” |
| Does POP mean never use classes? | “No. UIKit views and HeroWidget still need class identity. Put capabilities on protocols.” |
| Ads example of composition? | “A video hero may need render + track + playback. An image tile may only need render + track.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Why do inheritance trees hurt at scale for ads?
**Answer:**

> “Classic UIKit tutorials grow UIView → AdView → ImageAdView / VideoAdView. At scale the shared base gets fat, everything becomes a class even when data could be a value, tests must mock deep trees, a new creative forks the hierarchy, and Swift classes only get one parent while real ads need several abilities at once. That’s the fragile base class failure mode — every change to shared configure risks every subclass.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is a “fragile base class”? | “Shared configure grows into god-methods; every change risks every subclass.” |
| Why “multiple is-a” fails? | “Single class inheritance can’t express renderable and trackable and playable cleanly.” |
| When is inheritance still OK? | “When UIKit requires a subclass — UIView, UIViewController — or shared identity / ObjC runtime.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Protocol requirements vs extension defaults?
**Answer:**

> “Methods listed inside the protocol body are requirements — part of the contract; call sites usually dispatch them through a witness table. Methods added only in an extension are convenience. They may not override the way you expect when the variable is typed as the protocol. If a creative must customize a method, put it in the protocol body as a requirement.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Classic trap? | “wave only in an extension — through any Greeter you get the extension default, not Person.wave.” |
| Fix? | “Declare wave as a protocol requirement if polymorphic behavior matters.” |
| When are extension defaults fine? | “Shared identical behavior — same default click log — that nobody needs to override through the existential.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is protocol composition — and how is inheritance different?
**Answer:**

> “The & means and. AdRenderable & AdTrackable & PlaybackControllable means the type must satisfy all three contracts. That’s not multiple inheritance — it’s multiple capabilities. Protocol inheritance is different: VideoAdRenderable: AdRenderable, PlaybackControllable builds a lasting subtype in the protocol graph. Composition is at the use site; inheritance is in the protocol hierarchy. Typealiases like HeroAd keep whiteboard signatures readable.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can image ads skip playback? | “Yes — only require the capabilities they need. Don’t force video APIs onto image creatives.” |
| Class-bound AnyObject when? | “When you need weak delegates or class identity.” |
| Prefer protocols for models? | “Prefer value conformers for models; class conformers are fine for UIKit views.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is a generic parameter, and why beat Any on a revenue path?
**Answer:**

> “A generic parameter is a blank the caller fills in — Renderer of ImageCreative. Add constraints when you need methods: Creative: AdTrackable. Cast ladders with Any hide bugs until a new creative ships. Generics push mismatches to compile time. That matters on a revenue ads path — BookMyShow Ads pipeline plus HeroWidget lifecycle. I may say the pipeline was type-safe. I do not invent fill-rate percentages.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who chooses T? | “The caller.” |
| What does where buy you? | “Readable constraints when rules grow — especially with associated types.” |
| Provenance care? | “Type-safe pipeline is the claim. No invented fill-rate %.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. What is some vs any (first cut)?
**Answer:**

> “some P is an opaque type — one real concrete type, hidden from the caller. any P is an existential — a box that can hold different adopters, with limits. Generics and some specialize better. any uses a witness table / existential container and may block operations that need Self or associated types.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SwiftUI energy? | “some View hides one concrete view type.” |
| When prefer any? | “Heterogeneous stored values — or use a type eraser.” |
| Hot bind preference? | “Generics on the concrete type, or some.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. When is class inheritance still the right tool?
**Answer:**

> “POP is a tool, not a religion. Still subclass when UIKit requires it, when you need shared identity / ObjC runtime, or when the framework owns the base type. Senior pattern: subclass UIKit for the view, put capabilities on protocols. HeroWidget can be a real view with lifecycle and sit behind a playback protocol.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview trap? | “‘POP means never use classes.’ HeroWidget is a class; capabilities are protocols.” |
| Examples of required subclasses? | “UIView, UIViewController, UICollectionViewCell.” |
| Next sample file? | “Associated types under pressure and type erasure.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Class-bound AnyObject + weak delegate — why?
**Answer:**

> “Marking a protocol AnyObject restricts conformance to classes, which lets you hold weak references — classic delegates. Struct-friendly protocols omit that bound so value types can conform. For ads tracking on value creatives I keep protocols struct-friendly; for HeroWidget playback delegates or UIKit-style delegates I use class-bound protocols. weak needs a reference-counted object — structs have no shared identity to zero out.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Closure callbacks vs weak delegates? | “Closures need explicit weak self; class-bound weak var delegate is the classic UIKit cycle break.” |
| Composition with AnyObject? | “AnyObject & PlaybackDelegate lets you hold weak while requiring multiple capabilities.” |
| Actor-bound awareness? | “Actor-isolated protocol requirements force await hops — don’t casually mix with UIKit delegate assumptions.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q9. What is conditional conformance vs where on a function?
**Answer:**

> “Conditional conformance means a generic type adopts a protocol only when its parameters meet constraints — Array is Equatable when Element is; Pair is Equatable where A and B are. That keeps model layers honest. Function where constrains one call site; conditional conformance makes the type adopt the protocol when pieces allow. Wrappers that are Hashable or Codable only when the payload is — same honesty as stdlib collections.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pair sketch? | “extension Pair: Equatable where A: Equatable, B: Equatable.” |
| Pipeline use? | “Wrappers Hashable or Codable only when the creative payload is.” |
| vs constrained extension on Self? | “extension AdRenderable where Self: PlaybackControllable — refine helpers without a class tree.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. What is rethrows on a generic higher-order function?
**Answer:**

> “rethrows lets a higher-order function declare that it throws only when its function argument throws. A generic map over creatives can take a throwing transform without forcing every non-throwing caller to write try. Errors propagate when real and stay silent when not — clean pipeline APIs at module boundaries. Don’t sprinkle throws on APIs that never fail, and don’t mark everything rethrows as ceremony.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| throws vs rethrows? | “throws always can throw; rethrows only if a passed closure throws.” |
| Why it matters on ads pipelines? | “Typed mappers stay ergonomic for non-throwing call sites while still supporting throwing transforms.” |
| async interaction? | “Same instinct — don’t force try or await noise on callers when the transform never fails.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. What should you say after foundations, before the deep dive?
**Answer:**

> “I can explain POP with a capability example; contrast caller picks T versus adopter picks associated type; say why AdRenderable arrays are awkward when associated types differ; give one reason generics beat Any casts; name when I still subclass UIView; and sketch the witness-table versus extension-default trap.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Witness table in one line? | “Runtime dispatch table for protocol requirements.” |
| Existential in one line? | “any P — a value that can hold different adopters.” |
| Opaque type in one line? | “some P — one hidden concrete type.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Extension-only method through any Greeter

```swift
protocol Greeter {}
extension Greeter {
 func wave { print("default") }
}
struct Person: Greeter {
 func wave { print("person") }
}
let g: any Greeter = Person
g.wave
```

**Ask yourself:** What prints? Why?

**Answer:** Often `"default"`. `wave` was never a requirement, so the call binds to the extension based on the static type `any Greeter`. Promote `wave` into the protocol body if polymorphic override matters.

---

### Puzzle B — Fragile base class ads hierarchy

You have `AdView.configure(_:)` that every image/video/carousel subclass overrides. Product asks for “one more analytics hook” in the base.

**Ask:** What fails at scale?

**Answer:** Every subclass fights the shared base. New creatives fork the tree. Tests mock deep hierarchies. Prefer capability protocols — render / track / playback — so image tiles don’t inherit video APIs and the base doesn’t become a god object.

---

### Puzzle C — Always POP everything?

Interviewer: “So you POP every feature on day one?”

**Good reply:** “No. Two similar types forever — maybe don’t abstract yet. Highest-revenue growing creatives — abstraction pays. Introduce POP when variants or test seams demand it. At BookMyShow ads scale, variants justified the pipeline — I still don’t invent fill-rate percentages.”

---

Next: [02-associated-types-erasure.md](02-associated-types-erasure.md)
