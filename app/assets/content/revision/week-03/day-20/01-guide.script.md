# Audio script — Revision guide — Deep Links, Push Notifications & CI/CD Release Trains
> Listen-only revision day guide from `day-20.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: Universal Links vs custom schemes, AASA, cold-start queue-until-ready Push flow: permission → APNs token → provider (Airship) → payload → same DeepLinkRouter GitHub Actions → build/lint → TestFlight and release-train pause criteria.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 One router

Next. 2.1 One router. Universal Links, custom URL schemes, and push notification taps all resolve through one routing table — not parallel nav stacks.

## §3 2.2 Cold start

Next. 2.2 Cold start. Queue deep links until navigation and D I are ready, then flush in order. Never race partial graph wiring.

## §4 2.3 Release train gates

Next. 2.3 Release train gates. Phased rollout with pause criteria tied to BookMyShow I M O C + crash-free at scale reliability: crash free sessions drop, pin-fail spike, journey p90 cliff → stop rollout.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. Hybrid U I / deeplinks: Memphis Grizzlies — SwiftUI↔UIKit interop, deeplinks, Mixpanel analytics, Airship push. Book My Show CI: GitHub Actions build/lint → TestFlight automation on resume. Soft: District Free Parking + Clean/M V V M + AI tooling AI-assisted review judgment; BookMyShow I M O C + crash-free at scale pause rollout on crash free sessions drop. Interview line (≤20s): “I unify Universal Links and push into one router with cold-start queuing, and our release train pauses on crash free sessions or perf cliffs — not vibes.”.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. Universal Links vs custom scheme — trade-off in one breath 2. AASA — what it proves and common failure modes 3. Cold-start deep link — queue until when? 4. Push tap routing — same router as links?

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 07-revision-qna answer points.
