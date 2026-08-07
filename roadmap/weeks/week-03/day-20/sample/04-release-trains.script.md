# Audio script — Sample 04 — Release trains & rollout gates (Q&A)
> Listen-only sample Q&A from `04-release-trains.md`. Spoken answers and follow-ups.

## §0 Q1. What is a release train?

Next. Q1. What is a release train? Answer. A cadenced ship rhythm: merge → CI → TestFlight → phased App Store percentage → monitor → promote or pause. Not “whoever remembers the checklist.” Combines automation (Actions → TF) with human stop criteria on reliability and perf. North star: automate the train; keep a stop button for crash free sessions/perf. Follow-ups. Continuous deploy to 100%?: Rare on large consumer i O S — phased % standard.. Hotfix train?: Parallel fast lane — still needs gates.. Feature flags?: Decouple binary ship from user exposure..

## §1 Q2. What gates must pass before widening rollout?

Next. Q2. What gates must pass before widening rollout? Answer. Tests green, size budget, dSYM uploaded, internal TF smoke, crash free sessions/perf thresholds on phased rollout, feature flags configured. Promote percentage only when metrics hold. Weak gates + full automation = production roulette. Follow-ups. Size budget why?: Cellular download limits; Apple warnings.. Skip internal TF?: Risky — entitlements mismatches surface here.. Lint-only green?: Not sufficient — need build + tests..

## §2 Q3. When do you pause a phased rollout (BookMyShow IMOC + crash-free at scale)?

Next. Q3. When do you pause a phased rollout (BookMyShow IMOC + crash-free at scale)? Answer. Stop criteria: crash free sessions drop, pin-fail spike, journey p90 cliff, crash-loop in TF. I M O C owns pause during high-traffic events — BookMyShow I M O C + crash-free at scale soft bridge. Example: crash free sessions drop at 10% phased → pause, triage, fix or rollback — don’t “wait and see” through peak. Follow-ups. Who pulls the stop?: I M O C / release owner — named in ops culture.. Pin fail + release?: Security module changes need pin metrics on rollout.. Invent “zero incidents”?: Forbidden — don’t fabricate release stats..

## §3 Q4. How do feature flags decouple ship from exposure?

Next. Q4. How do feature flags decouple ship from exposure? Answer. Ship binary to App Store phased % with flag off → enable remotely for cohort → ramp. Bad behavior? Kill flag without emergency App Review for every rollback. Pair with Remote Config for S D U I kill switches. Still need CI quality — flags don’t fix crash-on-launch. Follow-ups. Flag vs phased %?: Both — binary reach vs feature exposure.. S D U I kill switch?: Disable server-driven surface; native scaffold fallback.. Flag debt?: Clean old flags — operational hygiene..

## §4 Q5. Draw the 3-minute end-to-end story.

Next. Q5. Draw the 3-minute end-to-end story Answer. Entry: Campaign https link (AASA/UL) + Airship push tap → DeepLinkParser → AppRoute → AuthGate → Coordinator (hybrid UIKit/SwiftUI) → Mixpanel screen + Airship attribution. Parallel: PR Actions → TestFlight → phased % → crash free sessions/p90 monitors → pause/I M O C. Say: “Entrypoints differ; routing and release gates are shared disciplines.” Follow-ups. Combined ≤25s line?: Grizzlies entrypoints + BMS release automation — production bridge §3.. Deeplink-only story?: Incomplete without rollout gates for senior loop.. Analytics after route?: Mixpanel on screen — not in parser..

## §5 Q6. BMS CI + Grizzlies Hybrid UI / deeplinks — how to tell one story?

Next. Q6. BMS CI + Grizzlies Hybrid UI / deeplinks — how to tell one story? Answer. BMS CI (45s): “Automated GitHub Actions for lint, build, TestFlight — signing secrets in CI, not repo; phased rollout still needs human stop on crash-free and perf.” Grizzlies (90s): “Hybrid SwiftUI/UIKit with deeplinks, Mixpanel, Airship — one router so campaigns and https links don’t drift.” Combined: entrypoints + release train as one reliability story. Follow-ups. Hybrid U I / deeplinks Verified exact claim?: SwiftUI↔UIKit; deeplinks; Mixpanel; Airship — no invented CTR.. BMS CI Verified?: Actions build/lint/TestFlight — resume automation.. Claim building Airship?: Forbidden — integrated, not authored..

## §6 Q7. Release train teach-back?

Next. Q7. Release train teach-back? Answer. 1. UL vs scheme 2. One router for UL + push 3. Cold-start queue 4. Actions → TestFlight + pause criteria 5. Hybrid U I / deeplinks one-liner Close: “Automate the train; I M O C pauses when crash free sessions or p90 cliffs — flags decouple exposure from binary ship.” Follow-ups. Day 20 agenda opener?: “Unify UL and push into one router, cold-start queuing, Actions → TestFlight with rollout gates.”. After sample?:../04-questions.md. App sync?: See sample README bash commands..
