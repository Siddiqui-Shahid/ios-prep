# Day 10 — SDUI / CMS · Schema Versioning · Fallbacks

> Week 2 · Phase: Architecture, networking, SDUI, UI · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- What **server-driven UI** is (and is not): schema, registry, actions, analytics — not “eval JSON as code”
- **Schema versioning**, unknown-component policy, and **fallback/cache** strategies that protect crash-free sessions
- How BMS **backend-driven header** + search CMS contracts worked in production
- How Aces **server-driven splash** improved cold-start flexibility / freshness

## 2. Concept deep dive

### 2.1 SDUI mental model (60s opener)

```text
CMS / Backend  --JSON schema-->  Parser + Version gate
                                    ↓
                            ComponentRegistry (type → native view)
                                    ↓
                            LayoutResolver + ActionHandler
                                    ↓
                            SwiftUI/UIKit render + analytics
                                    ↕
                            FallbackEngine (disk cache / last-known-good)
```

Primary doc: [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md)

**SDUI wins:** ship content/layout experiments without App Store; personalize surfaces; share contracts across Android/iOS.

**SDUI costs:** schema discipline, client capability matrix, QA of combinations, offline/fallback, security of actions (no arbitrary code).

### 2.2 Schema & versioning

| Strategy | Behavior |
|---|---|
| `schemaVersion` major/minor | Major mismatch → reject or safe fallback layout |
| Capability flags | Client advertises supported components |
| Unknown component | **Skip + log** (never crash) |
| Additive fields | Minor-compatible; clients ignore unknowns |
| Breaking change | New major + dual-publish period |

**Interview line:** “Compatibility is a product feature. Unknown nodes fail soft; known nodes validate strictly.”

### 2.3 Fallbacks (crash-free insurance)

1. **Network fail:** show last-known-good cached layout (TTL + freshness indicator if needed).
2. **Parse/version fail:** baked-in default header/splash.
3. **Partial fail:** render known children; skip bad nodes.
4. **Action fail:** no-op + analytics; never hard-crash on deep link miss.

At **30L+ DAU** and **99.95% crash-free**, SDUI without fallbacks is an incident generator.

### 2.4 Actions & security

Server can send `action: { type, payload }` (deeplink, open URL, refresh module). Client **allowlists** action types. Never execute scripts from CMS. Validate URLs against domain policy (ties to Day 09 whitelist mindset).

### 2.5 BMS header + Aces splash

**BMS:** Generalised protocol-driven main header from backend/CMS; paired with MVVM search (debounce/states). Faster content iteration without release for many header changes.

**Aces:** Server-driven splash to cut cold-start latency / improve freshness alongside audio streaming work — startup is a product surface (time-to-interactive).

### 2.6 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Full SDUI home | Super-app / high experiment velocity | QA matrix explosion |
| Hybrid (CMS slots + native chrome) | Most consumer apps | Need clear slot contracts |
| Native-only | Highly regulated / rare change | Slow iteration |
| Skip unknown components | Always for resilience | Possible visual gaps — measure |
| Disk cache splash/header | Cold start + offline | Stale content risk — version + TTL |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) | Interview spine for SDUI |
| Deepen | [feature-flag-system.md](../../../ios-system-design/docs/feature-flag-system.md) · [ab-testing-experimentation-sdk.md](../../../ios-system-design/docs/ab-testing-experimentation-sdk.md) | Experiments vs SDUI overlap |
| Deepen | [search-autocomplete.md](../../../ios-system-design/docs/search-autocomplete.md) | Header/search surface |
| Repo | S3 · S12 in [story-bank.md](../../stories/story-bank.md) | BMS header; Aces splash |

## 4. Map to your work

**Company / feature:** BookMyShow — backend-driven header & search  
**What you did:** Protocol-driven generalised main-screen header from CMS/backend; search debounce + MVVM states; API contracts for layout/content changes without release when possible.  
**Interview line (≤20s):** “I made the BMS main header backend-driven with a protocolised client and fail-soft rendering, plus race-safer debounced search.”

→ Full STAR: [stories/story-bank.md](../../stories/story-bank.md)#s3--backend-driven-header--search-bookmyshow

**Secondary — Las Vegas Aces:** Server-driven splash + audio streaming.  
→ [stories/story-bank.md](../../stories/story-bank.md)#s12--audio-streaming--server-driven-splash-raw--las-vegas-aces

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. What is server-driven UI? `(30–45s)`
**Skeleton:** Backend sends structured layout/content schema; client maps types to native components via registry; actions allowlisted. Not WebView-only, not JS eval.  
**Follow-up:** vs HTML WebView? → Native perf/a11y/brand control + schema constraints.  
**Story:** S3 / S12.

### Q2. Core client components? `(45–60s)`
**Skeleton:** Parser, version gate, ComponentRegistry, LayoutResolver, ActionHandler, FallbackEngine/cache, analytics hooks.  
**Follow-up:** Where does VM sit? → Owns fetch/cache state; registry is pure mapping.  
**Story:** Point to sdui-engine.md.

### Q3. How do you version the schema? `(60s)`
**Skeleton:** Semantic version; client max-supported; dual-write on breaking changes; ignore unknown fields; reject incompatible major to fallback.  
**Follow-up:** Who owns version bumps? → Contract between mobile + backend; changelog.  
**Story:** S3 API contracts.

### Q4. Unknown component arrives in prod — what happens? `(45s)`
**Skeleton:** Skip node, log/metric, continue siblings; never crash. Optional placeholder only if design allows.  
**Follow-up:** How detect in QA? → Contract tests + canary payloads.  
**Story:** Crash-free culture S8 + S3.

### Q5. Offline / fetch failure strategy? `(45–60s)`
**Skeleton:** Disk last-known-good with TTL; if none, native default; show stale affordance if product needs; retry with backoff.  
**Follow-up:** Splash specifically? → Cached splash critical for cold start (S12).  
**Story:** S12.

### Q6. How did BMS header SDUI help the business? `(45s)`
**Skeleton:** Faster content/layout iteration without app release for many cases; consistent protocolised implementation; paired with better search UX.  
**Follow-up:** Limits? → Still need app release for new component types.  
**Story:** S3.

### Q7. SDUI actions security? `(45–60s)`
**Skeleton:** Allowlist action types; validate URLs/domains; no script execution; auth-sensitive actions re-check client-side.  
**Follow-up:** Open external URL? → SFSafariViewController / controlled browser; ATS.  
**Story:** Day 09 whitelist mindset + S4.

### Q8. When is SDUI a bad idea? `(45s)`
**Skeleton:** Highly interactive unique UI, strong a11y/custom animation needs, rare change surfaces, team without schema QA. Prefer hybrid slots.  
**Follow-up:** Ads HeroWidget? → Often native for revenue-critical media lifecycle (S1).  
**Story:** Judgment vs S1 native ads.

### Q9. How do analytics work in SDUI? `(45s)`
**Skeleton:** Server can attach event names/params; client validates and injects common context (user, screen). Don’t trust server to log PII unchecked.  
**Follow-up:** Mixpanel on Grizzlies? → Host analytics vs SDK — S13 adjacent.  
**Story:** S3 + discipline.

### Q10. Cold start + server splash — metrics? `(45–60s)`
**Skeleton:** Time-to-first-frame vs time-to-interactive; cache splash JSON/images; don’t block forever on network; timeout → default.  
**Follow-up:** Audio init parallel? → Don’t serialize everything on main launch path (S12).  
**Story:** S12.

### Q11. Testing SDUI? `(45–60s)`
**Skeleton:** Fixture schemas per version; registry unit tests; snapshot critical layouts; contract tests with backend; chaos payload (unknown types).  
**Follow-up:** UITests? → Few golden paths; not every CMS combo.  
**Story:** S9 test mindset applied to SDUI.

### Q12. SDUI vs feature flags vs A/B? `(45s)`
**Skeleton:** Flags toggle code paths; A/B assigns variants; SDUI changes layout/content via payload. Often combined: flag enables SDUI surface; CMS supplies variant layout.  
**Follow-up:** Point to feature-flag / ab-testing docs.  
**Story:** Experiment velocity narrative.

## 6. Tricky questions

### T1. “JSON drives UI — isn’t that just a WebView?” `(90–120s)`
**Trap:** Conflate SDUI with web.  
**Senior answer:** SDUI maps to **native** components with typed schema, a11y, performance budgets, offline cache. WebView is a tool, not the architecture. Hybrid possible (HTML island) but BMS header was protocol-native.  
**Follow-up:** When WebView wins? → Rare complex docs/legal; not primary nav chrome.

### T2. “Backend sent a breaking schema to 30L users.” `(120s)`
**Trap:** Only “we crashed.”  
**Senior answer:** Version gate + fallback layout + kill switch/feature guard + Crashlytics watch + IMOC coordination (S8). Canary % rollout of schema. Client must survive bad payloads.  
**Follow-up:** Who pages whom? → Mobile + backend owners; blast radius.

### T3. “How do you keep Android and iOS parity?” `(90s)`
**Trap:** Copy-paste JSON hope.  
**Senior answer:** Shared schema spec, capability negotiation, contract tests in CI per platform registry, dual-publish rules. Accept temporary capability gaps with server targeting.  
**Follow-up:** New component: native apps ship first, then CMS uses it.

### T4. “Skip unknown components — empty screen risk?” `(90s)`
**Trap:** Skipping forever without metrics.  
**Senior answer:** Skip is crash-safe default; emit `unknown_component` metrics; alert on spike; require minimum viable tree (e.g. at least logo on splash). Empty root → hard fallback.  
**Follow-up:** S12 splash minimum content policy.

### T5. “Personalised SDUI + cache — privacy leak?” `(90–120s)`
**Trap:** One disk cache for all users.  
**Senior answer:** Cache keys include user/session; clear on logout; don’t write sensitive payloads longer than needed; pin down what splash may contain.  
**Follow-up:** Guest vs logged-in header variants.

### T6. “Where should component registry live — app or SDK?” `(90s)`
**Trap:** Absolute.  
**Senior answer:** App owns app-specific components; shared SDK can own common primitives (text, stack, image) — Stories SDK lesson (S10): clear public API and versioning. Header registry likely app module with protocol hooks.  
**Follow-up:** S10 modularity crossover.

### T7. “SDUI for revenue Ads?” `(90–120s)`
**Trap:** SDUI everything.  
**Senior answer:** Ads often need strict native lifecycle (pause/play video — S1 HeroWidget). Use SDUI for placement/config; keep media renderers native and type-safe (POP+generics).  
**Follow-up:** Perfect Mock #2 fork: Ads architecture vs SDUI engine.

### T8. “Parser on main thread drops frames.” `(90s)`
**Trap:** Ignore NFRs.  
**Senior answer:** Parse off main; budget <16ms interaction; prewarm splash cache; incremental render. Cite sdui-engine NFRs.  
**Follow-up:** Instruments Time Profiler on launch (Week 3 preview).

## 7. Flashcards for today

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

## 8. Practice

- **Coding / SD:** Whiteboard SDUI HLD from [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) in **5 minutes** (Mock #2 option). List BMS header component types you’d register and fallback rules.
- **Complexity / agenda to say first:** “I’ll define schema + registry + versioning + fail-soft, then map to BMS header and Aces splash, then trade-offs vs native Ads.”
- **Story polish:** S3 and S12 openers back-to-back (20s each).

## 9. Timed drill

1. Pick 3 Normal + 2 Tricky (recommended: Q3, Q4, Q10 + T2, T7). Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Log misses in gotchas (versioning + unknown-component policy).
4. Optional: 5-min timed SDUI architecture talk — record and compare to Mock #2 rubric on Day 14.
