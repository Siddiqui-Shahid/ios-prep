# Audio script — Sample 03 — Tools, leaks, and abandoned memory (Q&A)
> Listen-only sample Q&A from `03-tools-and-leaks.md`. Spoken answers and follow-ups.

## §0 Q1. What is the difference between a true leak and abandoned memory?

Next. Q1. What is the difference between a true leak and abandoned memory? Answer. A true leak is allocated memory with no live references left — unreachable. Instruments Leaks is built for that. Abandoned memory is still referenced, but unused by the product logic you care about — classic retain cycles, forever caches, forgotten observers. Primary tools: Memory Graph and Allocations. A high watermark is peak bytes in a session. It may be fine if memory drops again afterward. Follow-ups. Are retain cycles true leaks?: No. They are abandoned but still reachable.. Casual “we leaked the view controller” usually means?: Abandoned via cycle or cache — Graph / Allocations, not necessarily Leaks.. Winning interview sentence?: “Retain cycles don’t show as Leaks. I use Memory Graph for the cycle and Allocations for persistent growth.”.

## §1 Q2. Why doesn’t the Leaks instrument show retain cycles?

Next. Q2. Why doesn’t the Leaks instrument show retain cycles? Answer. Leaks looks for unreachable allocations. A retain cycle keeps objects reachable from each other, so their counts never hit zero and pointers still exist. The Leaks instrument can stay clean while your view controller never deinits. Never say “I found the retain cycle in Leaks.” Follow-ups. “Leaks is clean — ship it?”: Not if you suspected a cycle. Check Memory Graph and Allocations.. When do you use Leaks?: When you suspect unreachable memory — unsafe / CF / some ObjC edges — after Graph suggests something other than a cycle.. True in the demo comments?: Yes — the commented UIKit drill notes Leaks may stay clean even for a BROKEN cycle..

## §2 Q3. What is Debug Memory Graph for?

Next. Q3. What is Debug Memory Graph for? Answer. Memory Graph answers “who retains me?” Reproduce the flow, open the graph, filter by your type, and inspect instances that should be gone. Walk incoming references until you see the cycle — closure ↔ object, timer → target, and so on. Strength: visual ownership edges. Weakness: a snapshot in time, not a full historical growth curve. Follow-ups. Typical drill?: Push a view controller, arm a broken completion, pop, open Graph — instance remains.. What if the instance is still on a window?: That is still a live owner — not every surviving instance is a cycle.. Pair with what?: Allocations, to prove the type persists across navigation generations..

## §3 Q4. What is the Allocations instrument for?

Next. Q4. What is the Allocations instrument for? Answer. Allocations shows growth over time. Record while you navigate hot paths. Look for persistent growth of your types across generations or marks after you expect teardown. Compare before and after a fix. Strength: proves abandoned heaps over time. Weakness: does not draw the cycle as clearly as Memory Graph. Follow-ups. Generation marks help how?: Mark before/after push-pop; persistent bytes of that view controller type mean it never died.. High watermark vs abandoned?: Peak can be OK if it drops; abandoned keeps rising or stuck across generations.. Jetsam connection?: Peak memory plus abandoned heaps under big events can become process kills..

## §4 Q5. What order do you use when a VC “won’t die”?

Next. Q5. What order do you use when a VC “won’t die”? Answer. 1) Temporary deinit log or breakpoint. 2) Memory Graph — find unexpected owners. 3) Allocations — confirm the type persists across navigation. 4) Leaks — only if you suspect unreachable / unsafe issues. 5) Fix ownership; re-verify deinit and Graph. Do not start with Leaks for a suspected retain cycle. Follow-ups. First lab signal?: deinit never prints after pop.. Fix checklist?: Weak capture, weak delegate, timer.invalidate(), NC token removal, Task cancel.. Verify bar?: deinit runs; Graph clear; Allocations flat across generations..

## §5 Q6. What production-shaped failure modes should I name?

Next. Q6. What production-shaped failure modes should I name? Answer. Name concrete shapes: escaping ad/network completions holding screens; timers still ticking after leave; notification blocks without tokens; parent/child strong loops; unstructured Tasks that outlive U I; singleton caches that never prune. Each maps to a tool and a fix — not to “A R C is broken.” Follow-ups. Live ticking U I after leave?: Suspect Timer target retain — invalidate.. Callbacks after pop?: Notification / Task / network completion still holding self.. Memory climbs listing → detail → back?: Abandoned VCs, image caches, or cycles — Graph + Allocations..

## §6 Q7. How do you map casual language to the right tool?

Next. Q7. How do you map casual language to the right tool? Answer. “We leaked the view controller” (casual) usually means abandoned via cycle or cache → Graph / Allocations. “True leak” means unreachable → Leaks. “Memory pressure / jetsam” means the OS killed the process → Crashlytics + memory reports. “High watermark” means peak usage — may be OK. Use precise words with interviewers. Follow-ups. Why be pedantic?: Wrong tool claim (“cycles in Leaks”) is a common senior trap question.. Teach QA this difference?: Only if useful; always teach interviewers with precise words.. Next file?: Production BookMyShow I M O C + crash-free at scale language — Verified vs Applied..

## §7 Q8. What does a clean Leaks run *not* prove?

Next. Q8. What does a clean Leaks run *not* prove? Answer. A clean Leaks run does not prove you have no retain cycles, no abandoned VCs, and no forever caches. It only suggests you did not detect unreachable leaks in that session. If deinit never runs or Memory Graph still shows your type, you are not done. Follow-ups. Ship decision if Graph still shows the view controller?: No — fix ownership first.. What proves the fix?: deinit + Graph empty + Allocations generations flat.. One sentence to memorize?: “Leaks ≠ cycle detector.”.

## §8 Q9. When do you use autorelease pools?

Next. Q9. When do you use autorelease pools? Answer. Autorelease pools let you drain temporary autoreleased ObjC / bridged objects sooner — useful in tight loops that create lots of temporaries (image or string processing helpers). That lowers high watermark. It does not break retain cycles. Mention it only when the question is about peak temporary memory in ObjC-heavy loops — not when memory climbs from a cycle. Follow-ups. Default pool?: RunLoop drains pools; tight loops may need an explicit autoreleasepool { }.. Pure Swift structs loop?: Often unnecessary.. Relate to jetsam?: Lower peak can help pressure; still fix abandonment separately.. Wrong answer?: “Wrap everything in autoreleasepool to fix leaks.”.
