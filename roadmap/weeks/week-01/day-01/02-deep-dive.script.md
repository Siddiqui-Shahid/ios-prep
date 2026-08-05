# Audio script — 02 Deep Dive
> Listen-only audiobook of `02-deep-dive.md` (Day 01 — Value vs Reference, COW, Enums, Actors Intro). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Senior depth. Assumes 01-foundations.md. Still self-contained. no external reading required.

## §1 1. Value semantics under pressure

Next. 1. Value semantics under pressure.

1.1 What the compiler actually does (mental model) For small structs stored in registers / stack. assignment often is a bitwise copy of stored properties. For larger values, Swift may still copy stored properties eagerly. unless the type implements copy on write internally (std collections do). Your own struct Huge with ten large non-copy on write properties pays copy cost on each assignment /. pass-by-value. Here is a simple Swift example, explained in words. struct ListingRow. var id: String. var title: String. var subtitle: String. var imageURL: U R L?. var badge: String?. What to remember: focus on the idea, not every symbol. Interview small difference: “Structs are always cheaper than classes” is false. Structs win on semantics and often on small data. large graphs may want copy on write wrappers, inout, or a reference boundary. 1.2 inout and exclusivity Here is a simple Swift example, explained in words. func bumpX(_ p: inout Point). p.x + equals 1. var point equals Point(x: 0, y: 0). bumpX(&point) // mutate in place. no conceptual “return a copy”. What to remember: focus on the idea, not every symbol. Swift’s exclusivity rules prevent overlapping access to the same value. That’s part of why value semantics stay predictable. 1.3 Mutation through mutating methods Here is a simple Swift example, explained in words. struct Counter. private(set) var value equals 0. mutating func increment() value + equals 1. var c equals Counter(). c.increment(). What to remember: focus on the idea, not every symbol. A mutating method is allowed to replace self. That only works on var bindings.

## §2 2. Copy-on-write — senior mechanics

Next. 2. Copy-on-write — senior mechanics.

2.1 Uniqueness Stdlib collections store a reference to a buffer object. Before mutating, they ask roughly: “is this buffer uniquely referenced?” Swift exposes a related primitive for your copy. on write types: Here is a simple Swift example, explained in words. final class Storage. var items: [Int]. init(_ items: [Int]) self.items equals items. struct COWList. private var storage: Storage. What to remember: focus on the idea, not every symbol. Teaching point: isKnownUniquelyReferenced only works with class instances. copy on write is “value type façade over a reference-counted buffer.” 2.2 When does A change after mutating. B? Here is a simple Swift example, explained in words. var a equals [1, 2, 3]. var b equals a. b.append(4). // a is still [1,2,3]. copy on write copied for b. What to remember: focus on the idea, not every symbol. Trap answer: “Always shared” or “Always copied on assign.” Correct: shared until a write forces uniqueness. Edge case people forget: Here is a simple Swift example, explained in words. var a equals [1, 2, 3]. var b equals a. a.append(4) // a may copy b keeps old buffer. What to remember: focus on the idea, not every symbol. Same rule. whoever mutates while sharing pays for the copy (if not unique). 2.3 Wrapping arrays in a class kills copy on write across that wrapper Here is a simple Swift. example, explained in words. final class ArrayBox. var values: [Int]. init(_ values: [Int]) self.values equals values. let box1 equals ArrayBox([1, 2]). let box2 equals box1. What to remember: focus on the idea, not every symbol. The inner Array still has copy on write relative to other Array values. but two names pointing at one ArrayBox share the same array property storage path. Interviewers use this to test whether you confuse collection copy on write with object identity. 2.4 Performance interview answer (90s shape) Claim: copy on write makes value-typed collections cheap to pass until mutation. Mechanism: shared buffer + uniqueness check on write. Trade-off: unexpected copies if you mutate while aliases exist. profiling matters for huge buffers. Prod: listing/search arrays. avoid defensive deep copies in hot paths. let copy on write work. don’t wrap in classes “for safety” without thinking.

## §3 3. Nested references and “fake” value types

Next. 3. Nested references and “fake” value types.

3.1 Struct + class property Already covered in foundations. deepen the failure mode: Here is a simple Swift example, explained in words. struct UserSession. var token: String. var profiler: Profiler // class. final class Profiler. var events: [String] equals []. What to remember: focus on the idea, not every symbol. Copying UserSession duplicates token but shares profiler. Two “sessions” pollute one event log. Fixes: Make Profiler a struct with copy on write / value semantics Deep-copy explicitly when needed Don’t put. shared services inside data transfer objects. inject them at the boundary 3.2 Closures capture references Here is a simple Swift example, explained in words. final class Loader. var label equals "x". func makePrinter() - () - Void. print(self.label) // captures self strongly by default. What to remember: focus on the idea, not every symbol. Closures are reference-ish for captures. Pair with automatic reference counting / retain-cycle day. but for this day, know that “I used a struct” does not eliminate shared mutable state if you. capture classes.

## §4 4. Enums as state machines (production-grade)

Next. 4. Enums as state machines (production-grade).

4.1 Impossible states are bugs you don’t ship Boolean flags explode combinatorially: isLoading: hasData, hasError, Meaning?. T: F, F, loading. F: T, F, success. F: F, T, failure. T: T, T, ???. An enum with four cases encodes only the legal rows. 4.2 Mapping network Result. U I state Keep Result at the networking edge. map to a U I-facing enum: Here is a simple example with an enum. An enum is a fixed set of modes. Each case is one mode. Some cases can carry extra data. A switch must handle every case. Why this matters: enums make illegal states hard. What to remember: model states with enums. Why not use Result alone in the ViewModel? Result has no idle / loading. U I needs those modes. Domain enums communicate screen semantics. Result communicates one-shot outcomes. 4.3 Payment popup machine (Applied · S7-A1) Here is a simple example with an enum. An enum is a fixed set of modes. Each case is one mode. Some cases can carry extra data. A switch must handle every case. Why this matters: enums make illegal states hard. What to remember: model states with enums. Interview framing: Verified · S7: designed a processing-time popup so. delays weren’t silent (intent: less drop-off / support friction. no invented %). Applied · S7-A1: I’d model transitions as an enum state machine so illegal U I modes can’t exist. 4.4 Versioning new cases (S D U I / backend-driven adjacent) When backend can add modes: Here is. a simple example with an enum. An enum is a fixed set of modes. Each case is one mode. Some cases can carry extra data. A switch must handle every case. Why this matters: enums make illegal states hard. What to remember: model states with enums. Unknown cases keep the app resilient. Tie to S3 search/header themes later. today just know: enums + fallback beats crashing on new raw values. 4.5 Recursive / nested domain trees Here is a simple example with an enum. An enum is a fixed set of modes. Each case is one mode. Some cases can carry extra data. A switch must handle every case. Why this matters: enums make illegal states hard. What to remember: model states with enums. Useful for nested listings / comment threads. Mention indirect when asked about recursive enums.

## §5 5. Classes: identity, sets, and mutation hazards

Next. 5. Classes: identity, sets, and mutation hazards.

5.1 Hashing classes If you put class instances in a Set / Dictionary key: Prefer stable I D-based. Hashable or identity via ObjectIdentifier Never mutate fields that participate in hash(into:) while the object is in the. collection. undefined behavior / lost entries Here is a simple Swift example, explained in words. final class Seat: Hashable. let id: String. var isSelected: Bool. static func equals equals (l: Seat, r: Seat) - Bool l.id equals equals r.id. func hash(into hasher: inout Hasher) hasher.combine(id). init(id: String) self.id equals id isSelected equals false. What to remember: focus on the idea, not every symbol. 5.2 When a model should be a class Rare but real: Shared mutable cache entry with intentional identity. ObjC interop / U I kit subclass “One session object” everyone must see updates on Otherwise prefer values. + a single owner (ViewModel / store).

## §6 6. Actors intro — boundaries you’ll be asked about

Next. 6. Actors intro — boundaries you’ll be asked about.

6.1 Actor vs class Class: Actor. Semantics: Reference, Reference + isolation. Cross-task mutation: You synchronize, Compiler / runtime enforce. Call site: Direct, Often await. Inheritance: Possible, Limited (actors don’t freely inherit like classes). 6.2 Actor vs serial queue (S2 bridge) Approach: Pros, Cons. G C D serial queue around a dictionary: Works on older OS. familiar, Easy to misuse sync (deadlock). no compile-time isolation. Swift actor: Type-system isolation. clearer A P I, Requires concurrency adoption. hop latency. learning curve. Soft pitch (Verified · S2 + Applied · S2-A1): “We fixed races by serializing access with a G. C D queue. For greenfield code I’d expose the same A P I behind an actor so. isolation is checked by the compiler.” 6.3 Why not every ViewModel is an actor U I must update. on the main actor. Common pattern: Here is a simple example with an actor. An actor protects its own data. Other work talks to it with await. Access happens one at a time. Why this matters: fewer data races. What to remember: actors isolate mutable state. @MainActor is an isolation domain for U I affinity. A custom actor for every VM adds await noise at every bind site. Isolate the shared mutable store (caches, in-flight maps), keep U I models on @MainActor. 6.4 Actor reentrancy (awareness only) While an actor awaits, other work may run on that actor before your. method continues. Don’t assume “I set flag X, awaited, flag X still means what I think” without care. Deep dive = Day 05.

## §7 7. Trade-off tables (memorize shape)

Next. 7. Trade-off tables (memorize shape).

7.1 Type choice Choice: When, Cost. Small struct / enum: Models, state, data transfer objects, Negligible copy. Large struct, many copies: Hot paths with fat values, Copy churn. measure. consider copy on write / inout / reference boundary. Class for models: True shared identity, Shared mutation bugs, retain cycles. Actor for shared maps: Concurrent mutation, Await hops. A P I friction. @MainActor VM: U I state, Don’t block main with heavy work. 7.2 State modeling Choice: When, Cost. Boolean flags: Prototypes only, Impossible states. Result only: One-shot async outcome, No idle/loading. Domain LoadState: Screens, Slightly more mapping code. Event + enum reduce: Complex flows (payments), Need discipline on transitions.

## §8 8. Failure modes checklist

Next. 8. Failure modes checklist.

Failure: Symptom, Fix mindset. Class used for data transfer object: Flaky U I after “copy”, Prefer struct. Nested class in struct: Surprising shared side effects, Audit graph. Assume array assign deep-copies: Unexpected perf or wrong sharing mental model, Teach copy on write. Boolean U I state: Impossible screens / crashy force unwraps, Enum machine. Actor on every type: Contorted call sites, Isolate the real shared mutable core. Mutating hashed fields in Set: Lost objects / weird lookups, Hash stable identity only.

## §9 9. Spoken “agenda → answer” templates

Next. 9. Spoken “agenda → answer” templates.

Struct vs class (45s) Agenda: semantics. mutation. example. Structs have value semantics. copies are independent. Classes share identity. mutation is visible everywhere. I default to structs for ad/listing models. classes for U I kit and true shared services. copy on write (45s) Agenda: share. uniqueness. mutate. Assignment of Array is cheap because buffers are shared. On mutation, if the buffer isn’t uniquely referenced, Swift copies first. So value semantics stay intact without paying full copy on every assign. Enum state (45s) Agenda: impossible states. exhaustiveness. payload. Booleans allow illegal combinations. An associated-value enum makes each mode carry only the data it needs, and switches stay exhaustive. That’s how I’d model payment processing U I. Actor intro (45s) Agenda: race. isolation. bridge. An actor is a reference type that serializes access to its state. Call sites await. It’s the modern equivalent of the serial-queue boundary we used around shared dictionaries.

## §10 10. Diagram: decision flow

Next. 10. Diagram: decision flow.

Here is a simple example with an actor. An actor protects its own data. Other work talks to it with await. Access happens one at a time. Why this matters: fewer data races. What to remember: actors isolate mutable state.

## §11 11. Connect to code in this chapter

Next. 11. Connect to code in this chapter.

File: What to notice. code/LoadState.swift: Generic U I state + Result mapping + payment enum sketch. code/COWDemo.swift: Array sharing vs mutation. handmade copy on write list. Read both before questions.

## §12 Next

Next. Next.

03-production-bridge.md. turn S1 / S7 / S2 into tight interview lines without inventing metrics.
