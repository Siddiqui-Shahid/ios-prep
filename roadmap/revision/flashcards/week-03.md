# Week 3 Flashcards — Modularization, Media, Perf, Crashes, Security, CI

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Resume metrics only: **30L+ DAU**, **99.95%+ CFS**, **30%+ fewer full-screen navs**.

Source: sample critical truths from `week-03` days `day-15`…`day-21`.  
Guided teaching: `../weeks/week-03/day-NN/sample/` · Drill twins: `../revision/weeks/week-03/day-NN.md`.

**≈42 cards** · Tags: `modules` · `media` · `perf` · `observability` · `security` · `ci` · `mock`

---

## day-15 — App Modularization, SPM & DI Graphs

| Front | Back |
|---|---|
| Feature A → Feature B | Depend on B’s Interface, never B’s Impl |
| Composition root | App target wires concrete builders |
| `NetworkManager.shared` in features | Anti-pattern — hides DI graph |
| Packaging vs architecture | Clean boundary can live in CocoaPods or SPM |
| Service locator | Runtime missing deps — constructor/tree DI is safer |
| Stories SDK (Raw / Miami Heat) | Standalone Stories SDK + portfolio adoption — no invented build-time % |

## day-16 — Image/Video Pipelines, Caching & Memory Pressure

| Front | Back |
|---|---|
| HTTP cache | Not a UIImage cache — still need decode + L1 policy |
| Decoded 1000×1000 ARGB | ≈ 4 MB — key by url + targetSize |
| Wrong image in cell | Missing cancel/token on reuse |
| HeroWidget | Pause when off-screen / background / reuse — product contract |
| Aces audio | Not image LRU — AVAudioSession + interruptions |
| BookMyShow Ads pipeline + HeroWidget lifecycle / Audio streaming + server-driven splash (Aces) | No invented fill-rate % or splash ms |

## day-17 — Performance: Instruments, MetricKit, Startup & Scrolling (p50/p90)

| Front | Back |
|---|---|
| Optimize from desk anecdote | Wrong at 30L+ DAU — use field percentiles |
| Average FPS / latency | Hides tails — track p50/p90 and hitch rate |
| Leaks finds retain cycles | False — use Memory Graph + Allocations |
| MetricKit alone | Fleet OS truth — weak for product journey SLIs |
| Time Profiler on “slow network” | Waiting ≠ computing — check Network / backend |
| BookMyShow Firebase Performance traces | Firebase Performance on listing/checkout/search — no fake ms SLAs |

## day-18 — Crash Reporting, Observability & Incident Response (IMOC)

| Front | Back |
|---|---|
| BookMyShow synchronised dictionaries alone caused 99.95% CFS | Forbidden — BookMyShow synchronised dictionaries ⊂ reliability; BookMyShow IMOC + crash-free at scale = system |
| try/catch catches SEGV | No — signals need handlers + discipline |
| Upload in signal handler | Never — persist async-signal-safe; upload next launch |
| CFS fine ⇒ no freezes | False — hangs/OOM may not move CFS |
| Leaks for retain cycles | Wrong tool — Graph + Allocations |
| BookMyShow IMOC + crash-free at scale | 30L+ DAU, 99.95%+ CFS, Crashlytics triage, IMOC |

## day-19 — Security: ATS, SSL Pinning, Keychain & Persistence

| Front | Back |
|---|---|
| ATS | System HTTPS/TLS baseline — not pinning |
| SPKI | Hash of SPKI DER — not `SecKeyCopyExternalRepresentation` raw bytes |
| BookMyShow SSL pinning + URLSession migration | Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist |
| Design: pin rotation / break-glass (not shipped runbook) | Rotation / backup / break-glass = design judgment — not “shipped runbook” |
| Tokens | Keychain only — never UserDefaults |
| Persistence | Pick store from sensitivity + access pattern — not one tool for everything |

## day-20 — Deep Links, Push Notifications & CI/CD Release Trains

| Front | Back |
|---|---|
| One router | Universal Links, custom schemes, and push taps share one routing table |
| Cold start | Queue deep links until navigation/DI is ready — then flush |
| Hybrid UI / deeplinks | Grizzlies: SwiftUI↔UIKit; deeplinks; Mixpanel; Airship |
| BMS CI | GitHub Actions build/lint → TestFlight — not manual ceremony |
| District Free Parking + Clean/MVVM + AI tooling | AI PR review assists — humans own architecture and security |
| Pause criteria | CFS drop, pin-fail spike, journey p90 cliff → stop phased rollout (BookMyShow IMOC + crash-free at scale) |

## day-21 — System-Design Mock #3 (45 min)

| Front | Back |
|---|---|
| Spine | Clarify 5 → HLD 10 → API 10 → Dive 15 → Ops 5 |
| Pick one prompt | SDUI or Networking+pin live — skim the other after |
| Scale | 30L+ DAU from resume — don’t invent precise QPS |
| Ops | Last 5 minutes mandatory — cut dive rather than skip ops |
| Pass bar | ≥70 with ops ≥6/10 and no fabricated metrics |
| Provenance | Design: pin rotation / break-glass (not shipped runbook) = design; BookMyShow synchronised dictionaries ≠ sole CFS; SPKI ≠ SecKey raw bytes |
