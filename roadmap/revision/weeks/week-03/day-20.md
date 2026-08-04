# Day 20 — Deep Links, Push & CI/CD

> Week 3 · Revision twin · Full study: [weeks/week-03/day-20/](../../../weeks/week-03/day-20/)

## 1. Outcome

- UL vs custom schemes; AASA; cold-start **queue**; one **DeepLinkRouter** for UL + push
- Push: permission → APNs token → **Airship** → payload → router
- **GitHub Actions → build/lint → TestFlight** + pause on CFS/perf
- **Verified · S13:** Grizzlies SwiftUI↔UIKit, deeplinks, Mixpanel, Airship
- BMS CI automation; AI PR review = assist (**S9**), not owner

## 2. Concept deep dive (revision)

```text
UL/scheme/push tap → Parser → AppRoute → AuthGate → Coordinator | PendingQueue
PR → Actions (lint/build/test) → sign/archive → TestFlight → phased → monitor → PAUSE
```

**Debug UL→Safari:** AASA HTTPS, teamID.bundle, paths, entitlements, CDN cache, user preference — not “iOS bug” first.

**Hybrid footgun (S13):** hosting identity / stack ownership — design coordinator.

## 3. Map to work

**S13:** “On Grizzlies I owned deeplinks and Airship push atop hybrid SwiftUI/UIKit, with Mixpanel analytics.”  
**CI:** “At BMS I automated GitHub Actions into TestFlight so releases weren’t manual ceremony.”

## 4. Drill

**N:** Q3 cold-start race · Q7 CI pipeline · Q10 hybrid+deeplink · Q4 push→router  
**T:** T1 Safari instead of app · T5 CFS drop at 10% phased · T2 malformed push JSON

## 5. Flashcards

| Front | Back |
|---|---|
| One router | UL+push share table · Trap: dual switches · Prod: S13 |
| Cold-start | Queue until ready · Trap: route instantly · Prod: race bugs |
| Airship | Engagement on APNs · Trap: skip APNs knowledge · Prod: S13 |
| Actions→TF | Automate build/lint/upload · Trap: no pause gates · Prod: BMS |
| AI PRs | Assist · Trap: “AI approved” · Prod: S9 |

## 6. Timed drill

Q3, Q7, Q10 + T1, T5.
