# 02 — Deep Dive: Full 45-Min Scripts (SDUI OR Networking+Pinning)

> Both scripts are fully written. **Live mock: pick ONE.** Skim the other after.  
> Speak naturally — these are target narratives, not teleprompter robots.

---

# PROMPT A — SDUI Engine (full script)

## A0. Clarify (0–5)

**Say:**

> “I’ll design an iOS server-driven UI engine for CMS-driven home surfaces — header, splash-style screens, modular sections — not a full web CMS admin and not Android unless you want parity notes. Scale context from my work: consumer apps around thirty-plus lakh DAU. I’ll assume online-first with last-good cache unless you want offline-first. Out of scope unless you pull me in: ML ranking, pixel-perfect design-tool export, and arbitrary script execution on device. Deep dives I’ll prioritise: schema versioning with unknown-component fallback, and action routing. Ops at the end with flags and crash-free pause criteria. Does that match?”

**Listen / adjust** offline, in/out, which deep dives.

---

## A1. HLD (5–15)

**Draw & narrate:**

```text
CMS / Config service
        ↓
 Layout API (versioned JSON)
        ↓
iOS: Network client (pinned if config is sensitive)
        ↓
 Schema parser  →  ComponentRegistry  →  Renderer (UIKit/SwiftUI)
        ↓                ↓
   Fallback/cache    ActionHandler → DeepLinkRouter / API / analytics
```

**Say:**

> “CMS authors layouts as a component tree — type, props, optional action, analytics map. The client owns the design system pixels. Parser validates version. Registry maps type strings to native components; unknown types become empty or placeholder with a non-fatal metric — never crash. Actions go through a central handler with an allowlist — deeplink, api_call, open_web — no eval. FallbackEngine serves last-good layout from disk when network fails. I’ve shipped protocol-driven backend headers and search modernisation at BookMyShow, and server-driven splash on Aces — same family of problems: versioning, fallbacks, and not trusting the payload blindly.”

**Provenance hooks:** Verified · S3 · S12 (soft). Optional S6 as “lightweight surface” beat only if time.

---

## A2. Data / API (15–25)

**Entities:**

```text
Layout { id, version, screenId, components: [Component], etag? }
Component { type, id, props, children?, action?, analytics? }
Action { type: deeplink|api_call|web, payload }
```

**Endpoints (example):**

```text
GET /v1/layouts/{screenId}?version=clientMax
  Headers: X-Client-Schema: 3
  Response: Layout JSON (<~50KB gzip target mindset)
```

**Say:**

> “Client sends its max supported schema version. Server may strip unknown newer components for older clients. Pagination belongs inside list components via cursor fetch_more — not usually the whole screen. I’ll keep payloads lean; parse belongs off the critical path if heavy, with a frame-budget mindset so we don’t hitch.”

---

## A3. Deep dive 1 — Versioning + unknown component (25–33)

**Say:**

> “Two version axes: layout content version and schema major. If major is unsupported, I serve disk cache or prompt force-update depending on product. Unknown component types must not crash — EmptyView or placeholder, log non-fatal, metric `sdui_unknown_type`. That’s how you keep crash-free while CMS ships experiments. Backend can also strip components the client can’t render. The failure mode I refuse is ‘JSON decode fails entire home to white screen.’”

---

## A4. Deep dive 2 — Action routing (33–40)

**Say:**

> “Actions are data, not code. Allowlisted types only. Deeplink actions enter the same DeepLinkRouter as Universal Links and push — one table — so CMS can’t invent a second navigation world. Sensitive routes still auth-gate. Analytics maps on components let PM change event names without an app release. Kill switch via remote config disables SDUI surfaces and falls back to native scaffolding.”

---

## A5. Ops (40–45)

**Say:**

> “Failure modes: schema incompatibility, CDN/API down, poison layout, unknown-type spikes. Metrics: layout fetch p50/p90, fallback hit rate, unknown-type rate, crash-free sessions — we sustain ninety-nine point nine five plus at large DAU as an ops bar — and journey traces on home. Rollout: flag the new renderer, phased release, pause if CFS or p90 cliffs. IMOC owns stop criteria during peak traffic.”

**Checkpoint:** “Happy to go deeper on caching or image pipeline if you want.”

---

# PROMPT B — Networking + SSL Pinning (full script)

## B0. Clarify (0–5)

**Say:**

> “I’ll design a first-party iOS networking layer with auth and SSL pinning for a high-traffic consumer app — think ads or checkout-adjacent APIs. Scale: thirty-plus lakh DAU context. Out of scope unless asked: full backend service mesh, Android parity. Deep dives: single-flight token refresh, and SPKI pinning with rotation as design. I’ll close on observability with p50/p90 and failure modes. Match?”

---

## B1. HLD (5–15)

**Draw & narrate:**

```text
Feature modules
    ↓ (protocols)
APIClient (endpoint → build → intercept → execute → decode → map errors)
    ↓
Interceptors: Auth, Retry, Tracing
    ↓
URLSession + Delegate (server trust / SPKI pin) + Domain allowlist
    ↓
URLCache / App cache   |   Token store (Keychain)   |   Reachability / offline queue
```

**Say:**

> “I prefer URLSession over Alamofire when we need ownership of trust challenges — that’s exactly what we did on BookMyShow Ads: migrated to URLSession with HTTPS, SSL pinning, and domain whitelisting on a revenue-critical module. Features never see Alamofire types. Errors become a typed NetworkError. Tokens live in Keychain, not UserDefaults.”

> **Provenance:** Verified · S4

---

## B2. Data / API (15–25)

**Say:**

> “APIEndpoint protocol with path, method, headers, body, requiresAuth, associated Response: Decodable. Client exposes request(_:) async throws. HTTP 401 triggers refresh coordinator. Retry only transient 408/429/5xx on idempotent GETs with backoff and jitter — never blind retry charge POSTs without idempotency keys. Tracing uses URL templates to protect cardinality.”

---

## B3. Deep dive 1 — Single-flight refresh (25–33)

**Say:**

> “N parallel 401s must not start N refreshes. An actor owns refresh: first caller starts; others await the same result; success updates Keychain and retries once; failure fans out to logout. I don’t mutate actor state inside an unstructured Task body. If we discuss shared token maps historically, we serialised dictionary access with GCD on that path — today I’d evaluate an actor for greenfield — and I won’t claim that alone owned crash-free.”

> **Provenance:** Learning-lab refresh · Verified · S2 bounded · not sole CFS

---

## B4. Deep dive 2 — SPKI pinning + rotation design (33–40)

**Say:**

> “Pinning happens in the URLSession server-trust challenge. I pin SHA-256 of the certificate’s Subject Public Key Info DER — true SPKI — not SecKeyCopyExternalRepresentation raw bytes, which is a common mistake. Domain allowlist limits hosts. For Ads we shipped pinning; for rotation I insist on backup pins, ship client before server key rotate, staged exposure, and a monitored break-glass — that’s design judgment, not me claiming I shipped the full ops runbook. Sensitive hosts fail closed on mismatch.”

> **Provenance:** Verified · S4 · How I would apply it · S4-A1 · SPKI correctness

---

## B5. Ops (40–45)

**Say:**

> “Failures: pin mismatch outage, refresh stampede, poison cache, TLS middleboxes. Metrics: journey p50/p90 from Firebase Performance style traces — listing, checkout, search is what we instrumented — pin failure rate, 401/refresh rate, crash-free. Rollout: flag networking changes, phased release, pause on CFS or p90 regressions. Pin emergencies use break-glass design carefully — never silent forever-off.”

> **Provenance:** Verified · S5 · S8 ops culture

---

# Shared trade-offs (use live)

| Choice | When | Cost |
|---|---|---|
| SDUI for header/splash | Fast content iteration | Schema + fallbacks |
| Native-only UI | Unique interactive UX | App release per change |
| Hard-fail pinning | Sensitive APIs | Outage if rotation weak |
| Soft-fail pinning | Low sensitivity | Silent security regression |
| Cursor pagination | Feeds | Slightly harder clients |
| Journey traces | Product SLIs | Need clear start/stop |

---

# Anti-patterns (both)

| Don’t | Do |
|---|---|
| Draw buttons for 20 minutes | Park UI; return to schema/reliability |
| Invent QPS | DAU + labeled estimates |
| Skip ops | Force last 5 minutes |
| Claim S4-A1 runbook shipped | Label design |
| Claim S2 = 99.95% CFS | Path contribution only |
| Hash SecKey as SPKI | SPKI DER |
| End on class diagram | Failures + SLIs + pause |
