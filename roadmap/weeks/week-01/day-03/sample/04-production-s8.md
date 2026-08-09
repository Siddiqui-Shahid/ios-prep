# Sample 04 — IMOC + crash-free at scale (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.  
> Say answers out loud. **Brain puzzles** at the bottom keep claims honest.  
> In relate sections use **named work only** — never S-codes.

---

### Q1. What can you claim under BookMyShow IMOC + crash-free at scale?

**Answer:**

> “BookMyShow IMOC plus crash-free at scale is reliability culture at BookMyShow scale: 30-plus lakh DAU, sustained 99.95%+ crash-free sessions, Crashlytics triage workflows, and IMOC coordination for P0/P1 during high-traffic events. You may say memory and lifecycle bugs sit in that same reliability conversation. You may not invent a personal BMS Memory Graph war story or fake memory-reduction percentages unless you later add real evidence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20-second Verified-only line? | “At BookMyShow we held a 99.95%+ crash-free bar at 30L+ DAU — Crashlytics workflows and IMOC ownership for P0/P1. Memory and lifecycle bugs were reliability issues, not ‘just perf.’” |
| Does that prove a specific Instruments screenshot? | “No. It proves you operated under a high CFS bar.” |
| Forbidden phrase? | “‘At BMS I opened Memory Graph and found the ad retain cycle’ — unless later verified.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q2. How do you bridge reliability culture into ARC without overclaiming?

**Answer:**

> “Label both parts out loud. Verified: the reliability culture is BookMyShow IMOC plus crash-free at scale. Applied: if memory climbed or VCs never deinited after navigation, you would not start in Leaks for a suspected retain cycle — you would use Memory Graph to see who retains the object and Allocations to confirm persistent growth, then fix weak captures, timer invalidation, and observer tokens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why say Applied aloud? | “Interview honesty — design judgment vs resume-backed fact.” |
| Lead with ARC on a behavioral incident question? | “Usually no — lead with reliability STAR; bring memory in if asked.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Applied Memory Graph / Allocations triage — label Applied, not shipped.

---

### Q3. How does STAR use ARC as supporting color only?

**Answer:**

> “On incident-ownership questions, lead with BookMyShow IMOC plus crash-free at scale: scale, CFS bar, Crashlytics workflows, IMOC coordination, result. Memory enters as one class of reliability defect — supporting color — not the hero claim, unless the interviewer asks about leaks or abandoned VCs. Then pivot to the Applied triage playbook — labeled honestly. Situation and task: 30L+ DAU, 99.95%+ CFS, fast P0/P1. Action: Crashlytics workflows, IMOC, mitigations and comms. If asked about memory mid-STAR: Applied triage would be Graph for cycles, Allocations for growth — not Leaks for cycles.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Honesty checks before you speak? | “Verified vs Applied labeled? Timer invalidate mentioned when relevant? NC tokens when relevant? No invented Graph ticket?” |
| Result without overclaim? | “Sustained CFS bar and incident ownership — not ‘I personally cut memory X%.’” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q4. What is the Applied triage playbook?

**Answer:**

> “Reproduce the suspect flow. Expect death with a lab deinit log. Open Memory Graph and walk retain edges. Classify: cycle, singleton cache, or still-on-window — not ‘ARC bug.’ Confirm with Allocations generations. Use Leaks only for suspected unreachable or unsafe issues. Fix ownership. Verify deinit, Graph, and Allocations. Wrap with reliability thinking: blast radius and Crashlytics watch if it shipped.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trigger: memory climbs listing → detail → back? | “Hypothesis: abandoned VCs, caches, or cycles.” |
| Trigger: live ticking after leave? | “Timer target retain.” |
| Trigger: jetsam clusters in Crashlytics? | “Peak memory plus abandoned heaps under events.” |

**How can I relate to my case:**
- **Design if asked:** Applied triage — not a claimed shipped BMS Graph runbook.

---

### Q5. How would you talk about ads / navigation without inventing a ticket?

**Answer:**

> “Ads and media surfaces are cycle magnets: completions, players, timers, notification hooks. You may say — Applied — every escaping completion gets a capture-list review, timers invalidate on teardown, and you confirm the VC disappears in Memory Graph before calling the memory bug fixed. Do not invent a BMS ticket ID or metric. Architecture story for ads POP and generics is separate — BookMyShow Ads pipeline plus HeroWidget lifecycle — don’t blur it into a fake memory anecdote.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One Applied sentence for checkout/ads? | “Escaping work must not strongly own the screen.” |
| Safe practice place? | “Learning-lab sample app — Graph without claiming production.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle (architecture context)
- **Design if asked:** Applied memory triage — label Applied.
- **Don’t claim:** Invented fill-rate % or a fake BMS Memory Graph ticket.

---

### Q6. What must you never say about tools and reliability culture together?

**Answer:**

> “Do not say Leaks showed your retain cycles. Do not invent memory-reduction percentages. Do not claim a BMS Memory Graph discovery unless you have real evidence. Before you speak, check: Verified versus Applied labeled? Timer invalidate mentioned when relevant? NotificationCenter tokens mentioned when relevant?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Checklist item you forget most? | “Labeling Applied triage as Applied.” |
| Technically false claim? | “‘Leaks showed our retain cycles.’” |
| After this sample, where next? | “RetainCycleDemo.swift, then timed practice in 04-questions.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q7. How do District / Raw hooks fit without forcing fake stories?

**Answer:**

> “Keep Day 03 centered on BookMyShow IMOC plus crash-free at scale plus Applied triage. Soft hooks only: migrations can leave orphaned observers; live scoreboards need timer invalidation and weak captures. Personal apps are a safe Learning-lab place to practice Graph. Do not force every company into a fake memory anecdote.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Primary provenance for this day? | “BookMyShow IMOC + crash-free at scale + How I would apply it triage.” |
| Learning-lab role? | “Demo code and Instruments practice — not a shipped BMS claim.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Lab only:** Learning-lab demos / sketches only — not production source.

---

### Q8. Give a full honest answer that mixes Verified and Applied correctly

**Answer:**

> “At BMS scale we treated crash-free and incident ownership as first-class — Crashlytics plus IMOC under 30L+ DAU and a 99.95%+ CFS bar — that’s BookMyShow IMOC plus crash-free at scale. For memory specifically, my triage approach would be Memory Graph for cycles and Allocations for growth — not Leaks for retain cycles — How I would apply it. I’d fix weak captures, invalidate timers, remove NotificationCenter tokens, then verify deinit and the graph before calling it done.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is Verified in that paragraph? | “Scale, CFS, Crashlytics, IMOC.” |
| Where is Applied? | “Tool order and fix/verify loop.” |
| What did you refuse to invent? | “A specific BMS Graph ticket or percent memory win.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Applied triage — label Applied.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q9. Honesty checklist — fire it before every memory answer

**Answer:**

> “One: did I label Verified versus Applied? Two: did I avoid ‘found the cycle in Leaks’? Three: if I mentioned Timer, did I say invalidate? Four: if NotificationCenter block, did I say token? Five: did I invent a BMS Memory Graph war story? Six: did I hang app-wide CFS on one memory ticket? If any check fails, rewrite the sentence before you speak.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why so pedantic? | “Senior interviews punish blurred provenance harder than missing a keyword.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse after every Day 03 study block.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Verified S8 vs Applied triage labeling

Interviewer: “Tell me about a memory bug you fixed at BookMyShow.”

**Bad:** “I opened Memory Graph, found the ad retain cycle, cut memory 30%.”

**Good:** “Verified: we operated under a 99.95%+ CFS bar at 30L+ DAU with Crashlytics and IMOC — memory pressure sat in that reliability culture. Applied: if a screen won’t die, I’d reproduce, use Memory Graph for retain edges, Allocations for growth — not Leaks for cycles — then fix weak captures, invalidate timers, remove tokens. I won’t invent a specific BMS Graph ticket.”

---

### Puzzle B — STAR hijacked by ARC

You start an incident-ownership answer and spend two minutes on weak self.

**Ask:** What’s wrong?

**Answer:** ARC should be **supporting color**. Lead with scale, CFS, Crashlytics, IMOC, result. Bring Graph triage only when they ask about memory — and label it Applied.

---

### Puzzle C — “Leaks showed our retain cycles” under S8

You mix Verified reliability culture with “Leaks found our cycles.”

**Answer:** Technically false **and** provenance-sloppy. Cycles ≠ Leaks. Fix the tool claim and keep Verified/Applied separate.

---

### Puzzle D — Ads architecture vs memory anecdote

You cite BookMyShow Ads pipeline + HeroWidget lifecycle as proof you fixed a retain cycle in production.

**Ask:** Allowed?

**Answer:** Soft architecture context yes; **fake memory ticket** no. Escaping work must not strongly own the screen is Applied judgment unless you have verified evidence.

---

## After this sample

1. Read every BROKEN/FIXED pair in [`../code/RetainCycleDemo.swift`](../code/RetainCycleDemo.swift).
2. Speak from [`../04-questions.md`](../04-questions.md) — especially T1, T5, T8.
3. Finish leftovers in [06-module-drills.md](06-module-drills.md).

---

Next: [05-system-design-mock.md](05-system-design-mock.md)
