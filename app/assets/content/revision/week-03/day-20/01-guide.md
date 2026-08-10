# Day 20 — Deep Links, Push Notifications & CI/CD Release Trains

> Week 3 · Revision pass ~45–60 min  
> Full study: [weeks/week-03/day-20/](../../../weeks/week-03/day-20/README.md)  
> Sample Q&A (guided): [weeks/week-03/day-20/sample/](../../../weeks/week-03/day-20/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- **Universal Links vs custom schemes**, **AASA**, cold-start **queue-until-ready**
- Push flow: permission → APNs token → provider (**Airship**) → payload → **same DeepLinkRouter**
- **GitHub Actions → build/lint → TestFlight** and release-train **pause** criteria
- **Verified Hybrid UI / deeplinks:** Grizzlies **SwiftUI↔UIKit**, **deeplinks**, **Mixpanel**, **Airship**
- AI PR review **assists** — humans own architecture and security (District Free Parking + Clean/MVVM + AI tooling)

## 2. Concept refresh (simple)

### 2.1 One router

Universal Links, custom URL schemes, and push notification taps all resolve through **one routing table** — not parallel nav stacks.

```text
Entry (link / scheme / push tap)
  → parse intent → queue if cold-start not ready → flush → feature factory
```

### 2.2 Cold start

Queue deep links until navigation and DI are ready, then flush in order. Never race partial graph wiring.

### 2.3 Release train gates

Phased rollout with pause criteria tied to **BookMyShow IMOC + crash-free at scale** reliability: CFS drop, pin-fail spike, journey p90 cliff → stop rollout.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| One router | Universal Links, custom schemes, and push taps share **one** routing table |
| Cold start | Queue deep links until navigation/DI is ready — then flush |
| **Hybrid UI / deeplinks** Verified | Grizzlies: SwiftUI↔UIKit; deeplinks; Mixpanel; Airship |
| **BMS CI** | GitHub Actions build/lint → TestFlight — not manual ceremony |
| **District Free Parking + Clean/MVVM + AI tooling** | AI PR review **assists** — humans own architecture and security |
| Pause criteria | CFS drop, pin-fail spike, journey p90 cliff → stop phased rollout (BookMyShow IMOC + crash-free at scale) |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-03/day-20/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-03/day-20/01-foundations.md) | Gaps |
| Deepen | [code/DeepLinkQueue.swift](../../../weeks/week-03/day-20/code/DeepLinkQueue.swift) | Queue sketch |
| Drill | [07-revision-qna](../../../weeks/week-03/day-20/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**Hybrid UI / deeplinks:** Memphis Grizzlies — SwiftUI↔UIKit interop, deeplinks, Mixpanel analytics, Airship push.  
**BMS CI:** GitHub Actions build/lint → TestFlight automation on resume.  
**Soft:** District Free Parking + Clean/MVVM + AI tooling AI-assisted review judgment; BookMyShow IMOC + crash-free at scale pause rollout on CFS drop.

**Interview line (≤20s):** “I unify Universal Links and push into one router with cold-start queuing, and our release train pauses on CFS or perf cliffs — not vibes.”

→ [Hybrid UI / deeplinks Grizzlies](../../stories/story-bank.md#s13--swiftuiuikit--deeplinks--analyticspush-raw--memphis-grizzlies)

## 5. Flash prompts

1. Universal Links vs custom scheme — trade-off in one breath
2. AASA — what it proves and common failure modes
3. Cold-start deep link — queue until when?
4. Push tap routing — same router as links?
5. APNs token lifecycle — register, refresh, invalidation
6. Airship’s role vs APNs transport
7. GitHub Actions → TestFlight — honest BMS CI scope
8. Phased rollout pause criteria — name three
9. District Free Parking + Clean/MVVM + AI tooling — AI assists, humans own architecture
10. Verified Hybrid UI / deeplinks ≤20s — hybrid + deeplinks + push

## 6. Timed drills

| Drill | Budget |
|---|---|
| One-router diagram | 60s |
| Cold-start queue behavior | 45s |
| Push payload → route | 45s |
| CI/CD pipeline outline | 60s |
| Rollout pause criteria | 45s |
| Hybrid UI / deeplinks ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-03/day-20/sample/) and [07-revision-qna](../../../weeks/week-03/day-20/sample/07-revision-qna.md) answer points.
