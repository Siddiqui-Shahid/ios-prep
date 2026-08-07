# Sample 01 — SDUI foundations (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is server-driven UI, in plain words?

**Answer:**

> The backend or CMS sends a **structured description** of what to show — node types, props, children, actions — and the app maps those types to **native** SwiftUI/UIKit components through a registry. It is **not** evaluating JavaScript from the CMS, not “just a WebView for the whole app,” and not shipping arbitrary executable code in JSON. Think LEGO instructions (schema) plus official bricks (native views). Unknown brick types are skipped, not force-fit into crashes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why native registry vs WebView chrome? | Performance, accessibility, and brand control — WebView is an island tool, not the architecture. |
| Hybrid SDUI? | Most real apps: CMS slots inside native chrome — header slot, splash slot, native nav shell. |
| Interview trap? | “We eval CMS JavaScript” — forbidden; never claim that. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Walk the happy path for a backend-driven header.

**Answer:**

> ViewModel asks the repository for header payload. Repository returns network JSON or cached last-known-good. Version gate checks `schemaVersion` against client max-supported. Parser builds a tree. Registry maps `logo`, `promoBanner`, `searchEntry` to native views. Unknown `type: "sparkle_v9"` skips with a metric; siblings still render. User taps CTA → allowlisted action (e.g. `open_deeplink`) → router. ViewModel owns fetch/cache UI state; registry owns type→view mapping.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Search entry in header? | Opens search — MVVM search debounce is Day 08 sibling (BookMyShow backend-driven header & search). |
| Parse on main thread? | Large payloads should parse off main — NFR bug if jank (deep dive). |
| New component type? | Still needs an app release to register the type — CMS isn’t infinite flexibility. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What sad paths must the client survive?

**Answer:**

> **Offline:** show last-known-good if fresh enough, else baked default. **Major version too new:** hard fallback + `schema_reject` metric. **Unknown node mid-tree:** skip + metric; continue siblings. **Empty root after skips:** hard fallback — never blank chrome. **Unknown action type:** no-op + metric. **Parse error:** fallback + metric. At 30L+ DAU and 99.95% crash-free culture, SDUI without fallbacks is an incident generator.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip vs crash? | Always skip unknown types — never `fatalError` on CMS strings. |
| Empty vs error? | Empty root is product failure — engage hard fallback, alert on skip spikes. |
| Kill switch? | Feature flag back to native default if bad schema in wild. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What are the wins and costs of SDUI?

**Answer:**

> **Wins:** experiment without App Store review for layout/content; personalize surfaces; share contracts across iOS/Android; marketers iterate in CMS. **Costs:** schema discipline; capability matrix; QA combinatorics; offline/fallback engineering; action security; every new **type** still needs a client release. Bad fit: highly custom animation-heavy one-offs, revenue video lifecycle needing native pause/play guarantees (BookMyShow Ads pipeline + HeroWidget lifecycle HeroWidget — use SDUI for config/placement, keep media native).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI vs feature flag? | Flag toggles code path; SDUI changes layout via payload — often combined. |
| SDUI vs A/B? | A/B assigns variant; CMS supplies layout for bucket. |
| Whole home SDUI? | Possible for experiment velocity — QA matrix explosion (trade-off table). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q5. How does SDUI differ from WebView and native Ads?

**Answer:**

> **SDUI native registry:** dynamic layout with perf/a11y budgets. **WebView:** rare docs/legal islands — not primary chrome. **Native Ads (BookMyShow Ads pipeline + HeroWidget lifecycle):** revenue media lifecycle (pause/play, memory) stays native; SDUI may configure **placement** or promos around it. Strong reply to “Isn’t that a WebView?” — native registry + schema; WebView is a tool, not the architecture.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Claim Ads fully SDUI? | No — BookMyShow Ads pipeline + HeroWidget lifecycle is native lifecycle; don’t blur. |
| Legal/age gate on splash? | Prefer native if product-critical (splash inventory). |
| Image props in schema? | Still go through bounded image pipeline (Week 3). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. Why do interviewers care about SDUI at scale?

**Answer:**

> SDUI proves you can ship content velocity **without** sacrificing crash-free sessions — compatibility is a product feature. You must design version gates, unknown skip, allowlisted actions, cache privacy, and honest Verified vs Applied labels (BookMyShow backend-driven header & search vs BookMyShow backend-driven header & search-A1). Senior candidates explain fail-soft policies and metrics, not “we render JSON and hope.” Registry + skip is how CMS velocity doesn’t become crash velocity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metric examples? | `sdui_unknown_component`, `sdui_fallback_used`, `sdui_schema_reject`. |
| BookMyShow IMOC + crash-free at scale culture link? | Architecture reduces blast radius; SDUI skip aligns with reliability — don’t claim SDUI alone produced 99.95%. |
| Contract tests? | Fixture schemas per version asserted against registry in CI. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q7. What should you say in the 90-second teaching script?

**Answer:**

> “SDUI maps a versioned schema to native components through a registry. Unknown types skip with metrics; incompatible majors fall back. Actions are allowlisted. Cached last-known-good protects offline and bad payloads. On BMS I worked a backend-driven header; on Aces a server-driven splash. Schema versioning and unknown fallbacks I’d insist on as design so CMS velocity doesn’t become crash velocity.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Self-check before deep dive? | SDUI ≠ JS eval; unknown skip policy; empty root fallback; BookMyShow backend-driven header & search vs BookMyShow backend-driven header & search-A1; splash cache+timeout. |
| Flash: SDUI def? | Schema → native registry. |
| Flash: Audio streaming + server-driven splash (Aces)? | Aces server-driven splash — no invented ms. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [02-schema-version-fallbacks.md](02-schema-version-fallbacks.md)

---

