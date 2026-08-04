# 02 — Deep dive: ARC mechanics, cycles, Instruments

> Senior depth. Assumes [01-foundations.md](01-foundations.md). Still self-contained — no “go read Apple docs first.” Optional citations at the end.

## 1. What the compiler actually does

For class instances, the Swift/ObjC runtime maintains a retain count (plus side tables for weak references). The compiler emits:

- `retain` / `release` (or equivalent ARC runtime calls) at ownership transfer points
- `deinit` invocation when the last strong reference is released
- Zeroing weak bookkeeping so `weak` becomes `nil` after destroy

**Interview-ready contrast with GC:**

| | ARC | Tracing GC (Java, Go, etc.) |
|---|---|---|
| When work happens | Mostly at assign / scope exit | Periodic heap scan / pause or concurrent mark |
| Cycles | Must break manually (weak/unowned) | Collector can reclaim cyclic garbage |
| Determinism | `deinit` timing is predictable relative to last release | Finalizers are less deterministic |
| Cost model | Predictable per-operation | Throughput vs pause trade-offs |

ARC does **not** mean “no memory bugs.” It means ownership bugs show up as cycles, early dealloc crashes (`unowned`), or abandoned caches — not as “forgot to free” in everyday Swift class code.

## 2. Strong, weak, unowned — semantics table

| | strong | weak | unowned | unowned(unsafe) |
|---|---|---|---|---|
| Increments retain count | Yes | No | No | No |
| Type | `T` | `T?` | `T` | `T` |
| After owner dies | N/A (you *are* an owner) | Becomes `nil` | Dangling — use → crash | Dangling — undefined / crash risk |
| Runtime cost | Baseline | Side table / zeroing | Cheaper than weak | Cheapest, least safe |
| App code default? | Yes | Yes for cycles / async | Rare, proven lifetime | Almost never |

### When `unowned` is justified

Example: a `Person` strongly owns a `CreditCard`, and the card’s `owner` must always exist for the card’s entire life:

```swift
final class Person {
    var card: CreditCard!
    init() { card = CreditCard(owner: self) }
}

final class CreditCard {
    unowned let owner: Person  // card cannot outlive person by construction
    init(owner: Person) { self.owner = owner }
}
```

If a network callback might outlive a dismissed VC, **`unowned self` is a bug waiting to happen**. Prefer `weak`.

## 3. Closures: how captures create cycles

### 3.1 Escaping vs non-escaping

- **Non-escaping** closures (default for function parameters that don’t escape) usually cannot outlive `self`, so a strong capture of `self` often cannot form a long-lived cycle.
- **Escaping** closures stored in properties, dispatched async, or passed to APIs that keep them → **can** outlive the call site → cycle risk if they capture `self` and `self` owns them.

### 3.2 Capture lists

```swift
// Cycle: self → onComplete → self
onComplete = { self.refresh() }

// Breaks the cycle edge from closure → self
onComplete = { [weak self] in
    guard let self else { return }
    self.refresh()
}
```

Notes seniors get right:

- `[weak self]` alone is not enough if you then create *another* escaping closure that strongly captures the unwrapped `self` without care.
- Nested closures each need their own discipline.
- Capturing a specific property (`[weak self] in self?.foo`) vs capturing many locals — prefer narrow captures when readability allows.

### 3.3 `lazy var` closures

```swift
lazy var formatter: DateFormatter = {
    // This closure runs later and can capture self strongly while
    // self is initializing / retaining the lazy property.
    let f = DateFormatter()
    f.timeZone = self.timeZone  // careful: strong self capture
    return f
}()
```

Safer patterns: don’t touch `self` inside lazy init if avoidable; or compute without storing a self-capturing escaping closure; or use explicit weak if the design truly needs `self`.

## 4. Classic UIKit / AppKit cycle patterns

### 4.1 Delegates

```swift
protocol FeedDelegate: AnyObject {
    func feedDidRefresh()
}

final class FeedController {
    weak var delegate: FeedDelegate?
}
```

Class-bound (`AnyObject`) delegates are `weak` so `UIViewController` ↔ child controller / view model does not form a permanent loop. Value-type “delegates” (structs) don’t use ARC the same way — usually you pass closures or use different patterns.

### 4.2 Timer — target-selector retains the target

```swift
final class Ticker {
    private var timer: Timer?

    func start() {
        // IMPORTANT: scheduledTimer(target:selector:) RETAINS target (self)
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func tick() { /* … */ }

    deinit {
        timer?.invalidate()  // release the target retain
        timer = nil
    }
}
```

**Rules:**

1. Target-selector repeating timers keep the target alive until `invalidate()`.
2. Always `invalidate()` in `deinit` (and when leaving the screen if you intend teardown earlier).
3. Prefer block-based timers with `[weak self]` when you control the API surface:

```swift
timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
    self?.tick()
}
// Still invalidate on teardown — RunLoop ownership is separate from the capture list.
```

Block timers still need invalidation so the RunLoop drops them; the capture list prevents the *block → self* cycle, but you still manage timer lifetime.

### 4.3 NotificationCenter — block API uses tokens

Modern block-based API:

```swift
private var token: NSObjectProtocol?

func observe() {
    token = NotificationCenter.default.addObserver(
        forName: .NSSystemTimeZoneDidChange,
        object: nil,
        queue: .main
    ) { [weak self] _ in
        self?.reload()
    }
}

deinit {
    if let token {
        NotificationCenter.default.removeObserver(token)
    }
}
```

**Key facts:**

- The block API returns an **observer token**. Store it.
- Remove with `removeObserver(_:)` using that token (or remove in `deinit` / `viewDidDisappear` as your lifecycle policy dictates).
- Still use `[weak self]` inside the block — the center owns the block; the block must not own `self` if `self` also keeps the observation alive indefinitely.
- Older selector-based `addObserver(self, selector:…)` does **not** retain the observer the same way; you still must remove in `deinit` on older patterns. Prefer the token API in new code for clarity.

### 4.4 Parent ↔ child

```swift
final class Parent {
    var child: Child?
}
final class Child {
    weak var parent: Parent?  // break the cycle
}
```

Use `unowned` only if the child is guaranteed never to outlive the parent *and* you want non-optional access.

### 4.5 `Task` / unstructured concurrency

```swift
final class SearchVC {
    private var searchTask: Task<Void, Never>?

    func query(_ text: String) {
        searchTask?.cancel()
        searchTask = Task { [weak self] in
            guard let self else { return }
            // … await network …
            await self.apply(results)
        }
    }

    deinit {
        searchTask?.cancel()
    }
}
```

A running `Task` retains objects it strongly captures. Cancel on disappear / `deinit`, and prefer `[weak self]` when the task may outlive the screen.

## 5. Leak vs abandoned vs high watermark

| Concept | Definition | Typical cause | Primary tools |
|---|---|---|---|
| **True leak** | Memory allocated, **no** live references | Rare in pure Swift ARC; more common with unsafe / CF / missed CFRelease / some ObjC | **Leaks** instrument |
| **Abandoned memory** | Still referenced, but unused by current product logic | Retain cycles, singleton caches that never prune, forgotten observers | **Memory Graph**, **Allocations** |
| **High watermark** | Peak bytes during a session | Large images, peak concurrency, one-time spikes | Allocations / Memory report — may be OK if it drops |

### The sentence that wins interviews

> “Retain cycles are abandoned but still reachable, so they don’t show as Leaks. I use Memory Graph to see the cycle and Allocations to see persistent growth. Leaks is for unreachable memory.”

Never say: “I found the retain cycle in the Leaks instrument.”

## 6. Instruments workflow (senior playbook)

### 6.1 Debug Memory Graph (Xcode debugger)

1. Reproduce the bug (push VC, play ad, start timer, pop VC).
2. Debug → Memory Graph (or the gauge button).
3. Filter by your class name / module.
4. Inspect instances that should be gone.
5. Walk incoming references until you see the cycle (closure ↔ object, timer → target, etc.).

**Strength:** visual “who retains me?”  
**Weakness:** snapshot in time; less about historical growth curves.

### 6.2 Allocations

1. Record while navigating hot paths (feed, checkout, ads).
2. Look for persistent growth of your types across generations / marks.
3. Use generation analysis / “persistent” bytes after you expect teardown.
4. Compare before/after a fix.

**Strength:** proves growth and abandoned heaps over time.  
**Weakness:** doesn’t draw the cycle as clearly as Memory Graph.

### 6.3 Leaks

1. Record the same session.
2. Investigate *true* leaks (unreachable).
3. Do **not** conclude “no cycles” just because Leaks is clean.

**Strength:** unreachable memory.  
**Weakness:** silent on retain cycles.

### 6.4 Suggested order when a VC “won’t die”

1. Add a temporary `deinit { print("…") }` (learning lab) or breakpoint.
2. Memory Graph — find unexpected owners.
3. Allocations — confirm the type persists across navigation generations.
4. Leaks — only if you suspect unsafe / CF / true unreachable issues.
5. Fix ownership; re-verify `deinit` + Graph.

## 7. Trade-off table

| Choice | When | Cost / risk |
|---|---|---|
| Always `[weak self]` on escaping work | Uncertain lifetime (network, UI, ads) | Optional unwrapping noise; early `nil` skips work |
| `unowned self` | Nested object with proven shorter life | Crash if assumption wrong |
| `unowned(unsafe)` | Extreme low-level / proven hot path | Never casual app code |
| Invalidate timer in `deinit` only | Simple owned timer | If VC stays alive, timer keeps firing — also invalidate on disappear if needed |
| Store NC token + weak capture | Block observers | Must not forget removal |
| Strong delegate | Almost never for UIKit class delegates | Instant cycle risk |
| Cache with no eviction | “Performance” | Abandoned memory → jetsam under peak DAU |

## 8. Failure modes (production-shaped)

| Symptom | Likely ownership bug | First check |
|---|---|---|
| Memory climbs as user navigates | Abandoned VCs / cycles / caches | Memory Graph on popped VC type |
| Crash on callback after dismiss | `unowned` or force-unwrap after weak nil | Change to `weak` + guard |
| Timer fires after leave screen | Not invalidated; target retained | `invalidate` + nil |
| Observer fires after teardown | Token not removed / strong capture | Remove token; weak self |
| CFS dips during big events | Jetsam + crashes from pressure / races | Crashlytics + memory triage culture (S8) |

## 9. Autorelease pools (short, accurate)

In tight loops that create many temporary ObjC objects (bridging, image processing helpers), drain with:

```swift
for item in hugeList {
    autoreleasepool {
        // temporaries released each iteration
        process(item)
    }
}
```

This is **not** a retain-cycle fix. It reduces peak temporary memory. Mention it only when the question is about high watermark in ObjC-heavy loops.

## 10. Value types vs ARC (edge)

- Structs themselves are not reference-counted.
- A struct storing a `class` instance shares that reference; mutating the struct may copy the struct shell but still share/retain the class unless you implement COW yourself.
- Closures are reference types under the hood — capturing large value trees can still keep class graphs alive.

## 11. Interview answer skeleton (90s deep dive)

1. **Claim:** ARC frees at retain count zero; cycles prevent that.
2. **Mechanism:** strong vs weak/unowned; escaping closures; timer retain; NC tokens.
3. **Tools:** Graph/Allocations for abandoned; Leaks for unreachable — don’t confuse them.
4. **Production:** reliability culture at scale (Verified S8 metrics); triage playbook as Applied judgment.

## Optional citations (appendix only)

- Swift Language Guide — Automatic Reference Counting  
- Xcode Help — Debug memory graph / Instruments Allocations & Leaks  

Studying this chapter alone is sufficient; links are optional deepeners.

Next: [03-production-bridge.md](03-production-bridge.md).
