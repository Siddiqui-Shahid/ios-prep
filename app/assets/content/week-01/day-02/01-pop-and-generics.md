# Sample 01 — POP and generics (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is protocol-oriented programming (POP)?

**Points to:** [Foundations · §0 Main guiding idea](../01-foundations.md#0-main-guiding-idea) · [Foundations · §1 Why POP exists](../01-foundations.md#1-why-pop-exists)

**Answer:**

> POP means designing around **capabilities** — protocols and extensions — instead of growing a deep inheritance tree. Types opt into what they can do: renderable, trackable, playback-controllable. Structs and classes can both adopt protocols. On a revenue UI path, that lets new ad types plug into one pipeline instead of forking an `AdView` subclass hierarchy.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence contrast with inheritance? | Inheritance models *what you are*. Protocols model *what you can do*. |
| Does POP mean never use classes? | No. UIKit views and HeroWidget still need class identity. Put *capabilities* on protocols. |
| Ads example of composition? | A video hero may need render + track + playback. An image tile may only need render + track. |

---

### Q2. Why do inheritance trees hurt at scale for ads?

**Points to:** [Foundations · §1.1 The inheritance trap](../01-foundations.md#11-the-inheritance-trap)

**Answer:**

> Classic UIKit tutorials grow `UIView → AdView → ImageAdView / VideoAdView / …`. At scale the shared base gets fat, everything becomes a class even when data could be a value, tests must mock deep trees, a new creative forks the hierarchy, and Swift classes only get one parent while real ads need several abilities at once.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is a “fragile base class”? | Shared `configure` grows into god-methods; every change risks every subclass. |
| Why “multiple is-a” fails? | Single class inheritance cannot express “I am renderable and trackable and playable” cleanly. |
| When is inheritance still OK? | When UIKit requires a subclass (`UIView`, `UIViewController`) or shared identity / ObjC runtime. |

---

### Q3. What is the difference between protocol requirements and extension defaults?

**Points to:** [Foundations · §2.1 Requirements vs extension defaults](../01-foundations.md#21-requirements-vs-extension-defaults) · [Deep dive · §3.2 Extension default trap](../02-deep-dive.md#32-the-extension-default-trap-classic-interview)

**Answer:**

> Methods listed **inside the protocol body** are requirements — part of the contract; call sites usually dispatch them through a witness table. Methods added **only in an extension** are convenience. They may *not* override the way you expect when the variable is typed as the protocol. If a creative must customize a method, put it in the protocol body as a requirement.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Classic trap? | `wave()` only in an extension — through `any Greeter` you get the extension default, not `Person.wave`. |
| Fix? | Declare `wave()` as a protocol requirement if polymorphic behavior matters. |
| When are extension defaults fine? | Shared identical behavior (for example the same default click log) that nobody needs to override through the existential. |

---

### Q4. What is protocol composition?

**Points to:** [Foundations · §2.2 Protocol composition](../01-foundations.md#22-protocol-composition)

**Answer:**

> The `&` means “and.” `AdRenderable & AdTrackable & PlaybackControllable` means the type must satisfy all three contracts. That is not multiple inheritance. It is multiple capabilities. Typealiases like `HeroAd` keep whiteboard signatures readable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Can image ads skip playback? | Yes — only require the capabilities they need. Do not force video APIs onto image creatives. |
| Class-bound (`AnyObject`) when? | When you need `weak` delegates or class identity. |
| Prefer protocols for models? | Prefer value conformers for models; class conformers are fine for UIKit views. |

---

### Q5. What is a generic parameter, and why beat `Any` on a revenue path?

**Points to:** [Foundations · §3 Generics](../01-foundations.md#3-generics--the-caller-chooses-the-type)

**Answer:**

> A **generic parameter** is a blank the **caller** fills in — `Renderer<ImageCreative>`. Add constraints when you need methods: `Creative: AdTrackable`. Cast ladders with `Any` hide bugs until a new creative ships. Generics push mismatches to compile time. That matters on a revenue ads path.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who chooses `T`? | The **caller**. |
| What does `where` buy you? | Readable constraints when rules grow — especially with associated types. |
| Provenance care? | You may say the pipeline was type-safe (Verified S1). Do **not** invent fill-rate percentages. |

---

### Q6. What is `some` vs `any` (first cut)?

**Points to:** [Foundations · §5 some vs any](../01-foundations.md#5-some-vs-any-first-cut) · [Deep dive · §4 some vs any deep](../02-deep-dive.md#4-some-vs-any-deep)

**Answer:**

> `some P` is an opaque type — one real concrete type, hidden from the caller (“there is a real type; you just cannot name it”). `any P` is an existential — a box that can hold different adopters, with limits. Generics and `some` specialize better. `any` uses a witness table / existential container and may block operations that need `Self` or associated types.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SwiftUI energy? | `some View` hides one concrete view type. |
| When prefer `any`? | Heterogeneous stored values — or use a type eraser. |
| Hot bind preference? | Generics on the concrete type, or `some`. |

---

### Q7. When is class inheritance still the right tool?

**Points to:** [Foundations · §8 When inheritance is still OK](../01-foundations.md#8-when-inheritance-is-still-ok) · [Deep dive · §7 Mixing POP with UIKit](../02-deep-dive.md#7-mixing-pop-with-uikit-identity-herowidget)

**Answer:**

> POP is a tool, not a religion. Still subclass when UIKit requires it, when you need shared identity / ObjC runtime, or when the framework owns the base type. Senior pattern: subclass UIKit for the **view**, put **capabilities** on protocols. HeroWidget can be a real view with lifecycle *and* sit behind a playback protocol.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview trap? | “POP means never use classes.” HeroWidget is a class; capabilities are protocols. |
| Examples of required subclasses? | `UIView`, `UIViewController`, `UICollectionViewCell`. |
| Next sample file? | Associated types under pressure and type erasure. |

---

### Q8. What should you say after foundations, before the deep dive?

**Points to:** [Foundations · §11 Self-check](../01-foundations.md#11-self-check-before-deep-dive) · [Foundations · §9 Glossary](../01-foundations.md#9-glossary-pin)

**Answer:**

> You should be able to: explain POP with a capability example; contrast “caller picks `T`” vs “adopter picks associated type”; say why `[AdRenderable]` is awkward when associated types differ; give one reason generics beat `Any` casts; name when you still subclass `UIView`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Witness table in one line? | Runtime dispatch table for protocol requirements. |
| Existential in one line? | `any P` — a value that can hold different adopters. |
| Opaque type in one line? | `some P` — one hidden concrete type. |

---

Next: [02-associated-types-erasure.md](02-associated-types-erasure.md)
