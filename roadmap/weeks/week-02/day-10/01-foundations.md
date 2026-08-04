# 01 — Foundations: What SDUI Actually Is

> Intern → mid mental model. Read before the deep dive.

## 1. Plain-English mental model

**Server-driven UI (SDUI)** means the backend (or CMS) sends a **structured description** of what to show — types, props, children, actions — and the app maps those types to **native** SwiftUI/UIKit components.

It is **not**:

- Evaluating JavaScript from the CMS
- “Just a WebView for the whole app”
- Shipping arbitrary code in JSON

Think of a set of LEGO instructions (schema) and a box of official bricks (native registry). Unknown brick types are **skipped**, not force-fit into explosions (crashes).

```text
CMS / Backend  --JSON schema-->  Parser + Version gate
                                    ↓
                            ComponentRegistry (type → native view)
                                    ↓
                            LayoutResolver + ActionHandler
                                    ↓
                            Native render + analytics
                                    ↕
                            FallbackEngine (disk cache / last-known-good / baked default)
```

## 2. Glossary

| Term | Meaning |
|---|---|
| **Schema** | Contract describing nodes: `type`, props, children, actions, optional `schemaVersion`. |
| **schemaVersion** | Compatibility number; major mismatch → reject or hard fallback. |
| **ComponentRegistry** | Map from server `type` string → native factory/view. |
| **Unknown component** | Type not in registry — **skip + metric**, never crash. |
| **Capability flags** | Client advertises supported types / features to server. |
| **Additive change** | New optional fields; old clients ignore unknowns. |
| **Breaking change** | Requires major bump + dual-publish period. |
| **Action allowlist** | Only known `action.type` values execute (deeplink, refresh, openURL…). |
| **FallbackEngine** | Last-known-good cache, baked default, or partial tree render. |
| **Last-known-good** | Previously validated payload on disk for offline / fail. |
| **Hybrid SDUI** | CMS slots inside native chrome (most real apps). |
| **Cold start splash** | First paint / branded startup surface — product-critical (S12). |
| **Time-to-interactive** | When user can act — more honest than first-frame vanity. |
| **Canary payload** | % rollout of new schema to watch metrics before 100%. |
| **Contract test** | Fixture schemas asserted against registry per version. |

## 3. Why interviewers care

SDUI answers prove you can:

- Ship content velocity **without** sacrificing crash-free
- Design **compatibility** as a product feature
- Secure **actions** (no arbitrary code)
- Reason about **cold start** and cache freshness
- Stay honest about **Verified vs Applied** (S3 vs S3-A1)

At **30L+ DAU** and **99.95% crash-free** culture, SDUI without fallbacks is an incident generator.

## 4. Wins and costs

**Wins:** experiment without App Store; personalize surfaces; share contracts across iOS/Android; marketers/CMS iterate layout/content.

**Costs:** schema discipline; capability matrix; QA of combinations; offline/fallback; action security; new component types still need an app release.

## 5. Intern path: happy header render

1. App launches; ViewModel asks repository for header payload.
2. Repository returns network JSON or cached last-known-good.
3. Version gate checks `schemaVersion` against client max-supported.
4. Parser builds a tree of nodes.
5. Registry maps `logo`, `promoBanner`, `searchEntry` → native views.
6. Unknown `type: "sparkle_v9"` → skip + log; siblings still render.
7. User taps CTA → allowlisted `open_deeplink` action → router.

## 6. Intern path: sad paths you must name

| Failure | Client behavior |
|---|---|
| Offline | Show last-known-good if fresh enough; else baked default |
| Major version too new | Hard fallback layout; metric `schema_reject` |
| Unknown node mid-tree | Skip node; continue |
| Empty root after skips | Hard fallback (never blank chrome) |
| Action type unknown | No-op + metric; no crash |
| Parse error | Fallback + metric |

## 7. Schema versioning — 60s picture

| Strategy | Behavior |
|---|---|
| Major / minor | Major mismatch → reject or safe fallback |
| Capability flags | Server avoids sending unsupported types when possible |
| Unknown fields | Ignore (forward compatible) |
| Unknown types | Skip + metric |
| Breaking change | New major + dual-publish old+new |

**Interview line:** “Compatibility is a product feature. Unknown nodes fail soft; known nodes validate strictly.”

> **Provenance note:** Full versioning + unknown fallback as a disciplined system is **S3-A1 design** on top of verified S3 header work. Speak carefully in production bridge.

## 8. Actions & security (intern)

Server may send `action: { type, payload }`. Client **allowlists** types. Never execute scripts. Validate URLs against domain policy (Day 09 whitelist mindset). Auth-sensitive actions re-check client-side.

## 9. Two production anchors

### BMS header · S3

Generalised, protocol-driven main header from CMS/backend so many layout/content changes ship without an app release. Paired historically with MVVM search (Day 08).

### Aces splash · S12

Server-driven splash improved cold-start flexibility/freshness alongside audio streaming work. Startup is a product surface — cache + timeout to default; don’t block forever on network. **No invented ms** on resume.

## 10. SDUI vs WebView vs native Ads

| Approach | Use |
|---|---|
| SDUI native registry | Dynamic layout/content with a11y/perf budgets |
| WebView | Rare complex docs/legal islands — not primary chrome |
| Native Ads/HeroWidget (S1) | Revenue media lifecycle often stays native; SDUI may configure placement |

## 11. Self-check

Ready for deep dive when you can say:

1. SDUI ≠ JS eval ≠ whole-app WebView
2. Unknown component policy
3. Why empty root needs hard fallback
4. S3 verified vs S3-A1 design
5. Splash: cache + timeout default (S12)

## 12. Flash preview

| Front | Back |
|---|---|
| SDUI def | Schema → native registry |
| Unknown | Skip + metric |
| Fallback | Last-known-good / baked |
| Action | Allowlist only |
| S3 | BMS header CMS |
| S3-A1 | Versioning design |
| S12 | Aces splash |


## 13. Schema evolution worked examples

### Additive (safe for old clients)

Old client knows `promoBanner`. New payload adds optional `props.subtitle`. Old client ignores unknown field; banner still shows title.

### New type (needs app release + fail-soft)

Server sends `type: "countdownTimer"`. Old clients **skip** + metric. New clients register the type after App Store ships. CMS enables countdown only for builds advertising capability.

### Breaking (dual-publish)

`children` array renamed to `nodes` without major bump → parsers break. Correct approach: `schemaVersion: 4` with dual-publish of v3 and v4 until old clients fall below threshold — or keep additive shape.

## 14. Header component inventory (BMS-style thinking)

| Type | Native responsibility | Skip impact |
|---|---|---|
| `logo` | Brand chrome | High — hard fallback if missing at root |
| `citySelector` | Location UX | Medium — may hide |
| `promoBanner` | CMS campaign | Low — skip OK |
| `searchEntry` | Opens search | Medium — provide native default entry |
| `navIcons` | Profile/tickets | Medium |

## 15. Splash inventory (Aces-style thinking)

| Concern | Policy |
|---|---|
| Brand/logo | Required minimum |
| Seasonal art | Cacheable; skippable if unknown |
| Legal/age gate | Product-required; prefer native if critical |
| Enter CTA | Required affordance |
| Network freshness | Soft refresh with timeout |

## 16. Metric dictionary (speak these names)

| Metric | Meaning |
|---|---|
| `sdui_schema_reject` | Version gate refused payload |
| `sdui_unknown_component` | Skipped type |
| `sdui_unknown_action` | Allowlist miss |
| `sdui_fallback_used` | LKG or baked engaged |
| `sdui_splash_source` | cache \| network \| default |

## 17. 90-second teaching script (record once)

> “SDUI maps a versioned schema to native components through a registry. Unknown types skip with metrics; incompatible majors fall back. Actions are allowlisted. Cached last-known-good protects offline and bad payloads. On BMS I worked a backend-driven header; on Aces a server-driven splash. Schema versioning and unknown fallbacks I’d insist on as design so CMS velocity doesn’t become crash velocity.”
