# Sample 05 — System-design mock: App Modularization & DI (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/app-modularization.md`](../../../../ios-system-design/docs/app-modularization.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 08 — architecture modules (MVVM/Clean parallel).

---

### Q1. Interviewer: “Design App Modularization & DI.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Interface / Impl split** and **Composition-root DI**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Monorepo feature modules or multi-repo?
> 2. SPM only, or CocoaPods mix?
> 3. Build time budget (incremental <30s)?
> 4. DI style — constructor, Needle, Factory?
> 5. Dynamic frameworks limit concern?
> 6. Out: full CI scripts / git branching?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** App→Feature→Domain→Core; Interface vs Impl; composition-root DI; static preferred; out: CI deep dive.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> **Topology:** App composition root wires Feature interfaces; Features depend on Domain protocols; Core = network/storage/design system.
> **No feature→feature Impl deps.** Backend N/A beyond shared Network client.
> **Load/build:** 100–300 modules possible; incremental <30s target; ≤~6 dynamic historically — prefer static.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Clean vs modules? | Modules are boundaries; Clean/MVVM live inside features. |
| Circular deps? | Break with Interface modules — compile-time fail is good. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> Protocol contracts: `CheckoutBuildable`, `CheckoutDependency`. Factory/Needle components at composition root.
> Network as `APIClientProtocol` in Core — features never import URLSession directly if avoidable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Test seams? | Swap Impl in tests via Interface. |
| Binary size? | Track mb; avoid duplicate symbols across dynamics. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).

---

### Q5. Deep dive 1 — Interface / Impl split?

**Answer:**

> FeatureAInterface exposed to App; FeatureAImpl private. Prevents secretly coupled features and speeds compile.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who owns navigation? | App coordinator depends on buildable interfaces. |
| Shared UI kit? | DesignSystem in Core — version carefully. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).

---

### Q6. Deep dive 2 — Composition-root DI?

**Answer:**

> Construct graph once at launch; pass dependencies down. Avoid service locators in features.
> Needle/Factory trees mirror module graph.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Runtime optional deps? | Protocols + null objects; still wired at root. |
| District migration? | Clean/MVVM migration = boundaries + review bar — District Free Parking story. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> build_time_seconds, binary_size_mb, dyld_launch_time. Fail CI on new circular deps.
> Kill: feature flag whole module entry points.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Launch regression? | Fewer dynamics; defer non-critical modules. |
| Sev-1 bad module? | Flag off surface; hotfix train — platform EM vocabulary. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).

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

