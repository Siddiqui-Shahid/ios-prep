# 02 — Deep Dive: Routing, Airship, CI Gates

---

## 1. Universal Links debugging checklist

When links open Safari instead of the app:

1. AASA reachable over HTTPS; correct content-type
2. `appID` = `TEAMID.bundle`
3. Paths match (not excluded)
4. Entitlements associated domains
5. Apple CDN / device cache delay after AASA changes
6. User long-press “Open in Safari” preference
7. Universal Links vs opening from notes/apps quirks

**Trap:** “iOS bug” as first answer.

---

## 2. Router architecture

```text
Entrypoints: UL | custom scheme | push tap | Spotlight (optional)
     ↓
 DeepLinkParser → AppRoute (typed enum)
     ↓
 AuthGate / Validate params
     ↓
 Coordinator.navigate(route)  OR PendingDeepLinkStore.enqueue
```

**Why one table:** dual routers (push vs UL) drift — checkout works from one entry and 404s from another.

**Hybrid UI (S13):** SwiftUI hosted in UIKit (or reverse) — coordinator owns stack identity; don’t ad-hoc `UIHostingController` without lifecycle plan.

---

## 3. Deferred deep links

- Install attribution window; first launch fetches pending route
- Expiry (industry often ~days, not forever)
- Privacy / probabilistic matching limits — don’t overclaim certainty
- Prefer first-party login then route when identity matters

---

## 4. Push deep dive

| Concern | Practice |
|---|---|
| Permission timing | Contextual, not instant first launch |
| Token every launch | Tokens change; upsert server-side |
| 410 Unregistered | Invalidate token in DB |
| Malformed payload | Defensive decode → home; protect CFS |
| Rich images | Extension memory budgets |
| Silent push | Limited wake budget; don’t rely as cron |

**Airship vs Mixpanel (S13):** Airship = push/engagement; Mixpanel = analytics product behavior — complementary, not synonyms.

---

## 5. CI/CD deep dive

### 5.1 PR checks

Lint + build + unit tests on macOS runners; selective tests when modularized; quarantine flakes.

### 5.2 Signing

Encrypted certs/profiles (match-style); CI secrets / OIDC; `CODE_SIGNING` deterministic; never log secrets.

### 5.3 TestFlight + phased release

- Internal smoke before external
- Phased % with **stop criteria**: CFS drop, pin-fail spike, journey p90 cliff
- Feature flags decouple binary ship from exposure

### 5.4 dSYM

Upload every build that can reach users — Day 18 triage depends on it.

### 5.5 AI on PRs (S9)

> “AI accelerates review for obvious regressions; humans own architecture, security, and product trade-offs. I never say ‘AI approved so it’s fine.’”

---

## 6. Secure checkout link

- Auth gate
- Server-authoritative cart/price
- Ignore spoofed query prices
- Confirm destructive actions

---

## 7. Trade-offs

| Choice | When | Cost |
|---|---|---|
| Universal Links | Consumer production | AASA/CDN debug pain |
| Custom schemes | Legacy/internal | Hijack risk |
| Central router | Multi-feature | Must stay module-friendly |
| Airship | Speed + marketing tools | Vendor; still know APNs |
| Manual TestFlight | Tiny team | Human error |
| Fully auto prod | Only with strong gates | Risk if gates weak |
| AI PR review | Diff noise reduction | Must not replace ownership |

---

## 8. Failure modes

| Mode | Response |
|---|---|
| Dual routers drifted | Unify table |
| Push JSON crash | Defensive parse |
| TF crash-loop, CI green | Release flags / entitlements / race — smoke TF |
| CFS drop at 10% phased | Pause — IMOC (S8) |
| Secrets in git | Rotate; move to CI secrets |

---

## 9. End-to-end story you can draw in 3 minutes

```text
Campaign https link  ──► AASA / UL
Airship push tap     ──► payload route
        \                 /
         → DeepLinkParser → AppRoute
                ↓
         AuthGate (checkout?)
                ↓
     Coordinator (hybrid UIKit/SwiftUI stack)
                ↓
     Mixpanel screen event  |  Airship engagement attribution

Meanwhile release train:
  PR Actions → TestFlight → phased % → CFS/p90 monitors → pause/IMOC
```

**Say:** “Entrypoints differ; routing and release gates are shared disciplines.”

---

## 10. BMS CI elevator (45s) + Grizzlies (90s) back-to-back

**CI:**  
> “We automated GitHub Actions for lint, build, and TestFlight upload so the release path stopped depending on who remembered the manual checklist. Signing secrets stay in CI — not the repo. Phased rollout still needs human stop criteria on crash-free and perf.”

**Grizzlies:**  
> “On Grizzlies I designed hybrid SwiftUI/UIKit surfaces with real navigation ownership, deep links into that stack, Mixpanel for product analytics, and Airship for push engagement — one router mindset so campaigns and https links don’t drift.”

---

## 11. Optional citations

- deep-linking / push / mobile-ci-cd docs  
- Stories S13, S8, S9  

Self-contained without opens.
