# Audio script — Sample 03 — Actors and classes (Q&A)
> Listen-only sample Q&A from `03-actors-classes.md`. Spoken answers and follow-ups.

## §0 Q1. When is a class the right tool?

Next. Q1. When is a class the right tool? Answer. “Use a class when you need identity — the same service instance shared across the app, UIKit or AppKit objects, triple-equals checks, or ObjC and KVO runtime requirements. Otherwise prefer values plus a single owner — ViewModel, store. ‘One session object everyone must see updates on’ is the rare legitimate class model case.” Follow-ups. Shared APIClient?: “Class — one identity, one connection pool or config.”. Listing row render data?: “Struct — copy semantics unless you have a proven identity need.”. HeroWidget pause/play?: “Class concern — lifecycle and visibility tied to a reference-type surface.”.

## §1 Q2. What is an actor in one sentence?

Next. Q2. What is an actor in one sentence? Answer. “An actor is a reference type whose mutable state is isolated — you talk to it with await, and the runtime serializes access so concurrent tasks cannot data-race on its storage. Enough for Day 01: isolated reference type; await to touch state; prevents data races. Day 05 goes deeper on hops and reentrancy — today, awareness: after await, state may have changed.” Follow-ups. Minimal A P I shape?: “await counter.increment — cross-actor calls suspend until the actor can run.”. Do actors replace all classes?: “No — UIKit stays class; actors isolate specific shared mutable cores.”. What not to say today?: “‘Every ViewModel should be an actor’ — that’s a trap.”.

## §2 Q3. How is an actor different from a plain class?

Next. Q3. How is an actor different from a plain class? Answer. “Both are reference types. A class lets any task mutate shared properties if you forget synchronization — data races are your bug. An actor makes isolation part of the type system: mutable state is only accessible on the actor’s executor, usually via await. Inheritance is limited compared to classes.” Follow-ups. Call site difference?: “Class: direct calls. Actor: often await on mutating or isolated access.”. Same heap identity idea?: “Yes — actors are reference types; you don’t copy them like structs.”. If I already use a lock?: “Actor is the language-native version of ‘one serial gate around this state.’”.

## §3 Q4. How does an actor relate to a GCD serial queue?

Next. Q4. How does an actor relate to a GCD serial queue? Answer. “At BookMyShow, shared mutable maps were protected with G C D serial queues — BookMyShow synchronised dictionaries. Soft interview line: where you serialized dictionary access with a serial queue, a Swift actor is the language-native equivalent you’d evaluate for new code — same A P I surface idea, compile-time isolation instead of convention. Design: actor SafeDict is greenfield redesign; do not claim you rewrote production unless you did. And don’t migrate a stable queue module just for fashion — strangler at boundaries.” Follow-ups. Serial queue downside?: “Easy to misuse sync and deadlock; no compile-time isolation.”. Actor downside?: “Requires concurrency adoption; await hops; reentrancy across await; learning curve.”. When not to migrate?: “Stable closed A P I, proven under load, team still on mixed G C D — leave it; actor for greenfield.”.

## §4 Q5. Why not make every ViewModel an actor?

Next. Q5. Why not make every ViewModel an actor? Answer. “U I must update on the main actor. Common pattern: @MainActor final class SearchViewModel with published state. A custom actor for every VM adds await noise at every bind site. Isolate the shared mutable store — caches, in-flight maps — and keep U I-facing models on MainActor.” Follow-ups. What belongs in an actor?: “Shared map of in-flight requests, session cache mutated from background tasks.”. What stays on MainActor?: “Screen state, SwiftUI bindings, anything the U I reads directly.”. Failure mode?: “Actor on every type → contorted call sites for no gain.”.

## §5 Q6. What is `@MainActor` vs a custom actor?

Next. Q6. What is `@MainActor` vs a custom actor? Answer. “MainActor is an isolation domain for main-thread and U I work — related to actors but aimed at U I affinity, not a general-purpose shared store. A custom actor serializes its own state on its executor. Use MainActor for ViewModels and U I types; use a dedicated actor when background tasks share mutable state that must not race.” Follow-ups. Can a class be MainActor?: “Yes — typical for U I ViewModels.”. Heavy work on MainActor VM?: “Don’t block main — offload work, hop back to publish state.”. Reentrancy awareness?: “During await, other actor work may run — re-check state after resume. Details deepen on Day 05.”.

## §6 Q7. Actor reentrancy — what must you say on Day 01?

Next. Q7. Actor reentrancy — what must you say on Day 01? Answer. “Actors prevent data races on isolated storage, but they are reentrant at await. While your method is suspended, another task can enter the same actor and change fields. No data race — still a logic bug if you trust pre-await snapshots blindly. Awareness today; wallet and cache deep dives on Day 05.” Follow-ups. One phrase?: “Prevents data races; reentrant at await — re-validate.”. Fix mindset?: “Re-read state after await; keep mutations short; single-flight where needed.”.

## §7 Q8. What goes wrong with class instances in a Set or Dictionary key?

Next. Q8. What goes wrong with class instances in a Set or Dictionary key? Answer. “Prefer stable ID-based Hashable, or identity via ObjectIdentifier. Never mutate fields that participate in hash(into:) while the object sits in a collection — undefined behavior, lost entries, weird lookups. If selection state changes, hash on stable id only, not on isSelected. ObjectIdentifier is ‘same instance’; ID-based is ‘same business key across instances.’” Follow-ups. Seat selection example?: “Hash id; toggle isSelected without changing hash input.”. Symptom?: “Object ‘disappears’ from Set after mutation.”. ObjectIdentifier vs ID?: “ObjectIdentifier for true identity; ID when logical equality across instances matters.”.

## §8 Q9. What failure modes should you name in an interview?

Next. Q9. What failure modes should you name in an interview? Answer. “Class used for DTO → flaky U I after ‘copy.’ Nested class in struct → surprising shared side effects. Assume array assign deep-copies → wrong perf or wrong mental model. Boolean U I state → impossible screens. Actor on every type → contorted APIs. Mutating hashed fields in Set → lost objects. Fix mindset: match type to semantics, audit nested refs, isolate the real concurrent core.” Follow-ups. Struct vs class 45s?: “Semantics → mutation → BookMyShow Ads pipeline + HeroWidget: structs for models, classes for UIKit and services.”. copy on write 45s?: “Share → uniqueness check → mutate; trust stdlib in hot paths.”. Enum / actor 45s?: “Impossible states out → exhaustiveness → payment design. Race → isolation → serial-queue prior art.”.

## §9 Q10. Give the 45-second spoken agenda for actor intro?

Next. Q10. Give the 45-second spoken agenda for actor intro? Answer. “Agenda: race → isolation → bridge. An actor is a reference type that serializes access to its state. Call sites await. It’s the modern equivalent of the serial-queue boundary we used around BookMyShow synchronised dictionaries. For greenfield I’d evaluate Design: actor SafeDict — I won’t claim we rewrote production.” Follow-ups. Where next?: 04-production-s1-s7.md. Deepen concurrency?: Day 05 — reentrancy, Sendable, structured cancel..
