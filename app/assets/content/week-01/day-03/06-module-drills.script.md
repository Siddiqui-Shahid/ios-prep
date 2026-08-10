# Audio script — Sample 06 — Module leftovers: drills, flash recall, close-out (Q&A)
> Listen-only sample Q&A from `06-module-drills.md`. Spoken answers and follow-ups.

## §0 Q1. Predict `deinit` — fire A1 / A2 / A3 (exercise A)?

Next. Q1. Predict `deinit` — fire A1 / A2 / A3 (exercise A)? Answer. “A1: plain class in a do block — deinit prints; no extra owners. A2: stores a closure that strongly captures self — deinit does not print; that’s a cycle, abandoned but reachable. A3: weak self in the stored closure — deinit prints; the property may remain but doesn’t keep the object alive. Interview line: A2 is Memory Graph territory; Leaks may stay clean.” Follow-ups. Why A2 isn’t a ‘true leak’?: “Still reachable from itself — abandoned, not unreachable.”.

## §1 Q2. Fix the timer aloud (exercise B)?

Next. Q2. Fix the timer aloud (exercise B)? Answer. “Target-selector scheduledTimer retains the target until invalidate. Repeating timer means immortal object while scheduled. Fix: prefer block timer with weak self, call stop that invalidates and nils the timer, call stop from deinit and from disappear if you need earlier teardown. Weak alone does not fix target-selector retain.” Follow-ups. Demo twin?: “TickerBroken vs TickerFixed in RetainCycleDemo.”.

## §2 Q3. NotificationCenter token rewrite (exercise C)?

Next. Q3. NotificationCenter token rewrite (exercise C)? Answer. “Two bugs in the broken sketch: block strongly captures self, and the return token is discarded so you can’t remove cleanly. Fixed pattern: store the token, removeObserver on stop and deinit, weak self inside the block.” Follow-ups. Weak without token remove?: “Helps the cycle edge; still remove as lifecycle hygiene.”.

## §3 Q4. Tool selection sprint (exercise D)?

Next. Q4. Tool selection sprint (exercise D)? Answer. “D1 — popped view controller deinit never runs, suspect closure cycle — primary Memory Graph. D2 — bytes climb every time user opens checkout twenty times — Allocations for persistent growth. D3 — suspected CFTypeRef or unreachable malloc after a C bridge — Leaks. D4 — Leaks clean; are cycles impossible? No — cycles are reachable, so clean Leaks proves little; use Graph and Allocations.” Follow-ups. One sentence to memorize?: “Leaks ≠ cycle detector.”.

## §4 Q5. Speak 60s Verified + Applied (exercise E)?

Next. Q5. Speak 60s Verified + Applied (exercise E)? Answer. “Verified: at BookMyShow we operated under a 99.95%+ crash-free bar at 30L+ daily active users with Crashlytics workflows and I M O C ownership — memory pressure and lifecycle bugs sit in that reliability culture. Applied: if a screen won’t die, I wouldn’t start with Leaks for a suspected retain cycle. I’d reproduce push/pop, check Memory Graph for leftover instances and retain edges, use Allocations to confirm persistent growth, then fix weak captures, timer invalidation, or NotificationCenter tokens. Leaks is for unreachable memory — cycles stay reachable, so a green Leaks run wouldn’t convince me.” Follow-ups. Forbidden?: “‘I used Memory Graph at BMS and found the ad cycle’ as fact without evidence.”.

## §5 Q6. Code reading RetainCycleDemo (exercise F)?

Next. Q6. Code reading RetainCycleDemo (exercise F)? Answer. “BoxBroken.armCycle: onDone is stored on self and captures self strongly — cycle. TickerBroken: timer is on a RunLoop and target-selector retains self until invalidate — double ownership discipline. TimeZoneObserver.deinit: remove the NC token and clear local state so observation ends even if stop was forgotten. scheduleUnownedCrashRisk: after Ephemeral deinits, unowned self dangles; the delayed block crashes when it runs.” Follow-ups. Where’s the file?:../code/RetainCycleDemo.swift.

## §6 Q7. Parent/child weak vs unowned (exercise G)?

Next. Q7. Parent/child weak vs unowned (exercise G)? Answer. “Weak when parent might nil out while child briefly remains, or you’re unsure — safer optional. Unowned when child’s lifetime is strictly nested under parent by A P I construction and you want non-optional access — accept crash if the invariant breaks. Interview default under uncertainty: weak.” Follow-ups. Which edge is usually non-strong?: “Child → parent back-pointer.”.

## §7 Q8. Mini Memory Graph script (exercise H)?

Next. Q8. Mini Memory Graph script (exercise H)? Answer. “Blank app; paste LeakyViewController and SafeViewController from the commented section in RetainCycleDemo. Present leaky, assign onFinish, dismiss. Open Debug Memory Graph; filter the type — instance remains. Walk edges. Repeat with safe — absence. Optional Allocations marks; optional Leaks — may stay clean for the leaky cycle. Pass criteria: explain why Leaks stayed clean while Graph showed the object. Provenance: Learning-lab — don’t claim as verified BMS history.” Follow-ups. Edge-walking one-liner?: “Click the leftover instance; follow incoming references until the loop appears.”.

## §8 Q9. Flash recall — fire front → back like cards?

Next. Q9. Flash recall — fire front → back like cards? Answer. “A R C — strong count to zero then deinit; trap is ‘Swift has a GC’; prod color is reliability culture not a Graph ticket. Weak — optional, zeroed; trap is forgetting guard; use when lifetime uncertain. Unowned — non-optional, not zeroed; trap is use-after-free crash; only nested lifetime proof. Retain cycle — reachable abandoned; trap is calling it a Leaks finding; tool is Memory Graph. True leak — unreachable; tool is Leaks; CFRelease miss is a classic. Timer target-selector — retains until invalidate; trap is weak-only fix; invalidate in deinit. NC block — store token, remove, weak; trap is discarding the token. Nested guard let self — re-strong for new escaping work; trap is assuming outer weak covers nested. Combine store — Set of AnyCancellable plus strong sink; trap is ignoring the sink capture. Singleton cache — abandoned without two-node cycle; trap is only hunting A↔B loops. Autoreleasepool — lowers watermark; trap is thinking it breaks cycles. Jetsam — OS kill under pressure; Crashlytics signal; Graph still for ownership. Verified reliability — 30L+ daily active users, 99.95%+ crash free sessions, Crashlytics, I M O C; trap is inventing BMS Graph war stories. Applied triage — Graph then Allocations then Leaks; trap is starting in Leaks for cycles.” Follow-ups. Drill how?: “Cover the name, speak the back, uncover, score yourself. Also write trap cards from exercise I.”.

## §9 Q10. Day close-out — can you check these off?

Next. Q10. Day close-out — can you check these off? Answer. “Without notes: I explained A R C plus weak/unowned in under forty-five seconds. I corrected Leaks versus cycles. I fixed a timer and NC example without peeking. I spoke Verified plus Applied with honesty labels. I walked nested-closure and Combine store traps. I stated CFRelease as a true-leak path. I said autoreleasepool does not break cycles. I read RetainCycleDemo aloud once. I ran a timed set from 07-revision-qna including T1, T5, T8. If any box is open, that’s my next drill — not more reading.” Follow-ups. Where to practice code?:../05-exercises.md. Where to time speak?: 07-revision-qna.md T1–T10.

## §10 Q11. What should you be able to do by end of Day 03? (README outcomes)?

Next. Q11. What should you be able to do by end of Day 03? (README outcomes)? Answer. “Explain how A R C inserts retains and releases, when deinit runs, and what strong, weak, and unowned mean. Name classic retain-cycle patterns and the fix for each. Distinguish true leaks from abandoned memory — and which tool finds which. Walk interview triage: Memory Graph, then Allocations, then Leaks — without claiming the wrong instrument. Tie reliability culture to BookMyShow I M O C plus crash-free at scale without inventing a Memory Graph war story unless labeled Applied.” Follow-ups. Timed drill?: “Q1, Q2, Q5, Q11, T1, T5, T8 on a timer.”.
