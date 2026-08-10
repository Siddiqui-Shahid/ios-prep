# Sample 02 — Retain cycles and classic patterns (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer. 
> Each answer ends with **How can I relate to my case** using named work — never S-codes. 
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What is a retain cycle?
**Answer:**

> “A retain cycle is a loop of strong references. Example: a view controller owns a closure, and that closure strongly captures the view controller. Nothing outside still needs those objects, but their retain counts never hit zero, so they never deallocate. They are still reachable from each other. That is abandoned memory — not the same as an Instruments Leak, which is memory with no live references at all.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Do cycles show in the Leaks instrument? | “No. Cycles stay reachable. Use Memory Graph or Allocations.” |
| Classic fix for a stored escaping closure? | “Capture list: weak self plus guard let self.” |
| Is every mention of self in a closure a leak? | “No. Non-escaping closures usually cannot outlive self, so they often cannot form a long-lived cycle.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How do escaping closures create cycles?
**Answer:**

> “If self stores an escaping closure, and that closure captures self strongly, you get self → closure → self. Non-escaping parameters usually die with the call, so they are safer. Escaping work — stored properties, async APIs, completion handlers — can outlive the call site. That’s where cycle risk lives. Break the edge from the closure back to self with a capture list.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is weak self alone always enough? | “Not if you later create another escaping closure that strongly captures the unwrapped self without care. Nested closures need their own discipline.” |
| What does guard let self do after weak? | “It turns the optional weak reference into a strong local for the rest of the scope — only while that scope runs.” |
| Where do I see broken vs fixed? | “BoxBroken vs BoxFixed in RetainCycleDemo.swift.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Nested closures after `guard let self` — the re-strong trap?
**Answer:**

> “Classic pattern: outer closure captures weak self, then guard let self. Inside that scope, self is strong again. If you immediately create another escaping closure — nest a completion, store a Task block, schedule work — and that inner closure captures self without its own weak list, you’ve re-introduced a strong edge. Habit: every new escaping boundary gets its own capture list. Don’t assume the outer weak ‘covers’ nested work forever.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is guard let self fine? | “For the rest of a synchronous scope that doesn’t store a new escaping closure.” |
| Interview one-liner? | “Weak at the boundary; re-check every nested escaping capture.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Why are delegates usually weak?
**Answer:**

> “A child controller or view often holds a delegate pointing back to its owner. If both sides are strong, you get a permanent loop. Make the protocol class-bound — AnyObject — and store weak var delegate. That way the owner can die, and the back-pointer does not keep it alive.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why AnyObject on the protocol? | “Weak references need a class type.” |
| Strong delegate ever OK for UIKit? | “Almost never for the classic VC ↔ child pattern — instant cycle risk.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How does a Timer keep a target alive?
**Answer:**

> “Timer.scheduledTimer with target and selector strongly retains the target until you call invalidate. A repeating timer can keep a controller alive forever if you forget teardown. Always invalidate in deinit — and when leaving the screen if you intend earlier teardown. Prefer a block-based timer with weak self when you control the API — and still invalidate so the RunLoop drops the timer. Weak alone does not fix target-selector retain.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Does weak self alone fix a target-selector timer? | “No. The selector API retains the target regardless. You must invalidate. Weak helps more on block-based timers.” |
| Demo classes? | “TickerBroken never invalidates; TickerFixed stops in deinit.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What must you remember about NotificationCenter block observers?
**Answer:**

> “The modern block API returns an observer token. Store that token. Remove it on teardown with removeObserver. Still use weak self inside the block — the center owns the block, and the block must not own self forever if self also keeps the observation alive. Forgetting the token is how you never unregister cleanly. Prefer the token API in new code for clarity.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Weak capture without removing — enough? | “Weak helps the cycle edge; you still remove the observer as lifecycle hygiene.” |
| Where is a complete sketch? | “TimeZoneObserver in RetainCycleDemo.swift.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. Combine `AnyCancellable` store cycle?
**Answer:**

> “You store cancellables in a Set on self — self → Set → AnyCancellable → subscription → sink closure. If that sink strongly captures self, you close the loop. Fix: weak self in the sink, and cancel or empty the set on teardown. Same ownership idea as NotificationCenter tokens — the subscription graph must not keep the screen alive after leave.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is store(in:) itself wrong? | “No — storing is correct. The trap is a strong self inside the sink.” |
| Task vs Combine? | “Same family — long-lived work that strongly captures self.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How do Tasks create ownership problems?
**Answer:**

> “A running Task retains objects it strongly captures. If a screen starts a search task and the user leaves, that task can keep the screen alive or call into a dead UI. Prefer weak self when the task may outlive the screen. Cancel the task on disappear or deinit. Store the task so you can cancel the previous one when a new query starts.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cancel without weak — enough? | “Cancel helps stop work; weak still protects uncertain lifetime if the task outlives the owner briefly.” |
| Why cancel previous search? | “Avoid overlapping updates and abandoned tasks stacking up.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Singleton forever-cache — abandoned without a two-node cycle?
**Answer:**

> “A singleton ImageCache or SessionStore that forever keeps ViewControllers or huge models is abandoned memory even when there is no tiny A↔B cycle. The singleton is a live root. Those objects are reachable and ‘correct’ from ARC’s point of view — they just never leave. Fix: bounded caches, eviction, never stash VCs in forever maps. Tools: Allocations growth and Memory Graph showing the singleton as owner — not Leaks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is that a retain cycle? | “Not necessarily a cycle — still abandoned from the product’s point of view.” |
| Interview phrase? | “Reachable roots can abandon as badly as cycles.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. What is the trap with `lazy var` closures?
**Answer:**

> “A lazy var initializer is a closure that runs later. If it captures self strongly while self is retaining that lazy property, you can create a surprising ownership edge. Safer patterns: avoid touching self inside lazy init when possible; compute without storing a self-capturing escaping closure; or use an explicit weak design if you truly need self.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Is every lazy var a cycle? | “No — only when the lazy closure strongly captures self in a way that loops ownership.” |
| Interview angle? | “Show you know lazy init is a closure, not ‘just a delayed property.’” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. What are the weekly cycle hotspots to memorize?
**Answer:**

> “Six patterns: escaping closure on self → weak self; strong delegate → weak var delegate; Timer target-selector → invalidate — prefer block plus weak; NotificationCenter block → store token, remove, weak capture; parent ↔ child → one side weak or unowned; Combine sink or Task → weak plus cancel. Also: singleton forever-cache can abandon without a two-node cycle. Memorize pattern and one-line fix.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ads / media surfaces? | “Completions, players, timers, notification hooks — classic magnets. Escaping work must not strongly own the screen.” |
| Next practice? | “Walk every BROKEN/FIXED pair in RetainCycleDemo.swift aloud.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Timer keeps VC alive until invalidate

```swift
timer = Timer.scheduledTimer(timeInterval: 1, target: self,
 selector: #selector(tick),
 userInfo: nil, repeats: true)
```

You pop the VC. You never call `invalidate`. Does `deinit` run?

**Answer:** Usually **no**. Target-selector timers **strongly retain** the target until invalidate. Block + `[weak self]` helps the self edge, but you still invalidate so the RunLoop drops the timer.

---

### Puzzle B — NotificationCenter block without token

```swift
NotificationCenter.default.addObserver(forName: .ping, object: nil, queue: .main) { _ in
 self.handle
}
```

**Ask:** Two bugs?

**Answer:** (1) Strong `self` in the block. (2) Token discarded — cannot cleanly remove. Fix: store token, remove on teardown, `[weak self]`.

---

### Puzzle C — Task outlives screen

```swift
func onAppear {
 Task {
 let items = try await api.load
 self.items = items
 }
}
```

User leaves in 100ms. What can go wrong?

**Answer:** The Task keeps running and may keep `self` alive or update UI after leave. Prefer cancel on disappear, store the Task, and `[weak self]` when lifetime is uncertain.

---

### Puzzle D — Nested closures after guard let self

```swift
hold = { [weak self] in
 guard let self else { return }
 self.nested = {
 self.refresh // strong capture of the unwrapped self
 }
}
```

**Ask:** Did the outer weak save you?

**Answer:** Not for the nested stored closure. After `guard let self`, the inner escaping closure re-strong-captures `self`. Give the inner closure its own `[weak self]`.

---

Next: [03-tools-and-leaks.md](03-tools-and-leaks.md)
