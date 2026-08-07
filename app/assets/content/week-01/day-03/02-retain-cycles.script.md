# Audio script — Sample 02 — Retain cycles and classic patterns (Q&A)
> Listen-only sample Q&A from `02-retain-cycles.md`. Spoken answers and follow-ups.

## §0 Q1. What is a retain cycle?

Next. Q1. What is a retain cycle? Answer. A retain cycle is a loop of strong references. Example: a view controller owns a closure, and that closure strongly captures the view controller. Nothing outside still needs those objects, but their retain counts never hit zero, so they never deallocate. They are still reachable from each other. That is abandoned memory — not the same as an Instruments Leak, which is memory with no live references at all. Follow-ups. Do cycles show in the Leaks instrument?: No. Cycles stay reachable. Use Memory Graph or Allocations.. Classic fix for a stored escaping closure?: Capture list: [weak self] plus guard let self.. Is every mention of self in a closure a leak?: No. Non-escaping closures usually cannot outlive self, so they often cannot form a long-lived cycle..

## §1 Q2. How do escaping closures create cycles?

Next. Q2. How do escaping closures create cycles? Answer. If self stores an escaping closure, and that closure captures self strongly, you get self → closure → self. Non-escaping parameters usually die with the call, so they are safer. Escaping work (stored properties, async APIs, completion handlers) can outlive the call site — that is where cycle risk lives. Break the edge from the closure back to self with a capture list. Follow-ups. Is [weak self] alone always enough?: Not if you later create another escaping closure that strongly captures the unwrapped self without care. Nested closures need their own discipline.. What does guard let self do after weak?: It turns the optional weak reference into a strong local for the rest of the scope — only while that scope runs.. Where do I see broken vs fixed in the repo?: BoxBroken vs BoxFixed in RetainCycleDemo.swift..

## §2 Q3. Why are delegates usually weak?

Next. Q3. Why are delegates usually weak? Answer. A child controller or view often holds a delegate pointing back to its owner. If both sides are strong, you get a permanent loop. Make the protocol class-bound (AnyObject) and store weak var delegate. That way the owner can die, and the back-pointer does not keep it alive. Follow-ups. Why AnyObject on the protocol?: Weak references need a class type.. Strong delegate ever OK for UIKit?: Almost never for the classic view controller ↔ child pattern — instant cycle risk.. What about struct “delegates”?: Value types don’t use A R C the same way; usually you pass closures or another pattern..

## §3 Q4. How does a Timer keep a target alive?

Next. Q4. How does a Timer keep a target alive? Answer. Timer.scheduledTimer(timeInterval:target:selector:…) strongly retains the target until you call invalidate(). A repeating timer can keep a controller alive forever if you forget teardown. Always invalidate() in deinit (and when leaving the screen if you intend earlier teardown). Prefer a block-based timer with [weak self] when you control the A P I — and still invalidate so the RunLoop drops the timer. Follow-ups. Does [weak self] alone fix a target-selector timer?: The selector A P I retains the target regardless. You must invalidate(). Weak helps more on block-based timers.. Why invalidate on disappear too?: If the object stays alive for other reasons, the timer keeps firing until you stop it.. Demo classes?: TickerBroken never invalidates; TickerFixed stops in deinit..

## §4 Q5. What must you remember about NotificationCenter block observers?

Next. Q5. What must you remember about NotificationCenter block observers? Answer. The modern block A P I returns an observer token. Store that token. Remove it on teardown with removeObserver(_:). Still use [weak self] inside the block — the center owns the block, and the block must not own self forever if self also keeps the observation alive. Older selector-based APIs differ; prefer the token A P I in new code for clarity. Follow-ups. What if I forget the token?: You may never unregister cleanly, and the block can keep calling or holding work longer than you expect.. Weak capture without removing — enough?: Weak helps the cycle edge; you still remove the observer as part of lifecycle hygiene.. Where is a complete sketch?: TimeZoneObserver in RetainCycleDemo.swift..

## §5 Q6. How do you break a parent ↔ child cycle?

Next. Q6. How do you break a parent ↔ child cycle? Answer. If parent strongly owns child and child strongly points back to parent, neither dies. Keep the ownership edge strong one way (usually parent → child) and make the back edge weak (or carefully unowned if the child cannot outlive the parent). See ParentBroken / ChildBroken vs ParentFixed / ChildFixed in the demo. Follow-ups. Which side should be weak?: Usually the back-pointer to the owner (child → parent).. When unowned on parent?: Only if the child is guaranteed never to outlive the parent and you want non-optional access.. Same idea in UIKit?: Yes — view hierarchies and controller ownership need a clear owner; avoid two-way strong..

## §6 Q7. How do Tasks create ownership problems?

Next. Q7. How do Tasks create ownership problems? Answer. A running Task retains objects it strongly captures. If a screen starts a search task and the user leaves, that task can keep the screen alive or call into a dead U I. Prefer [weak self] when the task may outlive the screen. Cancel the task on disappear / deinit. Store the task so you can cancel the previous one when a new query starts. Follow-ups. Cancel without weak — enough?: Cancel helps stop work; weak still protects uncertain lifetime if the task outlives the owner briefly.. Why cancel previous search?: Avoid overlapping updates and abandoned tasks stacking up.. Same idea for Combine?: Yes — long-lived subscriptions that strongly capture self are a common cycle shape..

## §7 Q8. What is the trap with `lazy var` closures?

Next. Q8. What is the trap with `lazy var` closures? Answer. A lazy var initializer is a closure that runs later. If it captures self strongly while self is retaining that lazy property, you can create a surprising ownership edge. Safer patterns: avoid touching self inside lazy init when possible; compute without storing a self-capturing escaping closure; or use an explicit weak design if you truly need self. Follow-ups. Is every lazy var a cycle?: No — only when the lazy closure strongly captures self in a way that loops ownership.. Simple safe habit?: Build formatters and pure helpers without reading other self state when you can.. Interview angle?: Show you know lazy init is a closure, not “just a delayed property.”.

## §8 Q9. What are the weekly cycle hotspots to memorize?

Next. Q9. What are the weekly cycle hotspots to memorize? Answer. Five patterns show up constantly: (1) escaping closure on self → [weak self]; (2) strong delegate → weak var delegate; (3) Timer target-selector → invalidate() (prefer block + weak); (4) NotificationCenter block observer → store token, remove, weak capture; (5) parent ↔ child → one side weak/unowned. Memorize the pattern and the one-line fix. Follow-ups. Ads / media surfaces?: Completion handlers, players, timers, notification hooks — classic magnets. Escaping work must not strongly own the screen.. Singleton caches?: Forever caches of VCs or models are abandoned memory even without a tiny two-node cycle.. Next practice?: Walk every BROKEN/FIXED pair in RetainCycleDemo.swift aloud..
