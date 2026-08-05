# Sample 04 — Release trains & rollout gates (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is a release train?

**Points to:** [Foundations · §3 CI/CD & release trains](../01-foundations.md#3-cicd--release-trains) · [Foundations · §0 North star](../01-foundations.md#0-north-star)

**Answer:**

> A **cadenced ship rhythm**: merge → CI → TestFlight → phased App Store percentage → monitor → promote or **pause**. Not “whoever remembers the checklist.” Combines automation (Actions → TF) with **human stop criteria** on reliability and perf. North star: automate the train; keep a **stop button** for CFS/perf.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Continuous deploy to 100%? | Rare on large consumer iOS — phased % standard. |
| Hotfix train? | Parallel fast lane — still needs gates. |
| Feature flags? | Decouple binary ship from user exposure. |

---

### Q2. What gates must pass before widening rollout?

**Points to:** [Foundations · §3](../01-foundations.md#3-cicd--release-trains) · [Deep dive · §5.3 TestFlight + phased release](../02-deep-dive.md#53-testflight--phased-release)

**Answer:**

> Tests green, **size budget**, **dSYM uploaded**, internal TF smoke, **CFS/perf thresholds** on phased rollout, **feature flags** configured. Promote percentage only when metrics hold. Weak gates + full automation = production roulette.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Size budget why? | Cellular download limits; Apple warnings. |
| Skip internal TF? | Risky — entitlements mismatches surface here. |
| Lint-only green? | Not sufficient — need build + tests. |

---

### Q3. When do you pause a phased rollout (S8)?

**Points to:** [Deep dive · §5.3](../02-deep-dive.md#53-testflight--phased-release) · [Deep dive · §8 Failure modes](../02-deep-dive.md#8-failure-modes) · [Production bridge · S8](../03-production-bridge.md#1-provenance-map)

**Answer:**

> **Stop criteria:** CFS drop, **pin-fail spike**, **journey p90 cliff**, crash-loop in TF. **IMOC** owns pause during high-traffic events — Verified S8 soft bridge. Example: CFS drop at 10% phased → pause, triage, fix or rollback — don’t “wait and see” through peak.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who pulls the stop? | IMOC / release owner — named in ops culture. |
| Pin fail + release? | Security module changes need pin metrics on rollout. |
| Invent “zero incidents”? | **Forbidden** — don’t fabricate release stats. |

---

### Q4. How do feature flags decouple ship from exposure?

**Points to:** [Deep dive · §5.3](../02-deep-dive.md#53-testflight--phased-release) · [Deep dive · §9 End-to-end story](../02-deep-dive.md#9-end-to-end-story-you-can-draw-in-3-minutes)

**Answer:**

> Ship binary to App Store phased % with flag **off** → enable remotely for cohort → ramp. Bad behavior? **Kill flag** without emergency App Review for every rollback. Pair with Remote Config for SDUI kill switches. Still need CI quality — flags don’t fix crash-on-launch.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Flag vs phased %? | Both — binary reach vs feature exposure. |
| SDUI kill switch? | Disable server-driven surface; native scaffold fallback. |
| Flag debt? | Clean old flags — operational hygiene. |

---

### Q5. Draw the 3-minute end-to-end story.

**Points to:** [Deep dive · §9 End-to-end story](../02-deep-dive.md#9-end-to-end-story-you-can-draw-in-3-minutes)

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

---

### Q6. BMS CI + Grizzlies S13 — how to tell one story?

**Points to:** [Deep dive · §10 BMS CI elevator](../02-deep-dive.md#10-bms-ci-elevator-45s--grizzlies-90s-back-to-back) · [Production bridge · §3 Interview lines](../03-production-bridge.md#3-interview-lines)

**Answer:**

> **BMS CI (45s):** “Automated GitHub Actions for lint, build, TestFlight — signing secrets in CI, not repo; phased rollout still needs human stop on crash-free and perf.”  
> **Grizzlies (90s):** “Hybrid SwiftUI/UIKit with deeplinks, Mixpanel, Airship — one router so campaigns and https links don’t drift.”  
> Combined: entrypoints + release train as **one reliability story**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S13 Verified exact claim? | SwiftUI↔UIKit; deeplinks; Mixpanel; Airship — no invented CTR. |
| BMS CI Verified? | Actions build/lint/TestFlight — resume automation. |
| Claim building Airship? | **Forbidden** — integrated, not authored. |

---

### Q7. Release train teach-back?

**Points to:** [Foundations · §5 Teach-back](../01-foundations.md#5-teach-back) · [Production bridge](../03-production-bridge.md)

**Answer:**

> 1. UL vs scheme  
> 2. One router for UL + push  
> 3. Cold-start queue  
> 4. Actions → TestFlight + pause criteria  
> 5. S13 one-liner  
> Close: “Automate the train; IMOC pauses when CFS or p90 cliffs — flags decouple exposure from binary ship.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 20 agenda opener? | “Unify UL and push into one router, cold-start queuing, Actions → TestFlight with rollout gates.” |
| After sample? | [`../04-questions.md`](../04-questions.md) |
| App sync? | See sample README bash commands. |

---

Next: [`../04-questions.md`](../04-questions.md)
