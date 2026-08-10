# Audio script — Sample 07 — Revision Q&A (day-01) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Struct vs class — when do you choose each? `(30–45s)`

Next. Q1. Struct vs class — when do you choose each? `(30–45s)` Answer. “Structs and enums have value semantics — assignment gives you an independent copy, so mutating one variable doesn’t surprise another. Classes have reference semantics — multiple names can point at the same instance, so mutation is shared. I default to structs for models and DTOs, and reach for classes when I need identity, UIKit objects, or Objective-C interop. On the BookMyShow ads side, keeping render models value-friendly fits a type-safe pipeline so accidental shared mutation doesn’t corrupt revenue U I.” Follow-ups. When is a class mandatory?: “UIKit or AppKit objects, Objective-C interop, or intentional shared identity that value types can’t express.”. What if a struct contains a class property?: “Assigning the struct copies the reference, so both copies share the same class instance and its mutations.”. ViewModel — struct or class / MainActor?: “Usually a class or MainActor reference type so screens share one identity and observation stays stable under mutation.”.

## §1 Q2. What is copy-on-write? `(30–45s)`

Next. Q2. What is copy-on-write? `(30–45s)` Answer. “Copy-on-write means value-typed collections like Array can share their storage after assignment so the assign is cheap. When you mutate, the runtime checks whether that buffer is uniquely referenced. If it is, it mutates in place; if not, it copies the buffer first and then mutates. That preserves value semantics without paying a full element copy on every assignment.” Follow-ups. Does let a = b on arrays copy elements immediately?: “No — arrays share storage until a mutation forces a copy when the buffer isn’t uniquely referenced.”. How would you implement copy on write on your own type?: “Store data in a reference box and call isKnownUniquelyReferenced before mutating; copy the box if shared.”. Instruments when copy on write thrash happens?: “Allocations and Time Profiler show repeated large buffer copies on mutate-heavy loops that keep sharing.”.

## §2 Q3. Why prefer enums over booleans for UI state? `(30–45s)`

Next. Q3. Why prefer enums over booleans for UI state? `(30–45s)` Answer. “Boolean flags like isLoading plus optional data and error can represent illegal combinations — loading and failed at once. An associated-value enum makes each mode explicit and attaches only the data that mode needs. Switches stay exhaustive when you add cases. For the payment processing popup, I’d model processing, success, failure, and timeout as cases so the U I can’t enter a nonsense state.” Follow-ups. How do you map Result into U I state?: “Map success and failure into loaded and failed — never parallel booleans.”. How do you version new backend modes?: “Add an exhaustive case or unknown fallback, update switches, ship U I intentionally — or @unknown default for system enums you don’t own.”. Transition function vs scattering ifs?: “Centralize reduce(state, event) so illegal combinations can’t be set via scattered flag flips.”.

## §3 Q4. What is an actor at a high level? `(30–45s)`

Next. Q4. What is an actor at a high level? `(30–45s)` Answer. “An actor is a reference type whose mutable state is isolated. You interact with it asynchronously — typically with await — and the system serializes access so you don’t get data races on that state. At BookMyShow we used G C D serial queues around shared dictionaries for the same kind of problem; for greenfield code I’d evaluate a Swift actor as the language-native equivalent. Awareness: after await, state may change — reentrancy.” Follow-ups. Are actors value or reference types?: “Reference types with isolated mutable state — assignment shares the instance, access is serialized.”. Actor vs MainActor ViewModel?: “A general actor isolates its own state; MainActor pins work to the main actor for U I-bound models.”. Reentrancy in one line?: “While an actor method awaits, other tasks can enter — re-validate after resume.”.

## §4 Q5. Value type containing a class — what happens on copy? `(45s)`

Next. Q5. Value type containing a class — what happens on copy? `(45s)` Answer. “When you assign a struct, Swift copies its stored properties. Value-typed fields become independent; class-typed fields copy the reference, so both structs point at the same object. Mutating that nested object through either copy is visible to both. If you need a deep copy, you have to implement it explicitly — value semantics don’t recursively deep-copy the graph.” Follow-ups. UIKit cell-model example?: “A struct cell model holding a shared image cache object mutates cache state visible to every copied model.”. How do you redesign?: “Keep value models pure data and pass services separately, or deep-copy when shared mutation must not leak.”. copy on write array inside a class property?: “The class is shared by reference; the array still COWs on mutate, but every holder of the class sees the same array storage.”.

## §5 Q6. `===` vs `==`? `(30s)`

Next. Q6. `===` vs `==`? `(30s)` Answer. “Double equals asks whether two values are equal according to Equatable. Triple equals asks whether two class instances are the exact same object. Structs don’t have triple equals because they aren’t identities — you compare their values. I use identity for things like the same view controller instance, and equality for model data.” Follow-ups. ViewModels in tests?: “Assert on published state equality or snapshots; use identity only when proving the same instance is wired.”. Hashing a class by identity vs fields?: “Identity hashing treats distinct instances as different; field hashing can collide logically equal but separate objects.”. Equatable enums with associated Error?: “Error isn’t Equatable by default — compare by type or code, or erase to a domain error.”.

## §6 Q7. When would you use a class for a model? `(45s)`

Next. Q7. When would you use a class for a model? `(45s)` Answer. “I’d use a class for a model when shared identity is intentional — one session object many screens must see mutate — or when UIKit or ObjC interop forces it. For ordinary DTOs I still prefer structs. If the real need is safe concurrent mutation of shared storage, I’d consider an actor rather than an unsynchronized class.” Follow-ups. Could an actor replace that class?: “Yes for shared mutable storage needing isolation — Design: actor SafeDict is the greenfield shape versus a bare class.”. How do you test shared mutable models?: “Drive them through their synchronized A P I — queue or actor — assert via async tests, avoid raw storage.”. Reference cycles?: “Observers and closures must capture weakly; delegates should be weak class-bound.”.

## §7 Q8. Recursive enums — why `indirect`? `(45s)`

Next. Q8. Recursive enums — why `indirect`? `(45s)` Answer. “Swift enums have a size the compiler needs to know. If a case contains another value of the same enum, that would be infinite size unless you introduce indirection. Marking the enum or case indirect stores the associated value behind a reference so the layout stays finite. You see this with nested comment threads or tree-shaped feed nodes.” Follow-ups. Whole enum vs one case?: “Whole-enum indirect boxes every case; per-case indirect only boxes the recursive associated values you need.”. Compare to a class-based tree?: “Classes give identity and shared mutation; recursive enums give value trees with explicit copy and equality.”. Equatable synthesis?: “Works if associated values are Equatable — deep trees compare recursively through the indirection.”.

## §8 Q9. Are actors value or reference types? `(30s)`

Next. Q9. Are actors value or reference types? `(30s)` Answer. “Actors are reference types — assigning an actor shares the same instance — but unlike a plain class, their mutable state is isolated. You don’t freely mutate from arbitrary threads; you go through the actor’s interface, usually with await.” Follow-ups. Two tasks call the same method?: “Calls are serialized on the actor — one runs, the other waits — so isolated state isn’t data-raced.”. Can actors inherit from classes freely?: “Actors don’t participate in open class inheritance the way NSObject subclasses do — prefer composition and protocols.”. Actor vs lock vs serial queue?: “Actors compose with async/await; serial queues match BookMyShow synchronised dictionaries; locks are low-level and deadlock-prone.”.

## §9 Q10. Explain COW in one sentence to a junior? `(30s)`

Next. Q10. Explain COW in one sentence to a junior? `(30s)` Answer. “Arrays act like values, but they cheaply share memory until somebody writes — then they copy if they’re not the only owner. So var b = a is cheap, and b.append won’t change a.” Follow-ups. Which stdlib types use copy on write?: “Array, Dictionary, Set, String, and related collections share storage until mutation requires a unique buffer.”. Why doesn’t every struct get copy on write?: “copy on write needs a reference-counted buffer and uniqueness checks; plain stored properties just copy bit-for-bit.”. Implement ensureUnique?: “If not uniquely referenced, replace the box with a deep-copied storage instance before writing.”.

## §10 Q11. `let` on a class vs `let` on a struct? `(30–45s)`

Next. Q11. `let` on a class vs `let` on a struct? `(30–45s)` Answer. “Let means the name can’t be reassigned. For a struct, that also blocks mutating properties because mutation is really replacing the value. For a class, let only fixes which instance you point at — you can still change the instance’s properties. That’s why let doesn’t mean immutable object for reference types.” Follow-ups. How do you make a class’s properties immutable?: “Declare stored properties as let, or expose only private(set) or read-only computed surfaces.”. private(set) on structs vs classes?: “Same visibility; on structs outsiders still need a var binding to mutate via methods; on classes a let instance can still mutate settable props.”. Actors and mutation from outside?: “Outside code can’t freely mutate isolated state — it must go through actor methods, usually with await.”.

## §11 Q12. How do you explain preferring values for ads/listing models? `(45s)`

Next. Q12. How do you explain preferring values for ads/listing models? `(45s)` Answer. “For ad and listing render data I prefer value semantics so one surface’s mutation doesn’t leak into another. That sits well with the type-safe ads pipeline we built with protocols and generics. Where identity and lifecycle matter — like HeroWidget pause and play tied to visibility — that’s a reference-type concern. So values for data, classes for identity boundaries.” Follow-ups. How do generics fit that pipeline?: “BookMyShow Ads pipeline used protocol plus generic installers so each creative stays typed without Any downcasts.”. What breaks if an ad DTO secretly holds a shared cache?: “Value copies appear independent but share cache mutation — one surface’s write corrupts another’s render path.”. Testing strategy?: “Assert pure value transforms in isolation; inject fake services instead of process-wide singletons.”. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “Struct vs class — when do you choose each?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Struct vs class — when do you choose each?” — how do you answer without jargon? `(60–90s)` Answer. “Structs and enums have value semantics — assignment gives you an independent copy, so mutating one variable doesn’t surprise another. Classes have reference semantics — multiple names can point at the same instance, so mutation is shared. I default to structs for models and DTOs, and reach for classes when I need identity, UIKit objects, or Objective-C interop. On the BookMyShow ads side, keeping render models value-friendly fits a type-safe pipeline so accidental shared mutation doesn’t corrupt revenue U I.”. Follow-ups. What concept is this really?: Struct vs class — when do you choose each. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “What is copy-on-write” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “What is copy-on-write” just broke under load. What do you check first? `(60–90s)` Answer. “Copy-on-write means value-typed collections like Array can share their storage after assignment so the assign is cheap. When you mutate, the runtime checks whether that buffer is uniquely referenced. If it is, it mutates in place; if not, it copies the buffer first and then mutates. That preserves value semantics without paying a full element copy on every assignment.”. Follow-ups. What concept is this really?: What is copy-on-write. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Why prefer enums over booleans for UI state”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Why prefer enums over booleans for UI state”. How do you diagnose? `(60–90s)` Answer. “Boolean flags like isLoading plus optional data and error can represent illegal combinations — loading and failed at once. An associated-value enum makes each mode explicit and attaches only the data that mode needs. Switches stay exhaustive when you add cases. For the payment processing popup, I’d model processing, success, failure, and timeout as cases so the U I can’t enter a nonsense state.”. Follow-ups. What concept is this really?: Why prefer enums over booleans for U I state. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “What is an actor at a high level”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “What is an actor at a high level”. What do you say and what fix do you propose? `(60–90s)` Answer. “An actor is a reference type whose mutable state is isolated. You interact with it asynchronously — typically with await — and the system serializes access so you don’t get data races on that state. At BookMyShow we used G C D serial queues around shared dictionaries for the same kind of problem; for greenfield code I’d evaluate a Swift actor as the language-native equivalent. Awareness: after await, state may change — reentrancy.”. Follow-ups. What concept is this really?: What is an actor at a high level. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Value type containing a class — what happens on copy”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Value type containing a class — what happens on copy”? `(60–90s)` Answer. “When you assign a struct, Swift copies its stored properties. Value-typed fields become independent; class-typed fields copy the reference, so both structs point at the same object. Mutating that nested object through either copy is visible to both. If you need a deep copy, you have to implement it explicitly — value semantics don’t recursively deep-copy the graph.”. Follow-ups. What concept is this really?: Value type containing a class — what happens on copy. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “`===` vs `==`” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “`===` vs `==`” and how you’d correct it? `(60–90s)` Answer. “Double equals asks whether two values are equal according to Equatable. Triple equals asks whether two class instances are the exact same object. Structs don’t have triple equals because they aren’t identities — you compare their values. I use identity for things like the same view controller instance, and equality for model data.”. Follow-ups. What concept is this really?: === vs ==. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “When would you use a class for a model?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “When would you use a class for a model?” — how do you answer without jargon? `(60–90s)` Answer. “I’d use a class for a model when shared identity is intentional — one session object many screens must see mutate — or when UIKit or ObjC interop forces it. For ordinary DTOs I still prefer structs. If the real need is safe concurrent mutation of shared storage, I’d consider an actor rather than an unsynchronized class.”. Follow-ups. What concept is this really?: When would you use a class for a model. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Recursive enums — why `indirect`” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Recursive enums — why `indirect`” just broke under load. What do you check first? `(60–90s)` Answer. “Swift enums have a size the compiler needs to know. If a case contains another value of the same enum, that would be infinite size unless you introduce indirection. Marking the enum or case indirect stores the associated value behind a reference so the layout stays finite. You see this with nested comment threads or tree-shaped feed nodes.”. Follow-ups. What concept is this really?: Recursive enums — why indirect. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. Does `let box` make a class immutable? `(90s)`

Next. T1. Does `let box` make a class immutable? `(90s)` Answer. “No. Let fixes the binding — you can’t reassign box to another instance. The object’s var properties can still change. People confuse binding mutability with value versus reference semantics. For true immutability on a class, make the stored properties let, or expose a read-only surface. Structs are different: let on a struct also blocks property mutation because mutation replaces self. Interview one-liner: let is not immutable object for reference types.” Follow-ups. Probe deeper?: “Mutating methods on structs require a var binding — same family of ‘mutation replaces the value.’”.

## §21 T2. Struct with nested class — cache pollution after copy? `(90s)`

Next. T2. Struct with nested class — cache pollution after copy? `(90s)` swift class ImageCache { var bytes = Data } struct CellModel { var title: String; var cache: ImageCache } var m1 = CellModel(title: "A", cache: ImageCache) var m2 = m1 m2.title = "B" m2.cache.bytes = Data([1]) Answer. “Title is independent — m1 stays A. Cache is shared — m1 sees the bytes write. Value semantics copy stored properties; references stay shared. That’s fake value type confidence. Fix: keep DTOs pure data, inject caches at the boundary, or deep-copy when you must. Same trap as nesting a Metrics logger inside an AdCellModel — BookMyShow Ads pipeline mindset is value-friendly models, not hidden shared services in every row.” Follow-ups. Probe deeper?: “Closures capturing class self are the same nested-ref family.”.

## §22 T3. ArrayBox wrapper kills independence? `(90s)`

Next. T3. ArrayBox wrapper kills independence? `(90s)` swift final class ArrayBox { var values: [Int]; init(_ v: [Int]) { values = v } } let box1 = ArrayBox([1, 2]) let box2 = box1 box2.values.append(3) Answer. “Both boxes show [1,2,3]. The Array still has copy on write relative to other Array values, but two names pointing at one class share the same property path. Interviewers use this to catch ‘arrays are values so aliases are independent’ without noticing the wrapper. Don’t wrap collections in classes for safety without thinking — you reintroduce shared mutation across U I aliases. Contrast with plain var b = a on Array, where mutate copies when not unique.” Follow-ups. Probe deeper?: “Handmade COWList restores independence via isKnownUniquelyReferenced — see COWDemo.”.

## §23 T4. Mutating hashed fields while in a Set? `(90–120s)`

Next. T4. Mutating hashed fields while in a Set? `(90–120s)` swift final class Seat: Hashable { let id: String var isSelected: Bool static func == (l: Seat, r: Seat) - Bool { l.id == r.id } func hash(into hasher: inout Hasher) { hasher.combine(id); hasher.combine(isSelected) } } Answer. “If Seat sits in a Set and you flip isSelected, you’ve mutated a hash input while the collection owns the object — lost entries, failed contains, undefined behavior territory. Hash stable identity only — id — or use ObjectIdentifier when you mean same instance. ObjectIdentifier is identity; ID-based Hashable is business key across instances. Pick intentionally. Selection state must not participate in hash(into:).” Follow-ups. Probe deeper?: “Symptom in production: object ‘disappears’ from the Set after a U I toggle.”.

## §24 T5. Recursive tree without `indirect` — what breaks? `(90s)`

Next. T5. Recursive tree without `indirect` — what breaks? `(90s)` Answer. “Enums need a finite size. A case that embeds the same enum recursively would be infinite layout — it won’t compile. Indirect stores that associated value behind a reference so the layout stays finite. Use it for comment threads, nested feed sections, FeedNode trees. Whole-enum indirect versus per-case indirect is a trade-off on how much you box. Compared to a class tree: enums give value semantics and exhaustiveness; classes give identity and shared mutation.” Follow-ups. Probe deeper?: “section(title:children:) for nested listing rows is the interview sketch.”.

## §25 T6. Is `Result` alone enough for ViewModel state? `(90s)`

Next. T6. Is `Result` alone enough for ViewModel state? `(90s)` Answer. “No. Result models a one-shot success or failure. Screens need idle and loading. If you bolt booleans onto Result, you’re back to impossible combinations — loading plus success. Map Result at the networking edge into LoadState or a screen enum. For payment U I go further: processing, timedOut, success(bookingID) — Design: payment status pattern on top of the BookMyShow payment processing-status popup product intent. Don’t claim the shipped popup was that exact Swift enum unless it’s personally true.” Follow-ups. Probe deeper?: “Versioned S D U I payloads need unknown(type:raw:) so new modes don’t crash the switch.”.

## §26 T7. “Every ViewModel should be an actor” — your reply? `(90–120s)`

Next. T7. “Every ViewModel should be an actor” — your reply? `(90–120s)` Answer. “I’d push back. U I must update on the main actor. The common pattern is a MainActor class ViewModel with published state. A custom actor for every screen adds await noise at every bind site. Isolate the real shared mutable core — caches, in-flight maps — and keep U I-facing models on MainActor. Actors prevent data races on storage; they don’t magically remove reentrancy bugs across await. Day 05 deepens that — today the senior signal is selective isolation, not actor everywhere.” Follow-ups. Probe deeper?: “Heavy decode on a MainActor ViewModel still janks U I — offload, await back.”.

## §27 T8. Actor vs GCD serial queue — when not to migrate? `(90–120s)`

Next. T8. Actor vs GCD serial queue — when not to migrate? `(90–120s)` Answer. “BookMyShow synchronised dictionaries shipped as a serial-queue boundary with a closed A P I — proven on that path. An actor is the language-native equivalent I’d evaluate for greenfield. I would not big-bang rewrite a stable module next sprint for fashion. Strangler at boundaries. New pitfall to train: reentrancy after await, not only queue.sync deadlock. And I won’t hang app-wide crash-free percent on either story alone.” Follow-ups. Probe deeper?: “Same get/set surface idea — different enforcement. Label Design: actor SafeDict when speaking redesign.”.

## §28 T9. Honest Ads / payment claims vs invented metrics? `(90–120s)`

Next. T9. Honest Ads / payment claims vs invented metrics? `(90–120s)` Answer. “For Ads pipeline plus HeroWidget I claim type-safe protocols and generics, value-friendly model preference, and lifecycle identity for video — not invented fill-rate or revenue deltas. For payment processing-status popup I claim explicit processing, success, failure, timeout messaging for silent-waiting checkout — not a fabricated drop-off percent. Design patterns — enum machine, actor SafeDict — are how I would apply it, spoken as design. I also don’t combine unrelated stories to invent a bigger org metric. Match the question to one honest named case.” Follow-ups. Probe deeper?: “If they press for numbers I don’t have: stay qualitative and offer how I’d measure next time.”.

## §29 T10. Overlapping `inout` / exclusivity — and mutating on `let`? `(90s)`

Next. T10. Overlapping `inout` / exclusivity — and mutating on `let`? `(90s)` Answer. “Swift’s exclusivity rules forbid overlapping mutable access to the same value. That’s why inout feels strict — while a value is borrowed for mutation, overlapping reads or writes of that storage are illegal. Don’t fight the compiler with unsafe tricks; restructure so one exclusive write owns the window. Related: a mutating method may replace self, so it only compiles on a var binding — mutating on let is a hard error. Together: value semantics stay predictable because mutation is exclusive reassignment, not shared identity magic.” Follow-ups. Probe deeper?: “Large non-copy on write structs still pay bitwise copy on assign — exclusivity doesn’t make fat values free; measure hot paths.”.

## §30 T11. Does this compile? Is `box` “immutable”? `(90–120s)`

Next. T11. Does this compile? Is `box` “immutable”? `(90–120s)` Answer. “It compiles. let fixes the binding — you can’t do box = Box(2). The object’s properties can still change. Immutability for a class means let properties (or read-only surfaces), not let on the instance name. ---.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §31 T12. What is `m1.title`? What does `m1.cache.bytes` contain? `(90–120s)`

Next. T12. What is `m1.title`? What does `m1.cache.bytes` contain? `(90–120s)` Answer. “m1.title is still "A". m1.cache.bytes is Data([1]) — the nested class was shared. Value copy is shallow for references. ---.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §32 T13. What prints? Did “returning a function” give you an independent snapshot? `(90–120s)`

Next. T13. What prints? Did “returning a function” give you an independent snapshot? `(90–120s)` Answer. “Prints "y". The closure captured self by reference. “I returned a value-ish function” does not freeze class state. --- Next: 02-cow-enums.md.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §33 T14. What are `box1.values` and `box2.values`? `(90–120s)`

Next. T14. What are `box1.values` and `box2.values`? `(90–120s)` Answer. “Both [1,2,3]. The box is shared identity. Inner Array copy on write does not make two names pointing at one class independent. ---.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
