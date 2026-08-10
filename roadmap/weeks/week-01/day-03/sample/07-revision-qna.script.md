# Audio script — Sample 07 — Revision Q&A (day-03) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. What is ARC? `(30–45s)`

Next. Q1. What is ARC? `(30–45s)` Answer. “A R C is Automatic Reference Counting — the compiler inserts retain and release calls for class instances. Each strong reference bumps the count; when it hits zero, the object is destroyed and deinit runs. It’s not a tracing garbage collector, so we don’t get GC pause semantics, but we do have to break retain cycles ourselves with weak or unowned. At BookMyShow, reliability meant holding a 99.95%+ crash-free bar at 30L+ daily active users — lifecycle and memory bugs sit in that same reliability conversation, not as an afterthought.” Follow-ups. Probe deeper?: “When a popped view controller’s strong count hits zero, deinit runs and releases images and listeners — that’s A R C reclaim, not a GC pause.”.

## §1 Q2. weak vs unowned? `(45s)`

Next. Q2. weak vs unowned? `(45s)` Answer. “Weak is an optional reference that doesn’t keep the object alive, and it becomes nil when the object deinits — so you guard let self. Unowned also doesn’t keep it alive, but it isn’t optional and isn’t zeroed; if you touch it after deinit, you crash. I use weak for network, ads, and U I callbacks where lifetime is uncertain. I only use unowned when lifetimes are provably nested — like a child object that cannot outlive its parent by construction.” Follow-ups. Probe deeper?: “For an ads completion I use weak because the ad can outlive the view controller; I’d only use unowned for a child that cannot outlive its parent by construction.”.

## §2 Q3. What’s a common retain cycle in Swift? `(45s)`

Next. Q3. What’s a common retain cycle in Swift? `(45s)` Answer. “The textbook cycle is a view controller or service that stores an escaping completion handler, and that handler strongly captures self. Now self owns the closure and the closure owns self, so retain counts never reach zero — the object is abandoned but still reachable. The fix is a capture list: weak self plus a guard. Same shape shows up with delegates stored strongly, timers, and notification blocks.” Follow-ups. Probe deeper?: “A view controller that stores onComplete equals a closure calling self.refresh without weak self never deinits after dismiss until that closure is cleared.”.

## §3 Q4. Should delegates be weak? `(30–45s)`

Next. Q4. Should delegates be weak? `(30–45s)` Answer. “If the delegate is a class — typically a view controller — storing it strong creates an easy cycle when the child also owns its parent logically. So we declare weak var delegate and constrain the protocol to AnyObject. That way the child doesn’t keep the parent alive. If you’re using struct-based callbacks, you usually pass closures with explicit capture lists instead of a weak delegate property.” Follow-ups. Probe deeper?: “Declare weak var delegate with a class-bound protocol so the child cannot keep the parent view controller alive.”.

## §4 Q5. Memory leak vs abandoned memory? `(60s)`

Next. Q5. Memory leak vs abandoned memory? `(60s)` Answer. “A true leak is memory that’s allocated but has no live references — nothing can touch it, so it can never be freed. Abandoned memory still has references — classic retain cycles or caches that never evict — but the app no longer needs those objects. Retain cycles are abandoned and still reachable, so they typically do not show in the Leaks instrument. I use Memory Graph to see ownership edges and Allocations to see persistent growth. Leaks is for unreachable cases — including some CFRelease misses. High watermark is different again — peak usage that may drop later.” Follow-ups. Probe deeper?: “A retain-cycled ImageCache still appears in Memory Graph and Allocations growth, but usually not in the Leaks instrument.”.

## §5 Q6. Does `[weak self]` always fix cycles? `(45–60s)`

Next. Q6. Does `[weak self]` always fix cycles? `(45–60s)` Answer. “Weak self only weakens that closure’s reference to self. If a Timer is still retaining you via target-selector, or a NotificationCenter block is registered without teardown, or another nested escaping closure captures self strongly after guard let self, you can still fail to deinit. So weak is necessary for escaping closures, but the checklist is broader: timers invalidate, observer tokens removed, tasks cancelled, delegates weak, caches bounded.” Follow-ups. Probe deeper?: “Weak self in a network completion still leaves a repeating Timer retaining the view controller until you call invalidate.”.

## §6 Q7. `deinit` not called — checklist? `(60s)`

Next. Q7. `deinit` not called — checklist? `(60s)` Answer. “First I assume the object is still retained — A R C isn’t randomly broken. I check escaping closures and tasks, repeating timers that weren’t invalidated, NotificationCenter tokens still registered, strong delegates, Combine sinks, and whether the controller is still in a navigation stack, presented, or held by a singleton cache. Then I’d open Memory Graph and inspect who points at the instance. Once I break the unexpected strong edge, deinit should fire. I’d verify with Allocations that the type doesn’t persist across navigation generations.” Follow-ups. Probe deeper?: “If Memory Graph shows NotificationCenter to block to self, remove the observer token and deinit should fire on the next teardown.”.

## §7 Q8. Value types and ARC? `(30–45s)`

Next. Q8. Value types and ARC? `(30–45s)` Answer. “Structs and enums are value types — copying them doesn’t use A R C the way class instances do. But if a struct stores a class reference, that reference is still strong and retains the class. Closures are reference types under the hood, so a struct that somehow participates in escaping closure graphs can still keep objects alive. So ‘we only use structs’ doesn’t automatically mean ‘no retain cycles’ if classes and closures are in the mix.” Follow-ups. Probe deeper?: “A struct Model holding an ImageCache class still retains that cache; copying the struct bumps that reference’s retain count.”.

## §8 Q9. Autorelease pools — when? `(45s)`

Next. Q9. Autorelease pools — when? `(45s)` Answer. “Autorelease pools let you drain temporary autoreleased objects sooner — useful in tight loops that create lots of bridged ObjC temporaries, like some image or string processing paths. That reduces high watermark. It does not break retain cycles. If the interviewer asks about climbing memory from a cycle, I talk weak captures and Instruments Graph — not autorelease pools.” Follow-ups. Probe deeper?: “Wrapping a decode loop in autoreleasepool drains temporary bridged objects each iteration without fixing a retain cycle.”.

## §9 Q10. How do you prevent leaks with async `Task`? `(60s)`

Next. Q10. How do you prevent leaks with async `Task`? `(60s)` Answer. “A Task keeps alive anything it strongly captures for as long as it runs. If a view controller fires a task and the user pops the screen, a strong self capture can keep the controller around until the task finishes. I store the task, cancel it in deinit or onDisappear, and use weak self inside when the work is optional after teardown. Structured concurrency children cancel with their parent, which is preferable when the A P I allows it.” Follow-ups. Probe deeper?: “Store the fetch Task, cancel it in onDisappear, and capture weak self so a popped search screen isn’t kept alive until HTTP finishes.”.

## §10 Q11. How does a Timer create a retain cycle / keep a target alive? `(45–60s)`

Next. Q11. How does a Timer create a retain cycle / keep a target alive? `(45–60s)` Answer. “When you use Timer.scheduledTimer with target and selector, the timer strongly retains the target until you call invalidate. For a repeating timer on a view controller, that means the controller can live forever even after you think you dismissed it. The fix is to invalidate in deinit and usually when leaving the screen, and set the timer property to nil. Block-based timers with weak self avoid the selector retain semantics for self, but you still invalidate so the RunLoop drops the timer.” Follow-ups. Probe deeper?: “Timer.scheduledTimer with target self retains the view controller; invalidate in deinit or viewWillDisappear or the screen never frees.”.

## §11 Q12. NotificationCenter block observers — what must you remember? `(45–60s)`

Next. Q12. NotificationCenter block observers — what must you remember? `(45–60s)` Answer. “addObserver forName with a block returns an observer token. I store that token on the object and remove it in deinit or when stopping observation. Inside the block I capture weak self so the center’s ownership of the block doesn’t keep my controller alive forever. Forgetting either the token removal or the weak capture is a common abandoned-memory bug. I don’t rely on ‘Leaks will tell me’ — I’d expect Memory Graph to show the observer graph.” Follow-ups. Probe deeper?: “Store the token from addObserver forName and remove it in deinit, with weak self inside the block.”. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “What is ARC?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “What is ARC?” — how do you answer without jargon? `(60–90s)` Answer. “A R C is Automatic Reference Counting — the compiler inserts retain and release calls for class instances. Each strong reference bumps the count; when it hits zero, the object is destroyed and deinit runs. It’s not a tracing garbage collector, so we don’t get GC pause semantics, but we do have to break retain cycles ourselves with weak or unowned. At BookMyShow, reliability meant holding a 99.95%+ crash-free bar at 30L+ daily active users — lifecycle and memory bugs sit in that same reliability conversation, not as an afterthought.”. Follow-ups. What concept is this really?: What is A R C. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “weak vs unowned” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “weak vs unowned” just broke under load. What do you check first? `(60–90s)` Answer. “Weak is an optional reference that doesn’t keep the object alive, and it becomes nil when the object deinits — so you guard let self. Unowned also doesn’t keep it alive, but it isn’t optional and isn’t zeroed; if you touch it after deinit, you crash. I use weak for network, ads, and U I callbacks where lifetime is uncertain. I only use unowned when lifetimes are provably nested — like a child object that cannot outlive its parent by construction.”. Follow-ups. What concept is this really?: weak vs unowned. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “What’s a common retain cycle in Swift”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “What’s a common retain cycle in Swift”. How do you diagnose? `(60–90s)` Answer. “The textbook cycle is a view controller or service that stores an escaping completion handler, and that handler strongly captures self. Now self owns the closure and the closure owns self, so retain counts never reach zero — the object is abandoned but still reachable. The fix is a capture list: weak self plus a guard. Same shape shows up with delegates stored strongly, timers, and notification blocks.”. Follow-ups. What concept is this really?: What’s a common retain cycle in Swift. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “Should delegates be weak”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Should delegates be weak”. What do you say and what fix do you propose? `(60–90s)` Answer. “If the delegate is a class — typically a view controller — storing it strong creates an easy cycle when the child also owns its parent logically. So we declare weak var delegate and constrain the protocol to AnyObject. That way the child doesn’t keep the parent alive. If you’re using struct-based callbacks, you usually pass closures with explicit capture lists instead of a weak delegate property.”. Follow-ups. What concept is this really?: Should delegates be weak. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Memory leak vs abandoned memory”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Memory leak vs abandoned memory”? `(60–90s)` Answer. “A true leak is memory that’s allocated but has no live references — nothing can touch it, so it can never be freed. Abandoned memory still has references — classic retain cycles or caches that never evict — but the app no longer needs those objects. Retain cycles are abandoned and still reachable, so they typically do not show in the Leaks instrument. I use Memory Graph to see ownership edges and Allocations to see persistent growth. Leaks is for unreachable cases — including some CFRelease misses. High watermark is different again — peak usage that may drop later.”. Follow-ups. What concept is this really?: Memory leak vs abandoned memory. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “Does `[weak self]` always fix cycles” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Does `[weak self]` always fix cycles” and how you’d correct it? `(60–90s)` Answer. “Weak self only weakens that closure’s reference to self. If a Timer is still retaining you via target-selector, or a NotificationCenter block is registered without teardown, or another nested escaping closure captures self strongly after guard let self, you can still fail to deinit. So weak is necessary for escaping closures, but the checklist is broader: timers invalidate, observer tokens removed, tasks cancelled, delegates weak, caches bounded.”. Follow-ups. What concept is this really?: Does [weak self] always fix cycles. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “`deinit` not called — checklist?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “`deinit` not called — checklist?” — how do you answer without jargon? `(60–90s)` Answer. “First I assume the object is still retained — A R C isn’t randomly broken. I check escaping closures and tasks, repeating timers that weren’t invalidated, NotificationCenter tokens still registered, strong delegates, Combine sinks, and whether the controller is still in a navigation stack, presented, or held by a singleton cache. Then I’d open Memory Graph and inspect who points at the instance. Once I break the unexpected strong edge, deinit should fire. I’d verify with Allocations that the type doesn’t persist across navigation generations.”. Follow-ups. What concept is this really?: deinit not called — checklist. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Value types and ARC” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Value types and ARC” just broke under load. What do you check first? `(60–90s)` Answer. “Structs and enums are value types — copying them doesn’t use A R C the way class instances do. But if a struct stores a class reference, that reference is still strong and retains the class. Closures are reference types under the hood, so a struct that somehow participates in escaping closure graphs can still keep objects alive. So ‘we only use structs’ doesn’t automatically mean ‘no retain cycles’ if classes and closures are in the mix.”. Follow-ups. What concept is this really?: Value types and A R C. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. “I found the retain cycle in Leaks” — what’s wrong? `(90s)`

Next. T1. “I found the retain cycle in Leaks” — what’s wrong? `(90s)` Answer. “That’s the classic trap sentence. Leaks looks for unreachable allocations — memory with no live references. A retain cycle keeps objects reachable from each other, so retain counts never hit zero and pointers still exist. Leaks can stay completely clean while your view controller never deinits. For a suspected cycle I open Memory Graph and ask who still retains me, then use Allocations to prove the type persists across navigation generations. Leaks comes later if Graph suggests CF or unsafe unreachable weirdness — like a missed CFRelease. One sentence I refuse to say in interviews: I found the retain cycle in Leaks.” Follow-ups. Probe deeper?: “Clean Leaks does not prove absence of cycles. If deinit never runs, you’re not done.”.

## §21 T2. Nested closures after `guard let self`? `(90s)`

Next. T2. Nested closures after `guard let self`? `(90s)` swift hold = { [weak self] in guard let self else { return } self.nested = { self.refresh } } Answer. “The outer weak looks safe, but guard let self makes a strong local for the rest of that scope. The inner escaping closure then captures that strong self and gets stored — you’ve re-closed the loop. Every new escaping boundary needs its own capture list. Weak at the outer door does not automatically protect nested stored work. Same family of bug shows up when you weak-capture, unwrap, then spin a Task or Combine sink that strongly captures self again.” Follow-ups. Probe deeper?: “Habit: every escaping boundary gets its own weak list — don’t assume the outer weak covers nested forever.”.

## §22 T3. Combine `AnyCancellable` store cycle? `(90s)`

Next. T3. Combine `AnyCancellable` store cycle? `(90s)` Answer. “Self owns a Set of AnyCancellable. The subscription owns the sink. If the sink strongly captures self, you get self → Set → cancellable → sink → self. store(in:) itself is correct — the trap is the strong sink. Fix: weak self in the sink, and cancel or empty the set on teardown. Same ownership idea as NotificationCenter tokens — the subscription graph must not keep the screen alive after leave. Memory Graph shows the Set and the sink edge; Leaks often stays quiet.” Follow-ups. Probe deeper?: “Reviewer question: does every sink use weak self, and when do cancellables clear?”.

## §23 T4. `unowned` use-after-free crash? `(90s)`

Next. T4. `unowned` use-after-free crash? `(90s)` Answer. “Unowned does not keep the object alive and does not zero. If the object dies first, the reference dangles. Touching it crashes — use-after-free — which is a different failure mode from a retain cycle. That’s why I prefer weak when lifetime is uncertain: network callbacks, ads completions, delayed work after a screen pop. Unowned only when I can prove nested lifetime in one sentence — child owned by parent, never escapes. In the learning lab, scheduleUnownedCrashRisk demonstrates exactly that delayed crash after the last strong owner is gone.” Follow-ups. Probe deeper?: “Interview default under uncertainty: weak. Unowned is a sharp tool, not a micro-optimization.”.

## §24 T5. Clean Leaks ≠ no cycles — prove it? `(90s)`

Next. T5. Clean Leaks ≠ no cycles — prove it? `(90s)` Answer. “Scenario: Leaks is green, but after pop the view controller’s deinit never prints, and Memory Graph still shows the type. That is abandoned reachable memory — classic cycle or forever cache — not a clean bill of health. I’d walk Graph edges, confirm with Allocations generations, fix the ownership edge, then re-check deinit and Graph. Autoreleasepool won’t fix this. Starting in Leaks for a suspected cycle wastes time and teaches the wrong mental model. Memorize: Leaks is not a cycle detector.” Follow-ups. Probe deeper?: “Ship decision if Graph still shows the view controller? No — fix ownership first.”.

## §25 T6. Singleton forever-cache — abandoned without a two-node cycle? `(90–120s)`

Next. T6. Singleton forever-cache — abandoned without a two-node cycle? `(90–120s)` Answer. “Interviewers sometimes only hunt A↔B loops. But a singleton ImageCache or SessionStore that forever keeps ViewControllers or huge models is abandoned memory even with no tiny cycle. The singleton is a live root — A R C is ‘correct,’ the product just never lets go. Tools: Allocations growth and Memory Graph showing the singleton as owner — not Leaks. Fix: bounded caches, eviction, never stash VCs in forever maps. In image-loader design I’d say NSCache with cost limits, not a static Dictionary that only grows.” Follow-ups. Probe deeper?: “Phrase: reachable roots can abandon as badly as cycles.”.

## §26 T7. Timer block+weak vs target:selector? `(90s)`

Next. T7. Timer block+weak vs target:selector? `(90s)` Answer. “Target-selector scheduledTimer strongly retains the target until invalidate — weak self in some other closure does not cancel that retain. Block-based timers let you capture weak self so the block doesn’t keep self alive by capture, but you still must invalidate so the RunLoop drops the timer. Checklist: prefer block plus weak when you control the A P I; always invalidate in deinit and usually on disappear; nil the property. Live ticking U I after leave is the symptom that screams timer.” Follow-ups. Probe deeper?: “Does weak self alone fix a target-selector timer? No — invalidate.”.

## §27 T8. Verified reliability vs Applied Graph triage? `(90–120s)`

Next. T8. Verified reliability vs Applied Graph triage? `(90–120s)` Answer. “Verified: at BookMyShow we held a 99.95%+ crash-free bar at 30L+ daily active users with Crashlytics workflows and I M O C ownership for P0/P1 — memory and lifecycle bugs sit in that reliability culture. Applied: if a screen won’t die, I wouldn’t start in Leaks for a suspected retain cycle. I’d reproduce push/pop, use Memory Graph for retain edges, Allocations for persistent growth, then fix weak captures, timer invalidation, and NotificationCenter tokens. I will not invent a BMS Memory Graph war story or hang app-wide crash free sessions on one memory ticket. On incident STAR questions, reliability culture leads; A R C is supporting color unless they ask about memory.” Follow-ups. Probe deeper?: “Honesty checks: Verified vs Applied labeled? No ‘cycles in Leaks’? No invented Graph ticket?”.

## §28 T9. CFRelease miss vs cycle — which tool? `(90s)`

Next. T9. CFRelease miss vs cycle — which tool? `(90s)` Answer. “Two different bugs. Missed CFRelease — or wrong CF bridging ownership — can leave an allocation with no live Swift owner: a true unreachable leak. That’s Leaks territory. A view controller retain cycle is still reachable: Graph and Allocations, Leaks stays quiet. Jetsam clusters in Crashlytics tell you the fleet is under pressure; they don’t draw ownership edges. Autoreleasepool lowers temporary watermark; it doesn’t fix either a CF miss or a cycle. Senior signal is picking the tool that matches the failure mode.” Follow-ups. Probe deeper?: “Everyday Swift class cycles → Graph. CF/unsafe unreachable → Leaks. Fleet kills → Crashlytics, then Graph if you suspect abandonment.”.

## §29 T10. Task outlives screen + NC token forgotten? `(90–120s)`

Next. T10. Task outlives screen + NC token forgotten? `(90–120s)` Answer. “Two magnets that often co-exist on a screen. A fire-and-forget Task strongly capturing self keeps the view controller alive until the work finishes — or updates U I after leave. Fix: store the Task, cancel on disappear, weak self when lifetime is uncertain. Separately, a NotificationCenter block without a stored token can’t unregister cleanly, and a strong block capture keeps the ownership graph warm. Fix: store token, remove on teardown, weak self in the block. Weak self alone on the Task doesn’t remove the observer; removing the observer doesn’t cancel the Task. Checklist both before you call the screen ‘fixed,’ then verify deinit and Memory Graph.” Follow-ups. Probe deeper?: “Symptom split: callbacks after pop → NC/Task/network; live ticking → Timer.”.

## §30 T11. Weak vs unowned when lifetime uncertain? `(90–120s)`

Next. T11. Weak vs unowned when lifetime uncertain? `(90–120s)` Answer. “When the view controller dies, unowned self dangles. The late callback crashes (use-after-free). Prefer [weak self] when the network can outlive the screen. ---.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §31 T12. Is ARC broken? `(90–120s)`

Next. T12. Is ARC broken? `(90–120s)` Answer. “No. Something still strongly owns the view controller — almost always the escaping closure cycle. Open Memory Graph; break the edge; pop again until the print fires. ---.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §32 T13. Parent ↔ child choice? `(90–120s)`

Next. T13. Parent ↔ child choice? `(90–120s)` Answer. “Either can work; unowned is allowed when nested lifetime is proven and you want non-optional access. If anything about teardown is fuzzy, weak. Interview default under uncertainty: weak. ---.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §33 T14. “Structs don’t retain”? `(90–120s)`

Next. T14. “Structs don’t retain”? `(90–120s)` Answer. “False confidence. A struct holding a class still retains that class. Closures are reference types under the hood. Cycles live among class instances — structs can participate by storing them. --- Next: 02-retain-cycles.md.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
