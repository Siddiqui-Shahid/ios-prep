# Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)

> Pulled from `01-foundations`, `02-deep-dive`, `03-production-bridge`, `05-exercises`, and the day README — anything easy to miss if you only read samples 01–05.  
> Say answers like a conversation. Then do the real coding drills in [`../05-exercises.md`](../05-exercises.md).

---

### Q1. Predict `deinit` — fire A1 / A2 / A3 (exercise A)

**Answer:**

> “A1: plain class in a do block — deinit prints; no extra owners. A2: stores a closure that strongly captures self — deinit does not print; that’s a cycle, abandoned but reachable. A3: weak self in the stored closure — deinit prints; the property may remain but doesn’t keep the object alive. Interview line: A2 is Memory Graph territory; Leaks may stay clean.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why A2 isn’t a ‘true leak’? | “Still reachable from itself — abandoned, not unreachable.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q2. Fix the timer aloud (exercise B)

**Answer:**

> “Target-selector scheduledTimer retains the target until invalidate. Repeating timer means immortal object while scheduled. Fix: prefer block timer with weak self, call stop that invalidates and nils the timer, call stop from deinit and from disappear if you need earlier teardown. Weak alone does not fix target-selector retain.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Demo twin? | “TickerBroken vs TickerFixed in RetainCycleDemo.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q3. NotificationCenter token rewrite (exercise C)

**Answer:**

> “Two bugs in the broken sketch: block strongly captures self, and the return token is discarded so you can’t remove cleanly. Fixed pattern: store the token, removeObserver on stop and deinit, weak self inside the block.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Weak without token remove? | “Helps the cycle edge; still remove as lifecycle hygiene.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q4. Tool selection sprint (exercise D)

**Answer:**

> “D1 — popped VC deinit never runs, suspect closure cycle — primary Memory Graph. D2 — bytes climb every time user opens checkout twenty times — Allocations for persistent growth. D3 — suspected CFTypeRef or unreachable malloc after a C bridge — Leaks. D4 — Leaks clean; are cycles impossible? No — cycles are reachable, so clean Leaks proves little; use Graph and Allocations.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One sentence to memorize? | “Leaks ≠ cycle detector.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Speak 60s Verified + Applied (exercise E)

**Answer:**

> “Verified: at BookMyShow we operated under a 99.95%+ crash-free bar at 30L+ DAU with Crashlytics workflows and IMOC ownership — memory pressure and lifecycle bugs sit in that reliability culture. Applied: if a screen won’t die, I wouldn’t start with Leaks for a suspected retain cycle. I’d reproduce push/pop, check Memory Graph for leftover instances and retain edges, use Allocations to confirm persistent growth, then fix weak captures, timer invalidation, or NotificationCenter tokens. Leaks is for unreachable memory — cycles stay reachable, so a green Leaks run wouldn’t convince me.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden? | “‘I used Memory Graph at BMS and found the ad cycle’ as fact without evidence.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Applied triage — label Applied.

---

### Q6. Code reading RetainCycleDemo (exercise F)

**Answer:**

> “BoxBroken.armCycle: onDone is stored on self and captures self strongly — cycle. TickerBroken: timer is on a RunLoop and target-selector retains self until invalidate — double ownership discipline. TimeZoneObserver.deinit: remove the NC token and clear local state so observation ends even if stop was forgotten. scheduleUnownedCrashRisk: after Ephemeral deinits, unowned self dangles; the delayed block crashes when it runs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where’s the file? | [`../code/RetainCycleDemo.swift`](../code/RetainCycleDemo.swift) |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q7. Parent/child weak vs unowned (exercise G)

**Answer:**

> “Weak when parent might nil out while child briefly remains, or you’re unsure — safer optional. Unowned when child’s lifetime is strictly nested under parent by API construction and you want non-optional access — accept crash if the invariant breaks. Interview default under uncertainty: weak.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Which edge is usually non-strong? | “Child → parent back-pointer.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Mini Memory Graph script (exercise H)

**Answer:**

> “Blank app; paste LeakyViewController and SafeViewController from the commented section in RetainCycleDemo. Present leaky, assign onFinish, dismiss. Open Debug Memory Graph; filter the type — instance remains. Walk edges. Repeat with safe — absence. Optional Allocations marks; optional Leaks — may stay clean for the leaky cycle. Pass criteria: explain why Leaks stayed clean while Graph showed the object. Provenance: Learning-lab — don’t claim as verified BMS history.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Edge-walking one-liner? | “Click the leftover instance; follow incoming references until the loop appears.” |

**How can I relate to my case:**
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q9. Flash recall — fire front → back like cards

**Answer:**

> “ARC — strong count to zero then deinit; trap is ‘Swift has a GC’; prod color is reliability culture not a Graph ticket.
>
> Weak — optional, zeroed; trap is forgetting guard; use when lifetime uncertain.
>
> Unowned — non-optional, not zeroed; trap is use-after-free crash; only nested lifetime proof.
>
> Retain cycle — reachable abandoned; trap is calling it a Leaks finding; tool is Memory Graph.
>
> True leak — unreachable; tool is Leaks; CFRelease miss is a classic.
>
> Timer target-selector — retains until invalidate; trap is weak-only fix; invalidate in deinit.
>
> NC block — store token, remove, weak; trap is discarding the token.
>
> Nested guard let self — re-strong for new escaping work; trap is assuming outer weak covers nested.
>
> Combine store — Set of AnyCancellable plus strong sink; trap is ignoring the sink capture.
>
> Singleton cache — abandoned without two-node cycle; trap is only hunting A↔B loops.
>
> Autoreleasepool — lowers watermark; trap is thinking it breaks cycles.
>
> Jetsam — OS kill under pressure; Crashlytics signal; Graph still for ownership.
>
> Verified reliability — 30L+ DAU, 99.95%+ CFS, Crashlytics, IMOC; trap is inventing BMS Graph war stories.
>
> Applied triage — Graph then Allocations then Leaks; trap is starting in Leaks for cycles.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Drill how? | “Cover the name, speak the back, uncover, score yourself. Also write trap cards from exercise I.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Day close-out — can you check these off?

**Answer:**

> “Without notes: I explained ARC plus weak/unowned in under forty-five seconds. I corrected Leaks versus cycles. I fixed a timer and NC example without peeking. I spoke Verified plus Applied with honesty labels. I walked nested-closure and Combine store traps. I stated CFRelease as a true-leak path. I said autoreleasepool does not break cycles. I read RetainCycleDemo aloud once. I ran a timed set from 04-questions including T1, T5, T8. If any box is open, that’s my next drill — not more reading.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where to practice code? | [../05-exercises.md](../05-exercises.md) |
| Where to time speak? | [../04-questions.md](../04-questions.md) T1–T10 |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse after every Day 03 study block.

---

### Q11. What should you be able to do by end of Day 03? (README outcomes)

**Answer:**

> “Explain how ARC inserts retains and releases, when deinit runs, and what strong, weak, and unowned mean. Name classic retain-cycle patterns and the fix for each. Distinguish true leaks from abandoned memory — and which tool finds which. Walk interview triage: Memory Graph, then Allocations, then Leaks — without claiming the wrong instrument. Tie reliability culture to BookMyShow IMOC plus crash-free at scale without inventing a Memory Graph war story unless labeled Applied.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timed drill? | “Q1, Q2, Q5, Q11, T1, T5, T8 on a timer.” |

**How can I relate to my case:**
- **Shipped / Applied** as labeled in provenance — never blur them.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Exercise I trap cards

Write three flashcards without looking: Leaks vs cycle; Timer target retain; NC block token.

**Answer check:** (1) Cycles don’t show in Leaks — Graph/Allocations. (2) Target-selector retains until invalidate. (3) Store token; remove; weak self.

---

### Puzzle B — Unowned crash lab

You release the last strong ref to `Ephemeral`, then a delayed block with `[unowned self]` runs.

**Ask:** Leak or crash?

**Answer:** **Crash** — use-after-free. Different failure mode from a retain cycle.

---

### Puzzle C — Verified labeling under pressure

Timed drill: you forget to say Applied and claim Graph triage as shipped BMS fact.

**Answer:** Fail the honesty check. Restart the 60s answer with Verified culture first, Applied triage second.

---

Next: timed bank in [`../04-questions.md`](../04-questions.md).
