# Sample 04 — Production S8 and Applied triage (Q&A)

> Guided teaching. Separates **Verified** resume facts from **How I would apply it** memory triage so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S8?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map-for-this-chapter) · [§2 Verified · S8](../03-production-bridge.md#2-verified--s8--what-reliability-culture-actually-means)

**Answer:**

> Verified S8 is reliability culture at BookMyShow scale: **30+ lakh DAU**, sustained **99.95%+ crash-free sessions**, Crashlytics triage workflows, and **IMOC** coordination for P0/P1 during high-traffic events. You may say memory and lifecycle bugs sit in that same reliability conversation. You may **not** invent a personal BMS Memory Graph war story or fake memory-reduction percentages unless you later add real evidence.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20-second Verified-only line? | “At BookMyShow we held a 99.95%+ crash-free bar at 30L+ DAU — Crashlytics workflows and IMOC ownership for P0/P1. Memory and lifecycle bugs were reliability issues, not ‘just perf.’” |
| Does S8 prove a specific Instruments screenshot? | No. It proves you operated under a high CFS bar. |
| Forbidden phrase? | “At BMS I opened Memory Graph and found the ad retain cycle.” (unless later verified) |

---

### Q2. How do you bridge S8 into ARC without overclaiming?

**Points to:** [Production bridge · 45-second bridge](../03-production-bridge.md#45-second-bridge-into-arc-verified--applied-clearly-labeled)

**Answer:**

> Label both parts out loud. Verified: the reliability culture is S8. Applied: if memory climbed or VCs never deinited after navigation, you would not start in Leaks for a suspected retain cycle — you would use Memory Graph to see who retains the object and Allocations to confirm persistent growth, then fix weak captures, timer invalidation, and observer tokens.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why say “Applied” aloud? | Interview honesty — design judgment vs resume-backed fact. |
| Preferred combined phrasing? | See Preferred phrasing in production bridge §1 — Verified S8 + Applied triage in one breath. |
| Lead with ARC on a behavioral incident question? | Usually no — lead with S8 STAR; bring memory in if asked. |

---

### Q3. What is the Applied triage playbook?

**Points to:** [Production bridge · §3 How I would apply it](../03-production-bridge.md#3-how-i-would-apply-it--triage-playbook-at-bms-shaped-apps)

**Answer:**

> Reproduce the suspect flow. Expect death with a lab `deinit` log. Open Memory Graph and walk retain edges. Classify: cycle, singleton cache, or still-on-window — not “ARC bug.” Confirm with Allocations generations. Use Leaks only for suspected unreachable / unsafe issues. Fix ownership. Verify `deinit`, Graph, and Allocations. Wrap with reliability thinking: blast radius and Crashlytics watch if it shipped.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trigger: memory climbs listing → detail → back? | Hypothesis: abandoned VCs / caches / cycles. |
| Trigger: live ticking after leave? | Timer target retain. |
| Trigger: jetsam clusters in Crashlytics? | Peak memory + abandoned heaps under events. |

---

### Q4. How would you talk about ads / navigation without inventing a ticket?

**Points to:** [Production bridge · Ads / navigation flavor](../03-production-bridge.md#ads--navigation-flavor-applied-not-a-fake-war-story)

**Answer:**

> Ads and media surfaces are cycle magnets: completions, players, timers, notification hooks. You may say (Applied): every escaping completion gets a capture-list review, timers invalidate on teardown, and you confirm the VC disappears in Memory Graph before calling the memory bug fixed. Do not invent a BMS ticket ID or metric. Architecture story for ads POP/generics is separate (Verified S1) — don’t blur it into a fake memory anecdote.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One Applied sentence for checkout/ads? | Escaping work must not strongly own the screen. |
| Can you cite S1 here? | Softly for architecture context; memory triage stays Applied unless verified. |
| Safe practice place? | Learning-lab sample app / demo — Graph without claiming production. |

---

### Q5. What must you never say about tools and S8 together?

**Points to:** [Production bridge · Forbidden phrasing](../03-production-bridge.md#forbidden-phrasing-unless-you-later-add-real-evidence) · [§7 Checklist](../03-production-bridge.md#7-checklist-before-you-speak-in-an-interview)

**Answer:**

> Do not say Leaks showed your retain cycles. Do not invent memory-reduction percentages. Do not claim a BMS Memory Graph discovery unless you have real evidence. Before you speak, check: Verified vs Applied labeled? Timer invalidate mentioned when relevant? NotificationCenter tokens mentioned when relevant?

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Checklist item you forget most? | Labeling Applied triage as Applied. |
| Technically false claim? | “Leaks showed our retain cycles.” |
| After this sample, where next? | [`../code/RetainCycleDemo.swift`](../code/RetainCycleDemo.swift), then timed practice in [`../04-questions.md`](../04-questions.md). |

---

### Q6. How does S8 STAR use ARC as supporting color only?

**Points to:** [Production bridge · §6 STAR sketch](../03-production-bridge.md#6-star-sketch-s8--keep-arc-as-supporting-color) · [story-bank S8](../../../../stories/story-bank.md)

**Answer:**

> On incident-ownership questions, lead with S8: scale, CFS bar, Crashlytics workflows, IMOC coordination, result. Memory enters as *one class of reliability defect*, not the hero claim, unless the interviewer asks about leaks or abandoned VCs. Then pivot to the Applied triage playbook — labeled honestly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Situation/Task spine? | 30L+ DAU, 99.95%+ CFS, fast P0/P1. |
| Action spine? | Crashlytics workflows; IMOC; mitigations and comms. |
| If asked about memory mid-STAR? | “Applied triage would be Graph for cycles, Allocations for growth — not Leaks for cycles.” |

---

### Q7. How do District / Raw hooks fit without forcing fake stories?

**Points to:** [Production bridge · §4 District / Raw hooks](../03-production-bridge.md#4-district--raw-hooks-light-touch)

**Answer:**

> Keep Day 03 centered on S8 + Applied triage. Soft hooks only: migrations can leave orphaned observers (architecture verified separately); live scoreboards need timer invalidation and weak captures. Personal apps are a safe Learning-lab place to practice Graph. Do not force every company into a fake memory anecdote.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Primary provenance for this day? | Verified S8 + How I would apply it triage. |
| Learning-lab role? | Demo code and Instruments practice — not a shipped BMS claim. |
| Done with sample path? | Return to [sample README](README.md), then main questions bank. |

---

### Q8. Give a full honest answer that mixes Verified and Applied correctly

**Points to:** [Production bridge · Preferred phrasing](../03-production-bridge.md#preferred-phrasing) · [§3 playbook](../03-production-bridge.md#3-how-i-would-apply-it--triage-playbook-at-bms-shaped-apps)

**Answer:**

> “At BMS scale we treated crash-free and incident ownership as first-class — Crashlytics plus IMOC under 30L+ DAU and a 99.95%+ CFS bar (Verified S8). For memory specifically, my triage approach would be Memory Graph for cycles and Allocations for growth — not Leaks for retain cycles (How I would apply it). I’d fix weak captures, invalidate timers, remove NotificationCenter tokens, then verify `deinit` and the graph before calling it done.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is Verified in that paragraph? | Scale, CFS, Crashlytics, IMOC. |
| Where is Applied? | Tool order and fix/verify loop. |
| What did you refuse to invent? | A specific BMS Graph ticket or % memory win. |

---

## After this sample

1. Read every BROKEN/FIXED pair in [`../code/RetainCycleDemo.swift`](../code/RetainCycleDemo.swift).
2. Speak from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Do tool-selection drills in [`../05-exercises.md`](../05-exercises.md).
