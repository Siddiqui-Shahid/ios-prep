# Sample 02 — Schema versioning and fallbacks (Q&A)

> Guided teaching. Version gates, unknown skip, and FallbackEngine with code pointers.

---

### Q1. How does schema versioning work in 60 seconds?
**Answer:**

> Payloads carry `schemaVersion`. Client compares against min/max supported. **Major too new:** reject → hard fallback + metric. **Major too old:** fallback or force-upgrade messaging (product call). **Within range:** parse and render. **Unknown JSON fields:** ignore — forward compatible additive change. **Unknown component types:** skip + metric — not reject whole tree unless root becomes empty. **Breaking structural change:** bump major + dual-publish old and new until old clients fall below threshold.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview line? | “Compatibility is a product feature. Unknown nodes fail soft; known nodes validate strictly.” |
| BookMyShow backend-driven header & search-A1 label? | Full versioning discipline as **design** on top of verified BookMyShow backend-driven header & search header — not a named resume VersionGate service. |
| Dual-publish why? | Don’t force-upgrade 30L users for a banner experiment. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What happens at the version gate for each case?
**Answer:**

> | Case | Gate | UI |
> |---|---|---|
> | Version within client min/max | accept | Render tree |
> | `payload.version > clientMax` | reject_too_new | FallbackEngine |
> | `payload.version < clientMin` | reject_too_old | Fallback or upgrade UX |
> | Missing version on legacy | documented v1 policy | Treat as legacy default |

> See learning-lab [SchemaVersionGate.swift](../code/SchemaVersionGate.swift) for gate shape.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Canary payload? | % rollout of new schema before 100% — watch unknown/skip metrics. |
| Additive field example? | New optional `props.subtitle` on `promoBanner` — old client ignores, title still shows. |
| Breaking rename `children`→`nodes`? | Needs major bump + dual-publish — don’t silently rename. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What is the unknown-component policy?
**Answer:**

> Server sends `type: "countdownTimer"` but client registry only knows `{logo, promoBanner, searchEntry}`. **Policy:** skip that node, emit `sdui_unknown_component` metric with type name and schemaVersion, **continue rendering siblings**. Never `fatalError` on CMS strings. New types require an app release to register the factory; until then, skip is the crash-free contract. Server should use capability flags to avoid sending unsupported types when possible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Known type, bad props? | Pick consistent policy: skip node or safe defaults — validate known types strictly. |
| Silent skip spike? | Alert — hides broken contracts in production. |
| Partial failure vs empty root? | Skipping children OK; if root resolves to nothing meaningful, hard fallback. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What does FallbackEngine provide?
**Answer:**

> Layers: **memory cache** for fast revisit (lost on process death); **disk last-known-good** for offline/5xx/parse fail (TTL + version stamp — stale content risk); **baked default** in bundle when no cache; **feature-flag kill** to native default if bad schema in wild. Offline shows LKG if fresh enough; else baked default. Never leave header/splash as blank chrome — empty root triggers hard fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metric when fallback used? | `sdui_fallback_used` — know how often CMS/network failed. |
| Personalized header cache? | Key by user/session; clear on logout — don’t leak user A promo to user B. |
| TTL + freshness UX? | Optional “updated earlier” affordance if product wants honesty. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. Walk schema evolution: additive, new type, breaking?
**Answer:**

> **Additive:** optional `props.subtitle` on existing `promoBanner` — old clients ignore unknown keys; banner still renders. **New type:** `countdownTimer` — old clients skip + metric; new clients register after App Store ships; CMS enables only for builds advertising capability. **Breaking:** renaming `children` to `nodes` without major bump breaks parsers — ship `schemaVersion: 4`, dual-publish v3 and v4, or keep additive shape instead.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Capability negotiation? | Client advertises supported types/features; server targets payloads. |
| iOS/Android parity? | Shared schema spec + contract tests per platform registry — parity is negotiated. |
| Contract test value? | Fixture per schema version catches decode + gate drift in CI. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. How do you test SDUI without combinatorial UITest explosion?
**Answer:**

> Unit: fixture per schema version through gate + parser; registry tests for known types; chaos payload with unknown types asserts no crash; empty-root fixture asserts hard fallback; action allowlist tests for unknown action no-op. Snapshots for critical chrome layouts. Few XCUITest golden paths (launch → header visible). Don’t UITest every CMS combination — combinatorial explosion. Prefer contract tests + skip-path unit tests.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unknown action test? | Assert no-op + metric, no crash. |
| Snapshot scope? | Critical layouts only — not every CMS variant. |
| Main-thread parse test? | Performance budget — large JSON off main. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What is the decision rule card for SDUI?
**Answer:**

> (1) Dynamic content/layout + native quality → SDUI hybrid. (2) Always: version gate + unknown skip + fallback. (3) Actions allowlisted; no script exec. (4) Splash: cache + timeout default. (5) New types need app release — CMS isn’t infinite. (6) Speak BookMyShow backend-driven header & search verified; BookMyShow backend-driven header & search-A1 as design for versioning/fallback discipline.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Full SDUI home? | Super-app velocity vs QA matrix cost — trade-off table. |
| WebView island? | Docs/legal — perf/a11y trade-offs. |
| Backend breaks schema for everyone? | Gate + fallback + canary + kill switch — client must survive (BookMyShow IMOC + crash-free at scale culture). |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q8. Personalized SDUI cache — how do you prevent a privacy leak?
**Answer:**

> Personalized payloads must **not** live in a single global disk slot. Cache keys include **user or session**, and **logout clears** them. Be intentional about what splash or header may contain and how long it persists. Guest versus logged-in variants are different keys. A shared cache is how you leak another user’s promo — or worse — across accounts on a family device.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Multi-user devices? | Clear aggressively on account switch. |
| Encryption at rest? | Consider for sensitive CMS content. |
| Analytics in cache? | Don’t persist PII needlessly. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. How do you keep iOS / Android SDUI parity?
**Answer:**

> Parity is **negotiated**, not hoped. It comes from a **shared schema spec**, **capability negotiation**, and **contract tests in CI** against each platform’s registry. Temporary capability gaps are OK if the server targets correctly. A new component ships in native apps first, then CMS starts using it. Copy-pasting JSON and hoping is how iOS renders a banner Android skips into a lopsided experiment.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Gap communication? | CMS tooling shows support matrix. |
| Version skew? | Dual-publish + min client versions. |
| Design system help? | Shared primitives reduce drift. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-registry-actions-splash.md](03-registry-actions-splash.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What happens at the version gate for each case

**Ask yourself:** What happens at the version gate for each case?

**Answer:** “| Case | Gate | UI |
> |---|---|---|
> | Version within client min/max | accept | Render tree |
> | `payload.version > clientMax` | reject_too_new | FallbackEngine |
> | `payload.version < clientMin` | reject_too_old | Fallback or upgrade UX |
> | Missing version on legacy | documented v1 policy | Treat as legacy default |”

### Puzzle B — What is the unknown-component policy

**Ask yourself:** What is the unknown-component policy?

**Answer:** “Server sends `type: "countdownTimer"` but client registry only knows `{logo, promoBanner, searchEntry}`. **Policy:** skip that node, emit `sdui_unknown_component` metric with type name and schemaVersion, **continue rendering siblings**. Never `fatalError` on CMS strings. New types require an app release to register the factory; until then, skip is the crash-free contract. Server should use capability flags to avoid sending unsupported types when possible.”

### Puzzle C — What does FallbackEngine provide

**Ask yourself:** What does FallbackEngine provide?

**Answer:** “Layers: **memory cache** for fast revisit (lost on process death); **disk last-known-good** for offline/5xx/parse fail (TTL + version stamp — stale content risk); **baked default** in bundle when no cache; **feature-flag kill** to native default if bad schema in wild. Offline shows LKG if fresh enough; else baked default. Never leave header/splash as blank chrome — empty root triggers hard fallback.”
