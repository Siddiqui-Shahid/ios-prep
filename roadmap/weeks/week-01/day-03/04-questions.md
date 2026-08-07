# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What is ARC? `(30–45s)`

**Answer:**

> ARC is Automatic Reference Counting — the compiler inserts retain and release calls for class instances. Each strong reference bumps the count; when it hits zero, the object is destroyed and `deinit` runs. It’s not a tracing garbage collector, so we don’t get GC pause semantics, but we *do* have to break retain cycles ourselves with weak or unowned. At BookMyShow, reliability meant holding a 99.95%+ crash-free bar at 30L+ DAU — lifecycle and memory bugs sit in that same reliability conversation, not as an afterthought.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | When a popped VC’s strong count hits zero, deinit runs and releases images/listeners — that’s ARC reclaim, not a GC pause. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q2. weak vs unowned? `(45s)`

**Answer:**

> `weak` is an optional reference that doesn’t keep the object alive, and it becomes `nil` when the object deinits — so you `guard let self`. `unowned` also doesn’t keep it alive, but it isn’t optional and isn’t zeroed; if you touch it after deinit, you crash. I use `weak` for network, ads, and UI callbacks where lifetime is uncertain. I only use `unowned` when lifetimes are provably nested — like a child object that cannot outlive its parent by construction.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | For an ads completion I use weak because the ad can outlive the VC; I’d only use unowned for a child that cannot outlive its parent by construction. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What’s a common retain cycle in Swift? `(45s)`

**Answer:**

> The textbook cycle is a view controller or service that stores an escaping completion handler, and that handler strongly captures `self`. Now `self` owns the closure and the closure owns `self`, so retain counts never reach zero — the object is abandoned but still reachable. The fix is a capture list: `[weak self]` plus a guard. Same shape shows up with delegates stored strongly, timers, and notification blocks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | A VC that stores `onComplete = { self.refresh() }` without `[weak self]` never deinits after dismiss until that closure is cleared. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Should delegates be weak? `(30–45s)`

**Answer:**

> If the delegate is a class — typically a view controller — storing it `strong` creates an easy cycle when the child also owns its parent logically. So we declare `weak var delegate` and constrain the protocol to `AnyObject`. That way the child doesn’t keep the parent alive. If you’re using struct-based callbacks, you usually pass closures with explicit capture lists instead of a weak delegate property.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Declare `weak var delegate: FooDelegate?` with `protocol FooDelegate: AnyObject` so the child cannot keep the parent VC alive. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Memory leak vs abandoned memory? `(60s)`

**Answer:**

> A true leak is memory that’s allocated but has no live references — nothing can touch it, so it can never be freed. Abandoned memory still has references — classic retain cycles or caches that never evict — but the app no longer needs those objects. Retain cycles are abandoned and still reachable, so they typically do **not** show in the Leaks instrument. I use Memory Graph to see ownership edges and Allocations to see persistent growth. Leaks is for unreachable cases. High watermark is different again — peak usage that may drop later.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | A retain-cycled ImageCache still appears in Memory Graph and Allocations growth, but usually not in the Leaks instrument. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Does `[weak self]` always fix cycles? `(45–60s)`

**Answer:**

> `[weak self]` only weakens that closure’s reference to self. If a Timer is still retaining you via target-selector, or a NotificationCenter block is registered without teardown, or another nested escaping closure captures self strongly, you can still fail to deinit. So weak is necessary for escaping closures, but the checklist is broader: timers invalidate, observer tokens removed, tasks cancelled, delegates weak, caches bounded.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | `[weak self]` in a network completion still leaves a repeating Timer retaining the VC until you call `invalidate`. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. `deinit` not called — checklist? `(60s)`

**Answer:**

> First I assume the object is still retained — ARC isn’t randomly broken. I check escaping closures and tasks, repeating timers that weren’t invalidated, NotificationCenter tokens still registered, strong delegates, and whether the controller is still in a navigation stack, presented, or held by a singleton cache. Then I’d open Memory Graph and inspect who points at the instance. Once I break the unexpected strong edge, deinit should fire. I’d verify with Allocations that the type doesn’t persist across navigation generations.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | If Memory Graph shows NotificationCenter → block → self, remove the observer token and deinit should fire on the next teardown. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Value types and ARC? `(30–45s)`

**Answer:**

> Structs and enums are value types — copying them doesn’t use ARC the way class instances do. But if a struct stores a class reference, that reference is still strong and retains the class. Closures are reference types under the hood, so a struct that somehow participates in escaping closure graphs can still keep objects alive. So ‘we only use structs’ doesn’t automatically mean ‘no retain cycles’ if classes and closures are in the mix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | `struct Model { let cache: ImageCache }` still retains the class; copying the struct bumps that reference’s retain count. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Autorelease pools — when? `(45s)`

**Answer:**

> Autorelease pools let you drain temporary autoreleased objects sooner — useful in tight loops that create lots of bridged ObjC temporaries, like some image or string processing paths. That reduces high watermark. It does not break retain cycles. If the interviewer asks about climbing memory from a cycle, I talk weak captures and Instruments Graph — not autorelease pools.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Wrapping a decode loop in `autoreleasepool { }` drains temporary bridged objects each iteration without fixing a retain cycle. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. How do you prevent leaks with async `Task`? `(60s)`

**Answer:**

> A `Task` keeps alive anything it strongly captures for as long as it runs. If a view controller fires a task and the user pops the screen, a strong `self` capture can keep the controller around until the task finishes. I store the task, cancel it in `deinit` or `onDisappear`, and use `[weak self]` inside when the work is optional after teardown. Structured concurrency children cancel with their parent, which is preferable when the API allows it.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Store the fetch `Task`, cancel it in `onDisappear`, and capture `[weak self]` so a popped search screen isn’t kept alive until HTTP finishes. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. How does a Timer create a retain cycle / keep a target alive? `(45–60s)`

**Answer:**

> When you use `Timer.scheduledTimer(timeInterval:target:selector:…)`, the timer strongly retains the target until you call `invalidate`. For a repeating timer on a view controller, that means the controller can live forever even after you think you dismissed it. The fix is to invalidate in `deinit` and usually when leaving the screen, and set the timer property to nil. Block-based timers with `[weak self]` avoid the selector retain semantics for `self`, but you still invalidate so the RunLoop drops the timer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | `Timer.scheduledTimer(target: self, …)` retains the VC; invalidate in `deinit`/`viewWillDisappear` or the screen never frees. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q12. NotificationCenter block observers — what must you remember? `(45–60s)`

**Answer:**

> `addObserver(forName:object:queue:using:)` returns an observer token. I store that token on the object and remove it in `deinit` or when stopping observation. Inside the block I capture `[weak self]` so the center’s ownership of the block doesn’t keep my controller alive forever. Forgetting either the token removal or the weak capture is a common abandoned-memory bug. I don’t rely on ‘Leaks will tell me’ — I’d expect Memory Graph to show the observer graph.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | Store the token from `addObserver(forName:…)` and remove it in `deinit`, with `[weak self]` inside the block. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

## Timed drill (subset)

Record aloud: **Q1, Q2, Q5, Q11, T1, T5, T8**.

Score against [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md).  
Log misses (especially Leaks-vs-cycle confusion) in your gotchas list.

Revision twin: [`../../../revision/weeks/week-01/day-03.md`](../../../revision/weeks/week-01/day-03.md).
