# 04 — Questions (two-layer) + Two-Layer Scoring

> Part I = warm-up interview Qs (Answer points + Full spoken).  
> Part II = **scoring-layer** questions — how you grade a mock (also two-layer).  
> Totals: **12 normal + 8 tricky** warm-up · **plus** scoring Q set.

---

# Part I — Warm-up (Normal)

### Q1. How do you start any mobile SD interview? `(30–45s)`

**Answer points:** Agenda → clarify scope/scale/offline → confirm.

**Full spoken answer:**
> “I propose a timed agenda — clarify, HLD, API, two deep dives, ops — confirm it matches what they want, then ask scale, offline, and explicit out-of-scope. Drawing silently without a plan is how seniors look junior.”

**Provenance:** Learning-lab · cheatsheet spine

---

### Q2. What scale number do you use? `(30–45s)`

**Answer points:** 30L+ DAU from resume when BMS-like; don’t invent QPS.

**Full spoken answer:**
> “For BMS-like consumer systems I use thirty-plus lakh DAU from my resume. If they demand QPS I derive a labeled estimate from DAU and session assumptions — I never invent a precise fake QPS as fact.”

**Provenance:** Verified · S8 scale context

---

### Q3. Name four HLD layers for SDUI. `(30–45s)`

**Answer points:** CMS → delivery API → parser/registry → renderer/actions.

**Full spoken answer:**
> “CMS or config, a versioned layout API, a client parser plus component registry, and a native renderer with a central action handler and fallbacks. Analytics hooks live on components; unknown types never crash.”

**Provenance:** Verified · S3 · family

---

### Q4. Unknown component type — behavior? `(30–45s)`

**Answer points:** Skip/placeholder; metric; never crash; version strategy.

**Full spoken answer:**
> “Render empty or placeholder, emit a non-fatal metric, continue the tree. Schema versioning and server-side stripping protect older clients. Crashing home on an unknown CMS experiment is unacceptable under a high crash-free bar.”

**Provenance:** How I would apply it · S3-A1

---

### Q5. Where does pinning sit in a networking HLD? `(30–45s)`

**Answer points:** Trust evaluation in session delegate; allowlisted domains; SPKI DER.

**Full spoken answer:**
> “Beneath the API client, inside URLSession’s server-trust challenge. I compare SHA-256 of SPKI DER to embedded pins for allowlisted hosts — not raw SecKey export bytes. On Ads we owned that path after moving to URLSession.”

**Provenance:** Verified · S4 · SPKI correctness

---

### Q6. Which deep dives for networking mock? `(30–45s)`

**Answer points:** Refresh single-flight + pinning/rotation design + cache/observability.

**Full spoken answer:**
> “I’d pick single-flight refresh and SPKI pinning with rotation as design, and if time allows caching or journey p50/p90 observability. Equal time on every box looks shallow — seniors choose hard subsystems.”

**Provenance:** Learning-lab · S4/S5

---

### Q7. Ops metrics at the end? `(30–45s)`

**Answer points:** CFS 99.95%+, journey p50/p90, pin fail / fallback rate, rollout %.

**Full spoken answer:**
> “Crash-free as a reliability bar — ninety-nine point nine five plus at large DAU — journey p50/p90, pin-failure or SDUI fallback rates, and phased rollout percentage with pause ownership. Averages alone don’t close a senior mock.”

**Provenance:** Verified · S5 · S8

---

### Q8. How do modules appear in the diagram? `(30–45s)`

**Answer points:** Features talk to Network/SDUI core via protocols; App wires DI.

**Full spoken answer:**
> “Feature modules depend on protocols — LayoutProviding, APIClient — and the app composition root wires implementations. That keeps Ads pinning ownership and SDUI core replaceable without a monolith import graph.”

**Provenance:** Learning-lab · Day 15 mindset

---

### Q9. When to deep-dive images in SDUI? `(30–45s)`

**Answer points:** Media-heavy layouts; else mention pipeline and move on.

**Full spoken answer:**
> “If layouts are media-heavy I deep-dive downsample and off-main decode. Otherwise I name the image pipeline once and spend dive time on versioning and actions — timeboxed judgment.”

**Provenance:** Learning-lab · Day 16

---

### Q10. Offline for SDUI? `(30–45s)`

**Answer points:** Ask in clarify; cache last-good; stale policy; don’t brick first launch.

**Full spoken answer:**
> “I ask in clarify. Default I’d cache last-good layout with TTL and stale-while-revalidate, and ensure first launch has a native scaffold if cache is empty. Splash can be server-driven for freshness without blocking forever.”

**Provenance:** Verified · S12 · soft

---

### Q11. Idempotency — when? `(30–45s)`

**Answer points:** POST payments/bookings; Idempotency-Key; don’t blind retry.

**Full spoken answer:**
> “Any charge or booking POST needs idempotency keys and status polling discipline — the networking layer must not blindly retry. UX can still show a processing popup while status is uncertain.”

**Provenance:** Verified · S7 · intent (no fake %)

---

### Q12. Avoid turning SD into coding? `(30–45s)`

**Answer points:** Interfaces + data flow first; snippets only for critical APIs.

**Full spoken answer:**
> “I stay on interfaces, data flow, and failure modes. I only sketch code for critical seams — pin challenge, schema enum, refresh actor — and I don’t implement table view cells in a design interview.”

**Provenance:** Learning-lab

---

# Part I — Warm-up (Tricky)

### T1. Interviewer pulls you into pixel UI. `(90–120s)`

**Answer points:** Park pixels; one component example; return to schema/reliability/rollout; timebox 5 min if insisted.

**Full spoken answer:**
> “I’ll park pixel layout, give one component example, and return to schema, reliability, and rollout — those are the senior signals. If they insist on UI I’ll timebox five minutes then resume the agenda.”

---

### T2. “What’s your QPS?” you never measured. `(90–120s)`

**Answer points:** Don’t invent precise QPS; offer DAU; labeled estimate from sessions if needed; refocus on client arch.

**Full spoken answer:**
> “I don’t invent precise QPS. I offer DAU context and, if needed, a transparent estimate from sessions and think time, labeled as an estimate. Then I refocus on client architecture unless they truly want capacity planning.”

---

### T3. They ask both SDUI and pinning in one 45. `(90–120s)`

**Answer points:** Primary + 5-min secondary; or SDUI with security dive (allowlisted actions + pinned config); don’t boil both oceans.

**Full spoken answer:**
> “I’ll propose a primary system and a five-minute secondary, or SDUI with a security deep-dive on allowlisted actions plus a pinned config API. Boiling both oceans fails ops and depth.”

---

### T4. Pinning deep dive becomes cert lecture. `(90–120s)`

**Answer points:** SPKI vs leaf; rotation as design; failure metrics; Ads ownership; stop — no TLS history dump.

**Full spoken answer:**
> “I stay on SPKI versus leaf, rotation timeline as design, failure metrics, and Ads ownership — then stop. TLS history dumps burn the clock.”

---

### T5. SDUI that runs arbitrary native code paths. `(90–120s)`

**Answer points:** Allowlisted components/actions only; versioned schema; kill switch; no script eval.

**Full spoken answer:**
> “Allowlisted components and actions only, versioned schema, kill switch, no script eval. A Turing-complete CMS client is a security incident waiting to happen.”

---

### T6. You forget ops in last 5 minutes. `(90–120s)`

**Answer points:** 60s closer: failures, CFS/p90, flags, phased, IMOC pause; cut dive rather than skip ops.

**Full spoken answer:**
> “I practice a sixty-second closer: failures, CFS and p90, flags, phased rollout, IMOC pause — and I cut the dive short rather than skip ops. Ops is scored.”

---

### T7. “Why not just WebView for SDUI?” `(90–120s)`

**Answer points:** WebView = fast iterate; trade-offs perf/offline/UX/security; hybrid OK some surfaces; native for core chrome; state trade-off.

**Full spoken answer:**
> “WebView iterates fast but trades off performance, offline, platform UX, and security surface. Hybrid can work for some surfaces; native renderer fits core ticketing chrome. I state the trade-off, not a religion.”

---

### T8. Mock partner is silent. `(90–120s)`

**Answer points:** Checkpoint every phase; silence ≠ agreement; ask rather than monologue past misunderstanding.

**Full spoken answer:**
> “I checkpoint every phase — ‘OK to deep-dive refresh next?’ — silence isn’t agreement. I’d rather ask than monologue past a misunderstanding.”

---

# Part II — Two-layer scoring questions

> Use these to **grade yourself** after the live mock. Same shape: Answer points + Full spoken (as if explaining the rubric to a peer coach).

## Scoring Layer A — Structure (how you used the 45 minutes)

### SA1. What does “excellent agenda & clarify” look like? `(45s)`

**Answer points:** States plan; asks scale/offline/in-out; confirms with interviewer; ≤5 min.

**Full spoken answer:**
> “Excellent means you said the plan aloud, asked scale and offline and cut scope explicitly, and got a yes before drawing. Weak is silent boxing or clarifying for fifteen minutes.”

**Rubric pts:** 15 / 100

---

### SA2. What fails HLD clarity? `(45s)`

**Answer points:** Mystery boxes; no data-flow arrows; unreadable layers.

**Full spoken answer:**
> “If a peer can’t narrate request flow from CMS or client to UI, the HLD failed — regardless of how many buzzwords you listed. Arrows and layers beat ornament.”

**Rubric pts:** 20 / 100

---

### SA3. Why is ops weighted even if small minutes? `(45s)`

**Answer points:** Senior judgment; pause criteria; metrics; last 5 min used.

**Full spoken answer:**
> “Ops shows you ship. Ten points isn’t large, but a zero on ops — no metrics, no pause — fails the pass bar even with pretty boxes. I force the last five minutes.”

**Rubric pts:** 10 / 100 · pass needs ops ≥6/10

---

## Scoring Layer B — Content honesty (what you claimed)

### SB1. How do you score production grounding? `(45s)`

**Answer points:** Resume-true hooks; no invented metrics; correct S4 vs S4-A1 / S2 vs S8 labels.

**Full spoken answer:**
> “Full points if SDUI cites S3/S12-style proof or networking cites S4/S5 without fake QPS, and if rotation is labeled design when it is design. Invented metrics or ‘S2 caused CFS’ caps this dimension low.”

**Rubric pts:** 10 / 100

---

### SB2. Deep dive quality — what earns 25? `(45s)`

**Answer points:** 2–3 hard subsystems; trade-offs; failure modes inside dives.

**Full spoken answer:**
> “Excellent dives pick hard seams — unknown components, refresh single-flight, SPKI rotation design — and include failure modes inside the dive, not only happy path. Listing six shallow topics scores poorly.”

**Rubric pts:** 25 / 100

---

### SB3. Two-layer scoring — how do you combine? `(60s)`

**Answer points:** Structure layer + content layer; pass ≥70 with ops ≥6 and no fabricated metrics.

**Full spoken answer:**
> “I score structure — agenda, HLD, API, dives, ops, communication — and content honesty — provenance and technical correctness like SPKI DER — as two layers. Pass Mock #3 at seventy plus with ops at least six out of ten and zero fabricated metrics. A beautiful diagram with fake QPS and no ops still fails.”

---

## Full rubric (100 pts)

| Dimension | Points | Excellent |
|---|---|---|
| Agenda & clarify | 15 | Plan + scale/offline/in-out + confirm |
| HLD clarity | 20 | Layered diagram + data flow |
| API / data model | 15 | Entities + key endpoints + version/pagination |
| Deep dive quality | 25 | 2–3 hard subsystems + trade-offs + failures |
| Production grounding | 10 | Resume-true; correct labels |
| Ops / rollout | 10 | Metrics, flags, phased, pause — last 5 used |
| Communication | 5 | Checkpoints, timeboxes, scope cuts |

**Pass bar:** **≥70** with **ops ≥6/10** and **no fabricated metrics**.

---

## Timed warm-up set

Q1, Q4, Q5 + T3, T6 — then run the full 45-min mock once.
