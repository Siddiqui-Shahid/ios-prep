# 04 — Questions (two-layer answers)

> Study flow: cover the full spoken answer → speak from **Answer points** only → uncover and compare timing.  
> Totals: **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. What is server-driven UI? `(30–45s)`

**Answer points (frame first):**
- Backend sends structured layout/content schema
- Client maps types to native components
- Actions allowlisted
- Not WebView-only / not JS eval

**Agenda opener:** “I’d define schema-to-native, not web cosplay…”

**Full spoken answer:**
> “Server-driven UI means the backend sends a structured schema for layout and content, and the client maps each type to a native SwiftUI or UIKit component through a registry. Actions are allowlisted. It’s not evaluating JavaScript from CMS, and it’s not ‘the whole app is a WebView.’ On BookMyShow we used that approach for a backend-driven main header so content could move faster without waiting on every release.”

**Common wrong answer:** “SDUI means render HTML in a WebView.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | vs HTML WebView? | Native perf/a11y/brand + schema constraints. |
| L2 | New types? | Still need app release to register. |
| L3 | Search relation? | Header SDUI; search MVVM Day 08. |

**Provenance:** Verified · S3 · BMS header

---
### Q2. Core client components of an SDUI stack? `(45–60s)`

**Answer points (frame first):**
- Parser
- Version gate
- ComponentRegistry
- Layout/Action handlers
- FallbackEngine/cache
- Analytics hooks

**Agenda opener:** “I’d list the pipeline pieces…”

**Full spoken answer:**
> “I’d describe a pipeline: parse the payload, run a schema version gate, resolve nodes through a ComponentRegistry, handle allowlisted actions, and keep a FallbackEngine for last-known-good or baked defaults. Analytics hooks validate events. The ViewModel owns fetch and cache state; the registry stays a pure mapping layer.”

**Common wrong answer:** “Just JSONDecoder into View.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Where does VM sit? | Fetch/cache/error UI; registry maps. |
| L2 | Who owns deeplink? | Action → app router. |
| L3 | Metrics? | unknown_component / schema_reject. |

**Provenance:** Learning-lab · pipeline; Verified S3 direction

---
### Q3. How do you version the schema? `(60s)`

**Answer points (frame first):**
- Semantic / major-minor
- Client max-supported
- Dual-write on breaks
- Ignore unknown fields
- Reject incompatible major → fallback

**Agenda opener:** “I’d treat compatibility as a product feature…”

**Full spoken answer:**
> “I version the schema and have the client declare a max-supported version. Additive fields are ignored by older clients. Breaking changes get a major bump with a dual-publish period. If the payload is too new, I reject to a safe fallback rather than crashing. Capability flags help the server avoid sending unsupported types. On BMS header work I’d insist on that discipline as design even when speaking carefully about what was named in production.”

**Common wrong answer:** “Force upgrade the app for every banner change.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Who owns bumps? | Mobile + backend contract/changelog. |
| L2 | Missing version? | Document legacy default policy. |
| L3 | S3-A1? | Label as How I would apply it. |

**Provenance:** How I would apply it · S3-A1 · versioning design

---
### Q4. Unknown component arrives in prod — what happens? `(45s)`

**Answer points (frame first):**
- Skip node
- Log/metric
- Continue siblings
- Never crash
- Empty root → hard fallback

**Agenda opener:** “I’d fail soft, then measure…”

**Full spoken answer:**
> “The registry skips the unknown node, emits a metric with the type name, and continues rendering siblings. We never crash on CMS strings. If skipping leaves a meaningless root — like a blank splash — we engage a hard fallback layout. Skipping without metrics is how broken contracts hide until users complain.”

**Common wrong answer:** “Force unwrap and crash so QA notices.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | QA detection? | Contract tests + canary payloads. |
| L2 | Alerting? | Spike on unknown_component rate. |
| L3 | Crash-free link? | S8 culture — fail soft. |

**Provenance:** How I would apply it · S3-A1; culture S8

---
### Q5. Offline / fetch failure strategy? `(45–60s)`

**Answer points (frame first):**
- Disk last-known-good + TTL
- Baked default if none
- Stale affordance if needed
- Retry with backoff
- Splash: cache critical

**Agenda opener:** “I’d layer cache then default…”

**Full spoken answer:**
> “On network or parse failure I show last-known-good from disk if present and within TTL; otherwise a baked native default. Optionally show a stale affordance if product needs honesty. Retry with backoff in the background. For splash specifically, cached content is critical so cold start isn’t held hostage by the network — that’s the Aces mindset.”

**Common wrong answer:** “Blank screen until network returns.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Personalized cache? | Key by user; clear on logout. |
| L2 | Timeout? | Short timeout → default on splash. |
| L3 | Version-stamped cache? | Don’t apply incompatible cached major. |

**Provenance:** Verified · S12 · splash; Learning-lab fallback

---
### Q6. How did BMS header SDUI help the business? `(45s)`

**Answer points (frame first):**
- Faster content/layout iteration
- Many changes without release
- Protocolised client
- Still need release for new types

**Agenda opener:** “I’d connect CMS velocity to release cost…”

**Full spoken answer:**
> “It let content and layout on the main header iterate faster without waiting on App Store for many changes, behind a generalised protocol-driven client. That’s real product velocity. The limit is honest: new component types still require an app release to register native renderers.”

**Common wrong answer:** “Unlimited UI without ever shipping an app again.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Search? | MVVM sibling — Day 08. |
| L2 | Android? | Shared schema + capability negotiation. |
| L3 | Risk? | Without fallbacks → incidents. |

**Provenance:** Verified · S3 · header iteration

---
### Q7. SDUI actions security? `(45–60s)`

**Answer points (frame first):**
- Allowlist action types
- Validate URLs/domains
- No script execution
- Auth-sensitive re-check client-side

**Agenda opener:** “I’d treat actions as a privileged API…”

**Full spoken answer:**
> “Actions are allowlisted — open deeplink, open URL, refresh module — not arbitrary code. URLs go through domain policy; deeplinks go through the app router. Auth-sensitive actions re-check client-side. Never execute CMS scripts. It’s the same threat mindset as host whitelisting on networking day.”

**Common wrong answer:** “Trust CMS completely; it’s internal.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | External URL? | Controlled browser; ATS. |
| L2 | Unknown action? | No-op + metric. |
| L3 | Injection? | Don’t string-concat into JS/WebView blindly. |

**Provenance:** Learning-lab · allowlist; Day 09 mindset

---
### Q8. When is SDUI a bad idea? `(45s)`

**Answer points (frame first):**
- Highly interactive unique UI
- Heavy custom a11y/animation
- Rare change surfaces
- No schema QA
- Prefer hybrid slots

**Agenda opener:** “I’d scope SDUI to change velocity vs complexity…”

**Full spoken answer:**
> “SDUI is a poor fit for highly interactive one-off UI, heavy custom animation, or surfaces that rarely change — and it’s dangerous if the team won’t invest in schema QA. Prefer hybrid: CMS slots inside native chrome. Revenue ads video often stays native for lifecycle guarantees — configure placement maybe, don’t SDUI the player.”

**Common wrong answer:** “SDUI everything including checkout micro-interactions.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Ads HeroWidget? | Native pause/play — S1. |
| L2 | Hybrid example? | Native tab bar + CMS header slots. |
| L3 | Legal WebView? | Island OK; not primary nav. |

**Provenance:** Judgment · S1 contrast

---
### Q9. How do analytics work in SDUI? `(45s)`

**Answer points (frame first):**
- Server may attach event names
- Client validates
- Inject common context
- Don’t trust PII unchecked

**Agenda opener:** “I’d validate before logging…”

**Full spoken answer:**
> “The payload can attach analytics event names and params, but the client validates them and injects common context like screen and app version. I don’t treat CMS as an unchecked PII pipe. Bad event names get dropped or mapped safely.”

**Common wrong answer:** “Log whatever JSON says.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Mixpanel on Grizzlies? | Host analytics vs SDK — S13 adjacent. |
| L2 | Allowlist events? | Yes for high-risk surfaces. |
| L3 | Debug? | Sample unknown event metrics. |

**Provenance:** Learning-lab · hygiene; S3 surface

---
### Q10. Cold start + server splash — how do you think about metrics? `(45–60s)`

**Answer points (frame first):**
- TTI over vanity first-frame only
- Cache splash JSON/images
- Timeout → default
- Don’t block forever
- No invented ms

**Agenda opener:** “I’d optimize for safe interactivity…”

**Full spoken answer:**
> “I care about time-to-interactive more than a vanity first-frame number. Splash should read cache quickly, attempt a short network refresh, and fall back to a default if slow. Blocking launch on a perfect CMS response is how you create slow launches. On Aces we made splash server-driven for flexibility and freshness — I won’t invent millisecond claims.”

**Common wrong answer:** “Always wait for network so splash is fresh.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Audio init? | Don’t serialize everything on main launch path. |
| L2 | Minimum tree? | Logo/brand required. |
| L3 | Metric names? | Launch stages + splash source cache/network/default. |

**Provenance:** Verified · S12 · splash cold start

---
### Q11. How do you test SDUI? `(45–60s)`

**Answer points (frame first):**
- Fixtures per version
- Registry unit tests
- Chaos unknown types
- Snapshots for chrome
- Few golden UITests
- Contract tests with backend

**Agenda opener:** “I’d test contracts more than every CMS combo…”

**Full spoken answer:**
> “I use fixture schemas per version, registry unit tests, chaos payloads with unknown types, and snapshots for critical chrome. Contract tests with backend catch drift. UITests cover a few golden paths — not every CMS combination, because that matrix explodes.”

**Common wrong answer:** “Only manual QA on production CMS.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Empty root fixture? | Assert hard fallback. |
| L2 | Action tests? | Unknown action no-op. |
| L3 | Canary? | Payload % rollout in prod. |

**Provenance:** Learning-lab · S9 test mindset applied

---
### Q12. SDUI vs feature flags vs A/B? `(45s)`

**Answer points (frame first):**
- Flags toggle code paths
- A/B assigns variants
- SDUI changes layout/content via payload
- Often combined

**Agenda opener:** “I’d separate mechanism from experiment…”

**Full spoken answer:**
> “Feature flags toggle code paths. A/B assigns users to variants. SDUI changes layout and content through payloads. They’re often combined: a flag enables an SDUI surface, and CMS or experiment config supplies the variant layout. Don’t conflate the three in an interview.”

**Common wrong answer:** “They’re all the same thing.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Kill switch? | Flag back to native default. |
| L2 | Personalization? | Server targeting + privacy-safe cache keys. |
| L3 | Docs? | Optional feature-flag / ab-testing system design. |

**Provenance:** Learning-lab · experiment vocabulary

---

## Tricky questions

### T1. JSON drives UI — isn’t that just a WebView? `(90–120s)`

**Answer points (frame first):**
- Trap: conflate SDUI with web
- Native components + typed schema
- a11y/perf/offline
- WebView is a tool
- BMS header protocol-native

**Agenda opener:** “I’d separate architecture from embedding HTML…”

**Full spoken answer:**
> “Driving UI from JSON doesn’t mean WebView. SDUI maps a typed schema onto native components with accessibility, performance budgets, and offline cache. A WebView can be an island for documents, but it isn’t the architecture. BookMyShow’s header direction was protocol-native — structured contracts into native rendering — not ‘put the home chrome in WKWebView.’”

**Common wrong answer:** SDUI = WebView.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | When WebView wins? | Complex legal/docs; not primary nav. |
| L2 | Hybrid HTML island? | Possible; still allowlist actions. |
| L3 | SEO? | Irrelevant for native app chrome. |

**Provenance:** Verified · S3 · native header direction

---
### T2. Backend sent a breaking schema to 30L users. `(120s)`

**Answer points (frame first):**
- Version gate + fallback
- Kill switch / feature guard
- Crashlytics watch
- Canary %
- IMOC coordination mindset
- Client must survive

**Agenda opener:** “I’d talk survival first, then process…”

**Full spoken answer:**
> “First, the client should already survive: version gate rejects to fallback, unknown nodes skip, empty root hard-falls back. Operationally I’d want canary payload exposure, a kill switch to native default, Crashlytics and schema-reject metrics, and coordination between mobile and backend owners — IMOC mindset at scale. The mistake is assuming CMS is safe because it’s ‘our server.’”

**Common wrong answer:** Only “we crashed” / only blame backend.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Who pages whom? | Mobile + backend; blast radius. |
| L2 | Dual-publish? | Should have prevented hard break. |
| L3 | S3-A1? | This is why versioning design matters. |

**Provenance:** S3-A1 design + S8 culture

---
### T3. How do you keep Android and iOS parity? `(90s)`

**Answer points (frame first):**
- Shared schema spec
- Capability negotiation
- Contract tests per registry
- Accept temporary gaps
- Server targeting

**Agenda opener:** “I’d negotiate parity, not hope…”

**Full spoken answer:**
> “Parity comes from a shared schema spec, capability negotiation, and contract tests in CI against each platform’s registry. Temporary capability gaps are OK if the server targets correctly. A new component ships in native apps first, then CMS starts using it. Copy-pasting JSON and hoping is how iOS renders a banner Android skips into a lopsided experiment.”

**Common wrong answer:** “Same JSON always looks identical.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Gap communication? | CMS tooling shows support matrix. |
| L2 | Version skew? | Dual-publish + min versions. |
| L3 | Design system? | Shared primitives help. |

**Provenance:** Learning-lab · parity practice

---
### T4. Skip unknown components — empty screen risk? `(90s)`

**Answer points (frame first):**
- Skip is crash-safe default
- Metric + alert
- Minimum viable tree
- Empty root → hard fallback

**Agenda opener:** “I’d separate child skip from root emptiness…”

**Full spoken answer:**
> “Skipping unknowns is the crash-safe default, but you must emit metrics and alert on spikes. Define a minimum viable tree — for splash, at least brand/logo. If the resolved root is meaningless, hard fallback. Skipping without measurement trades crashes for silent blank UI, which users experience as ‘app is broken’ anyway.”

**Common wrong answer:** Skip forever without metrics.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S12 policy? | Minimum splash content. |
| L2 | Placeholder views? | Only if design allows. |
| L3 | Partial promo missing? | OK; header chrome must remain. |

**Provenance:** S3-A1 design + S12 splash rules

---
### T5. Personalised SDUI + cache — privacy leak? `(90–120s)`

**Answer points (frame first):**
- Cache keys include user/session
- Clear on logout
- Limit sensitive retention
- Guest vs logged-in variants

**Agenda opener:** “I’d key and invalidate deliberately…”

**Full spoken answer:**
> “Personalized payloads must not live in a single global disk slot. Cache keys include user or session, and logout clears them. Be intentional about what splash or header may contain and how long it persists. Guest versus logged-in variants are different keys. A shared cache is how you leak another user’s promo — or worse — across accounts on a family device.”

**Common wrong answer:** One disk cache for all users.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Multi-user devices? | Clear aggressively on account switch. |
| L2 | Encryption at rest? | Consider for sensitive CMS. |
| L3 | Analytics in cache? | Don’t persist PII needlessly. |

**Provenance:** Learning-lab · privacy

---
### T6. Where should component registry live — app or SDK? `(90s)`

**Answer points (frame first):**
- App owns app-specific components
- SDK may own primitives
- Clear public API if shared
- Header registry likely app module

**Agenda opener:** “I’d put specificity with ownership…”

**Full spoken answer:**
> “App-specific header components live in the app module with protocol hooks. A shared SDK can own common primitives — text, stack, image — if versioned cleanly. The Stories SDK lesson applies: public API and independence matter when multiple apps share code. Don’t shove every BMS-only promo widget into a portfolio SDK.”

**Common wrong answer:** Absolute one place forever.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S10 crossover? | Modularity + versioning. |
| L2 | Binary size? | Primitives shared; features app-local. |
| L3 | Registration API? | App registers custom types at launch. |

**Provenance:** S10 adjacent modularity

---
### T7. SDUI for revenue Ads? `(90–120s)`

**Answer points (frame first):**
- Ads need strict native lifecycle
- SDUI for placement/config OK
- Media renderers native POP+generics
- Don’t SDUI pause/play

**Agenda opener:** “I’d split config from media runtime…”

**Full spoken answer:**
> “I’d be cautious. Revenue ads often need strict native lifecycle — pause and play with visibility, as with HeroWidget. SDUI can drive placement or configuration, but media renderers should stay native and type-safe. Schema-driving a video player’s lifecycle is how you get wasted playback and UI glitches on a money path.”

**Common wrong answer:** SDUI everything including video ads.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Mock fork? | Ads architecture vs SDUI engine. |
| L2 | S1 proof? | POP+generics native pipeline. |
| L3 | Experiment ads layout? | Config/slots yes; player no. |

**Provenance:** Verified · S1 contrast with SDUI

---
### T8. Parser on main thread drops frames — response? `(90s)`

**Answer points (frame first):**
- Parse off main
- Budget interactions
- Prewarm splash cache
- Incremental render
- Profile launch

**Agenda opener:** “I’d treat it as an NFR bug…”

**Full spoken answer:**
> “Parsing large SDUI payloads on the main thread is a performance defect. Move parse off main, prewarm splash cache, render incrementally if needed, and keep interaction budgets tight. Then profile launch with Time Profiler. JSON isn’t inherently slow — main-thread work without a budget is.”

**Common wrong answer:** Ignore NFRs / blame JSON.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Where decode? | Repository/background before UI apply. |
| L2 | Images? | Bounded pipeline Week 3. |
| L3 | Metric? | Parse duration histogram. |

**Provenance:** Learning-lab · NFR

---
