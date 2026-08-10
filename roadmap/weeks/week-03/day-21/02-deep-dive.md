# 02 — Deep Dive: Full 45-Min Scripts (SDUI OR Networking+Pinning) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. A0. Clarify (0–5)? `(45–60s)`
**Answer:**

> “Say: > “I’ll design an iOS server-driven UI engine for CMS-driven home surfaces — header, splash-style screens, modular sections — not a full web CMS admin and not Android unless you want parity notes. Scale context from my work: consumer apps around thirty-plus lakh DAU. I’ll assume online-first with last-good cache unless you want offline-first. Out of scope unless you pull me in: ML ranking, pixel-perfect design-tool export, and arbitrary script execution on device. Deep dives I’ll prioritise: schema versioning with unknown-component fallback, and action routing. Ops at the end with flags and crash-free pause criteria. Does that match?”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. A1. HLD (5–15)? `(45–60s)`
**Answer:**

> “Draw & narrate: text CMS / Config service ↓ Layout API (versioned JSON) ↓ iOS: Network client (pinned if config is sensitive) ↓ Schema parser → ComponentRegistry → Renderer (UIKit/SwiftUI) ↓ ↓ Fallback/cache ActionHandler → DeepLinkRouter / API / analytics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q3. A2. Data / API (15–25)? `(45–60s)`
**Answer:**

> “Entities: text Layout { id, version, screenId, components: [Component], etag? } Component { type, id, props, children?, action?, analytics? } Action { type: deeplink web, payload }.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. A3. Deep dive 1 — Versioning + unknown component (25–33)? `(45–60s)`
**Answer:**

> “Say: > “Two version axes: layout content version and schema major. If major is unsupported, I serve disk cache or prompt force-update depending on product. Unknown component types must not crash — EmptyView or placeholder, log non-fatal, metric sdui_unknown_type. That’s how you keep crash-free while CMS ships experiments. Backend can also strip components the client can’t render. The failure mode I refuse is ‘JSON decode fails entire home to white screen.’”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. A4. Deep dive 2 — Action routing (33–40)? `(45–60s)`
**Answer:**

> “Say: > “Actions are data, not code. Allowlisted types only. Deeplink actions enter the same DeepLinkRouter as Universal Links and push — one table — so CMS can’t invent a second navigation world. Sensitive routes still auth-gate. Analytics maps on components let PM change event names without an app release. Kill switch via remote config disables SDUI surfaces and falls back to native scaffolding.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. A5. Ops (40–45)? `(45–60s)`
**Answer:**

> “Say: > “Failure modes: schema incompatibility, CDN/API down, poison layout, unknown-type spikes. Metrics: layout fetch p50/p90, fallback hit rate, unknown-type rate, crash-free sessions — we sustain ninety-nine point nine five plus at large DAU as an ops bar — and journey traces on home. Rollout: flag the new renderer, phased release, pause if CFS or p90 cliffs. IMOC owns stop criteria during peak traffic.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. B0. Clarify (0–5)? `(45–60s)`
**Answer:**

> “Say: > “I’ll design a first-party iOS networking layer with auth and SSL pinning for a high-traffic consumer app — think ads or checkout-adjacent APIs. Scale: thirty-plus lakh DAU context. Out of scope unless asked: full backend service mesh, Android parity. Deep dives: single-flight token refresh, and SPKI pinning with rotation as design. I’ll close on observability with p50/p90 and failure modes. Match?”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. B1. HLD (5–15)? `(45–60s)`
**Answer:**

> “Draw & narrate: text Feature modules ↓ (protocols) APIClient (endpoint → build → intercept → execute → decode → map errors) ↓ Interceptors: Auth, Retry, Tracing ↓ URLSession + Delegate (server trust / SPKI pin) + Domain allowlist ↓ URLCache / App cache Reachability / offline queue.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q9. B2. Data / API (15–25)? `(45–60s)`
**Answer:**

> “Say: > “APIEndpoint protocol with path, method, headers, body, requiresAuth, associated Response: Decodable. Client exposes request(_:) async throws. HTTP 401 triggers refresh coordinator. Retry only transient 408/429/5xx on idempotent GETs with backoff and jitter — never blind retry charge POSTs without idempotency keys. Tracing uses URL templates to protect cardinality.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. B3. Deep dive 1 — Single-flight refresh (25–33)? `(45–60s)`
**Answer:**

> “Say: > “N parallel 401s must not start N refreshes. An actor owns refresh: first caller starts; others await the same result; success updates Keychain and retries once; failure fans out to logout. I don’t mutate actor state inside an unstructured Task body. If we discuss shared token maps historically, we serialised dictionary access with GCD on that path — today I’d evaluate an actor for greenfield — and I won’t claim that alone owned crash-free.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q11. B4. Deep dive 2 — SPKI pinning + rotation design (33–40)? `(45–60s)`
**Answer:**

> “Say: > “Pinning happens in the URLSession server-trust challenge. I pin SHA-256 of the certificate’s Subject Public Key Info DER — true SPKI — not SecKeyCopyExternalRepresentation raw bytes, which is a common mistake. Domain allowlist limits hosts. For Ads we shipped pinning; for rotation I insist on backup pins, ship client before server key rotate, staged exposure, and a monitored break-glass — that’s design judgment, not me claiming I shipped the full ops runbook. Sensitive hosts fail closed on mismatch.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q12. B5. Ops (40–45)? `(45–60s)`
**Answer:**

> “Say: > “Failures: pin mismatch outage, refresh stampede, poison cache, TLS middleboxes. Metrics: journey p50/p90 from Firebase Performance style traces — listing, checkout, search is what we instrumented — pin failure rate, 401/refresh rate, crash-free. Rollout: flag networking changes, phased release, pause on CFS or p90 regressions. Pin emergencies use break-glass design carefully — never silent forever-off.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---
