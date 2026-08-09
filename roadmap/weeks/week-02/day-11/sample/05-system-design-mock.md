# Sample 05 — System-design mock: Deep Linking & Universal Links (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/deep-linking-universal-links.md`](../../../../ios-system-design/docs/deep-linking-universal-links.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 11 — hybrid UI / deeplink router parallel.

---

### Q1. Interviewer: “Design Deep Linking & Universal Links.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Router + Coordinator** and **Deferred + cold-start queue**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Universal Links + custom schemes both?
> 2. Deferred links after install?
> 3. Cold-start queue required?
> 4. Auth-gated routes?
> 5. Out: push payload design, Android App Links?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** UL + schemes; router+coordinator; cold-start pendingRoute; deferred optional; out: push deep design.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> OS openURL → AppDelegate/Scene → DeepLinkRouter match → Coordinator navigate. If UI not ready (<500ms), queue pendingRoute.
> **Backend:** AASA hosted; deferred fingerprint API.
> **Load:** AASA <128KB; OS caches ~24h; routing <100ms target.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hybrid UIKit/SwiftUI? | One router owns path — Grizzlies interop lesson. |
| Push vs deeplink? | Same router — don’t fork navigation. |

**How can I relate to my case:**
- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> AASA at `/.well-known/apple-app-site-association`. `GET /v1/deep-link/deferred?fingerprint=`.
> Route table: pattern → builder.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unsigned links? | Validate path allowlist; strip dangerous query. |
| AASA fail? | Smart Banner / custom scheme fallback. |

**How can I relate to my case:**
- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.

---

### Q5. Deep dive 1 — Router + Coordinator?

**Answer:**

> Parse URL → typed Route → Coordinator presents. Unknown route → metric + home fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Auth wall? | Queue route post-login. |
| Multiple windows? | Scene-aware routing. |

**How can I relate to my case:**
- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.

---

### Q6. Deep dive 2 — Deferred + cold-start queue?

**Answer:**

> Pending route until root ready; deferred match within ~72h; fail → organic open.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Race login? | Hold route until session. |
| Hijack? | HTTPS UL preferred over custom schemes. |

**How can I relate to my case:**
- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> Open rate, unknown route %, routing latency. Kill: disable deferred; UL only.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | Hybrid UI / deeplinks Verified — Grizzlies. |
| Mixpanel/Airship? | Push taps through same router. |

**How can I relate to my case:**
- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> **Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; API has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics.
> **Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.
> **Spine:** 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | Park dive 2 bullets; protect ops 5 min. |
| Forgot load? | One sentence: DAU → labeled QPS, cursor cost, single-flight. |
| Invented crash-free %? | Forbidden — use resume-backed numbers or label as target. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

