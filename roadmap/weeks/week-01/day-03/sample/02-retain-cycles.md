# Sample 02 — Retain cycles and classic patterns (Q&A)

> Guided teaching. Links point at foundations, deep dive, and the learning-lab demo.

---

### Q1. What is a retain cycle?

**Points to:** [Foundations · §3 What is a retain cycle?](../01-foundations.md#3-what-is-a-retain-cycle) · [Foundations · §8 Mini demo](../01-foundations.md#8-mini-demo-mental-walkthrough) · [code · BoxBroken / BoxFixed](../code/RetainCycleDemo.swift)

**Answer:**

> A retain cycle is a loop of strong references. Example: a view controller owns a closure, and that closure strongly captures the view controller. Nothing outside still needs those objects, but their retain counts never hit zero, so they never deallocate. They are still **reachable** from each other. That is **abandoned memory** — not the same as an Instruments **Leak**, which is memory with no live references at all.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Do cycles show in the Leaks instrument? | **No.** Cycles stay reachable. Use Memory Graph or Allocations. |
| Classic fix for a stored escaping closure? | Capture list: `[weak self]` plus `guard let self`. |
| Is every mention of `self` in a closure a leak? | No. Non-escaping closures usually cannot outlive `self`, so they often cannot form a long-lived cycle. |

---

### Q2. How do escaping closures create cycles?

**Points to:** [Deep dive · §3 Closures](../02-deep-dive.md#3-closures-how-captures-create-cycles) · [code · ClosureCycleDemo](../code/RetainCycleDemo.swift)

**Answer:**

> If `self` stores an escaping closure, and that closure captures `self` strongly, you get `self → closure → self`. Non-escaping parameters usually die with the call, so they are safer. Escaping work (stored properties, async APIs, completion handlers) can outlive the call site — that is where cycle risk lives. Break the edge from the closure back to `self` with a capture list.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is `[weak self]` alone always enough? | Not if you later create another escaping closure that strongly captures the unwrapped `self` without care. Nested closures need their own discipline. |
| What does `guard let self` do after weak? | It turns the optional weak reference into a strong local for the rest of the scope — only while that scope runs. |
| Where do I see broken vs fixed in the repo? | `BoxBroken` vs `BoxFixed` in [`RetainCycleDemo.swift`](../code/RetainCycleDemo.swift). |

---

### Q3. Why are delegates usually weak?

**Points to:** [Deep dive · §4.1 Delegates](../02-deep-dive.md#41-delegates) · [Foundations · §5 Cycle hotspots](../01-foundations.md#5-cycle-hotspots-youll-see-every-week)

**Answer:**

> A child controller or view often holds a `delegate` pointing back to its owner. If both sides are strong, you get a permanent loop. Make the protocol class-bound (`AnyObject`) and store `weak var delegate`. That way the owner can die, and the back-pointer does not keep it alive.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why `AnyObject` on the protocol? | Weak references need a class type. |
| Strong delegate ever OK for UIKit? | Almost never for the classic VC ↔ child pattern — instant cycle risk. |
| What about struct “delegates”? | Value types don’t use ARC the same way; usually you pass closures or another pattern. |

---

### Q4. How does a Timer keep a target alive?

**Points to:** [Deep dive · §4.2 Timer](../02-deep-dive.md#42-timer--target-selector-retains-the-target) · [code · TickerBroken / TickerFixed](../code/RetainCycleDemo.swift)

**Answer:**

> `Timer.scheduledTimer(timeInterval:target:selector:…)` **strongly retains** the target until you call `invalidate()`. A repeating timer can keep a controller alive forever if you forget teardown. Always `invalidate()` in `deinit` (and when leaving the screen if you intend earlier teardown). Prefer a block-based timer with `[weak self]` when you control the API — and still invalidate so the RunLoop drops the timer.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Does `[weak self]` alone fix a target-selector timer? | The selector API retains the target regardless. You must `invalidate()`. Weak helps more on block-based timers. |
| Why invalidate on disappear too? | If the object stays alive for other reasons, the timer keeps firing until you stop it. |
| Demo classes? | `TickerBroken` never invalidates; `TickerFixed` stops in `deinit`. |

---

### Q5. What must you remember about NotificationCenter block observers?

**Points to:** [Deep dive · §4.3 NotificationCenter](../02-deep-dive.md#43-notificationcenter--block-api-uses-tokens) · [code · TimeZoneObserver](../code/RetainCycleDemo.swift)

**Answer:**

> The modern block API returns an **observer token**. Store that token. Remove it on teardown with `removeObserver(_:)`. Still use `[weak self]` inside the block — the center owns the block, and the block must not own `self` forever if `self` also keeps the observation alive. Older selector-based APIs differ; prefer the token API in new code for clarity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if I forget the token? | You may never unregister cleanly, and the block can keep calling or holding work longer than you expect. |
| Weak capture without removing — enough? | Weak helps the cycle edge; you still remove the observer as part of lifecycle hygiene. |
| Where is a complete sketch? | `TimeZoneObserver` in [`RetainCycleDemo.swift`](../code/RetainCycleDemo.swift). |

---

### Q6. How do you break a parent ↔ child cycle?

**Points to:** [Deep dive · §4.4 Parent ↔ child](../02-deep-dive.md#44-parent--child) · [code · ParentChildDemo](../code/RetainCycleDemo.swift)

**Answer:**

> If parent strongly owns child and child strongly points back to parent, neither dies. Keep the ownership edge strong one way (usually parent → child) and make the back edge `weak` (or carefully `unowned` if the child cannot outlive the parent). See `ParentBroken` / `ChildBroken` vs `ParentFixed` / `ChildFixed` in the demo.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Which side should be weak? | Usually the back-pointer to the owner (child → parent). |
| When unowned on parent? | Only if the child is guaranteed never to outlive the parent *and* you want non-optional access. |
| Same idea in UIKit? | Yes — view hierarchies and controller ownership need a clear owner; avoid two-way strong.

---

### Q7. How do Tasks create ownership problems?

**Points to:** [Deep dive · §4.5 Task / unstructured concurrency](../02-deep-dive.md#45-task--unstructured-concurrency)

**Answer:**

> A running `Task` retains objects it strongly captures. If a screen starts a search task and the user leaves, that task can keep the screen alive or call into a dead UI. Prefer `[weak self]` when the task may outlive the screen. Cancel the task on disappear / `deinit`. Store the task so you can cancel the previous one when a new query starts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cancel without weak — enough? | Cancel helps stop work; weak still protects uncertain lifetime if the task outlives the owner briefly. |
| Why cancel previous search? | Avoid overlapping updates and abandoned tasks stacking up. |
| Same idea for Combine? | Yes — long-lived subscriptions that strongly capture `self` are a common cycle shape. |

---

### Q8. What is the trap with `lazy var` closures?

**Points to:** [Deep dive · §3.3 lazy var closures](../02-deep-dive.md#33-lazy-var-closures)

**Answer:**

> A `lazy var` initializer is a closure that runs later. If it captures `self` strongly while `self` is retaining that lazy property, you can create a surprising ownership edge. Safer patterns: avoid touching `self` inside lazy init when possible; compute without storing a self-capturing escaping closure; or use an explicit weak design if you truly need `self`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is every lazy var a cycle? | No — only when the lazy closure strongly captures `self` in a way that loops ownership. |
| Simple safe habit? | Build formatters and pure helpers without reading other `self` state when you can. |
| Interview angle? | Show you know lazy init is a closure, not “just a delayed property.” |

---

### Q9. What are the weekly cycle hotspots to memorize?

**Points to:** [Foundations · §5 Cycle hotspots](../01-foundations.md#5-cycle-hotspots-youll-see-every-week) · [Deep dive · §7 Trade-off table](../02-deep-dive.md#7-trade-off-table)

**Answer:**

> Five patterns show up constantly: (1) escaping closure on `self` → `[weak self]`; (2) strong `delegate` → `weak var delegate`; (3) Timer target-selector → `invalidate()` (prefer block + weak); (4) NotificationCenter block observer → store token, remove, weak capture; (5) parent ↔ child → one side weak/unowned. Memorize the pattern and the one-line fix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ads / media surfaces? | Completion handlers, players, timers, notification hooks — classic magnets. Escaping work must not strongly own the screen. |
| Singleton caches? | Forever caches of VCs or models are abandoned memory even without a tiny two-node cycle. |
| Next practice? | Walk every BROKEN/FIXED pair in [`RetainCycleDemo.swift`](../code/RetainCycleDemo.swift) aloud. |

---

Next: [03-tools-and-leaks.md](03-tools-and-leaks.md)
