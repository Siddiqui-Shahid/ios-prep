# Week 2 Flashcards — Architecture, Networking, SDUI, UIKit, SwiftUI

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Resume metrics only: **30L+ DAU**, **99.95%+ CFS**, **30%+ fewer full-screen navs**.

Source days: `weeks/week-02/day-08/README.md` … `day-14`.

**≈90 cards** · Tags: `architecture` · `networking` · `sdui` · `uikit` · `swiftui` · `dsa` · `mock`

---

## Architecture / MVVM / Clean (`architecture`) · Day 08

| Front | Back |
|---|---|
| MVVM one-liner | View renders state; VM presentation + async; Model domain · Trap: networking in View · Prod: BMS search VM |
| Clean one-liner | UseCases/entities independent of UI · Trap: Clean everywhere · Prod: District Free Parking rules |
| MVI one-liner | Intent → reduce → State → View · Trap: boilerplate for CRUD · Prod: payment/live state cousins |
| Where debounce lives | VM/UseCase presentation policy · Trap: only in URLSession · Prod: BMS search |
| DI default | Protocol + constructor injection · Trap: service locator for domain · Prod: testable VMs |
| Repository duty | Cache/remote + DTO map · Trap: business rules in repo · Prod: search repository |
| Fat VM smell | Networking + routing + rules · Fix: UseCase + Router · Prod: S9 extract |
| AI in migration | Accelerate inside envelope + review · Trap: “AI wrote it” · Prod: S9 Context Engineering |
| Navigation ownership | Events from VM; Coordinator for cross-feature · Trap: UIKit in UseCase · Prod: S13 deeplinks |
| Fail-soft UI states | loading/empty/error/success · Trap: spinner forever · Prod: BMS search |
| When not Clean | Trivial UI, no shared domain · Trap: resume padding · Prod: judgment call |
| Test pyramid tip | UseCase unit tests cheapest · Trap: only UITests · Prod: District XCTest |
| Strangler migration | Incremental extract, flags · Trap: rewrite · Prod: District |
| Protocol boundary | Network/Search/Analytics · Trap: protocol every struct · Prod: S1/S10 |
| Scale link | Clear layers reduce blast radius · Trap: architecture = crash-free alone · Prod: 30L DAU + S8 |

## Networking (`networking`) · Day 09

| Front | Back |
|---|---|
| Networking SDK core | Endpoint → build → intercept → session → decode · Trap: UI in client · Prod: Ads URLSession |
| Single-flight refresh | One refresh Task; waiters share · Trap: N refreshes · Prod: auth storms |
| Cancel search | Cancel Task on new query · Trap: show cancel as error · Prod: S3 |
| Retry safe? | Idempotent GET + backoff · Trap: POST payments · Prod: S7 |
| URLCache vs app cache | Headers vs domain/offline · Trap: cache private unkeyed · Prod: SDUI Day 10 |
| SSL pinning | SPKI pin; MITM ↓ · Trap: no rotation = outage · Prod: S4 |
| Domain whitelist | Only approved hosts · Trap: CMS open fetch · Prod: S4 |
| Why leave Alamofire | Control + deps + pinning · Trap: hate libraries · Prod: S4 Ads |
| NetworkError kinds | Transport/HTTP/decode/cancel/auth · Trap: raw strings to UI · Prod: S3 states |
| Interceptor order | Auth → log/trace → send · Trap: log tokens · Prod: hygiene |
| Test strategy | Fake session + fixtures · Trap: live network CI · Prod: migration parity |
| Idempotency key | Safe payment retries · Trap: client-only duplicate POST · Prod: checkout |
| p90 networking | Trace spans; optimize tail · Trap: mean latency · Prod: S5 |
| Break-glass pin | Monitored failover plan · Trap: silent disable forever · Prod: S4 lesson |
| Protocol NetworkSession | Inject URLSession mock · Trap: concrete everywhere · Prod: testability |

## SDUI (`sdui`) · Day 10

| Front | Back |
|---|---|
| SDUI definition | Schema → native registry render · Trap: JS eval · Prod: BMS header |
| Unknown component | Skip + metric · Trap: crash · Prod: 99.95% mindset |
| Schema major bump | Dual-publish + fallback · Trap: force upgrade only · Prod: contracts |
| FallbackEngine | Last-known-good disk · Trap: blank on offline · Prod: S12 splash |
| Action allowlist | No arbitrary code · Trap: open any URL · Prod: security |
| Hybrid SDUI | CMS slots + native chrome · Trap: 100% dynamic · Prod: most apps |
| Capability matrix | Client declares support · Trap: assume parity · Prod: iOS/Android |
| Cold start splash | Cache + timeout default · Trap: block on network · Prod: S12 |
| BMS header win | Iterate without release · Trap: new types need app · Prod: S3 |
| SDUI vs Ads native | Config dynamic; media native · Trap: SDUI video lifecycle · Prod: S1 |
| Cache keying | Per user for personalised · Trap: shared cache leak · Prod: privacy |
| Analytics in SDUI | Validate server events · Trap: trust PII · Prod: hygiene |
| Canary schema | % rollout payloads · Trap: 100% push · Prod: S8 culture |
| Empty root policy | Hard fallback required · Trap: skip all → blank · Prod: splash rules |
| Contract tests | Fixtures per version · Trap: only manual QA · Prod: CI |

## UIKit / hybrid (`uikit`) · Day 11

| Front | Back |
|---|---|
| Pause video where | willDisappear / offscreen · Trap: only deinit · Prod: S1 HeroWidget |
| prepareForReuse | Reset async + UI · Trap: stale images · Prod: lists |
| Prefetch cancel | cancelPrefetching… · Trap: unbounded downloads · Prod: data budget |
| SwiftUI in UIKit | UIHostingController · Trap: sizing/safeArea · Prod: S13 |
| UIKit in SwiftUI | Representable + Coordinator · Trap: recreate storms · Prod: S13 |
| Deeplink owner | App-edge router → intent · Trap: dual stacks · Prod: S13 |
| Bottom sheet win | Context kept; fewer pushes · Trap: deep flows in sheet · Prod: S6 30%+ |
| Diffable benefit | Identity diffs · Trap: unstable IDs · Prod: fewer reload bugs |
| Appear vs load | Refresh vs once · Trap: network only in didLoad · Prod: tabs |
| Cell retain cycle | weak self + clear handlers · Trap: strong VC in cell · Prod: leaks |
| Airship tap path | Same deeplink router · Trap: parallel nav · Prod: S13 |
| Hybrid cost | Lifecycle + identity · Trap: bolt hosting · Prod: S13 lesson |
| Estimated size | Close to real · Trap: 1pt estimates · Prod: jank |
| LE metric | 30%+ fewer full-screen navs · Trap: vanity UI · Prod: resume |
| Visibility ads | Threshold policy · Trap: play always · Prod: S1 |

## SwiftUI (`swiftui`) · Day 12

| Front | Back |
|---|---|
| `@State` use | Local ephemeral UI · Trap: async in every view · Prod: chrome |
| `@Observable` use | Feature/async model · Trap: god AppModel · Prod: Stories player |
| Identity rule | Stable IDs preserve state · Trap: UUID in body · Prod: S10 pages |
| ForEach ID | Identifiable stable keys · Trap: indices on reorder · Prod: lists |
| Lazy vs VStack | Lazy for large · Trap: eager thousands · Prod: perf |
| body rule | Cheap; no side effects · Trap: fetch in body · Prod: jank |
| Environment DI | Theme ok; services careful · Trap: hidden NetworkClient · Prod: S10 |
| Stories API | DataSource + events + inject loaders · Trap: hardcode host net · Prod: S10 |
| Pause stories | Scene phase / disappear · Trap: run in background · Prod: S10/S1 |
| Invalidation storm | Split models · Trap: observe all · Prod: redraws |
| Representable reset | Parent id churn · Trap: SwiftUI bug · Prod: S13 |
| Animation scope | Transaction local · Trap: animate whole tree · Prod: lists |
| Portfolio reuse | Protocols + theming hooks · Trap: fork per app · Prod: S10 |
| SDUI leaf id | Server-stable id · Trap: array index · Prod: S3 |
| Test SwiftUI | Model unit tests first · Trap: only UITest · Prod: S9 |

## DSA stack/queue/LL (`dsa`) · Day 13

| Front | Back |
|---|---|
| Stack use | LIFO matching/undo · Trap: use for BFS · Prod: nav nested |
| Queue use | FIFO BFS / waiters · Trap: Array.removeFirst hot · Prod: refresh waiters |
| Monotonic stack | Next greater O(n) · Trap: O(n²) scan · Prod: — |
| Two-stack queue | Amortized O(1) · Trap: claim strict O(1) always · Prod: — |
| Floyd cycle | Slow/fast O(1) space · Trap: only hash set · Prod: — |
| Reverse list | Iterative 3 pointers · Trap: lose next · Prod: — |
| Merge lists | Dummy head · Trap: null edges · Prod: — |
| Array as queue cost | removeFirst O(n) · Trap: ignore · Prod: Swift |
| Coding agenda | Restate→edges→complexity→code · Trap: code immediately · Prod: interviews |
| Deque window max | Maintain mono deque · Trap: heap each slide only · Prod: — |
| Min stack | Aux mins · Trap: O(n) scan · Prod: — |
| LL in Swift apps | Rare vs Array · Trap: force LL UI · Prod: honesty |
| k-group reverse | Count-reverse-reconnect · Trap: leftover mishandle · Prod: — |
| Ring buffer | Head/tail mod · Trap: empty/full ambiguity · Prod: audio-ish |
| Week 2 catch-up | Drill weak day Qs · Trap: only DSA forever · Prod: Mock #2 |

## Mock meta (`mock`) · Day 14

| Front | Back |
|---|---|
| Week 2 one-liner | Layers→network→SDUI→UI identity · Trap: isolated facts · Prod: narrative |
| Ads 5-min agenda | POP·lifecycle·URLSession pin · Trap: no agenda · Prod: S1/S4 |
| SDUI 5-min agenda | Schema·registry·fallback·prod · Trap: skip fail-soft · Prod: S3/S12 |
| Refresh stampede | Single-flight · Trap: N refreshes · Prod: Day 09 |
| Pin outage | Rotation/runbook · Trap: pinning only · Prod: S4 |
| Unknown SDUI node | Skip+metric · Trap: crash · Prod: crash-free |
| Dual nav stacks | One owner · Trap: sync forever · Prod: S13 |
| UUID in body | Resets state · Trap: SwiftUI bug · Prod: Day 12 |
| Sheet metric | 30%+ fewer pushes · Trap: vague UX · Prod: S6 |
| AI seniority | Envelope+review · Trap: AI wrote app · Prod: S9 |
| Search cancel | Task cancel silent · Trap: error toast · Prod: S3 |
| HeroWidget | Pause on invisible · Trap: play forever · Prod: S1 |
| Stories SDK | Public API+inject · Trap: host coupled · Prod: S10 |
| Queue pitfall | removeFirst O(n) · Trap: ignore · Prod: Day 13 |
| Mock discipline | Timer + retro gotchas · Trap: skip retro · Prod: growth |

---

Anki sample: [anki-import.csv](anki-import.csv) · DSA: [../coding/dsa-track.md](../coding/dsa-track.md)
