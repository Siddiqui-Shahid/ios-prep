# Sample 01 — SDUI foundations (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is server-driven UI, in plain words?

**Points to:** [Foundations · §1 Plain-English mental model](../01-foundations.md#1-plain-english-mental-model) · [Foundations · §2 Glossary](../01-foundations.md#2-glossary)

**Answer:**

> The backend or CMS sends a **structured description** of what to show — node types, props, children, actions — and the app maps those types to **native** SwiftUI/UIKit components through a registry. It is **not** evaluating JavaScript from the CMS, not “just a WebView for the whole app,” and not shipping arbitrary executable code in JSON. Think LEGO instructions (schema) plus official bricks (native views). Unknown brick types are skipped, not force-fit into crashes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why native registry vs WebView chrome? | Performance, accessibility, and brand control — WebView is an island tool, not the architecture. |
| Hybrid SDUI? | Most real apps: CMS slots inside native chrome — header slot, splash slot, native nav shell. |
| Interview trap? | “We eval CMS JavaScript” — forbidden; never claim that. |

---

### Q2. Walk the happy path for a backend-driven header.

**Points to:** [Foundations · §5 Intern path: header](../01-foundations.md#5-intern-path-happy-header-render) · [Deep dive · §1 End-to-end flow](../02-deep-dive.md#1-end-to-end-data-flow)

**Answer:**

> ViewModel asks the repository for header payload. Repository returns network JSON or cached last-known-good. Version gate checks `schemaVersion` against client max-supported. Parser builds a tree. Registry maps `logo`, `promoBanner`, `searchEntry` to native views. Unknown `type: "sparkle_v9"` skips with a metric; siblings still render. User taps CTA → allowlisted action (e.g. `open_deeplink`) → router. ViewModel owns fetch/cache UI state; registry owns type→view mapping.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Search entry in header? | Opens search — MVVM search debounce is Day 08 sibling (S3). |
| Parse on main thread? | Large payloads should parse off main — NFR bug if jank (deep dive). |
| New component type? | Still needs an app release to register the type — CMS isn’t infinite flexibility. |

---

### Q3. What sad paths must the client survive?

**Points to:** [Foundations · §6 Sad paths](../01-foundations.md#6-intern-path-sad-paths-you-must-name) · [Deep dive · §17 Failure modes](../02-deep-dive.md#17-failure-modes)

**Answer:**

> **Offline:** show last-known-good if fresh enough, else baked default. **Major version too new:** hard fallback + `schema_reject` metric. **Unknown node mid-tree:** skip + metric; continue siblings. **Empty root after skips:** hard fallback — never blank chrome. **Unknown action type:** no-op + metric. **Parse error:** fallback + metric. At 30L+ DAU and 99.95% crash-free culture, SDUI without fallbacks is an incident generator.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip vs crash? | Always skip unknown types — never `fatalError` on CMS strings. |
| Empty vs error? | Empty root is product failure — engage hard fallback, alert on skip spikes. |
| Kill switch? | Feature flag back to native default if bad schema in wild. |

---

### Q4. What are the wins and costs of SDUI?

**Points to:** [Foundations · §4 Wins and costs](../01-foundations.md#4-wins-and-costs) · [Deep dive · §13 When SDUI is a bad idea](../02-deep-dive.md#13-when-sdui-is-a-bad-idea)

**Answer:**

> **Wins:** experiment without App Store review for layout/content; personalize surfaces; share contracts across iOS/Android; marketers iterate in CMS. **Costs:** schema discipline; capability matrix; QA combinatorics; offline/fallback engineering; action security; every new **type** still needs a client release. Bad fit: highly custom animation-heavy one-offs, revenue video lifecycle needing native pause/play guarantees (S1 HeroWidget — use SDUI for config/placement, keep media native).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI vs feature flag? | Flag toggles code path; SDUI changes layout via payload — often combined. |
| SDUI vs A/B? | A/B assigns variant; CMS supplies layout for bucket. |
| Whole home SDUI? | Possible for experiment velocity — QA matrix explosion (trade-off table). |

---

### Q5. How does SDUI differ from WebView and native Ads?

**Points to:** [Foundations · §10 SDUI vs WebView vs Ads](../01-foundations.md#10-sdui-vs-webview-vs-native-ads) · [Production bridge · §7 Interviewer pushes](../03-production-bridge.md#7-interviewer-pushes)

**Answer:**

> **SDUI native registry:** dynamic layout with perf/a11y budgets. **WebView:** rare docs/legal islands — not primary chrome. **Native Ads (S1):** revenue media lifecycle (pause/play, memory) stays native; SDUI may configure **placement** or promos around it. Strong reply to “Isn’t that a WebView?” — native registry + schema; WebView is a tool, not the architecture.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Claim Ads fully SDUI? | No — S1 is native lifecycle; don’t blur. |
| Legal/age gate on splash? | Prefer native if product-critical (splash inventory). |
| Image props in schema? | Still go through bounded image pipeline (Week 3). |

---

### Q6. Why do interviewers care about SDUI at scale?

**Points to:** [Foundations · §3 Why interviewers care](../01-foundations.md#3-why-interviewers-care) · [Deep dive · §8 BMS header](../02-deep-dive.md#8-bms-header-s3--architecture-reading)

**Answer:**

> SDUI proves you can ship content velocity **without** sacrificing crash-free sessions — compatibility is a product feature. You must design version gates, unknown skip, allowlisted actions, cache privacy, and honest Verified vs Applied labels (S3 vs S3-A1). Senior candidates explain fail-soft policies and metrics, not “we render JSON and hope.” Registry + skip is how CMS velocity doesn’t become crash velocity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metric examples? | `sdui_unknown_component`, `sdui_fallback_used`, `sdui_schema_reject`. |
| S8 culture link? | Architecture reduces blast radius; SDUI skip aligns with reliability — don’t claim SDUI alone produced 99.95%. |
| Contract tests? | Fixture schemas per version asserted against registry in CI. |

---

### Q7. What should you say in the 90-second teaching script?

**Points to:** [Foundations · §17 90-second script](../01-foundations.md#17-90-second-teaching-script-record-once) · [Production bridge · §5 Interview lines](../03-production-bridge.md#5-interview-lines-20s)

**Answer:**

> “SDUI maps a versioned schema to native components through a registry. Unknown types skip with metrics; incompatible majors fall back. Actions are allowlisted. Cached last-known-good protects offline and bad payloads. On BMS I worked a backend-driven header; on Aces a server-driven splash. Schema versioning and unknown fallbacks I’d insist on as design so CMS velocity doesn’t become crash velocity.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Self-check before deep dive? | SDUI ≠ JS eval; unknown skip policy; empty root fallback; S3 vs S3-A1; splash cache+timeout. |
| Flash: SDUI def? | Schema → native registry. |
| Flash: S12? | Aces server-driven splash — no invented ms. |

---

Next: [02-schema-version-fallbacks.md](02-schema-version-fallbacks.md)
