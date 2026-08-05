# Audio script — Sample 02 — Associated types, dispatch, type erasure (Q&A)
> Listen-only sample Q&A from `02-associated-types-erasure.md`. Spoken answers and follow-ups.

## §0 Q1. How is an associated type different from a generic parameter?

Next. Q1. How is an associated type different from a generic parameter? Answer. A generic parameter is filled in by the caller — Renderer<ImageCreative. An associated type is filled in by the type that adopts the protocol — ImageAd decides what its ContentView is. Remember: “Generics: I tell the function what T is. Associated types: the adopter decides.” Follow-ups. Mini example?: AdRenderable has associatedtype ContentView; image returns UIImageView, video returns another view type.. Why is that powerful?: Flexible contracts without a shared base class.. Why does it feel hard?: Different adopters pick different shapes — hard to put in one plain array..

## §1 Q2. Why does a “simple protocol variable” stop working with associated types?

Next. Q2. Why does a “simple protocol variable” stop working with associated types? Answer. Each adopter may pick a different Model and ContentView. Three situations get hard: (1) mixed arrays — image and video in one list; (2) returning the protocol from a function — which associated types came back?; (3) storing a property typed only as the protocol — same unknown shape. The language needs a concrete answer or a strategy that hides the differences. Follow-ups. Were these always usable as simple existentials?: Historically no — unlike many plain protocols. Modern Swift improved some cases; you still need a plan.. Four strategies?: Stay generic end-to-end; type-erase at the boundary; constrained any P; closed enum of known creatives.. Decision to memorize?: Stay generic while you can; erase only when you must mix shapes..

## §2 Q3. What do primary associated types buy you?

Next. Q3. What do primary associated types buy you? Answer. Primary associated types let you pin down part of the shape — for example any AdRenderable<HeroModel. That helps some call sites. It does not magically make every protocol with associated types free as an unconstrained [any P] for every operation. Follow-ups. Interview line?: “They fix part of the type shape — they don’t make every associated-type protocol free as a mixed array.”. Still need erasure sometimes?: Yes — when you need one usable type for heterogeneous storage.. Same idea in Apple’s libs?: AnyIterator / AnySequence / AnyPublisher exist because associated types block easy existentials..

## §3 Q4. What is the extension-default dispatch trap?

Next. Q4. What is the extension-default dispatch trap? Answer. Requirements called through an existential go through a witness table (dynamic, protocol-scoped). Extension-only methods may bind to the static type. So let p: any Greeter = Person(); p.wave() can call the extension default, not Person.wave, if wave was never a requirement. Fix: declare methods you need to customize as requirements. Follow-ups. One interview sentence?: “Generics can specialize; existentials use witness tables; extension defaults that aren’t requirements may bind statically.”. Ads angle?: Shared identical track() defaults in an extension are fine; custom per-creative overrides must be requirements.. Static vs witness vs ObjC?: Concrete/final/specialized generics → static; protocol requirements via existential → witness; @objc → message send..

## §4 Q5. What is type erasure, and when do you need it?

Next. Q5. What is type erasure, and when do you need it? Answer. Type erasure builds one concrete box (like AnyAd or AnyTrackable) that can hold different adopters behind a common interface. You need it when you want [AnyAd] but the original protocol has associated types that block a plain mixed array. Prefer generics inside the hot pipeline; erase at module boundaries or heterogeneous lists only. Follow-ups. How does a hand-rolled eraser work?: Store the needed operations as closures / a common output (often upcast views to UIView).. Same idea as Combine?: AnyPublisher hides nested generic publisher types — same motive.. Demo file?: TypeErasureDemo.swift — AnyTrackable wrapping Banner and Interstitial..

## §5 Q6. What costs of type erasure must you say aloud?

Next. Q6. What costs of type erasure must you say aloud? Answer. Name four costs: allocation (closures / box often on the heap), indirection (extra call through a stored function), lost specialization (compiler sees AnyAd, not VideoAd), and a narrower A P I (rich associated types shrink to a common denominator). Erasure is not free abstraction. Follow-ups. Senior rule?: Generics inside; erase at the boundary only.. Trap answer?: “Type erasure is free.”. When still worth it?: True mixed feed, plugin registry, or public boundary that must hide nested generics..

## §6 Q7. Open registry vs closed enum — when each?

Next. Q7. Open registry vs closed enum — when each? Answer. A closed enum of known creatives is simple and exhaustive — but every new type is an app release plus an enum edit. An open protocol registry of factories matches CMS growth better — with an explicit unknown fallback and versioning. Soft bridge to S D U I / backend-driven header (Verified S3 / Applied S3-A1); keep Day 02 centered on S 1. Follow-ups. Pros of enum?: Exhaustive switches; simple mental model.. Cons of open registry?: Unknown types need fallback; versioning matters.. P O P connection?: Factories and capabilities are the same composition instinct..

## §7 Q8. How do `some` and `any` differ once associated types enter?

Next. Q8. How do `some` and `any` differ once associated types enter? Answer. Opaque some still means one concrete type — specialization-friendly, but the caller cannot swap types. Existential any may hold different adopters, yet operations involving Self or associated types may be unavailable unless constrained. When associated types block you, reach for generics, erasure, or constrained any — not wishful [any P] for everything. Follow-ups. Hide one return type?: Prefer some P.. Store different adopters?: any P if allowed, else type eraser.. Max performance in hot bind?: Generics / some on a stable concrete type.. Next: 03-pipeline-and-code.md.
