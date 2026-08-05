# Audio script — Sample 01 — POP and generics (Q&A)
> Listen-only sample Q&A from `01-pop-and-generics.md`. Spoken answers and follow-ups.

## §0 Q1. What is protocol-oriented programming (POP)?

Next. Q1. What is protocol-oriented programming (POP)? Answer. P O P means designing around capabilities — protocols and extensions — instead of growing a deep inheritance tree. Types opt into what they can do: renderable, trackable, playback-controllable. Structs and classes can both adopt protocols. On a revenue U I path, that lets new ad types plug into one pipeline instead of forking an AdView subclass hierarchy. Follow-ups. One-sentence contrast with inheritance?: Inheritance models what you are. Protocols model what you can do.. Does P O P mean never use classes?: No. UIKit views and HeroWidget still need class identity. Put capabilities on protocols.. Ads example of composition?: A video hero may need render + track + playback. An image tile may only need render + track..

## §1 Q2. Why do inheritance trees hurt at scale for ads?

Next. Q2. Why do inheritance trees hurt at scale for ads? Answer. Classic UIKit tutorials grow UIView → AdView → ImageAdView / VideoAdView / …. At scale the shared base gets fat, everything becomes a class even when data could be a value, tests must mock deep trees, a new creative forks the hierarchy, and Swift classes only get one parent while real ads need several abilities at once. Follow-ups. What is a “fragile base class”?: Shared configure grows into god-methods; every change risks every subclass.. Why “multiple is-a” fails?: Single class inheritance cannot express “I am renderable and trackable and playable” cleanly.. When is inheritance still OK?: When UIKit requires a subclass (UIView, UIViewController) or shared identity / ObjC runtime..

## §2 Q3. What is the difference between protocol requirements and extension defaults?

Next. Q3. What is the difference between protocol requirements and extension defaults? Answer. Methods listed inside the protocol body are requirements — part of the contract; call sites usually dispatch them through a witness table. Methods added only in an extension are convenience. They may not override the way you expect when the variable is typed as the protocol. If a creative must customize a method, put it in the protocol body as a requirement. Follow-ups. Classic trap?: wave() only in an extension — through any Greeter you get the extension default, not Person.wave.. Fix?: Declare wave() as a protocol requirement if polymorphic behavior matters.. When are extension defaults fine?: Shared identical behavior (for example the same default click log) that nobody needs to override through the existential..

## §3 Q4. What is protocol composition?

Next. Q4. What is protocol composition? Answer. The & means “and.” AdRenderable & AdTrackable & PlaybackControllable means the type must satisfy all three contracts. That is not multiple inheritance. It is multiple capabilities. Typealiases like HeroAd keep whiteboard signatures readable. Follow-ups. Can image ads skip playback?: Yes — only require the capabilities they need. Do not force video APIs onto image creatives.. Class-bound (AnyObject) when?: When you need weak delegates or class identity.. Prefer protocols for models?: Prefer value conformers for models; class conformers are fine for UIKit views..

## §4 Q5. What is a generic parameter, and why beat `Any` on a revenue path?

Next. Q5. What is a generic parameter, and why beat `Any` on a revenue path? Answer. A generic parameter is a blank the caller fills in — Renderer<ImageCreative. Add constraints when you need methods: Creative: AdTrackable. Cast ladders with Any hide bugs until a new creative ships. Generics push mismatches to compile time. That matters on a revenue ads path. Follow-ups. Who chooses T?: The caller.. What does where buy you?: Readable constraints when rules grow — especially with associated types.. Provenance care?: You may say the pipeline was type-safe (Verified S 1). Do not invent fill-rate percentages..

## §5 Q6. What is `some` vs `any` (first cut)?

Next. Q6. What is `some` vs `any` (first cut)? Answer. some P is an opaque type — one real concrete type, hidden from the caller (“there is a real type; you just cannot name it”). any P is an existential — a box that can hold different adopters, with limits. Generics and some specialize better. any uses a witness table / existential container and may block operations that need Self or associated types. Follow-ups. SwiftUI energy?: some View hides one concrete view type.. When prefer any?: Heterogeneous stored values — or use a type eraser.. Hot bind preference?: Generics on the concrete type, or some..

## §6 Q7. When is class inheritance still the right tool?

Next. Q7. When is class inheritance still the right tool? Answer. P O P is a tool, not a religion. Still subclass when UIKit requires it, when you need shared identity / ObjC runtime, or when the framework owns the base type. Senior pattern: subclass UIKit for the view, put capabilities on protocols. HeroWidget can be a real view with lifecycle and sit behind a playback protocol. Follow-ups. Interview trap?: “P O P means never use classes.” HeroWidget is a class; capabilities are protocols.. Examples of required subclasses?: UIView, UIViewController, UICollectionViewCell.. Next sample file?: Associated types under pressure and type erasure..

## §7 Q8. What should you say after foundations, before the deep dive?

Next. Q8. What should you say after foundations, before the deep dive? Answer. You should be able to: explain P O P with a capability example; contrast “caller picks T” vs “adopter picks associated type”; say why [AdRenderable] is awkward when associated types differ; give one reason generics beat Any casts; name when you still subclass UIView. Follow-ups. Witness table in one line?: Runtime dispatch table for protocol requirements.. Existential in one line?: any P — a value that can hold different adopters.. Opaque type in one line?: some P — one hidden concrete type.. Next: 02-associated-types-erasure.md.
