# Week 2 Flashcards — Architecture, Networking, SDUI, UIKit, SwiftUI

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Resume metrics only: **30L+ DAU**, **99.95%+ CFS**, **30%+ fewer full-screen navs**.

Source: sample critical truths from `week-02` days `day-08`…`day-14`.  
Guided teaching: `../weeks/week-02/day-NN/sample/` · Drill twins: `../revision/weeks/week-02/day-NN.md`.

**≈48 cards** · Tags: `architecture` · `networking` · `sdui` · `uikit` · `swiftui` · `dsa` · `mock`

---

## day-08 — MVVM / Clean / MVI · Layering · DI

| Front | Back |
|---|---|
| Default pattern | MVVM for feature UI; Clean UseCases where rules/migration demand |
| Debounce | Lives in ViewModel (presentation policy), not URLSession |
| Repository vs UseCase | Repo = where bytes come from; UseCase = what product should do |
| DI default | Protocol + constructor injection; assembler at module edge |
| District Free Parking + Clean/MVVM + AI tooling AI line | Accelerator inside envelope — you own architecture, not the tool |
| BookMyShow backend-driven header & search search | Explicit idle/loading/results/empty/error + cancel stale work |
| Forbidden | “AI wrote our Clean Architecture” or “whole app is Clean” |

## day-09 — URLSession Networking Layer

| Front | Back |
|---|---|
| Pipeline | Endpoint → build → intercept → execute → decode → map errors |
| Single-flight | Many concurrent 401s share one refresh; retry originals once |
| Async cancel | `URLSession.data(for:)` participates in `Task` cancellation |
| Callback cancel | Explicit `task.cancel()` + generation/stale guard |
| ATS ≠ pinning | ATS is HTTPS baseline; pinning is extra identity check |
| SPKI | Hash SPKI DER — not raw `SecKeyCopyExternalRepresentation` bytes |
| BookMyShow SSL pinning + URLSession migration verified | Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist |
| Design: pin rotation / break-glass (not shipped runbook) | Pin rotation / backup pins / break-glass = design, not shipped runbook |

## day-10 — SDUI / CMS · Schema Versioning · Fallbacks

| Front | Back |
|---|---|
| SDUI def | Schema → version gate → registry → native render |
| Not SDUI | JS eval, whole-app WebView, arbitrary code in JSON |
| Unknown component | Skip + metric — never crash |
| Empty root | Hard fallback — blank chrome unacceptable |
| BookMyShow backend-driven header & search verified | BMS backend-driven / protocolised header |
| BookMyShow backend-driven header & search-A1 | Schema versioning + unknown fallback = design |
| Audio streaming + server-driven splash (Aces) verified | Aces server-driven splash — no invented ms |
| Ads media | BookMyShow Ads pipeline + HeroWidget lifecycle native lifecycle — config maybe SDUI, video stays native |

## day-11 — UIKit Lifecycle, Cells, Prefetch · Hybrid UIKit ↔ SwiftUI

| Front | Back |
|---|---|
| Load vs appear | `viewDidLoad` once; tabs appear many times — refresh on appear |
| Wrong cell image | Async completion after reuse without ID check |
| Prefetch | Warm + cancel + bound concurrency — not unlimited download |
| Hybrid nav | One router owner — dual stacks double-present |
| BookMyShow LE Bottom Sheet metric | 30%+ fewer full-screen navigations — resume only |
| Hybrid UI / deeplinks | Hybrid interop + deeplinks designed, not bolted |
| BookMyShow Ads pipeline + HeroWidget lifecycle | HeroWidget pause/play is a product contract, not plumbing |

## day-12 — SwiftUI State, Identity, @Observable, Lists, Performance

| Front | Back |
|---|---|
| `@State` | View-local ephemeral UI — not every toggle in VM |
| `@Observable` | iOS 17+ — still explain `ObservableObject` for legacy |
| Identity | `@State` lifetime follows identity — `.id(UUID())` in body resets everything |
| Lists | `List` / `LazyVStack` for large data — not eager `VStack` of thousands |
| Stories SDK (Raw / Miami Heat) | Reusable SDK = public API + host isolation — not hardcoded networking |
| Trap | UUID in `.id` → text fields clear, representables remake (Day 11 pain) |

## day-13 — DSA: Stack / Queue / Linked List

| Front | Back |
|---|---|
| Array as queue | `removeFirst()` is O(n) — call it out or use two-stack / Deque |
| Two-stack queue | Amortized O(1) — not strict O(1) every dequeue |
| Linked list in Swift apps | Interview skill + LRU design — not everyday UITableView |
| Agenda-first | 2–3 min spoken plan before typing |
| BookMyShow SSL pinning + URLSession migration bridge | Refresh waiters = FIFO queue of continuations (soft, not shipped LL) |
| Forbidden | “We used linked lists for the feed” |

## day-14 — Week 2 Revision + Mock #2 (Ads or SDUI)

| Front | Back |
|---|---|
| Pick one track | Ads or SDUI for 5-min talk — not both cold |
| 5-min hard stop | Agenda in first 20s; stop at 5:00 and invite questions |
| BookMyShow Ads pipeline + HeroWidget lifecycle / BookMyShow backend-driven header & search | Core STAR for Ads / SDUI tracks respectively |
| Design: pin rotation / break-glass (not shipped runbook) / BookMyShow backend-driven header & search-A1 | Pin rotation / schema fallback = design, not shipped runbook |
| Forbidden | Invented fill-rate %, splash ms, pin shadow-traffic claims |
| Bridge | SDUI config + native HeroWidget renderer — best of both |
