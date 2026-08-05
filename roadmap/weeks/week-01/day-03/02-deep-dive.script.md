# Audio script — 02 Deep Dive
> Listen-only audiobook of `02-deep-dive.md` (Day 03 — ARC, Retain Cycles, weak/unowned, Instruments). Simple English. Basic explanations. Self-contained speech. Does not assume you are looking at a screen.


## §0 Introduction

Next. Introduction.

Senior depth. Assumes 01-foundations.md. Still self-contained. no “go read Apple docs first.” Optional citations at the end.

## §1 1. What the compiler actually does

Next. 1. What the compiler actually does.

For class instances, the Swift/ObjC runtime maintains a retain count (plus side tables for weak references). The compiler emits: retain / release (or equivalent automatic reference counting runtime calls) at ownership transfer points deinit. invocation when the last strong reference is released Zeroing weak bookkeeping so. weak becomes nil after destroy Interview-ready contrast with GC: automatic reference counting: Tracing GC (Java. Go, etc.). When work happens: Mostly at assign / scope exit, Periodic heap scan / pause or concurrent mark. Cycles: Must break manually (weak/unowned), Collector can reclaim cyclic garbage. Determinism: deinit timing is predictable relative to last release, Finalizers are less deterministic. Cost model: Predictable per-operation, Throughput vs pause trade-offs. automatic reference counting does not mean “no memory bugs.” It means ownership bugs show up as cycles. early dealloc crashes (unowned), or abandoned caches. not as “forgot to free” in everyday Swift class code.

## §2 2. Strong, weak, unowned — semantics table

Next. 2. Strong, weak, unowned — semantics table.

strong: weak, unowned, unowned(unsafe). Increments retain count: Yes, No, No, No. Type: T, T?, T, T. After owner dies: N/A (you are an owner), Becomes nil, Dangling. use. crash, Dangling. undefined / crash risk. Runtime cost: Baseline, Side table / zeroing, Cheaper than weak, Cheapest, least safe. App code default?: Yes, Yes for cycles / async, Rare, proven lifetime, Almost never. When unowned is justified Example: a Person strongly owns a CreditCard. and the card’s owner must always exist for the card’s entire life: Here is a simple Swift example. explained in words. final class Person. var card: CreditCard!. init() card equals CreditCard(owner: self). final class CreditCard. unowned let owner: Person // card cannot outlive person by construction. What to remember: focus on the idea, not every symbol. If a network callback might outlive a dismissed VC, unowned self is a bug waiting to happen. Prefer weak.

## §3 3. Closures: how captures create cycles

Next. 3. Closures: how captures create cycles.

3.1 Escaping vs non-escaping Non-escaping closures (default for function parameters that don’t escape) usually cannot outlive self. so a strong capture of self often cannot form a long-lived cycle. Escaping closures stored in properties, dispatched async, or passed to APIs that keep them. can outlive the call site. cycle risk if they capture self and self owns them. 3.2 Capture lists Here is a simple Swift example, explained in words. // Cycle: self. onComplete. self. onComplete equals self.refresh(). // Breaks the cycle edge from closure. self. onComplete equals [weak self] in. guard let self else return. self.refresh(). What to remember: focus on the idea, not every symbol. Notes seniors get right: [weak self] alone is not enough if you then. create another escaping closure that strongly captures the unwrapped self without care. Nested closures each need their own discipline. Capturing a specific property ([weak self] in self?.foo) vs capturing many locals. prefer narrow captures when readability allows. 3.3 lazy var closures Here is a simple Swift example, explained in words. lazy var formatter: DateFormatter equals. // This closure runs later and can capture self strongly while. // self is initializing / retaining the lazy property.. let f equals DateFormatter(). f.timeZone equals self.timeZone // careful: strong self capture. return f. What to remember: focus on the idea, not every symbol. Safer patterns: don’t touch self inside lazy init if avoidable. or compute without storing a self-capturing escaping closure. or use explicit weak if the design truly needs self.

## §4 4. Classic UIKit / AppKit cycle patterns

Next. 4. Classic U I kit / App kit cycle patterns.

4.1 Delegates Here is a simple example with a protocol. A protocol is a list of capabilities. A type can adopt it without sharing a base class. Why this matters: this is protocol oriented programming, or P O P. What to remember: protocols describe behavior. Class-bound (AnyObject) delegates are weak so UIViewController ↔ child controller / view model does not form a permanent. loop. Value-type “delegates” (structs) don’t use automatic reference counting the same way. usually you pass closures or use different patterns. 4.2 Timer. target-selector retains the target Here is a simple Swift example, explained in words. final class Ticker. private var timer: Timer?. func start(). // IMPORTANT: scheduledTimer(target:selector:) RETAINS target (self). timer equals Timer.scheduledTimer(. timeInterval: 1,. What to remember: focus on the idea, not every symbol. Rules: Target-selector repeating timers keep the target alive until invalidate(). Always invalidate() in deinit (and when leaving the screen if you intend teardown earlier). Prefer block-based timers with [weak self] when you control the A P I surface: Here is a simple. Swift example, explained in words. timer equals Timer.scheduledTimer(withTimeInterval: 1, repeats: true) [weak self] _ in. self?.tick(). // Still invalidate on teardown. RunLoop ownership is separate from the capture list.. What to remember: focus on the idea, not every symbol. Block timers still need invalidation so the RunLoop drops them. the capture list prevents the block. self cycle, but you still manage timer lifetime. 4.3 NotificationCenter. block A P I uses tokens Modern block-based A P I: Here is a simple Swift example. explained in words. private var token: NSObjectProtocol?. func observe(). token equals NotificationCenter.default.addObserver(. forName:.NSSystemTimeZoneDidChange,. object: nil,. queue:.main. What to remember: focus on the idea, not every symbol. Key facts: The block A P I returns an observer token. Store it. Remove with removeObserver(_:) using that token (or remove in deinit / viewDidDisappear as your lifecycle policy dictates). Still use [weak self] inside the block. the center owns the block. the block must not own self if self also keeps the observation alive indefinitely. Older selector-based addObserver(self, selector:…) does not retain the observer the same way. you still must remove in deinit on older patterns. Prefer the token A P I in new code for clarity. 4.4 Parent ↔ child Here is a simple Swift example, explained in words. final class Parent. var child: Child?. final class Child. weak var parent: Parent? // break the cycle. What to remember: focus on the idea, not every symbol. Use unowned only if the child is guaranteed never to outlive the parent and you want non-optional access. 4.5 Task / unstructured concurrency Here is a simple Swift example, explained in words. final class SearchVC. private var searchTask: Task Void, Never ?. func query(_ text: String). searchTask?.cancel(). searchTask equals Task [weak self] in. guard let self else return. What to remember: focus on the idea, not every symbol. A running Task retains objects it strongly captures. Cancel on disappear / deinit, and prefer [weak self] when the task may outlive the screen.

## §5 5. Leak vs abandoned vs high watermark

Next. 5. Leak vs abandoned vs high watermark.

Concept: Definition, Typical cause, Primary tools. True leak: Memory allocated, no live references, Rare in pure Swift automatic reference counting. more common with unsafe / CF / missed CFRelease / some ObjC, Leaks instrument. Abandoned memory: Still referenced, but unused by current product logic. Retain cycles, singleton caches that never prune, forgotten observers, Memory Graph. Allocations. High watermark: Peak bytes during a session, Large images, peak concurrency, one-time spikes, Allocations / Memory report. may be if it drops. The sentence that wins interviews “Retain cycles are abandoned but still reachable, so they don’t show as Leaks. I use Memory Graph to see the cycle and Allocations to see persistent growth. Leaks is for unreachable memory.” Never say: “I found the retain cycle in the Leaks instrument.”.

## §6 6. Instruments workflow (senior playbook)

Next. 6. Instruments workflow (senior playbook).

6.1 Debug Memory Graph (X code debugger) Reproduce the bug (push VC, play ad, start timer, pop VC). Debug. Memory Graph (or the gauge button). Filter by your class name / module. Inspect instances that should be gone. Walk incoming references until you see the cycle (closure ↔ object, timer. target, etc.). Strength: visual “who retains me?” Weakness: snapshot in time. less about historical growth curves. 6.2 Allocations Record while navigating hot paths (feed, checkout, ads). Look for persistent growth of your types across generations / marks. Use generation analysis / “persistent” bytes after you expect teardown. Compare before/after a fix. Strength: proves growth and abandoned heaps over time. Weakness: doesn’t draw the cycle as clearly as Memory Graph. 6.3 Leaks Record the same session. Investigate true leaks (unreachable). Do not conclude “no cycles” just because Leaks is clean. Strength: unreachable memory. Weakness: silent on retain cycles. 6.4 Suggested order when a VC “won’t die” Add a temporary deinit { print("…") } (learning lab) or. breakpoint. Memory Graph. find unexpected owners. Allocations. confirm the type persists across navigation generations. Leaks. only if you suspect unsafe / CF / true unreachable issues. Fix ownership. re-verify deinit + Graph.

## §7 7. Trade-off table

Next. 7. Trade-off table.

Choice: When, Cost / risk. Always [weak self] on escaping work: Uncertain lifetime (network, U I, ads), Optional unwrapping noise. early nil skips work. unowned self: Nested object with proven shorter life, Crash if assumption wrong. unowned(unsafe): Extreme low-level / proven hot path, Never casual app code. Invalidate timer in deinit only: Simple owned timer, If VC stays alive, timer keeps firing. also invalidate on disappear if needed. Store NC token + weak capture: Block observers, Must not forget removal. Strong delegate: Almost never for U I kit class delegates, Instant cycle risk. Cache with no eviction: “Performance”, Abandoned memory. jetsam under peak DAU.

## §8 8. Failure modes (production-shaped)

Next. 8. Failure modes (production-shaped).

Symptom: Likely ownership bug, First check. Memory climbs as user navigates: Abandoned VCs / cycles / caches, Memory Graph on popped VC type. Crash on callback after dismiss: unowned or force-unwrap after weak nil, Change to weak + guard. Timer fires after leave screen: Not invalidated. target retained, invalidate + nil. Observer fires after teardown: Token not removed / strong capture, Remove token. weak self. CFS dips during big events: Jetsam + crashes from pressure / races, Crashlytics + memory triage culture (S8).

## §9 9. Autorelease pools (short, accurate)

Next. 9. Autorelease pools (short, accurate).

In tight loops that create many temporary ObjC objects (bridging. image processing helpers), drain with: Here is a simple Swift example. explained in words. for item in hugeList. autoreleasepool. // temporaries released each iteration. process(item). What to remember: focus on the idea, not every symbol. This is not a retain-cycle fix. It reduces peak temporary memory. Mention it only when the question is about high watermark in ObjC-heavy loops.

## §10 10. Value types vs ARC (edge)

Next. 10. Value types vs automatic reference counting (edge).

Structs themselves are not reference-counted. A struct storing a class instance shares that reference. mutating the struct may copy the struct shell but still share/retain the class unless you implement copy on. write yourself. Closures are reference types under the hood. capturing large value trees can still keep class graphs alive.

## §11 11. Interview answer skeleton (90s deep dive)

Next. 11. Interview answer skeleton (90s deep dive).

Claim: automatic reference counting frees at retain count zero. cycles prevent that. Mechanism: strong vs weak/unowned. escaping closures. timer retain. NC tokens. Tools: Graph/Allocations for abandoned. Leaks for unreachable. don’t confuse them. Production: reliability culture at scale (Verified S8 metrics). triage playbook as Applied judgment.

## §12 Optional citations (appendix only)

Next. Optional citations (appendix only).

Swift Language Guide. Automatic Reference Counting X code Help. Debug memory graph / Instruments Allocations & Leaks Studying this chapter alone is sufficient. links are optional deepeners. Next: 03-production-bridge.md.
