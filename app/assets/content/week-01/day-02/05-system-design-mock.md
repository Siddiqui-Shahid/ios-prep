# Sample 05 — System-design mock: Server-Driven UI Engine (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer. 
> **Source:** [`ios-system-design/docs/sdui-engine.md`](../../../../ios-system-design/docs/sdui-engine.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md) 
> **Angle:** Day 02 — typed **ComponentRegistry** (POP/generics parallel). 
> **Brain puzzles** at the bottom.

---

### Q1. Interviewer: “Design Server-Driven UI Engine.” How do you open?
**Answer:**

> “I’ll take about five minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API and data, two deep dives on ComponentRegistry and unknown types, and FallbackEngine and schema versioning, and close on failure modes, metrics, and kill switches. Does that work? Then I ask: which surfaces — home header style or entire app shell? DAU and how often layouts refresh? Online-first with last-good disk cache, or offline-first? iOS-only? Unknown component policy — skip versus hard fail? Schema versioning — major mismatch force update? Out of scope: CMS admin UI and executing JS on device? I do not draw until they answer or I state labeled assumptions.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | “Weak senior signal — interviewer may want different dives.” |
| Clarify for 15 min? | “Hard stop at five — park extras as labeled assumptions.” |
| They refuse numbers? | “State labeled estimates from DAU context; continue.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q2. After clarify — what does the optimal flow look like?
**Answer:**

> “Scripted outcomes for this mock: iOS SDUI for CMS-driven surfaces; online-first plus last-good cache; unknown goes to EmptyView; out of scope: CMS admin and client JS. Good flow: agenda, clarify questions, confirm, HLD with four layers plus backend plus load, API, two crisp dives, ops last five. Weak flow: silent drawing, happy-path only, no QPS or TTL, invent metrics, skip ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | “Re-confirm in/out in twenty seconds; adjust dives; protect ops.” |
| Backend mesh deep-dive? | “Out unless asked — sketch touchpoints, stay client-owned.” |
| Forgot to ask offline? | “State online-first plus last-good cache as assumption; invite correction.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q3. Walk the HLD — client layers, backend, load?
**Answer:**

> “Layers: Screen VC or SwiftUI, SDUI ViewModel, Parser Registry LayoutResolver, Network plus FallbackEngine on disk. Backend: CMS to Layout API to CDN or gateway to client. Payload under about fifty KB gzip as a target. Load: refresh TTL for example thirty-six hundred seconds; stale-while-revalidate; don’t refetch every scroll frame. Parse under sixteen milliseconds to avoid hitch.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is type safety? | “Registry maps string type to native builder; unknown types no-crash.” |
| Backend CMS? | “Out — you own client contract plus fallbacks.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q4. Data / API — entities, endpoints, scale?
**Answer:**

> “GET /v1/screens/{screenId} with Client-Version and schema version headers. Tree of components: type, props, children, actions, analytics payload. Nested fetch_more for lists — don’t invent a full scripting language on device.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Breaking schema? | “Major version bump; unsupported goes to cache or force-update screen.” |
| Payload too large? | “Split screens; field-mask; gzip; CDN.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q5. Deep dive 1 — open ComponentRegistry & unknown-type fallback?
**Answer:**

> “Dictionary from type string to AnyView or UIView builder. Missing type returns EmptyView and bumps metric unknown_component. Prefer protocol plus generics for prop decoding where possible — fail soft per node, not the whole tree. That’s the Day 02 parallel: open registry of typed factories, not a forever-closed enum that needs an app release for every CMS experiment. Never crash on unknown — skip the node, keep siblings.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crash on unknown? | “Never — skip node; keep siblings.” |
| POP link? | “Registry as composition of typed factories — Day 02 vocabulary.” |
| Closed enum when? | “Stable tiny set; rare additions — not weekly CMS creatives.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Design if asked:** Unknown-component fallback + versioning — label design when Applied.
- **Don’t claim:** You built the entire CMS.

---

### Q6. Deep dive 2 — FallbackEngine & schema versioning?
**Answer:**

> “On success: write last-good JSON to disk. On network fail: serve disk — under fifty milliseconds as a target. Version gate: skip unsupported majors; remote kill switch returns native scaffold.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty first launch offline? | “Native scaffold plus retry — don’t crash.” |
| Stale layout forever? | “TTL plus force-refresh path; show subtle stale if needed.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q7. Ops — failures, metrics, rollout, load?
**Answer:**

> “Track schema_fetch_latency, cache_hit, unknown_component count, crash-free on SDUI surfaces — as targets or resume-backed numbers, not invented facts. Kill switch: remote config disables SDUI to native. Timeout goes to disk cache.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Force update UX? | “Only on unsupported major — don’t brick minors.” |
| Relate production? | “Backend-driven header and Aces splash — design judgment plus verified hooks.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.

---

### Q8. Flow scorecard — did you hit the optimal spine?
**Answer:**

> “Pass bar: clarify plus agenda in five minutes or less; HLD shows four layers plus backend plus load; API has cursors or idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite or decode; inventing QPS as fact; never reaching ops; blob architecture with no data flow. Spine: zero to five clarify, five to fifteen HLD, fifteen to twenty-five API, twenty-five to forty dives, forty to forty-five ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | “Park dive 2 bullets; protect ops five minutes.” |
| Forgot load? | “One sentence: DAU to labeled QPS, cursor cost, single-flight.” |
| Invented crash-free %? | “Forbidden — use resume-backed numbers or label as target.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

---

### Q9. Tie SDUI back to Day 02 Ads vocabulary in 20s?
**Answer:**

> “Ads day taught capability protocols and generics for a typed pipeline. SDUI’s ComponentRegistry is the same instinct at CMS scale — typed factories, open registration, unknown fallback instead of a fragile closed enum. I still keep Ads plus HeroWidget as the Day 02 production spine unless they asked for SDUI.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Steal Ads credit? | “No — SDUI is the mock; Ads is the verified revenue story.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow backend-driven header & search
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Closed enum forever

Product: “Just switch on component type — we’ll never have more than five.”

**Ask:** What breaks when CMS ships a sixth type next week?

**Answer:** App release dependency. Prefer open ComponentRegistry with unknown → EmptyView + metric. Closed enum only for a truly stable tiny set.

---

### Puzzle B — Crash on unknown

Engineer: “Fail the whole screen if we see an unknown type — safer.”

**Good reply:** “No — skip the node, keep siblings, emit unknown_component. Hard-failing the tree turns CMS experiments into outages.”

---

### Puzzle C — Silent drawing, no ops

You spent forty minutes on pretty boxes and never said kill switch or cache.

**Ask:** What’s missing for senior bar?

**Answer:** Ops last five: latency, cache hit, unknown count, kill switch to native, timeout → disk. Agenda + clarify up front. Pretty boxes without failure modes fail the scorecard.

---

Next: [06-module-drills.md](06-module-drills.md)
