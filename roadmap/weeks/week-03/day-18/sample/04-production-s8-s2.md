# Sample 04 — Production S8 and S2 (Q&A)

> Guided teaching. Separates **Verified** resume facts, **S2 path-scoped** technical add-on, and **Forbidden** causal overclaims.

---

### Q1. What can you claim under Verified · S8?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map) · [§2 Verified S8 STAR](../03-production-bridge.md#2-verified-s8--star-2-3-min)

**Answer:**

> **30+ lakh DAU**, sustained **99.95%+ crash-free sessions**, **Crashlytics triage** with structured workflows, **IMOC** coordination for **P0/P1** during high-traffic events. Mitigations first: feature guards, rollout pause, hotfix path, cadenced comms. CFS as sustained operational bar — not a slide metric. Forbidden: invented downtime minutes, “I wrote in-house signal handler” by default, “CFS proves no hangs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “At 30L+ DAU we held 99.95%+ crash-free — Crashlytics triage plus IMOC on P0/P1s, not just fixing stacks alone.” |
| Provenance tag? | Verified · S8 · BookMyShow · 30L+ DAU · 99.95%+ CFS · IMOC |
| Lesson? | Incident leadership = owner + blast radius + rollback — not lone-hero debugging. |

---

### Q2. Walk the S8 STAR spine

**Points to:** [Production bridge · §2 Verified S8](../03-production-bridge.md#2-verified-s8--star-2-3-min)

**Answer:**

> **Opener:** Sustaining 99.95%+ CFS at 30L+ DAU. **S/T:** Consumer ticketing at very large DAU — reliability as product during peak; structured crash response and multi-team command. **Action:** Crashlytics triage workflow; IMOC across iOS/backend/QA; mitigate first; CFS as operational bar. **Result:** Sustained high CFS; reduced peak-event downtime impact through ownership and blast-radius thinking. **Lesson:** Owner + mitigate + comms — not stack reading alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Action detail interviewers want? | Detect → classify → reproduce → mitigate → fix → write-up. |
| Result without fake stats? | Sustained bar + reduced impact — no invented minute counts. |
| Behavioral emphasis? | Cadenced comms under peak sale pressure. |

---

### Q3. How do you add S2 without stealing S8?

**Points to:** [Production bridge · §4 S2 add-on](../03-production-bridge.md#4-s2-as-technical-add-on-90s--correct-coupling) · [§3 Forbidden script](../03-production-bridge.md#forbidden-script)

**Answer:**

> **OK (≤90s add-on):** “Separately, shared async dictionaries had intermittent race crashes. We gated access with GCD serial queues and RW locks behind a safe API — removed concurrent-access crashes **on that path**. That contributed to reliability. I’m not claiming one fix is the whole 99.95% CFS story — triage, incident process, and many inputs including concurrency hygiene.” **Forbidden:** “We hit 99.95% because I synchronised dictionaries.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S2-A1? | Greenfield → Swift `actor` — How I would apply it. |
| When lead S2 vs S8? | Incident/leadership → S8; concurrency depth → S2 add-on after. |
| Provenance split? | S8 system · S2 path-scoped. |

---

### Q4. What must you never say about S8 and S2 together?

**Points to:** [Production bridge · Forbidden overclaims](../03-production-bridge.md#forbidden-overclaims)

**Answer:**

> Never: S2 alone caused/delivered 99.95% CFS. Never: in-house signal handler unless evidenced. Never: invented crash counts or downtime minutes. Never: CFS proves no hangs/OOM pain. Never: merge S8 IMOC story into fake memory Graph war story.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CFS honesty drill? | Foundations §9 — one minute continuous speak, restart if “because dictionaries.” |
| Hang gap phrase? | “CFS fine — still check hangs and MetricKit.” |
| Memory tools if asked? | Applied triage — Graph/Allocations, not Leaks for cycles. |

---

### Q5. How do behavioral variants use the same facts?

**Points to:** [Production bridge · §6 Behavioral variants](../03-production-bridge.md#6-behavioral-variants-same-facts)

**Answer:**

> **Conflict:** IMOC timeline vs blame spiral. **Pressure:** peak traffic mitigate-first + comms clock. **Leadership:** owner, handoff, postmortem actions. **Technical:** S2 races + signal-safety vocabulary as add-on — same Verified S8 spine, different emphasis per prompt.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| STAR time budget? | 2–3 min — opener 10s, action ~90s. |
| Mid-STAR memory question? | Short Applied triage sentence — return to IMOC narrative. |
| Postmortem? | Blameless — alerts/tests/runbooks as outputs. |

---

### Q6. How does S8 bridge to Days 17 and 20?

**Points to:** [Production bridge · implicit] · [Deep dive · §10 Failure modes](../02-deep-dive.md#10-failure-modes)

**Answer:**

> **Day 17:** CFS may be fine while users freeze — hang/OOM observability separate. Perf p90 culture (S5) complements CFS — don’t trust crash-free alone for UX. **Day 20:** release trains pause on perf/CFS gates; dSYM upload CI. Reliability is ops + engineering — not one dictionary fix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Jetsam clusters? | OOM heuristics + memory lab — not always CFS fatal. |
| Peak + perf? | S5 p90 and S8 CFS both matter during events. |
| Security launch cost? | Day 19 — measure; don’t silently regress startup. |

---

### Q7. Give a full honest answer mixing S8 and S2

**Points to:** [Production bridge · §3 Interview line](../03-production-bridge.md#3-interview-line-20s) · [§4 OK script](../03-production-bridge.md#ok-script)

**Answer:**

> “At 30L+ DAU we held 99.95%+ crash-free sessions through Crashlytics triage and IMOC coordination on P0/P1s (Verified S8) — mitigate first, blast radius, cadenced comms. Separately, synchronised shared async dictionaries removed intermittent race crashes on that path (Verified S2) — one reliability input among many. I don’t collapse those into one causal story. Hangs and OOM still need their own observability even when CFS looks fine.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified in paragraph? | Scale, CFS bar, IMOC, triage workflow. |
| S2 in paragraph? | Path-scoped race fix — contributed, not sole cause. |
| Honesty closing? | CFS ≠ full UX health. |

---

### Q8. What is the one-minute CFS honesty drill?

**Points to:** [Foundations · §9 One-minute drill](../01-foundations.md#9-one-minute-cfs-honesty-drill)

**Answer:**

> Speak continuously: “Crash-free at ninety-nine point nine five percent on thirty-plus lakh DAU was sustained through Crashlytics triage workflows and IMOC coordination on P0/P1s during peak traffic. Separately, synchronised dictionaries removed intermittent race crashes on a shared async state path — that contributed to reliability. I don’t collapse those into one causal story.” **Stop.** If you said “because of dictionaries,” restart.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why drill? | Interviews tempt false causality — muscle memory prevents it. |
| After this sample? | Code notes, [`../04-questions.md`](../04-questions.md), [`../05-exercises.md`](../05-exercises.md). |
| Primary provenance? | S8 IMOC/CFS system + S2 path honesty. |

---

## After this sample

1. Skim [`../code/BreadcrumbRing.swift`](../code/BreadcrumbRing.swift) and [`../code/CrashReportNotes.swift`](../code/CrashReportNotes.swift).
2. Time S8 STAR + S2 add-on from [`../04-questions.md`](../04-questions.md).
3. Run the one-minute CFS honesty drill aloud until clean.
