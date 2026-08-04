# 03 — Production bridge: reliability culture vs memory triage

> Separate what you **verified shipped** from what you would **apply as design judgment**. Never blur them in an interview.

## 1. Provenance map for this chapter

| Label | ID | What you may claim |
|---|---|---|
| **Verified** | S8 | BookMyShow consumer app at **30+ lakh DAU**; sustained **99.95%+ crash-free sessions**; Crashlytics triage workflows; **IMOC** coordination for P0/P1 during high-traffic events |
| **How I would apply it** | S8 extension (not a separate registry ID) | Memory Graph + Allocations + Leaks triage playbook for abandoned VCs / retain cycles under peak traffic — as *how a reliability-minded iOS engineer would hunt memory pressure*, not as “I personally shipped Memory Graph runbooks at BMS” |
| **Learning-lab** | — | `RetainCycleDemo.swift`, playground cycles, Instruments practice on a sample app |

### Forbidden phrasing (unless you later add real evidence)

- “At BMS I opened Memory Graph and found the ad retain cycle.”
- “We measured X% memory reduction from fixing cycles.” (not in resume)
- “Leaks showed our retain cycles.” (technically false anyway)

### Preferred phrasing

> “At BMS scale we treated crash-free and incident ownership as first-class — Crashlytics + IMOC under 30L+ DAU and a 99.95%+ CFS bar (Verified S8). For memory specifically, my triage approach would be Memory Graph for cycles and Allocations for growth — not Leaks for retain cycles (How I would apply it).”

## 2. Verified · S8 — what reliability culture actually means

> **Provenance:** Verified · S8 · BookMyShow · 30L+ DAU · 99.95%+ CFS · Crashlytics · IMOC

Resume-backed facts you can own:

1. **Scale:** tens of lakhs of daily users — small per-user memory bugs become fleet-wide pressure.
2. **Bar:** 99.95%+ crash-free sessions is a reliability KPI, not a vanity metric.
3. **Workflow:** Crashlytics triage with structured crash workflows.
4. **Ownership:** IMOC role coordinating iOS, backend, QA on P0/P1 during peak events.

How this connects to *today’s topic* without overclaiming:

- Memory pressure (jetsam) and bad lifecycle ownership show up as **crashes / kills / instability** in the same reliability conversation as races and nil crashes.
- Senior signal is **process**: reproduce → classify (crash vs abandoned memory vs true leak) → fix ownership → verify → communicate blast radius.
- S8 proves you operated under a high CFS bar; it does **not** by itself prove a specific Instruments screenshot from BMS.

### 20-second interview line (Verified only)

> “At BookMyShow we held a 99.95%+ crash-free bar at 30L+ DAU — Crashlytics workflows and IMOC ownership for P0/P1. Memory and lifecycle bugs were reliability issues, not ‘just perf.’”

### 45-second bridge into ARC (Verified + Applied clearly labeled)

> “Verified: that reliability culture is S8. Applied: if we saw climbing memory or VCs that never deinited after navigation, I wouldn’t start in Leaks for a suspected retain cycle — I’d use Memory Graph to see who retains the object and Allocations to confirm persistent growth, then fix weak captures / timer invalidation / observer tokens.”

## 3. How I would apply it — triage playbook at BMS-shaped apps

> **Provenance:** How I would apply it · memory triage for retain cycles / abandoned VCs

### Trigger signals

| Signal | Hypothesis |
|---|---|
| Memory climbs while user browses listings → detail → back | Abandoned VCs / image caches / cycles |
| Ad module / video surface left on screen stack | Closure or player retain |
| Live ticking UI after leave | Timer target retain |
| Weird callbacks after pop | Notification / Task / network completion holding `self` |
| Jetsam clusters in Crashlytics during big events | Peak memory + abandoned heaps |

### Step-by-step (say this in interviews)

1. **Reproduce** on a debug build with the suspect flow (push/pop N times).
2. **Expect death:** temporary `deinit` log on the VC / controller under test (lab).
3. **Memory Graph:** filter type; inspect unexpected remaining instances; walk retain edges.
4. **Classify:** cycle / singleton cache / still-on-window — not “ARC bug.”
5. **Allocations:** mark generations before/after navigation; confirm persistent bytes of that type.
6. **Leaks:** only if Graph suggests unreachable weirdness or CF/unsafe involvement — do not use Leaks as the cycle detector.
7. **Fix:** weak capture, weak delegate, `timer.invalidate()`, NC token removal, Task cancel.
8. **Verify:** `deinit` runs; Graph clear; Allocations flat across generations.
9. **Reliability wrap:** if it shipped, watch Crashlytics / memory metrics; communicate blast radius like any P1.

### Ads / navigation flavor (Applied, not a fake war story)

Ads and media surfaces are classic cycle magnets: completion handlers, players, timers, notification hooks. At revenue-critical modules (Verified S1 exists for ads architecture — separate story), a senior instinct is: **escaping work must not strongly own the screen**.

You may say:

> “How I would apply it in an ads or checkout flow: every escaping completion gets a capture-list review, timers invalidate on teardown, and I confirm the VC disappears in Memory Graph before calling the memory bug fixed.”

Do **not** invent a specific BMS ticket ID or metric.

## 4. District / Raw hooks (light touch)

| Context | Provenance | Memory angle |
|---|---|---|
| District Free Parking / MVVM-Clean (S9) | Verified S9 for architecture; Applied for memory | Migrations often leave orphaned observers or long-lived VMs — review teardown during refactors |
| Raw live scoreboard (S10/S11) | Verified realtime ownership | Timers / live updates: invalidate and weak captures or you keep scoreboard controllers forever |
| Personal apps | Learning-lab | Safe place to practice Graph without claiming production |

Keep Day 03 centered on **S8 + Applied triage**. Don’t force every company into a fake memory anecdote.

## 5. Mapping tools to production language

| Engineer says | Interview-correct meaning | Tool |
|---|---|---|
| “We leaked the VC” (casual) | Usually **abandoned** via cycle / cache | Graph / Allocations |
| “True leak” | Unreachable allocation | Leaks |
| “Memory pressure / jetsam” | OS killed process | Crashlytics + memory reports |
| “High watermark” | Peak usage, may be OK | Allocations |

Teach PMs/QA the difference only if useful; teach interviewers by using precise words.

## 6. STAR sketch (S8) — keep ARC as supporting color

When the behavioral question is incident ownership, lead with S8 STAR (see story bank). Memory enters as *one class of reliability defect*, not the hero claim unless the interviewer asks about leaks.

**Situation/Task:** 30L+ DAU, 99.95%+ CFS, fast P0/P1.  
**Action:** Crashlytics workflows; IMOC coordination; mitigations and comms.  
**Result:** Sustained crash-free; reduced downtime in peaks.  
**If asked about memory:** pivot to Applied triage playbook above — labeled honestly.

Full STAR: [`../../../stories/story-bank.md`](../../../stories/story-bank.md)#s8--imoc--crash-free-at-scale-bookmyshow

## 7. Checklist before you speak in an interview

- [ ] Did I label Verified vs Applied?
- [ ] Did I avoid “cycles show in Leaks”?
- [ ] Did I mention Timer retain + invalidate?
- [ ] Did I mention NC **tokens** for the block API?
- [ ] Did I invent a BMS Memory Graph war story? → rewrite as Applied

Next: [code/RetainCycleDemo.swift](code/RetainCycleDemo.swift), then [04-questions.md](04-questions.md).
