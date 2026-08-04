# 03 — Production Bridge: Mock Story Map

> Wire Verified stories into Mock #2 without overclaiming.

## 1. Provenance map

| ID | Label | Exact claim |
|---|---|---|
| **S1** | Verified | Ads refactor; POP+Generics; HeroWidget pause/play on revenue-critical module |
| **S4** | Verified | Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist |
| **S4-A1** | Applied design | Pin rotation, backup pins, break-glass — **not** “I shipped the ops runbook” |
| **S3** | Verified | Backend-driven header; search debounce/state/MVVM |
| **S3-A1** | Applied design | Schema versioning + unknown-component fallback emphasis |
| **S12** | Verified | Aces audio streaming; server-driven splash; cold-start improvement (**no invented ms**) |
| **S9** | Verified | District Free Parking; Clean/MVVM migration; Context Engineering; tests assist |
| **S6** | Verified | LE Bottom Sheet; **30%+** fewer full-screen navigations |
| **S10** | Verified | Stories SDK reusable across portfolio |
| **S13** | Verified | Grizzlies SwiftUI+UIKit; deeplinks |
| **S8** | Verified | 30L+ DAU; 99.95%+ CFS; Crashlytics; IMOC — use for leadership composure |

### Forbidden

- Invented fill-rate % or splash latency ms  
- “Shipped pin rotation runbook / shadow traffic” as fact  
- Claiming both tracks as one giant project you did in a week  

## 2. Track → story pairing

| Track | Core STAR | Supporting |
|---|---|---|
| **Ads** | S1 (2–3 min) | S4 opener; S5 perf culture optional; S8 scale |
| **SDUI** | S3 (2–3 min) | S12 splash/audio; S8 fail-soft culture |

**Spice either track:** S9 (migration + AI judgment), S6 (product UX metric), S10/S13 (modular/hybrid).

## 3. S1 talk track (2–3 min STAR)

### Opener (~10s)

> “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.”

### S/T (~20s)

Highest-revenue Ads module needed a safer reusable rendering path. Video ads inside HeroWidget needed correct pause/play with lifecycle.

### Action (~90s)

1. Refactored around **protocol-oriented** ad component contracts + **generics** for a type-safe pipeline.  
2. Built reusable **HeroWidget** with explicit pause/play tied to visibility / VC lifecycle.  
3. Kept revenue paths behind clear protocols so new ad types didn’t fork the pipeline.  
4. Coordinated with stakeholders on behavior without breaking the revenue path.

### Result (~20–30s)

Maintainable type-safe ads pipeline; lifecycle-correct video reduced wasted playback and UI glitches on a module that mattered for revenue. (**No invented fill-rate %.**)

### Lesson (~15–20s)

For revenue-critical UI, prefer POP + generics over inheritance trees; lifecycle is part of the product contract.

> **Provenance:** Verified · S1 · BookMyShow · Ads / HeroWidget

## 4. S3 talk track (2–3 min STAR)

### Opener (~10s)

> “I’ll cover our backend-driven header and the search UX we aligned to MVVM.”

### S/T (~20s)

Main header needed to be CMS/backend-driven; search needed modern UX — debounce and explicit state — aligned to MVVM.

### Action (~90s)

1. Migrated header to a **generalised, protocol-driven** main-screen implementation.  
2. Search: **debouncing**, loading/empty/error state, MVVM binding; cancel in-flight appropriately.  
3. Contracted with backend so layout/content could change without app release for many cases.  
4. Fail-soft mindset: unknown/bad payloads must not crash the shell (emphasize as S3-A1 design if asked about versioning).

### Result (~20–30s)

Faster content iteration on header; snappier, race-safer search UX.

### Lesson (~15–20s)

SDUI needs schema/versioning + client fallbacks — not just “render JSON.”

> **Provenance:** Verified · S3 · BookMyShow · backend-driven header / search

## 5. Supporting openers (≤20–45s)

**S4:**  
> “We moved Ads networking off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist on a high-traffic revenue module.”

**S12:**  
> “On Aces I integrated live audio streaming and a server-driven splash so cold-start content could stay fresh — measuring time-to-interactive, not just first frame.”

**S9:**  
> “At District we migrated Free Parking toward Clean/MVVM with an AI-assisted workflow inside a human-owned architecture envelope — tests and review still gate merges.”

**S6:**  
> “LE Bottom Sheet cut full-screen navigations by 30%+ on targeted flows by giving a lightweight overview instead of a push.”

## 6. Interview lines (≤20s)

**Ads mock:**  
> “I’ll walk a revenue Ads architecture — POP/generics, HeroWidget lifecycle, and URLSession pinning.”

**SDUI mock:**  
> “I’ll walk a fail-soft SDUI pipeline — schema versioning, registry, and BMS/Aces production usage.”

## 7. Leadership hybrid (T3)

When refresh stampede + pin outage same week:

> “I’d lead IMOC-style: blast radius, feature guards, rollback/break-glass design, owners, comms — then technical fixes: single-flight refresh, backup pins. Watch TLS failure rate and crash-free. Verified culture: 30L+ DAU and 99.95%+ CFS bar from S8 — without claiming pinning alone owns CFS.”

> **Provenance:** Verified · S8 culture · S4 controls · S4-A1 design
