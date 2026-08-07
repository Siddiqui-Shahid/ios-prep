# Sample 04 — IMOC + crash-free at scale (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow IMOC + crash-free at scale?

**Answer:**

> BookMyShow IMOC + crash-free at scale is reliability culture at BookMyShow scale: **30+ lakh DAU**, sustained **99.95%+ crash-free sessions**, Crashlytics triage workflows, and **IMOC** coordination for P0/P1 during high-traffic events. You may say memory and lifecycle bugs sit in that same reliability conversation. You may **not** invent a personal BMS Memory Graph war story or fake memory-reduction percentages unless you later add real evidence.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20-second Verified-only line? | “At BookMyShow we held a 99.95%+ crash-free bar at 30L+ DAU — Crashlytics workflows and IMOC ownership for P0/P1. Memory and lifecycle bugs were reliability issues, not ‘just perf.’” |
| Does BookMyShow IMOC + crash-free at scale prove a specific Instruments screenshot? | No. It proves you operated under a high CFS bar. |
| Forbidden phrase? | “At BMS I opened Memory Graph and found the ad retain cycle.” (unless later verified) |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q2. How do you bridge BookMyShow IMOC + crash-free at scale into ARC without overclaiming?

**Answer:**

> Label both parts out loud. Verified: the reliability culture is BookMyShow IMOC + crash-free at scale. Applied: if memory climbed or VCs never deinited after navigation, you would not start in Leaks for a suspected retain cycle — you would use Memory Graph to see who retains the object and Allocations to confirm persistent growth, then fix weak captures, timer invalidation, and observer tokens.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why say “Applied” aloud? | Interview honesty — design judgment vs resume-backed fact. |
| Preferred combined phrasing? | See Preferred phrasing in production bridge §1 — BookMyShow IMOC + crash-free at scale + Applied triage in one breath. |
| Lead with ARC on a behavioral incident question? | Usually no — lead with BookMyShow IMOC + crash-free at scale STAR; bring memory in if asked. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q3. What is the Applied triage playbook?

**Answer:**

> Reproduce the suspect flow. Expect death with a lab `deinit` log. Open Memory Graph and walk retain edges. Classify: cycle, singleton cache, or still-on-window — not “ARC bug.” Confirm with Allocations generations. Use Leaks only for suspected unreachable / unsafe issues. Fix ownership. Verify `deinit`, Graph, and Allocations. Wrap with reliability thinking: blast radius and Crashlytics watch if it shipped.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trigger: memory climbs listing → detail → back? | Hypothesis: abandoned VCs / caches / cycles. |
| Trigger: live ticking after leave? | Timer target retain. |
| Trigger: jetsam clusters in Crashlytics? | Peak memory + abandoned heaps under events. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How would you talk about ads / navigation without inventing a ticket?

**Answer:**

> Ads and media surfaces are cycle magnets: completions, players, timers, notification hooks. You may say (Applied): every escaping completion gets a capture-list review, timers invalidate on teardown, and you confirm the VC disappears in Memory Graph before calling the memory bug fixed. Do not invent a BMS ticket ID or metric. Architecture story for ads POP/generics is separate (BookMyShow Ads pipeline + HeroWidget lifecycle) — don’t blur it into a fake memory anecdote.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One Applied sentence for checkout/ads? | Escaping work must not strongly own the screen. |
| Can you cite BookMyShow Ads pipeline + HeroWidget lifecycle here? | Softly for architecture context; memory triage stays Applied unless verified. |
| Safe practice place? | Learning-lab sample app / demo — Graph without claiming production. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. What must you never say about tools and BookMyShow IMOC + crash-free at scale together?

**Answer:**

> Do not say Leaks showed your retain cycles. Do not invent memory-reduction percentages. Do not claim a BMS Memory Graph discovery unless you have real evidence. Before you speak, check: Verified vs Applied labeled? Timer invalidate mentioned when relevant? NotificationCenter tokens mentioned when relevant?

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Checklist item you forget most? | Labeling Applied triage as Applied. |
| Technically false claim? | “Leaks showed our retain cycles.” |
| After this sample, where next? | [`../code/RetainCycleDemo.swift`](../code/RetainCycleDemo.swift), then timed practice in [`../04-questions.md`](../04-questions.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q6. How does BookMyShow IMOC + crash-free at scale STAR use ARC as supporting color only?

**Answer:**

> On incident-ownership questions, lead with BookMyShow IMOC + crash-free at scale: scale, CFS bar, Crashlytics workflows, IMOC coordination, result. Memory enters as *one class of reliability defect*, not the hero claim, unless the interviewer asks about leaks or abandoned VCs. Then pivot to the Applied triage playbook — labeled honestly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Situation/Task spine? | 30L+ DAU, 99.95%+ CFS, fast P0/P1. |
| Action spine? | Crashlytics workflows; IMOC; mitigations and comms. |
| If asked about memory mid-STAR? | “Applied triage would be Graph for cycles, Allocations for growth — not Leaks for cycles.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q7. How do District / Raw hooks fit without forcing fake stories?

**Answer:**

> Keep Day 03 centered on BookMyShow IMOC + crash-free at scale + Applied triage. Soft hooks only: migrations can leave orphaned observers (architecture verified separately); live scoreboards need timer invalidation and weak captures. Personal apps are a safe Learning-lab place to practice Graph. Do not force every company into a fake memory anecdote.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Primary provenance for this day? | BookMyShow IMOC + crash-free at scale + How I would apply it triage. |
| Learning-lab role? | Demo code and Instruments practice — not a shipped BMS claim. |
| Done with sample path? | Return to [sample README](README.md), then main questions bank. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q8. Give a full honest answer that mixes Verified and Applied correctly

**Answer:**

> “At BMS scale we treated crash-free and incident ownership as first-class — Crashlytics plus IMOC under 30L+ DAU and a 99.95%+ CFS bar (BookMyShow IMOC + crash-free at scale). For memory specifically, my triage approach would be Memory Graph for cycles and Allocations for growth — not Leaks for retain cycles (How I would apply it). I’d fix weak captures, invalidate timers, remove NotificationCenter tokens, then verify `deinit` and the graph before calling it done.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is Verified in that paragraph? | Scale, CFS, Crashlytics, IMOC. |
| Where is Applied? | Tool order and fix/verify loop. |
| What did you refuse to invent? | A specific BMS Graph ticket or % memory win. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

## After this sample

1. Read every BROKEN/FIXED pair in [`../code/RetainCycleDemo.swift`](../code/RetainCycleDemo.swift).
2. Speak from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Do tool-selection drills in [`../05-exercises.md`](../05-exercises.md).

---

