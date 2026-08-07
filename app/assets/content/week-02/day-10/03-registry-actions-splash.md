# Sample 03 — Registry, actions, and cold start (Q&A)

> Guided teaching. Component registry rules, action security, and splash cold-start policy.

---

### Q1. What are the design rules for a ComponentRegistry?

**Answer:**

> (1) **Fail soft on unknown** — never crash on CMS type strings. (2) **Validate known props strictly** — bad props on a known type: skip node or safe defaults — pick one policy and stay consistent. (3) **Stable identity** — server `id` on nodes for SwiftUI identity and analytics. (4) **Keep leaves dumb** — registry returns views; ViewModel owns payload lifecycle. (5) **Ownership** — app-specific header components in app module; shared primitives in UI kit with clear public API (Stories SDK (Raw / Miami Heat) SDK lesson).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Example skip in tree? | `sparkle_v9` skipped; logo + promoBanner still render. |
| `fatalError` in factory? | Forbidden — skip + metric instead. |
| See code? | [ComponentRegistry.swift](../code/ComponentRegistry.swift) learning-lab. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. How do allowlisted actions work?

**Answer:**

> Server sends `action: { type, payload }`. `ActionHandler` checks type against allowlist — unknown types: metric + no-op, no crash. Known types validate payload: deeplink schemes for `open_deeplink`, HTTPS + domain policy for `open_url`, refresh triggers re-fetch. **Never** execute `custom_js` or arbitrary scripts. Auth-sensitive actions re-check client-side. Tie to Day 09 whitelist mindset for URLs that leave the app.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metric for bad action? | `sdui_unknown_action`. |
| `open_deeplink`? | App schemes only; router owns nav (Hybrid UI / deeplinks). |
| Analytics in CMS payload? | Validate event names; refuse unchecked PII from CMS. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What is BMS-style header component inventory thinking?

**Answer:**

> Types like `logo`, `citySelector`, `promoBanner`, `searchEntry`, `navIcons` map to native responsibilities. Skip impact varies: missing **logo** at root is high — may trigger hard fallback; **promoBanner** skip is low. **searchEntry** skip medium — provide native default search affordance. BookMyShow backend-driven header & search: protocol-driven generalised main-screen header from backend/CMS so many layout/content changes skip App Store — registry + fail-soft is how that stays crash-safe.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Search MVVM sibling? | Day 08 — debounce/cancel on search surface; header is SDUI beat. |
| New component type? | App release to register — CMS can’t invent native types without client. |
| Limits of SDUI? | Not infinite flexibility — types need client support. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What is the Aces splash cold-start checklist?

**Answer:**

> Verified **Audio streaming + server-driven splash (Aces):** server-driven splash for cold-start flexibility/freshness alongside audio streaming — **no invented milliseconds**. Design checklist: prewarm/read disk cache on launch; network fetch with **short timeout** → default if slow; minimum viable tree (logo/brand) if partial skip; don’t serialize audio init and splash network on one blocking main-thread chain; measure **time-to-interactive**, not only first frame. Startup is a product surface — cached splash with timeout-to-default beats blocking on perfection.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metric `sdui_splash_source`? | cache \| network \| default — know what users saw. |
| Seasonal art unknown type? | Skip skippable art; keep brand minimum. |
| Legal/age gate? | Prefer native if product-required. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How do analytics work safely in SDUI payloads?

**Answer:**

> Server may attach `analytics: { event, params }`. Client validates event names against allowlist or prefix rules, injects common context (screen, app version, bucket), and **refuses unchecked PII** from CMS. Don’t treat CMS as a raw logging pipe — same discipline as network logging (no secrets/PII dumps). Unknown analytics keys should fail safe, not crash.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trust CMS for event names? | No — allowlist or prefix validation. |
| Skip metrics vs analytics? | `sdui_unknown_component` is ops signal; product analytics still gated. |
| Double logging? | Inject context once — avoid duplicate fire on re-render. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. How does SDUI relate to feature flags and A/B?

**Answer:**

> **Feature flag:** toggles code path on/off. **A/B:** assigns variant bucket. **SDUI:** layout/content via payload. Often combined: flag enables SDUI surface; CMS/A/B supplies variant layout. Parity across iOS/Android needs shared schema spec, capability negotiation, contract tests per registry, and server targeting — don’t send iOS-only types to old Android builds blindly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Kill switch? | Feature flag back to native default — part of BookMyShow backend-driven header & search-A1 design. |
| Canary payload? | % expose new schema before full rollout. |
| Contract tests in CI? | Catch platform drift early. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What performance notes matter for SDUI on iOS?

**Answer:**

> Parse **off main** when payloads grow. Budget interaction frames; prewarm splash cache on launch path. Incremental render if tree is large. Image props still use bounded image pipeline — SDUI doesn’t bypass Week 3 perf rules. Parser-on-main dropping frames is an NFR bug, not “JSON’s fault.” Splash prioritizes fast **safe paint** over perfect freshness when network is slow.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty splash after slow network? | Timeout → baked default — never infinite spinner on launch. |
| Large header tree? | Incremental render or flatten where product allows. |
| Whiteboard script? | Schema → gate → registry → actions → fallback; map BMS + Aces. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Where should the component registry live — app or SDK?

**Answer:**

> Put specificity with ownership. **App-specific** header components live in the **app module** with protocol hooks. A shared SDK can own common primitives — text, stack, image — if versioned cleanly. The Stories SDK lesson (Stories SDK (Raw / Miami Heat)) applies: public API and independence matter when multiple apps share code. Don’t shove every BMS-only promo widget into a portfolio SDK.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Stories SDK (Raw / Miami Heat) crossover? | Modularity + versioning of the public surface. |
| Header registry default? | Likely app module — BMS-specific types. |
| Absolute one place forever? | Wrong — specificity drives ownership. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [04-production-s3-s12.md](04-production-s3-s12.md)

---

