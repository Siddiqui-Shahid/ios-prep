# Audio script — iOS basics — language, types, and memory

## §0 Introduction

iOS basics — language, types, and memory This chapter is meant to be spoken . After each Sample answer , cover the screen and say it in your own words.

## §1 Value types vs reference types

Value type (a type whose assignment copies the data: struct , enum , tuple): two variables do not share mutation. Reference type (a type whose assignment copies a pointer to one heap object: class , actor , closures): two variables can see each other’s mutation. Sample answer (45s): “I default to structs for models because copies are independent. I use a class when I need identity — UIKit views, a shared API client, Objective-C interop. I use an actor when shared mutable state is hit from many concurrent tasks. let vs var is not the same as value vs reference: let locks the name ; a class behind let can still mutate its properties.” Quick checks | Question | Answer | |---|---| | Listing row model? | Struct | | Shared URLSession wrapper? | Class or actor | | Load / success / failure UI? | Enum with associated values | | let box = Box(1); box.value = 2 on a class? | Legal — name is fixed, object mutates | | == vs === | == is Equatable value equality; === is identity for classes | COW (Copy-On-Write: Swift collections like Array share storage until a mutation forces a unique copy). Fat custom structs do not get COW for free — you wrap a class buffer if copies show up in Instruments.

## §2 ARC and retain cycles

ARC (Automatic Reference Counting: the compiler inserts retain/release so an object lives while at least one strong owner exists, then deinit runs at zero). Strong (default ownership: keeps the object alive). weak (non-owning optional reference: becomes nil when the object dies — use for delegates and parent pointers from children). unowned (non-owning non-optional: crashes if you use it after the object dies — only when lifetimes are proven, e.g. self inside a closure when self outlives the closure). Retain cycle (two objects strongly pointing at each other so ARC never hits zero — classic: view controller → closure → self , or parent ↔ child both strong). Sample answer (60s): “ARC is not a garbage collector scanning the heap on a pause. It is compile-time retain counts. Cycles happen with closures capturing self strongly, and with delegates if you forget weak . I use [weak self] in escaping closures, then guard let self if I need a stable window. I confirm with the Memory Graph Debugger and Allocations in Instruments, not folklore.” Instruments (Xcode’s profiler: Time Profiler for CPU, Allocations/Leaks for memory, os signpost for custom intervals).

## §3 Optionals, errors, and Result

Optional ( T? : a value or nil — never silently a magic -1 ). throws / Result (typed failure: either success value or error). Prefer async throws at API boundaries; map to UI enums ( loading , loaded(T) , failed(Message) ) at the view-model edge so SwiftUI does not eat raw NSError . Never force-unwrap ( ! ) in production paths except after a proven invariant (storyboard outlets you control). Interviewers listen for that discipline.

## §4 Protocols, generics, type erasure

POP (Protocol-Oriented Programming: model behavior as protocols with extensions, not deep class hierarchies). Associated type (a placeholder type inside a protocol, like IteratorProtocol.Element ). Type erasure (hiding the concrete generic type behind a wrapper like AnyPublisher so you can store mixed conformers). You reach for it when the compiler says “protocol with associated type cannot be used as a type”. Sample answer: “I protocol the things I need to fake in tests — networking, clock, file system. I keep associated types for strongly typed pipelines. If the UI layer needs to store ‘any publisher of Feed’, I erase to AnyPublisher or use Swift 5.7+ any / some deliberately and can explain the difference: some is opaque one concrete type; any is an existential box.”

## §5 Concurrency: GCD, Operation, async/await, actors

GCD (Grand Central Dispatch: Apple’s queue API — DispatchQueue.main for UI, global queues for work; you must still hop back to main for UIKit/SwiftUI updates). Main thread (the thread that may touch UIKit; blocking it drops frames — 16.7ms per frame at 60Hz, ~8.3ms at 120Hz ProMotion). async/await (Swift Concurrency: functions can suspend without blocking a thread; Task starts work; Task.detached is rarely what you want because it ignores actor isolation). Actor (a reference type that serializes access to its mutable state — compile-time data-race protection). MainActor (the actor representing the main thread; mark view-models @MainActor if they own UI state). Sendable (a compiler contract that a type is safe to pass across concurrency domains). Sample answer (90s): “I still know GCD because production codebases mix both. New work is async/await with a URLSession async API. Shared mutable caches sit in an actor. UI state is @MainActor . I never call DispatchQueue.main.async from a place already on the main actor without a reason — that’s a smell I inherited from callback code. Structured concurrency means child tasks cancel when the parent is cancelled — I propagate Task.isCancelled in loops.” Data race (two threads mutating the same memory without synchronization — undefined behavior; Thread Sanitizer / actors catch this).

## §6 RunLoop, timers, and why lists hitch

RunLoop (the loop that processes events, timers, and sources on a thread — the main run loop drains touches and display links). Heavy JSON decode on main = dropped frames. Decode on a background executor, then hop to MainActor with an already-built DTO (Data Transfer Object: a Codable struct matching the JSON).

## §7 SwiftUI vs UIKit (you must speak both)

UIKit (imperative UI: UIViewController , UITableView / UICollectionView — still the spine of huge apps). SwiftUI (declarative UI: a View is a function of state; ObservableObject / @Observable hold the source of truth). Diffable data source (UIKit lists identified by hashable IDs so updates animate without reloadData nukes). Sample answer: “I pick SwiftUI for new screens with modest UIKit interop via UIViewRepresentable . For a 60fps ticker tape or a battle-tested checkout, I stay on UIKit with a diffable data source. I never block the main thread in body — body must be cheap.”

## §8 Persistence one-liners (you will reuse in LLD)

| Need | Tool | Why | |---|---|---| | User prefs, non-secrets | UserDefaults (small key-value store) | Fast; not for tokens | | Tokens | Keychain (encrypted item store) | Survives reinstall in some cases; use after-first-unlock for background | | Relational rows | SQLite / GRDB / Core Data | Query, migrations | | Files | FileManager Caches vs Application Support | OS may purge Caches |

## §9 Speak this close-out (90s)

“Basics I actually use: value types for data, ARC with weak delegates, async/await with MainActor UI, Instruments when I guess. I can write a Codable DTO, a URLSession client, and a SwiftUI list that does not hitch.”
