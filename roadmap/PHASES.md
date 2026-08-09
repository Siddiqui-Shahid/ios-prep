# 4-Week Calendar at a Glance

**Target:** Senior iOS (ownership, trade-offs, production scale)  
**Load:** ~4–5 hrs weekdays · ~5–6 hrs weekends  
**System design spine:** `ios-system-design/docs/` (linked per day)  
**Daily SD drill:** every day includes [`sample/05-system-design-mock.md`](weeks/week-01/day-01/sample/05-system-design-mock.md) — mock-interview Q&A (clarify → HLD → API/load → dives → ops) mapped to the day’s primary SD doc.

---

## Week 1 — Swift mastery, memory, concurrency

| Day | File | Focus | Production hook | Parallel SD |
|---|---|---|---|---|
| 1 | [week-01/day-01](weeks/week-01/day-01/README.md) | Value/reference, COW, enums, actors intro | Ads type-safety | Social feed scope |
| 2 | [week-01/day-02](weeks/week-01/day-02/README.md) | POP, generics, associated types, type erasure | HeroWidget POP+Generics | — |
| 3 | [week-01/day-03](weeks/week-01/day-03/README.md) | ARC, retain cycles, Instruments | Crash triage @ BMS | — |
| 4 | [week-01/day-04](weeks/week-01/day-04/README.md) | GCD, thread-safe structures | Synchronised dictionaries | — |
| 5 | [week-01/day-05](weeks/week-01/day-05/README.md) | async/await, actors, Sendable | Race → actor migration | Feed HLD |
| 6 | [week-01/day-06](weeks/week-01/day-06/README.md) | DSA: Arrays/Strings/Two Pointers/Window | — | — |
| 7 | [week-01/day-07](weeks/week-01/day-07/README.md) | Revision + Mock #1 | Sync-dict story ≤3 min | Feed LLD |

**Primary SD doc:** [social-feed.md](../ios-system-design/docs/social-feed.md)

---

## Week 2 — Architecture, networking, SDUI, UI

| Day | File | Focus | Production hook | Parallel SD |
|---|---|---|---|---|
| 8 | [week-02/day-08](weeks/week-02/day-08/README.md) | MVVM / Clean / MVI / DI | District migration; BMS search | — |
| 9 | [week-02/day-09](weeks/week-02/day-09/README.md) | URLSession, interceptors, refresh, cache | Alamofire → URLSession | Networking layer |
| 10 | [week-02/day-10](weeks/week-02/day-10/README.md) | SDUI / CMS UI | Backend-driven header; Aces splash | SDUI engine |
| 11 | [week-02/day-11](weeks/week-02/day-11/README.md) | UIKit lifecycle, hybrid UI | Grizzlies; LE Bottom Sheet | — |
| 12 | [week-02/day-12](weeks/week-02/day-12/README.md) | SwiftUI state, identity, lists | Stories SDK | — |
| 13 | [week-02/day-13/](weeks/week-02/day-13/) | DSA: Stack/Queue/LinkedList | — | — |
| 14 | [week-02/day-14/](weeks/week-02/day-14/) | Revision + Mock #2 | Ads architecture 5 min | Payment + Search |

**Primary SD docs:** [networking-layer.md](../ios-system-design/docs/networking-layer.md), [sdui-engine.md](../ios-system-design/docs/sdui-engine.md), [payment-checkout.md](../ios-system-design/docs/payment-checkout.md), [search-autocomplete.md](../ios-system-design/docs/search-autocomplete.md)

---

## Week 3 — Full architecture, performance, security, platform

| Day | File | Focus | Production hook | Parallel SD |
|---|---|---|---|---|
| 15 | [week-03/day-15/](weeks/week-03/day-15/) | Modularization, SPM, DI | Stories SDK module | App modularization |
| 16 | [week-03/day-16/](weeks/week-03/day-16/) | Image/video pipelines, cache | HeroWidget; Aces audio | Image loading |
| 17 | [week-03/day-17](weeks/week-03/day-17/README.md) | Perf: Instruments, p50/p90 | Firebase Performance | APM |
| 18 | [week-03/day-18](weeks/week-03/day-18/README.md) | Crash reporting, IMOC | 99.95% crash-free | Crash SDK |
| 19 | [week-03/day-19](weeks/week-03/day-19/README.md) | Security, SSL pinning, Keychain | Pinning + whitelist | Security engine |
| 20 | [week-03/day-20](weeks/week-03/day-20/README.md) | Deeplinks, push, CI/CD | Grizzlies; GH Actions | Deeplink/Push/CI |
| 21 | [week-03/day-21](weeks/week-03/day-21/README.md) | System-design Mock #3 (45 min) | SDUI or Networking+pinning | Cheatsheet |

**Also:** Persistence decision tree (UserDefaults / Keychain / Files / SQLite / Core Data) — see Day 19 extras and [cheatsheet.md](../ios-system-design/docs/cheatsheet.md).

---

## Week 4 — DSA polish, on-device AI, behavioral, game day

| Day | File | Focus | Notes |
|---|---|---|---|
| 22 | [week-04/day-22/](weeks/week-04/day-22/) | DSA: Trees, BFS/DFS | Mediums; complexity first |
| 23 | [week-04/day-23/](weeks/week-04/day-23/) | DSA: HashMap/Heap + mixed | Unknown-pattern simulation |
| 24 | [week-04/day-24/](weeks/week-04/day-24/) | On-device AI architecture | FinTrack / GymFlow |
| 25 | [week-04/day-25/](weeks/week-04/day-25/) | Machine round (3 hrs) | Paginated list+cache **or** SDUI renderer |
| 26 | [week-04/day-26/](weeks/week-04/day-26/) | Behavioral + leadership | STAR polish; AI tooling judgment |
| 27 | [week-04/day-27/](weeks/week-04/day-27/) | Expert Mock #4 full loop | Coding + deep dive + SD |
| 28 | [week-04/day-28/](weeks/week-04/day-28/) | Game day | Flashcards + stories only; sleep |

---

## Mock schedule

| Mock | Day | Format | Focus |
|---|---|---|---|
| #1 | 7 | Self/peer 60–90 min | Concurrency + memory; timed answers |
| #2 | 14 | Self/peer 60–90 min | Ads or SDUI architecture (5 min talk) |
| #3 | 21 | Self/expert 45 min | Full mobile system design |
| #4 | 27 | Expert preferred | Coding 45 + iOS 45 + SD 45 |
