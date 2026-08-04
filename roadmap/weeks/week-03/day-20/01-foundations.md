# 01 — Foundations: Deeplinks, Push, Release Trains

---

## 0. North star

**One router for every entrypoint; queue links until navigation is ready; automate the train; keep a stop button for CFS/perf.**

---

## 1. Deep linking pipeline

```text
https://domain/path?params  (Universal Link if AASA ok)
  OR myapp://…              (custom scheme — hijackable)
  → Scene / onOpenURL
  → DeepLinkRouter (parse, validate, match)
  → AppCoordinator (nav ready?)
  → Target screen OR queue until warm
```

| | Universal Links | Custom scheme |
|---|---|---|
| Security | Domain association via AASA | Hijackable by other apps |
| UX | https works in browser too | `myapp://` only |
| Setup | AASA + entitlements | URL types in Info |

**AASA:** JSON at `/.well-known/apple-app-site-association` over HTTPS; lists appIDs + paths; size limits; CDN caching can delay fixes (~OS cache).

**Cold start race:** link arrives before DI/nav ready → **queue** intent; flush when root UI ready; invalid → safe home + metric.

**Security:** validate params; auth-gate checkout; never trust URL for price/user authority.

---

## 2. Push pipeline

```text
Permission (contextual) → register for remote notifications
  → APNs device token → backend / Airship
  → Campaign / transactional push
  → Tap → deep link / category action → SAME router as UL
```

| Topic | Senior line |
|---|---|
| Airship | Engagement layer on APNs — segments/journeys; still know APNs |
| Payload | Small; route id/URL; defensive decode (CFS!) |
| Token lifecycle | Register; upload; refresh on reinstall/OS; invalidate old |
| Foreground vs tap | Different handlers; unify routing |

**Verified · S13:** Memphis Grizzlies — deeplinks + **Airship** + **Mixpanel** atop hybrid SwiftUI/UIKit navigation.

---

## 3. CI/CD & release trains

```text
PR → GitHub Actions (lint, build, unit tests)
  → merge → archive + sign
  → TestFlight (internal/external)
  → phased App Store
  → monitor CFS / perf → PAUSE if needed
```

**BMS proof:** automated **GitHub Actions** for build, lint, **TestFlight** — cut manual release overhead.

**Gates:** tests green, size budget, **dSYM upload** (Day 18), CFS/perf thresholds on phased rollout, feature flags.

**Signing:** secrets in CI — never commit `.p12` in clear.

**AI PR review:** accelerate regression spotting; humans own architecture/security (**S9** judgment).

---

## 4. Glossary

| Term | Meaning |
|---|---|
| AASA | apple-app-site-association |
| Deferred deep link | Post-install route attribution |
| APNs | Apple Push Notification service |
| Collapse id | Collapse related notifications |
| Release train | Cadenced ship + phased % |
| match / signing | Cert/profile management in CI |

---

## 5. Teach-back

1. UL vs scheme  
2. One router for UL + push  
3. Cold-start queue  
4. Actions → TestFlight + pause criteria  
5. S13 one-liner  

Next: [`02-deep-dive.md`](02-deep-dive.md).
