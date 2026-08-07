# Sample 04 — Crash-free culture & synchronised dictionaries (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow IMOC + crash-free at scale?

**Answer:**

> **30+ lakh DAU**, sustained **99.95%+ crash-free sessions**, **Crashlytics triage** with structured workflows, **IMOC** coordination for **P0/P1** during high-traffic events. Mitigations first: feature guards, rollout pause, hotfix path, cadenced comms. CFS as sustained operational bar — not a slide metric. Forbidden: invented downtime minutes, “I wrote in-house signal handler” by default, “CFS proves no hangs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “At 30L+ DAU we held 99.95%+ crash-free — Crashlytics triage plus IMOC on P0/P1s, not just fixing stacks alone.” |
| Provenance tag? | BookMyShow IMOC + crash-free at scale · BookMyShow · 30L+ DAU · 99.95%+ CFS · IMOC |
| Lesson? | Incident leadership = owner + blast radius + rollback — not lone-hero debugging. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q2. Walk the BookMyShow IMOC + crash-free at scale STAR spine

**Answer:**

> **Opener:** Sustaining 99.95%+ CFS at 30L+ DAU. **S/T:** Consumer ticketing at very large DAU — reliability as product during peak; structured crash response and multi-team command. **Action:** Crashlytics triage workflow; IMOC across iOS/backend/QA; mitigate first; CFS as operational bar. **Result:** Sustained high CFS; reduced peak-event downtime impact through ownership and blast-radius thinking. **Lesson:** Owner + mitigate + comms — not stack reading alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Action detail interviewers want? | Detect → classify → reproduce → mitigate → fix → write-up. |
| Result without fake stats? | Sustained bar + reduced impact — no invented minute counts. |
| Behavioral emphasis? | Cadenced comms under peak sale pressure. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q3. How do you add BookMyShow synchronised dictionaries without stealing BookMyShow IMOC + crash-free at scale?

**Answer:**

> **OK (≤90s add-on):** “Separately, shared async dictionaries had intermittent race crashes. We gated access with GCD serial queues and RW locks behind a safe API — removed concurrent-access crashes **on that path**. That contributed to reliability. I’m not claiming one fix is the whole 99.95% CFS story — triage, incident process, and many inputs including concurrency hygiene.” **Forbidden:** “We hit 99.95% because I synchronised dictionaries.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Design: actor SafeDict (not shipped)? | Greenfield → Swift `actor` — How I would apply it. |
| When lead BookMyShow synchronised dictionaries vs BookMyShow IMOC + crash-free at scale? | Incident/leadership → BookMyShow IMOC + crash-free at scale; concurrency depth → BookMyShow synchronised dictionaries add-on after. |
| Provenance split? | BookMyShow IMOC + crash-free at scale system · BookMyShow synchronised dictionaries path-scoped. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q4. What must you never say about BookMyShow IMOC + crash-free at scale and BookMyShow synchronised dictionaries together?

**Answer:**

> Never: BookMyShow synchronised dictionaries alone caused/delivered 99.95% CFS. Never: in-house signal handler unless evidenced. Never: invented crash counts or downtime minutes. Never: CFS proves no hangs/OOM pain. Never: merge BookMyShow IMOC + crash-free at scale IMOC story into fake memory Graph war story.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| CFS honesty drill? | Foundations §9 — one minute continuous speak, restart if “because dictionaries.” |
| Hang gap phrase? | “CFS fine — still check hangs and MetricKit.” |
| Memory tools if asked? | Applied triage — Graph/Allocations, not Leaks for cycles. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q5. How do behavioral variants use the same facts?

**Answer:**

> **Conflict:** IMOC timeline vs blame spiral. **Pressure:** peak traffic mitigate-first + comms clock. **Leadership:** owner, handoff, postmortem actions. **Technical:** BookMyShow synchronised dictionaries races + signal-safety vocabulary as add-on — same BookMyShow IMOC + crash-free at scale spine, different emphasis per prompt.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| STAR time budget? | 2–3 min — opener 10s, action ~90s. |
| Mid-STAR memory question? | Short Applied triage sentence — return to IMOC narrative. |
| Postmortem? | Blameless — alerts/tests/runbooks as outputs. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q6. How does BookMyShow IMOC + crash-free at scale bridge to Days 17 and 20?

**Answer:**

> **Day 17:** CFS may be fine while users freeze — hang/OOM observability separate. Perf p90 culture (BookMyShow Firebase Performance traces) complements CFS — don’t trust crash-free alone for UX. **Day 20:** release trains pause on perf/CFS gates; dSYM upload CI. Reliability is ops + engineering — not one dictionary fix.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Jetsam clusters? | OOM heuristics + memory lab — not always CFS fatal. |
| Peak + perf? | BookMyShow Firebase Performance traces p90 and BookMyShow IMOC + crash-free at scale CFS both matter during events. |
| Security launch cost? | Day 19 — measure; don’t silently regress startup. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q7. Give a full honest answer mixing BookMyShow IMOC + crash-free at scale and BookMyShow synchronised dictionaries

**Answer:**

> “At 30L+ DAU we held 99.95%+ crash-free sessions through Crashlytics triage and IMOC coordination on P0/P1s (BookMyShow IMOC + crash-free at scale) — mitigate first, blast radius, cadenced comms. Separately, synchronised shared async dictionaries removed intermittent race crashes on that path (BookMyShow synchronised dictionaries) — one reliability input among many. I don’t collapse those into one causal story. Hangs and OOM still need their own observability even when CFS looks fine.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified in paragraph? | Scale, CFS bar, IMOC, triage workflow. |
| BookMyShow synchronised dictionaries in paragraph? | Path-scoped race fix — contributed, not sole cause. |
| Honesty closing? | CFS ≠ full UX health. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q8. What is the one-minute CFS honesty drill?

**Answer:**

> Speak continuously: “Crash-free at ninety-nine point nine five percent on thirty-plus lakh DAU was sustained through Crashlytics triage workflows and IMOC coordination on P0/P1s during peak traffic. Separately, synchronised dictionaries removed intermittent race crashes on a shared async state path — that contributed to reliability. I don’t collapse those into one causal story.” **Stop.** If you said “because of dictionaries,” restart.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why drill? | Interviews tempt false causality — muscle memory prevents it. |
| After this sample? | Code notes, [`../04-questions.md`](../04-questions.md), [`../05-exercises.md`](../05-exercises.md). |
| Primary provenance? | BookMyShow IMOC + crash-free at scale IMOC/CFS system + BookMyShow synchronised dictionaries path honesty. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

## After this sample

1. Skim [`../code/BreadcrumbRing.swift`](../code/BreadcrumbRing.swift) and [`../code/CrashReportNotes.swift`](../code/CrashReportNotes.swift).
2. Time BookMyShow IMOC + crash-free at scale STAR + BookMyShow synchronised dictionaries add-on from [`../04-questions.md`](../04-questions.md).
3. Run the one-minute CFS honesty drill aloud until clean.

---

