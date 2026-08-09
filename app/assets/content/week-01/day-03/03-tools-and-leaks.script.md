# Audio script — Sample 03 — Tools, leaks, and abandoned memory (Q&A)
> Listen-only sample Q&A from `03-tools-and-leaks.md`. Spoken answers and follow-ups.

## §0 Q1. What is the difference between a true leak and abandoned memory?

Next. Q1. What is the difference between a true leak and abandoned memory? Answer. “A true leak is allocated memory with no live references left — unreachable. Instruments Leaks is built for that. Abandoned memory is still referenced, but unused by the product logic you care about — classic retain cycles, forever caches, forgotten observers. Primary tools: Memory Graph and Allocations. A high watermark is peak bytes in a session. It may be fine if memory drops again afterward.” Follow-ups. Are retain cycles true leaks?: “No. They are abandoned but still reachable.”. Casual ‘we leaked the view controller’ usually means?: “Abandoned via cycle or cache — Graph / Allocations, not necessarily Leaks.”. Winning interview sentence?: “Retain cycles don’t show as Leaks. I use Memory Graph for the cycle and Allocations for persistent growth.”.

## §1 Q2. Why doesn’t the Leaks instrument show retain cycles?

Next. Q2. Why doesn’t the Leaks instrument show retain cycles? Answer. “Leaks looks for unreachable allocations. A retain cycle keeps objects reachable from each other, so their counts never hit zero and pointers still exist. The Leaks instrument can stay clean while your view controller never deinits. Never say ‘I found the retain cycle in Leaks.’” Follow-ups. ‘Leaks is clean — ship it?’: “Not if you suspected a cycle. Check Memory Graph and Allocations.”. When do you use Leaks?: “When you suspect unreachable memory — unsafe / CF / some ObjC edges — after Graph suggests something other than a cycle.”.

## §2 Q3. CF / unsafe — when is a missed `CFRelease` a true leak?

Next. Q3. CF / unsafe — when is a missed `CFRelease` a true leak? Answer. “Core Foundation and some unsafe / C bridges can hand you a CFTypeRef you own. If you forget CFRelease — or the matching transfer rule under A R C bridging — that allocation can become unreachable with no Swift owner. That’s a real Leaks hit: no live references, still allocated. Contrast with a retain cycle: still reachable, Leaks stays quiet. So: Graph for cycles; Leaks when CF/unsafe ownership was dropped.” Follow-ups. Everyday Swift classes?: “Usually A R C owns them — cycles are Graph problems, not CFRelease.”. Interview trap?: “Saying every memory bug is a Leaks bug — or that CF bugs never need Leaks.”.

## §3 Q4. What is Debug Memory Graph for?

Next. Q4. What is Debug Memory Graph for? Answer. “Memory Graph answers ‘who retains me?’ Reproduce the flow, open the graph, filter by your type, and inspect instances that should be gone. Walk incoming references until you see the cycle — closure ↔ object, timer → target, and so on. Strength: visual ownership edges. Weakness: a snapshot in time, not a full historical growth curve.” Follow-ups. Typical drill?: “Push a view controller, arm a broken completion, pop, open Graph — instance remains.”. What if the instance is still on a window?: “That is still a live owner — not every surviving instance is a cycle.”. Pair with what?: “Allocations, to prove the type persists across navigation generations.”.

## §4 Q5. Walk the Memory Graph edge-walking script aloud

Next. Q5. Walk the Memory Graph edge-walking script aloud Answer. “Learning-lab script: present the leaky view controller, assign the strong completion, dismiss. Open Debug Memory Graph. Filter the view controller type — confirm the instance remains. Click it. Walk incoming edges until you see self → closure → self, or timer → target. Repeat with the fixed view controller — confirm absence. Optional: Allocations generation marks; optional Leaks — note it may stay clean for the cycle. Pass bar: explain why Leaks stayed clean while Graph showed the object. Label this Applied or Learning-lab — do not claim it as a shipped BookMyShow war story.” Follow-ups. Provenance?: “Learning-lab — and How I would apply it if narrating for BMS-shaped apps.”. Forbidden?: “‘At BMS I opened Memory Graph and found the ad retain cycle’ without evidence.”.

## §5 Q6. What is the Allocations instrument for?

Next. Q6. What is the Allocations instrument for? Answer. “Allocations shows growth over time. Record while you navigate hot paths. Look for persistent growth of your types across generations or marks after you expect teardown. Compare before and after a fix. Strength: proves abandoned heaps over time. Weakness: does not draw the cycle as clearly as Memory Graph.” Follow-ups. Generation marks help how?: “Mark before/after push-pop; persistent bytes of that view controller type mean it never died.”. High watermark vs abandoned?: “Peak can be OK if it drops; abandoned keeps rising or stuck across generations.”.

## §6 Q7. What order do you use when a VC won’t die?

Next. Q7. What order do you use when a VC won’t die? Answer. “One: temporary deinit log or breakpoint. Two: Memory Graph — find unexpected owners. Three: Allocations — confirm the type persists across navigation. Four: Leaks — only if you suspect unreachable or unsafe issues. Five: fix ownership; re-verify deinit and Graph. Do not start with Leaks for a suspected retain cycle.” Follow-ups. First lab signal?: “deinit never prints after pop.”. Fix checklist?: “Weak capture, weak delegate, timer invalidate, NC token removal, Task cancel.”. Verify bar?: “deinit runs; Graph clear; Allocations flat across generations.”.

## §7 Q8. Jetsam / Crashlytics vs Graph triage?

Next. Q8. Jetsam / Crashlytics vs Graph triage? Answer. “Jetsam is the OS killing your process under memory pressure — it shows up in Crashlytics as a kill, not a Swift stack you step through like a retain cycle. Crashlytics tells you the fleet is dying under pressure or a crash signature. Graph and Allocations tell you why a specific screen’s heap won’t shrink. In reliability culture you start from the signal — jetsam clusters during big events — then apply Graph for suspected cycles and Allocations for growth. Don’t pretend Crashlytics draws ownership edges.” Follow-ups. Verified vs Applied?: “Crashlytics and I M O C under a high crash free sessions bar — Verified reliability culture. Specific Graph walk of a BMS ad cycle — only if verified; otherwise Applied.”. Peak vs abandoned?: “Both feed jetsam risk; tools differ.”.

## §8 Q9. What does a clean Leaks run not prove?

Next. Q9. What does a clean Leaks run not prove? Answer. “A clean Leaks run does not prove you have no retain cycles, no abandoned VCs, and no forever caches. It only suggests you did not detect unreachable leaks in that session. If deinit never runs or Memory Graph still shows your type, you are not done. One sentence to memorize: Leaks is not a cycle detector.” Follow-ups. Ship decision if Graph still shows the view controller?: “No — fix ownership first.”. What proves the fix?: “deinit plus Graph empty plus Allocations generations flat.”.

## §9 Q10. When do you use autorelease pools?

Next. Q10. When do you use autorelease pools? Answer. “Autorelease pools let you drain temporary autoreleased ObjC or bridged objects sooner — useful in tight loops that create lots of temporaries, like image or string processing helpers. That lowers high watermark. It does not break retain cycles. Mention it only when the question is about peak temporary memory in ObjC-heavy loops — not when memory climbs from a cycle. Wrong answer: wrap everything in autoreleasepool to fix leaks.” Follow-ups. Default pool?: “RunLoop drains pools; tight loops may need an explicit autoreleasepool.”. Relate to jetsam?: “Lower peak can help pressure; still fix abandonment separately.”.

## §10 Q11. How do you map casual language to the right tool?

Next. Q11. How do you map casual language to the right tool? Answer. “‘We leaked the view controller’ casually usually means abandoned via cycle or cache — Graph and Allocations. True leak means unreachable — Leaks. Memory pressure or jetsam means the OS killed the process — Crashlytics plus memory reports. High watermark means peak usage — may be OK. Use precise words with interviewers.” Follow-ups. Why be pedantic?: “Wrong tool claim — ‘cycles in Leaks’ — is a common senior trap question.”. Next file?: “Production BookMyShow I M O C + crash-free at scale language — Verified vs Applied.”.
