# Sample 03 — Tools, leaks, and abandoned memory (Q&A)

> Guided teaching. Say the **Answer** out loud like you’re talking to an interviewer. 
> This file exists so you never confuse Leaks with retain cycles in an interview. 
> **Brain puzzles** at the bottom — cover the answer, think, then check.

---

### Q1. What is the difference between a true leak and abandoned memory?
**Answer:**

> “A true leak is allocated memory with no live references left — unreachable. Instruments Leaks is built for that. Abandoned memory is still referenced, but unused by the product logic you care about — classic retain cycles, forever caches, forgotten observers. Primary tools: Memory Graph and Allocations. A high watermark is peak bytes in a session. It may be fine if memory drops again afterward.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Are retain cycles true leaks? | “No. They are abandoned but still reachable.” |
| Casual ‘we leaked the VC’ usually means? | “Abandoned via cycle or cache — Graph / Allocations, not necessarily Leaks.” |
| Winning interview sentence? | “Retain cycles don’t show as Leaks. I use Memory Graph for the cycle and Allocations for persistent growth.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Why doesn’t the Leaks instrument show retain cycles?
**Answer:**

> “Leaks looks for unreachable allocations. A retain cycle keeps objects reachable from each other, so their counts never hit zero and pointers still exist. The Leaks instrument can stay clean while your view controller never deinits. Never say ‘I found the retain cycle in Leaks.’”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ‘Leaks is clean — ship it?’ | “Not if you suspected a cycle. Check Memory Graph and Allocations.” |
| When do you use Leaks? | “When you suspect unreachable memory — unsafe / CF / some ObjC edges — after Graph suggests something other than a cycle.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. CF / unsafe — when is a missed `CFRelease` a true leak?
**Answer:**

> “Core Foundation and some unsafe / C bridges can hand you a CFTypeRef you own. If you forget CFRelease — or the matching transfer rule under ARC bridging — that allocation can become unreachable with no Swift owner. That’s a real Leaks hit: no live references, still allocated. Contrast with a retain cycle: still reachable, Leaks stays quiet. So: Graph for cycles; Leaks when CF/unsafe ownership was dropped.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Everyday Swift classes? | “Usually ARC owns them — cycles are Graph problems, not CFRelease.” |
| Interview trap? | “Saying every memory bug is a Leaks bug — or that CF bugs never need Leaks.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is Debug Memory Graph for?
**Answer:**

> “Memory Graph answers ‘who retains me?’ Reproduce the flow, open the graph, filter by your type, and inspect instances that should be gone. Walk incoming references until you see the cycle — closure ↔ object, timer → target, and so on. Strength: visual ownership edges. Weakness: a snapshot in time, not a full historical growth curve.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Typical drill? | “Push a VC, arm a broken completion, pop, open Graph — instance remains.” |
| What if the instance is still on a window? | “That is still a live owner — not every surviving instance is a cycle.” |
| Pair with what? | “Allocations, to prove the type persists across navigation generations.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Walk the Memory Graph edge-walking script aloud?
**Answer:**

> “Learning-lab script: present the leaky VC, assign the strong completion, dismiss. Open Debug Memory Graph. Filter the VC type — confirm the instance remains. Click it. Walk incoming edges until you see self → closure → self, or timer → target. Repeat with the fixed VC — confirm absence. Optional: Allocations generation marks; optional Leaks — note it may stay clean for the cycle. Pass bar: explain why Leaks stayed clean while Graph showed the object. Label this Applied or Learning-lab — do not claim it as a shipped BookMyShow war story.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance? | “Learning-lab — and How I would apply it if narrating for BMS-shaped apps.” |
| Forbidden? | “‘At BMS I opened Memory Graph and found the ad retain cycle’ without evidence.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Design if asked:** Applied triage playbook — label Applied.

---

### Q6. What is the Allocations instrument for?
**Answer:**

> “Allocations shows growth over time. Record while you navigate hot paths. Look for persistent growth of your types across generations or marks after you expect teardown. Compare before and after a fix. Strength: proves abandoned heaps over time. Weakness: does not draw the cycle as clearly as Memory Graph.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generation marks help how? | “Mark before/after push-pop; persistent bytes of that VC type mean it never died.” |
| High watermark vs abandoned? | “Peak can be OK if it drops; abandoned keeps rising or stuck across generations.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What order do you use when a VC won’t die?
**Answer:**

> “One: temporary deinit log or breakpoint. Two: Memory Graph — find unexpected owners. Three: Allocations — confirm the type persists across navigation. Four: Leaks — only if you suspect unreachable or unsafe issues. Five: fix ownership; re-verify deinit and Graph. Do not start with Leaks for a suspected retain cycle.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| First lab signal? | “deinit never prints after pop.” |
| Fix checklist? | “Weak capture, weak delegate, timer invalidate, NC token removal, Task cancel.” |
| Verify bar? | “deinit runs; Graph clear; Allocations flat across generations.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Jetsam / Crashlytics vs Graph triage?
**Answer:**

> “Jetsam is the OS killing your process under memory pressure — it shows up in Crashlytics as a kill, not a Swift stack you step through like a retain cycle. Crashlytics tells you the fleet is dying under pressure or a crash signature. Graph and Allocations tell you why a specific screen’s heap won’t shrink. In reliability culture you start from the signal — jetsam clusters during big events — then apply Graph for suspected cycles and Allocations for growth. Don’t pretend Crashlytics draws ownership edges.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified vs Applied? | “Crashlytics and IMOC under a high CFS bar — Verified reliability culture. Specific Graph walk of a BMS ad cycle — only if verified; otherwise Applied.” |
| Peak vs abandoned? | “Both feed jetsam risk; tools differ.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Applied Graph / Allocations triage — label Applied.

---

### Q9. What does a clean Leaks run not prove?
**Answer:**

> “A clean Leaks run does not prove you have no retain cycles, no abandoned VCs, and no forever caches. It only suggests you did not detect unreachable leaks in that session. If deinit never runs or Memory Graph still shows your type, you are not done. One sentence to memorize: Leaks is not a cycle detector.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ship decision if Graph still shows the VC? | “No — fix ownership first.” |
| What proves the fix? | “deinit plus Graph empty plus Allocations generations flat.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. When do you use autorelease pools?
**Answer:**

> “Autorelease pools let you drain temporary autoreleased ObjC or bridged objects sooner — useful in tight loops that create lots of temporaries, like image or string processing helpers. That lowers high watermark. It does not break retain cycles. Mention it only when the question is about peak temporary memory in ObjC-heavy loops — not when memory climbs from a cycle. Wrong answer: wrap everything in autoreleasepool to fix leaks.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default pool? | “RunLoop drains pools; tight loops may need an explicit autoreleasepool.” |
| Relate to jetsam? | “Lower peak can help pressure; still fix abandonment separately.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. How do you map casual language to the right tool?
**Answer:**

> “‘We leaked the VC’ casually usually means abandoned via cycle or cache — Graph and Allocations. True leak means unreachable — Leaks. Memory pressure or jetsam means the OS killed the process — Crashlytics plus memory reports. High watermark means peak usage — may be OK. Use precise words with interviewers.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why be pedantic? | “Wrong tool claim — ‘cycles in Leaks’ — is a common senior trap question.” |
| Next file? | “Production BookMyShow IMOC + crash-free at scale language — Verified vs Applied.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

## Brain puzzles (cover → think → check)

### Puzzle A — “I found the retain cycle in Leaks”

Interviewer: “How did you find the retain cycle?” You: “Leaks instrument.”

**Ask:** What’s wrong?

**Answer:** Retain cycles stay **reachable**. Leaks hunts **unreachable** memory. Correct tools: **Memory Graph** (who retains me?) and **Allocations** (persistent growth). Never claim cycles were found in Leaks.

---

### Puzzle B — Clean Leaks ≠ no cycles

Leaks is green. `deinit` never prints after pop. Memory Graph still shows your VC.

**Ask:** Ship it?

**Answer:** **No.** Clean Leaks does not prove absence of cycles. Fix ownership; verify deinit + Graph + Allocations.

---

### Puzzle C — Autoreleasepool ≠ cycle fix

Memory climbs every push/pop of a detail VC. Someone wraps the navigation code in `autoreleasepool { }`.

**Ask:** Fixed?

**Answer:** Probably **not**. Autoreleasepool drains temporaries / lowers watermark. It does **not** break a retain cycle. Use Graph + weak / invalidate / tokens.

---

### Puzzle D — CF miss vs cycle

After a CFStringCreate / transfer bug, Leaks lights up. Separately, a VC never deinits with a clean Leaks run.

**Ask:** Same tool for both?

**Answer:** **No.** Missed CFRelease-style ownership → true unreachable leak → **Leaks**. VC cycle → reachable abandoned → **Graph / Allocations**.

---

Next: [04-production-s8.md](04-production-s8.md)
