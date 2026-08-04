# Week 3 Flashcards — Modularization, Images, Perf, Crashes, Security, Deeplinks/CI

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Resume metrics only: **30L+ DAU**, **99.95%+ CFS**, **30%+ fewer full-screen navs**.

Source days: `weeks/week-03/day-15` … `day-21`.

**≈108 cards** · Tags: `architecture` · `images` · `perf` · `crashes` · `security` · `deeplinks` · `ci` · `mock`

---

## Modularization (`architecture`) · Day 15

| Front | Back |
|---|---|
| Interface vs Impl module | Interface = protocols/DTOs; Impl = UI+logic. Cross-feature deps only on Interface · Trap: Impl→Impl · Prod: Stories public API |
| Composition root | App wires DI; features don’t resolve globals · Trap: Swinject everywhere · Prod: host injects Stories providers |
| Why SPM | Native, parallel, no Ruby · Trap: ignore legacy Pod constraints · Prod: new modules SPM-first |
| Circular dependency fix | Depend on Interface; App registers builders · Trap: import Impl “just once” · Prod: portfolio SDK boundary |
| Static vs dynamic | Prefer static internal; dynamic for app↔extension share · Trap: 40 dynamic frameworks · Prod: launch dyld cost |
| Needle-style DI | Typed dependency protocols + component tree · Trap: runtime locator · Prod: CheckoutDependency pattern |
| Stories SDK lesson | Reuse = API + isolation + versioning · Trap: copy views per app · Prod: S10 portfolio adoption |
| Core junk drawer | Shared kernel only for true shared types · Trap: everything in Core · Prod: feature DTOs stay local |
| Forbidden import | FeatureAImpl must not import FeatureBImpl · Trap: convenience import · Prod: graph as architecture |
| Module testability | Mock Interface protocols in unit tests · Trap: only UITests on full app · Prod: S9 test discipline |
| Binary size gate | CI budget + thinning · Trap: modules magically shrink binary · Prod: watch duplicates |
| Singleton rule | OK rarely at process boundary; never hidden in features · Trap: NetworkManager.shared in VM · Prod: S2 shared-state API |
| First module to extract | Leaf with clear API (design system / networking / Stories) · Trap: split biggest mess first · Prod: S10 |
| Build Timing Summary | Measure before/after splits · Trap: split blindly · Prod: xcodebuild flag |
| SDK host config | Theme, analytics, loader via protocols · Trap: hardcode Heat branding · Prod: multi-app Stories |

## Images / media (`images`) · Day 16

| Front | Back |
|---|---|
| Decoded image math | w×h×4 bytes · Trap: think JPEG size · Prod: downsample always |
| L1/L2/L3 | NSCache / disk / network · Trap: URLCache = UIImage cache · Prod: cheatsheet pipeline |
| Thumbnail API | CGImageSourceCreateThumbnailAtIndex · Trap: draw full UIImage then scale · Prod: ImageIO |
| Cache key | url + targetSize · Trap: URL only · Prod: avatar vs hero |
| Deduplication | One in-flight per key, N observers · Trap: N downloads · Prod: feed posters |
| Cancellation | Token + ignore stale · Trap: late setImage · Prod: cell reuse |
| NSCache benefit | Evicts under pressure · Trap: deterministic LRU · Prod: memory warnings |
| HeroWidget rule | Pause offscreen / on disappear · Trap: fire-and-forget AVPlayer · Prod: S1 ads |
| prepareForReuse | Stop player, clear image, cancel loads · Trap: only clear text · Prod: revenue ads |
| Prefetch footgun | Decode storm on fling · Trap: prefetch everything · Prod: cancel + cap |
| Aces audio | Session + interruptions · Trap: treat like image TTL · Prod: S12 |
| Splash metric | Time-to-interactive · Trap: only TTFF vanity · Prod: S12 SDUI splash |
| Write-around images | Decode then memory; disk async · Trap: sync disk on main · Prod: hitch budget |
| Memory warning | Trim L1, pause media · Trap: wipe user data · Prod: /Caches OK to lose |
| GIF scope | Separate path / call out of scope · Trap: same as JPEG pipeline · Prod: SD interviews |
| Inject loader in SDK | Protocol from host · Trap: hardcode dependency · Prod: S10 Stories |

## Performance (`perf`) · Day 17

| Front | Back |
|---|---|
| Perf loop | Symptom → attribute → fix → p50/p90 verify · Trap: vibe optimise · Prod: S5 |
| Why p90 | Tail = real pain at scale · Trap: averages · Prod: BMS journeys |
| Time Profiler | CPU hotspots · Trap: find network waits · Prod: main-thread JSON |
| MetricKit | Daily OS aggregates / hangs · Trap: replaces custom traces · Prod: fleet truth |
| Firebase Performance | Custom journey traces · Trap: only FPS · Prod: listing/checkout/search |
| Hitch | Missed frame deadline · Trap: low CPU = smooth · Prod: decode on main |
| Cold start phases | Pre-main → init → first frame → TTI · Trap: only TTFF · Prod: S12 splash |
| Hang detector | Ping main; threshold capture · Trap: ignore overhead · Prod: APM doc |
| Lab vs field | Instruments vs MetricKit/Firebase · Trap: one device = fleet · Prod: 30L DAU |
| Defer SDK init | Launch budget · Trap: init all in didFinish · Prod: start regression |
| Signposts | Custom intervals · Trap: unguided profiling · Prod: journey spans |
| LE sheet as perf | Less navigation cost · Trap: only micro-CPU · Prod: S6 30%+ flows |
| Network-bound p90 | Fix API/cache · Trap: micro-optimise UI · Prod: S5 + backend |
| Scroll budget | ~16ms @60fps · Trap: 100ms OK · Prod: hitch tools |
| APM overhead | Budget + batch + sample · Trap: sync upload always · Prod: APM NFR |

## Crashes / reliability (`crashes`) · Day 18

| Front | Back |
|---|---|
| CFS | Crash-free sessions; BMS 99.95%+ · Trap: vanity without process · Prod: S8 |
| Signal safety | No alloc/lock/ObjC in handler · Trap: log normally · Prod: mmap writer |
| dSYM | Symbolicate UUID-matched builds · Trap: forget CI upload · Prod: unreadable stacks |
| Breadcrumbs | Last N events, scrub PII · Trap: log tokens · Prod: ring buffer |
| OOM vs crash | Jetsam heuristics vs fatal signal · Trap: one bucket · Prod: memory tools |
| IMOC | Owner, blast radius, mitigate, comms · Trap: hero debug only · Prod: S8 P0/P1 |
| Mitigate first | Flag/pause rollout · Trap: wait for perfect RCA · Prod: peak events |
| Sync dictionaries | Serialise shared map access · Trap: sprinkle locks · Prod: S2 |
| Non-fatals | Useful ≠ CFS · Trap: alert on all · Prod: sample/group |
| Launch order | Crash SDK early + fast · Trap: after all analytics · Prod: launch crashes |
| Postmortem | Blameless actions · Trap: finger-point · Prod: S8 write-up |
| Hang gap | CFS can look fine · Trap: ignore freezes · Prod: MetricKit hangs |
| Upload timing | Next launch, not in-signal · Trap: network in handler · Prod: crash SDK |
| Severity matrix | Rare×critical still P0 · Trap: % only · Prod: payments |
| Symbolicate fail | Missing dSYM · Trap: “Swift bug” · Prod: fix pipeline |
| 30L DAU | Scale context for reliability · Trap: startup metrics only · Prod: resume |

## Security / storage (`security`) · Day 19

| Front | Back |
|---|---|
| ATS | HTTPS/TLS baseline · Trap: equals pinning · Prod: no cleartext |
| SPKI pin | Hash public key · Trap: pin leaf cert only · Prod: S4 |
| Pin rotation | Dual pins + ship early · Trap: rotate server first · Prod: S4 lesson |
| Domain allowlist | Only known hosts · Trap: pin world · Prod: BMS Ads |
| Alamofire→URLSession | Ownership of trust path · Trap: cargo-cult · Prod: S4 |
| Keychain vs UD | Secrets vs prefs · Trap: token in UD · Prod: auth |
| Caches vs App Support | Purgeable vs user data · Trap: media in UD · Prod: FileManager |
| SQLite WAL | Fast writes, concurrent readers · Trap: main-thread queries · Prod: cheatsheet |
| Core Data use | Object graph needs · Trap: three booleans · Prod: decision tree |
| NSCache | Session images · Trap: secrets · Prod: Day 16 |
| Biometric truth | Unlocks Keychain item · Trap: store face data · Prod: LAContext |
| Break-glass pins | Remote disable carefully · Trap: unauthenticated toggle · Prod: ops |
| Hard-fail pin | Prefer for sensitive APIs · Trap: silent insecure fallback · Prod: ads/pay |
| SQLCipher | Encrypted DB · Trap: plaintext PII · Prod: threat model |
| Obfuscation | Not security · Trap: base64 token · Prod: Keychain |
| Decision tree opener | “Depends on sensitivity + query needs…” · Trap: one tool · Prod: cheatsheet |

## Deeplinks / push / CI (`deeplinks` `ci`) · Day 20

| Front | Back |
|---|---|
| Universal Links | HTTPS + AASA association · Trap: equal to schemes · Prod: S13 |
| AASA | Well-known JSON appIDs/paths · Trap: HTTP OK · Prod: HTTPS only |
| Cold-start queue | Hold link until nav ready · Trap: route instantly · Prod: race bugs |
| Deferred link | Post-install route · Trap: infinite retention · Prod: expiry |
| One router | UL + push share table · Trap: duplicate switches · Prod: consistency |
| APNs token | Register → provider · Trap: hardcode · Prod: refresh |
| Airship | Engagement layer on APNs · Trap: replaces understanding APNs · Prod: Grizzlies |
| Payload safety | Defensive parse · Trap: force unwrap · Prod: CFS |
| GH Actions→TF | Build/lint/upload automation · Trap: no gates · Prod: BMS |
| Release train | Cadence + phased % · Trap: big-bang 100% · Prod: pause on CFS |
| dSYM in CI | Upload every build · Trap: only local · Prod: Day 18 |
| Hybrid deeplink | Coordinator owns stack · Trap: ad hoc UIHostingController · Prod: S13 |
| Secure checkout link | Auth + server truth · Trap: trust query price · Prod: payments |
| AI PR review | Assist, don’t own · Trap: “AI approved” · Prod: S9 |
| Signing secrets | CI secrets, not git · Trap: commit p12 · Prod: rotate |
| Mixpanel vs Airship | Analytics vs push/engagement · Trap: same tool · Prod: Grizzlies |

## System-design mock meta (`mock`) · Day 21

| Front | Back |
|---|---|
| 45-min spine | Clarify 5 / HLD 10 / API 10 / Dive 15 / Ops 5 · Trap: dive first · Prod: cheatsheet |
| Agenda opener | Propose plan; confirm · Trap: silent drawing · Prod: staff signal |
| Scale line | 30L+ DAU from resume · Trap: invent QPS · Prod: BMS |
| CFS in ops | 99.95%+ constraint · Trap: omit reliability · Prod: S8 |
| SDUI deep dives | Versioning, fallbacks, actions · Trap: only widgets · Prod: S3 |
| Networking deep dives | Refresh, pin rotation, cache · Trap: list every verb · Prod: S4 |
| Unknown component | Fallback + metric · Trap: crash · Prod: schema lesson |
| Pin rotation | Dual pins + break-glass · Trap: server-first rotate · Prod: S4 |
| Ops closer | Failures + SLIs + rollout · Trap: end on boxes · Prod: Days 17–20 |
| Resume discipline | Only real metrics · Trap: inflate · Prod: story bank |
| Negotiate scope | Primary + optional · Trap: both full systems · Prod: T3 |
| Module mention | Protocols at boundaries · Trap: ignore packaging · Prod: Day 15 |
| Image callout | Downsample math if media · Trap: ignore memory · Prod: Day 16 |
| p50/p90 | Journey traces · Trap: averages · Prod: S5 |
| Checkpoint habit | Ask “OK to proceed?” · Trap: monologue · Prod: T8 |

---

Anki sample: [anki-import.csv](anki-import.csv)
