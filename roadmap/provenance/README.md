# Experience registry (resume-backed)

Use these IDs in chapter provenance labels. **Verified** = stated in `resume.tex`. **Applied** = interview design extension (not claimed as shipped).

## Verified stories

| ID | Company | Resume anchor | Allowed metrics | Topics |
|---|---|---|---|---|
| S1 | BookMyShow | Ads module refactor; HeroWidget pause/play; POP + Generics | revenue-critical module (no invented fill-rate %) | POP, generics, video lifecycle |
| S2 | BookMyShow | Synchronised dictionaries via GCD serial queues and RW locks | race/crash reduction on that path (do not claim sole CFS ownership) | GCD, concurrency |
| S3 | BookMyShow | Backend-driven header; search debounce, state, MVVM | — | SDUI, search, MVVM |
| S4 | BookMyShow | Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelisting | — | networking, security |
| S5 | BookMyShow | Firebase Performance traces listing/checkout/search p50/p90 | p50/p90 instrumentation | observability |
| S6 | BookMyShow | LE Bottom Sheet | 30%+ of user flows fewer full-screen navigations | product, UX |
| S7 | BookMyShow | Payment processing-time popup | intent: reduce drop-off/support (no measured % unless you add real data) | checkout UX, state |
| S8 | BookMyShow | 30+ lakh DAU; 99.95%+ CFS; Crashlytics; IMOC P0/P1 | 30L+ DAU, 99.95%+ CFS | incidents, reliability |
| S9 | District | Free Parking; MVVM/Clean migration; Context Engineering; XCTest/XCUITest assist | — | architecture, AI tooling |
| S10 | Raw / Miami Heat | Stories SDK reused across portfolio; live scoreboard | portfolio reuse | SDK, modularity, realtime |
| S11 | Raw / Miami Heat | Live in-arena scoreboard | — | realtime reliability |
| S12 | Raw / Aces | Audio streaming; server-driven splash | cold-start improvement (no invented ms) | AV, SDUI splash |
| S13 | Raw / Grizzlies | SwiftUI+UIKit; deeplinks; Mixpanel; Airship | — | hybrid UI, push, analytics |
| S14 | Raw / Chicago Sky | Xcode 15 migration; QA zero-regression checklist | — | platform upgrade |
| S15 | Personal | FinTrack on-device RAG / Apple Intelligence / BM25 | local-first / no cloud financial sync | on-device AI |
| S16 | Personal | GymFlow TFLite MiniLM + TF-IDF fallback | — | edge ML |

## Applied extensions (not shipped claims)

| ID | Extends | Claim you may say |
|---|---|---|
| S2-A1 | S2 | Greenfield shared maps → Swift `actor` with same API surface |
| S4-A1 | S4 | Pin rotation, backup pins, staged break-glass as **design** (not “I shipped the runbook”) |
| S7-A1 | S7 | Explicit enum state machine for payment UI (design pattern; resume does not name enums) |
| S3-A1 | S3 | Schema versioning + unknown-component fallback for SDUI |
| S5-A1 | S5 | Journey-level traces vs interceptor path traces |

## Label format in chapters

```markdown
> **Provenance:** Verified · S2 · BookMyShow · synchronised dictionaries

> **Provenance:** How I would apply it · S4-A1 · pin rotation / break-glass design
```
