# Sample 03 — Tools, leaks, and abandoned memory (Q&A)

> Guided teaching. This file exists so you never confuse Leaks with retain cycles in an interview.

---

### Q1. What is the difference between a true leak and abandoned memory?

**Points to:** [Deep dive · §5 Leak vs abandoned vs high watermark](../02-deep-dive.md#5-leak-vs-abandoned-vs-high-watermark) · [Foundations · §3](../01-foundations.md#3-what-is-a-retain-cycle)

**Answer:**

> A **true leak** is allocated memory with **no** live references left — unreachable. Instruments **Leaks** is built for that.  
> **Abandoned memory** is still referenced, but unused by the product logic you care about — classic retain cycles, forever caches, forgotten observers. Primary tools: **Memory Graph** and **Allocations**.  
> A **high watermark** is peak bytes in a session. It may be fine if memory drops again afterward.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Are retain cycles true leaks? | No. They are abandoned but still reachable. |
| Casual “we leaked the VC” usually means? | Abandoned via cycle or cache — Graph / Allocations, not necessarily Leaks. |
| Winning interview sentence? | “Retain cycles don’t show as Leaks. I use Memory Graph for the cycle and Allocations for persistent growth.” |

---

### Q2. Why doesn’t the Leaks instrument show retain cycles?

**Points to:** [Foundations · §3 Why this matters](../01-foundations.md#why-this-matters-in-interviews) · [Deep dive · §6.3 Leaks](../02-deep-dive.md#63-leaks) · [Day 03 README critical correctness](../README.md#critical-correctness-memorize)

**Answer:**

> Leaks looks for unreachable allocations. A retain cycle keeps objects reachable from each other, so their counts never hit zero and pointers still exist. The Leaks instrument can stay clean while your view controller never deinits. Never say “I found the retain cycle in Leaks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Leaks is clean — ship it?” | Not if you suspected a cycle. Check Memory Graph and Allocations. |
| When *do* you use Leaks? | When you suspect unreachable memory — unsafe / CF / some ObjC edges — after Graph suggests something other than a cycle. |
| True in the demo comments? | Yes — the commented UIKit drill notes Leaks may stay clean even for a BROKEN cycle. |

---

### Q3. What is Debug Memory Graph for?

**Points to:** [Foundations · §9 Tools at a glance](../01-foundations.md#9-tools-at-a-glance-foundations) · [Deep dive · §6.1 Debug Memory Graph](../02-deep-dive.md#61-debug-memory-graph-xcode-debugger)

**Answer:**

> Memory Graph answers “who retains me?” Reproduce the flow, open the graph, filter by your type, and inspect instances that should be gone. Walk incoming references until you see the cycle — closure ↔ object, timer → target, and so on. Strength: visual ownership edges. Weakness: a snapshot in time, not a full historical growth curve.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Typical drill? | Push a VC, arm a broken completion, pop, open Graph — instance remains. |
| What if the instance is still on a window? | That is still a live owner — not every surviving instance is a cycle. |
| Pair with what? | Allocations, to prove the type persists across navigation generations. |

---

### Q4. What is the Allocations instrument for?

**Points to:** [Deep dive · §6.2 Allocations](../02-deep-dive.md#62-allocations)

**Answer:**

> Allocations shows growth over time. Record while you navigate hot paths. Look for persistent growth of your types across generations or marks after you expect teardown. Compare before and after a fix. Strength: proves abandoned heaps over time. Weakness: does not draw the cycle as clearly as Memory Graph.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generation marks help how? | Mark before/after push-pop; persistent bytes of that VC type mean it never died. |
| High watermark vs abandoned? | Peak can be OK if it drops; abandoned keeps rising or stuck across generations. |
| Jetsam connection? | Peak memory plus abandoned heaps under big events can become process kills. |

---

### Q5. What order do you use when a VC “won’t die”?

**Points to:** [Deep dive · §6.4 Suggested order](../02-deep-dive.md#64-suggested-order-when-a-vc-wont-die)

**Answer:**

> 1) Temporary `deinit` log or breakpoint.  
> 2) Memory Graph — find unexpected owners.  
> 3) Allocations — confirm the type persists across navigation.  
> 4) Leaks — only if you suspect unreachable / unsafe issues.  
> 5) Fix ownership; re-verify `deinit` and Graph.  
> Do not start with Leaks for a suspected retain cycle.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| First lab signal? | `deinit` never prints after pop. |
| Fix checklist? | Weak capture, weak delegate, `timer.invalidate()`, NC token removal, Task cancel. |
| Verify bar? | `deinit` runs; Graph clear; Allocations flat across generations. |

---

### Q6. What production-shaped failure modes should I name?

**Points to:** [Deep dive · §8 Failure modes](../02-deep-dive.md#8-failure-modes-production-shaped)

**Answer:**

> Name concrete shapes: escaping ad/network completions holding screens; timers still ticking after leave; notification blocks without tokens; parent/child strong loops; unstructured Tasks that outlive UI; singleton caches that never prune. Each maps to a tool and a fix — not to “ARC is broken.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Live ticking UI after leave? | Suspect Timer target retain — invalidate. |
| Callbacks after pop? | Notification / Task / network completion still holding `self`. |
| Memory climbs listing → detail → back? | Abandoned VCs, image caches, or cycles — Graph + Allocations. |

---

### Q7. How do you map casual language to the right tool?

**Points to:** [Production bridge · §5 Mapping tools to production language](../03-production-bridge.md#5-mapping-tools-to-production-language)

**Answer:**

> “We leaked the VC” (casual) usually means abandoned via cycle or cache → Graph / Allocations.  
> “True leak” means unreachable → Leaks.  
> “Memory pressure / jetsam” means the OS killed the process → Crashlytics + memory reports.  
> “High watermark” means peak usage — may be OK. Use precise words with interviewers.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why be pedantic? | Wrong tool claim (“cycles in Leaks”) is a common senior trap question. |
| Teach QA this difference? | Only if useful; always teach interviewers with precise words. |
| Next file? | Production S8 language — Verified vs Applied. |

---

### Q8. What does a clean Leaks run *not* prove?

**Points to:** [Deep dive · §6.3](../02-deep-dive.md#63-leaks) · [04-questions · T8 pattern](../04-questions.md)

**Answer:**

> A clean Leaks run does not prove you have no retain cycles, no abandoned VCs, and no forever caches. It only suggests you did not detect unreachable leaks in that session. If `deinit` never runs or Memory Graph still shows your type, you are not done.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ship decision if Graph still shows the VC? | No — fix ownership first. |
| What proves the fix? | `deinit` + Graph empty + Allocations generations flat. |
| One sentence to memorize? | “Leaks ≠ cycle detector.” |

---

Next: [04-production-s8.md](04-production-s8.md)
