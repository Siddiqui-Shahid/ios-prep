# Sample 04 — Release trains & rollout gates (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is a release train?
**Answer:**

> A **cadenced ship rhythm**: merge → CI → TestFlight → phased App Store percentage → monitor → promote or **pause**. Not “whoever remembers the checklist.” Combines automation (Actions → TF) with **human stop criteria** on reliability and perf. North star: automate the train; keep a **stop button** for CFS/perf.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Continuous deploy to 100%? | Rare on large consumer iOS — phased % standard. |
| Hotfix train? | Parallel fast lane — still needs gates. |
| Feature flags? | Decouple binary ship from user exposure. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What gates must pass before widening rollout?
**Answer:**

> Tests green, **size budget**, **dSYM uploaded**, internal TF smoke, **CFS/perf thresholds** on phased rollout, **feature flags** configured. Promote percentage only when metrics hold. Weak gates + full automation = production roulette.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Size budget why? | Cellular download limits; Apple warnings. |
| Skip internal TF? | Risky — entitlements mismatches surface here. |
| Lint-only green? | Not sufficient — need build + tests. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. When do you pause a phased rollout (BookMyShow IMOC + crash-free at scale)?
**Answer:**

> **Stop criteria:** CFS drop, **pin-fail spike**, **journey p90 cliff**, crash-loop in TF. **IMOC** owns pause during high-traffic events — BookMyShow IMOC + crash-free at scale soft bridge. Example: CFS drop at 10% phased → pause, triage, fix or rollback — don’t “wait and see” through peak.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who pulls the stop? | IMOC / release owner — named in ops culture. |
| Pin fail + release? | Security module changes need pin metrics on rollout. |
| Invent “zero incidents”? | **Forbidden** — don’t fabricate release stats. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q4. How do feature flags decouple ship from exposure?
**Answer:**

> Ship binary to App Store phased % with flag **off** → enable remotely for cohort → ramp. Bad behavior? **Kill flag** without emergency App Review for every rollback. Pair with Remote Config for SDUI kill switches. Still need CI quality — flags don’t fix crash-on-launch.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Flag vs phased %? | Both — binary reach vs feature exposure. |
| SDUI kill switch? | Disable server-driven surface; native scaffold fallback. |
| Flag debt? | Clean old flags — operational hygiene. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Draw the 3-minute end-to-end story?
**Answer:**

> **Entry:** Campaign https link (AASA/UL) + Airship push tap → **DeepLinkParser → AppRoute → AuthGate → Coordinator** (hybrid UIKit/SwiftUI) → Mixpanel screen + Airship attribution. 
> **Parallel:** PR Actions → TestFlight → phased % → CFS/p90 monitors → pause/IMOC. 
> Say: “Entrypoints differ; routing and release gates are shared disciplines.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Combined ≤25s line? | Grizzlies entrypoints + BMS release automation — production bridge §3. |
| Deeplink-only story? | Incomplete without rollout gates for senior loop. |
| Analytics after route? | Mixpanel on screen — not in parser. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. BMS CI + Grizzlies Hybrid UI / deeplinks — how to tell one story?
**Answer:**

> **BMS CI (45s):** “Automated GitHub Actions for lint, build, TestFlight — signing secrets in CI, not repo; phased rollout still needs human stop on crash-free and perf.” 
> **Grizzlies (90s):** “Hybrid SwiftUI/UIKit with deeplinks, Mixpanel, Airship — one router so campaigns and https links don’t drift.” 
> Combined: entrypoints + release train as **one reliability story**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hybrid UI / deeplinks Verified exact claim? | SwiftUI↔UIKit; deeplinks; Mixpanel; Airship — no invented CTR. |
| BMS CI Verified? | Actions build/lint/TestFlight — resume automation. |
| Claim building Airship? | **Forbidden** — integrated, not authored. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Release train teach-back?
**Answer:**

> 1. UL vs scheme 
> 2. One router for UL + push 
> 3. Cold-start queue 
> 4. Actions → TestFlight + pause criteria 
> 5. Hybrid UI / deeplinks one-liner 
> Close: “Automate the train; IMOC pauses when CFS or p90 cliffs — flags decouple exposure from binary ship.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 20 agenda opener? | “Unify UL and push into one router, cold-start queuing, Actions → TestFlight with rollout gates.” |
| After sample? | [07-revision-qna.md](07-revision-qna.md) |
| App sync? | See sample README bash commands. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What gates must pass before widening rollout

**Ask yourself:** What gates must pass before widening rollout?

**Answer:** “Tests green, **size budget**, **dSYM uploaded**, internal TF smoke, **CFS/perf thresholds** on phased rollout, **feature flags** configured. Promote percentage only when metrics hold. Weak gates + full automation = production roulette.”

### Puzzle B — When do you pause a phased rollout (BookMyShow IMOC + crash-free at scale)

**Ask yourself:** When do you pause a phased rollout (BookMyShow IMOC + crash-free at scale)?

**Answer:** “**Stop criteria:** CFS drop, **pin-fail spike**, **journey p90 cliff**, crash-loop in TF. **IMOC** owns pause during high-traffic events — BookMyShow IMOC + crash-free at scale soft bridge. Example: CFS drop at 10% phased → pause, triage, fix or rollback — don’t “wait and see” through peak.”

### Puzzle C — How do feature flags decouple ship from exposure

**Ask yourself:** How do feature flags decouple ship from exposure?

**Answer:** “Ship binary to App Store phased % with flag **off** → enable remotely for cohort → ramp. Bad behavior? **Kill flag** without emergency App Review for every rollback. Pair with Remote Config for SDUI kill switches. Still need CI quality — flags don’t fix crash-on-launch.”
