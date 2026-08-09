# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What is ARC? `(30–45s)`

**Answer:**

> “ARC is Automatic Reference Counting — the compiler inserts retain and release calls for class instances. Each strong reference bumps the count; when it hits zero, the object is destroyed and deinit runs. It’s not a tracing garbage collector, so we don’t get GC pause semantics, but we do have to break retain cycles ourselves with weak or unowned. At BookMyShow, reliability meant holding a 99.95%+ crash-free bar at 30L+ DAU — lifecycle and memory bugs sit in that same reliability conversation, not as an afterthought.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “When a popped VC’s strong count hits zero, deinit runs and releases images and listeners — that’s ARC reclaim, not a GC pause.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q2. weak vs unowned? `(45s)`

**Answer:**

> “Weak is an optional reference that doesn’t keep the object alive, and it becomes nil when the object deinits — so you guard let self. Unowned also doesn’t keep it alive, but it isn’t optional and isn’t zeroed; if you touch it after deinit, you crash. I use weak for network, ads, and UI callbacks where lifetime is uncertain. I only use unowned when lifetimes are provably nested — like a child object that cannot outlive its parent by construction.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “For an ads completion I use weak because the ad can outlive the VC; I’d only use unowned for a child that cannot outlive its parent by construction.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What’s a common retain cycle in Swift? `(45s)`

**Answer:**

> “The textbook cycle is a view controller or service that stores an escaping completion handler, and that handler strongly captures self. Now self owns the closure and the closure owns self, so retain counts never reach zero — the object is abandoned but still reachable. The fix is a capture list: weak self plus a guard. Same shape shows up with delegates stored strongly, timers, and notification blocks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “A VC that stores onComplete equals a closure calling self.refresh without weak self never deinits after dismiss until that closure is cleared.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Should delegates be weak? `(30–45s)`

**Answer:**

> “If the delegate is a class — typically a view controller — storing it strong creates an easy cycle when the child also owns its parent logically. So we declare weak var delegate and constrain the protocol to AnyObject. That way the child doesn’t keep the parent alive. If you’re using struct-based callbacks, you usually pass closures with explicit capture lists instead of a weak delegate property.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Declare weak var delegate with a class-bound protocol so the child cannot keep the parent VC alive.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Memory leak vs abandoned memory? `(60s)`

**Answer:**

> “A true leak is memory that’s allocated but has no live references — nothing can touch it, so it can never be freed. Abandoned memory still has references — classic retain cycles or caches that never evict — but the app no longer needs those objects. Retain cycles are abandoned and still reachable, so they typically do not show in the Leaks instrument. I use Memory Graph to see ownership edges and Allocations to see persistent growth. Leaks is for unreachable cases — including some CFRelease misses. High watermark is different again — peak usage that may drop later.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “A retain-cycled ImageCache still appears in Memory Graph and Allocations growth, but usually not in the Leaks instrument.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Does `[weak self]` always fix cycles? `(45–60s)`

**Answer:**

> “Weak self only weakens that closure’s reference to self. If a Timer is still retaining you via target-selector, or a NotificationCenter block is registered without teardown, or another nested escaping closure captures self strongly after guard let self, you can still fail to deinit. So weak is necessary for escaping closures, but the checklist is broader: timers invalidate, observer tokens removed, tasks cancelled, delegates weak, caches bounded.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Weak self in a network completion still leaves a repeating Timer retaining the VC until you call invalidate.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. `deinit` not called — checklist? `(60s)`

**Answer:**

> “First I assume the object is still retained — ARC isn’t randomly broken. I check escaping closures and tasks, repeating timers that weren’t invalidated, NotificationCenter tokens still registered, strong delegates, Combine sinks, and whether the controller is still in a navigation stack, presented, or held by a singleton cache. Then I’d open Memory Graph and inspect who points at the instance. Once I break the unexpected strong edge, deinit should fire. I’d verify with Allocations that the type doesn’t persist across navigation generations.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “If Memory Graph shows NotificationCenter to block to self, remove the observer token and deinit should fire on the next teardown.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Value types and ARC? `(30–45s)`

**Answer:**

> “Structs and enums are value types — copying them doesn’t use ARC the way class instances do. But if a struct stores a class reference, that reference is still strong and retains the class. Closures are reference types under the hood, so a struct that somehow participates in escaping closure graphs can still keep objects alive. So ‘we only use structs’ doesn’t automatically mean ‘no retain cycles’ if classes and closures are in the mix.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “A struct Model holding an ImageCache class still retains that cache; copying the struct bumps that reference’s retain count.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Autorelease pools — when? `(45s)`

**Answer:**

> “Autorelease pools let you drain temporary autoreleased objects sooner — useful in tight loops that create lots of bridged ObjC temporaries, like some image or string processing paths. That reduces high watermark. It does not break retain cycles. If the interviewer asks about climbing memory from a cycle, I talk weak captures and Instruments Graph — not autorelease pools.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Wrapping a decode loop in autoreleasepool drains temporary bridged objects each iteration without fixing a retain cycle.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. How do you prevent leaks with async `Task`? `(60s)`

**Answer:**

> “A Task keeps alive anything it strongly captures for as long as it runs. If a view controller fires a task and the user pops the screen, a strong self capture can keep the controller around until the task finishes. I store the task, cancel it in deinit or onDisappear, and use weak self inside when the work is optional after teardown. Structured concurrency children cancel with their parent, which is preferable when the API allows it.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Store the fetch Task, cancel it in onDisappear, and capture weak self so a popped search screen isn’t kept alive until HTTP finishes.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. How does a Timer create a retain cycle / keep a target alive? `(45–60s)`

**Answer:**

> “When you use Timer.scheduledTimer with target and selector, the timer strongly retains the target until you call invalidate. For a repeating timer on a view controller, that means the controller can live forever even after you think you dismissed it. The fix is to invalidate in deinit and usually when leaving the screen, and set the timer property to nil. Block-based timers with weak self avoid the selector retain semantics for self, but you still invalidate so the RunLoop drops the timer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Timer.scheduledTimer with target self retains the VC; invalidate in deinit or viewWillDisappear or the screen never frees.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q12. NotificationCenter block observers — what must you remember? `(45–60s)`

**Answer:**

> “addObserver forName with a block returns an observer token. I store that token on the object and remove it in deinit or when stopping observation. Inside the block I capture weak self so the center’s ownership of the block doesn’t keep my controller alive forever. Forgetting either the token removal or the weak capture is a common abandoned-memory bug. I don’t rely on ‘Leaks will tell me’ — I’d expect Memory Graph to show the observer graph.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Store the token from addObserver forName and remove it in deinit, with weak self inside the block.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These are the ones that separate “I read a blog” from “I’ve been burned.”  
> Timed drill cites **T1, T5, T8** — rehearse those cold.

---

### T1. “I found the retain cycle in Leaks” — what’s wrong? `(90s)`

**Answer:**

> “That’s the classic trap sentence. Leaks looks for unreachable allocations — memory with no live references. A retain cycle keeps objects reachable from each other, so retain counts never hit zero and pointers still exist. Leaks can stay completely clean while your view controller never deinits. For a suspected cycle I open Memory Graph and ask who still retains me, then use Allocations to prove the type persists across navigation generations. Leaks comes later if Graph suggests CF or unsafe unreachable weirdness — like a missed CFRelease. One sentence I refuse to say in interviews: I found the retain cycle in Leaks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Clean Leaks does not prove absence of cycles. If deinit never runs, you’re not done.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T2. Nested closures after `guard let self` `(90s)`

```swift
hold = { [weak self] in
    guard let self else { return }
    self.nested = { self.refresh() }
}
```

**Answer:**

> “The outer weak looks safe, but guard let self makes a strong local for the rest of that scope. The inner escaping closure then captures that strong self and gets stored — you’ve re-closed the loop. Every new escaping boundary needs its own capture list. Weak at the outer door does not automatically protect nested stored work. Same family of bug shows up when you weak-capture, unwrap, then spin a Task or Combine sink that strongly captures self again.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Habit: every escaping boundary gets its own weak list — don’t assume the outer weak covers nested forever.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T3. Combine `AnyCancellable` store cycle `(90s)`

**Answer:**

> “Self owns a Set of AnyCancellable. The subscription owns the sink. If the sink strongly captures self, you get self → Set → cancellable → sink → self. store(in:) itself is correct — the trap is the strong sink. Fix: weak self in the sink, and cancel or empty the set on teardown. Same ownership idea as NotificationCenter tokens — the subscription graph must not keep the screen alive after leave. Memory Graph shows the Set and the sink edge; Leaks often stays quiet.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Reviewer question: does every sink use weak self, and when do cancellables clear?” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T4. `unowned` use-after-free crash `(90s)`

**Answer:**

> “Unowned does not keep the object alive and does not zero. If the object dies first, the reference dangles. Touching it crashes — use-after-free — which is a different failure mode from a retain cycle. That’s why I prefer weak when lifetime is uncertain: network callbacks, ads completions, delayed work after a screen pop. Unowned only when I can prove nested lifetime in one sentence — child owned by parent, never escapes. In the learning lab, scheduleUnownedCrashRisk demonstrates exactly that delayed crash after the last strong owner is gone.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Interview default under uncertainty: weak. Unowned is a sharp tool, not a micro-optimization.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### T5. Clean Leaks ≠ no cycles — prove it `(90s)`

**Answer:**

> “Scenario: Leaks is green, but after pop the VC’s deinit never prints, and Memory Graph still shows the type. That is abandoned reachable memory — classic cycle or forever cache — not a clean bill of health. I’d walk Graph edges, confirm with Allocations generations, fix the ownership edge, then re-check deinit and Graph. Autoreleasepool won’t fix this. Starting in Leaks for a suspected cycle wastes time and teaches the wrong mental model. Memorize: Leaks is not a cycle detector.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Ship decision if Graph still shows the VC? No — fix ownership first.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T6. Singleton forever-cache — abandoned without a two-node cycle `(90–120s)`

**Answer:**

> “Interviewers sometimes only hunt A↔B loops. But a singleton ImageCache or SessionStore that forever keeps ViewControllers or huge models is abandoned memory even with no tiny cycle. The singleton is a live root — ARC is ‘correct,’ the product just never lets go. Tools: Allocations growth and Memory Graph showing the singleton as owner — not Leaks. Fix: bounded caches, eviction, never stash VCs in forever maps. In image-loader design I’d say NSCache with cost limits, not a static Dictionary that only grows.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Phrase: reachable roots can abandon as badly as cycles.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T7. Timer block+weak vs target:selector `(90s)`

**Answer:**

> “Target-selector scheduledTimer strongly retains the target until invalidate — weak self in some other closure does not cancel that retain. Block-based timers let you capture weak self so the block doesn’t keep self alive by capture, but you still must invalidate so the RunLoop drops the timer. Checklist: prefer block plus weak when you control the API; always invalidate in deinit and usually on disappear; nil the property. Live ticking UI after leave is the symptom that screams timer.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Does weak self alone fix a target-selector timer? No — invalidate.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### T8. Verified reliability vs Applied Graph triage `(90–120s)`

**Answer:**

> “Verified: at BookMyShow we held a 99.95%+ crash-free bar at 30L+ DAU with Crashlytics workflows and IMOC ownership for P0/P1 — memory and lifecycle bugs sit in that reliability culture. Applied: if a screen won’t die, I wouldn’t start in Leaks for a suspected retain cycle. I’d reproduce push/pop, use Memory Graph for retain edges, Allocations for persistent growth, then fix weak captures, timer invalidation, and NotificationCenter tokens. I will not invent a BMS Memory Graph war story or hang app-wide CFS on one memory ticket. On incident STAR questions, reliability culture leads; ARC is supporting color unless they ask about memory.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Honesty checks: Verified vs Applied labeled? No ‘cycles in Leaks’? No invented Graph ticket?” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Applied Memory Graph / Allocations triage — label Applied.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing a BMS Graph discovery.

---

### T9. CFRelease miss vs cycle — which tool? `(90s)`

**Answer:**

> “Two different bugs. Missed CFRelease — or wrong CF bridging ownership — can leave an allocation with no live Swift owner: a true unreachable leak. That’s Leaks territory. A VC retain cycle is still reachable: Graph and Allocations, Leaks stays quiet. Jetsam clusters in Crashlytics tell you the fleet is under pressure; they don’t draw ownership edges. Autoreleasepool lowers temporary watermark; it doesn’t fix either a CF miss or a cycle. Senior signal is picking the tool that matches the failure mode.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Everyday Swift class cycles → Graph. CF/unsafe unreachable → Leaks. Fleet kills → Crashlytics, then Graph if you suspect abandonment.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale — for jetsam/Crashlytics culture framing only.
- **Concept:** Tool selection by failure mode.

---

### T10. Task outlives screen + NC token forgotten `(90–120s)`

**Answer:**

> “Two magnets that often co-exist on a screen. A fire-and-forget Task strongly capturing self keeps the VC alive until the work finishes — or updates UI after leave. Fix: store the Task, cancel on disappear, weak self when lifetime is uncertain. Separately, a NotificationCenter block without a stored token can’t unregister cleanly, and a strong block capture keeps the ownership graph warm. Fix: store token, remove on teardown, weak self in the block. Weak self alone on the Task doesn’t remove the observer; removing the observer doesn’t cancel the Task. Checklist both before you call the screen ‘fixed,’ then verify deinit and Memory Graph.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Probe deeper? | “Symptom split: callbacks after pop → NC/Task/network; live ticking → Timer.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Timed set suggestions

| Drill | Questions | Focus |
|---|---|---|
| Core 10 min | Q1, Q2, Q5, Q11, T1, T5, T8 | ARC + Leaks myth + Verified/Applied |
| Tools 8 min | Q5, T1, T5, T9 | Leak vs abandoned + CF vs cycle |
| Ownership 10 min | Q6, Q11, Q12, T2, T3, T7 | Nested, Combine, Timer, NC |
| Brain-puzzle sprint 12 min | T1, T5, T8, T4, T6 | Leaks myth + honesty + unowned + forever cache |

## Timed drill (subset)

Record aloud: **Q1, Q2, Q5, Q11, T1, T5, T8**.

Score against [`../../../timing/answer-timing-guide.md`](../../../timing/answer-timing-guide.md).  
Log misses (especially Leaks-vs-cycle confusion and Verified/Applied blur) in your gotchas list.

Revision twin: [`../../../revision/weeks/week-01/day-03.md`](../../../revision/weeks/week-01/day-03.md).
