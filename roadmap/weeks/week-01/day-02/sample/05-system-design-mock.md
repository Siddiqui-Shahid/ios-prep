# Sample 05 — System-design mock: Server-Driven UI Engine (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/sdui-engine.md`](../../../../ios-system-design/docs/sdui-engine.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 02 — typed **ComponentRegistry** (POP/generics parallel).

---

### Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **ComponentRegistry & unknown types** and **FallbackEngine & schema versioning**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Which surfaces — home header/splash-style screens, or entire app shell?
> 2. DAU / how often layouts refresh from CMS?
> 3. Online-first with last-good disk cache, or offline-first?
> 4. iOS-only?
> 5. Unknown component policy — skip vs hard fail?
> 6. Schema versioning — major mismatch force update?
> 7. Out of scope: CMS admin UI and executing JS on device?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** iOS SDUI for CMS-driven surfaces; online-first + last-good cache; unknown → EmptyView; out: CMS admin, client JS.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> **Layers:** Screen VC/SwiftUI → SDUI ViewModel → Parser/Registry/LayoutResolver → Network + FallbackEngine disk.
> **Backend:** CMS → Layout API → CDN/gateway → client. Payload <50KB gzip target.
> **Load:** `refresh_ttl` e.g. 3600s; stale-while-revalidate; don’t refetch every scroll frame. Parse <16ms to avoid hitch.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is type safety? | Registry maps string type → native builder; unknown types no-crash. |
| Backend CMS? | Out — you own client contract + fallbacks. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> `GET /v1/screens/{screenId}` with Client-Version / schema version headers.
> Tree of components: type, props, children, actions, analytics payload.
> Nested `fetch_more` for lists — don’t invent a full scripting language.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Breaking schema? | Major version bump; unsupported → cache or force-update screen. |
| Payload too large? | Split screens; field-mask; gzip; CDN. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q5. Deep dive 1 — ComponentRegistry & unknown types?

**Answer:**

> Dictionary type → `AnyView`/UIView builder. Missing type → EmptyView + metric `unknown_component`.
> Prefer protocol + generics for prop decoding where possible — fail soft per node, not whole tree.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crash on unknown? | Never — skip node; keep siblings. |
| POP link? | Registry as composition of typed factories — Day 02 vocabulary. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q6. Deep dive 2 — FallbackEngine & schema versioning?

**Answer:**

> On success: write last-good JSON to disk. On network fail: serve disk (<50ms target).
> Version gate: skip unsupported majors; remote kill switch → native scaffold.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty first launch offline? | Native scaffold + retry — don’t crash. |
| Stale layout forever? | TTL + force-refresh path; show subtle stale if needed. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> schema_fetch_latency, cache_hit, unknown_component count, crash-free on SDUI surfaces.
> Kill switch: remote config disables SDUI → native. Timeout → disk cache.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Force update UX? | Only on unsupported major — don’t brick minors. |
| Relate production? | BookMyShow backend-driven header & search / Aces splash — design judgment + verified hooks. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

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

