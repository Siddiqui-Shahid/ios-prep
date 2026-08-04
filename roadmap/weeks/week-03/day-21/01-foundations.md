# 01 — Foundations: 45-Minute Mobile System Design

---

## 0. North star

**Timebox ruthlessly: clarify, draw a readable HLD, define API/data, deep-dive 2–3 hard subsystems, close on ops — grounded in real production proof.**

---

## 1. Universal spine (memorize)

```text
0–5 min   → CLARIFY:    Scope (in/out), scale (DAU), offline?, platform?
5–15 min  → HLD:        4-layer diagram + data flow
15–25 min → DATA/API:   Entities, endpoints, pagination/versioning
25–40 min → DEEP DIVE:  2–3 hardest subsystems (you choose)
40–45 min → OPS:        Failures, metrics, rollout, flags, pause criteria
```

**Staff/EM opener:**  
> “I’ll spend ~5 minutes on scope and scale, then a full architecture pass, then deep-dive X and Y — does that match what you want?”

---

## 2. Clarify checklist (resume-true numbers only)

| Ask | Your honest anchor |
|---|---|
| Platform | iOS (SwiftUI/UIKit as relevant) |
| Scale | **30+ lakh DAU** when BMS-like |
| Reliability | **99.95%+ CFS** as ops constraint when rollout discussed |
| Offline? | Ask — don’t assume |
| In/out | Cut web admin, Android, ML ranking unless asked |

**Trap:** Invent precise QPS. If forced to estimate, label assumptions transparently.

---

## 3. Pick one primary prompt (coin flip live)

### Prompt A — SDUI engine

**HLD layers:** CMS/config → API → schema parser → component registry → renderer → actions/analytics → fallbacks/cache

**Strong deep dives (pick 2–3):**
1. Schema versioning + unknown component fallback  
2. Action routing / navigation (Day 20)  
3. Caching & freshness of layout JSON  
4. Performance — parse budget, images, p50/p90 (Day 17)  
5. Security — allowlisted actions (no arbitrary script)

**Agenda script (SDUI):**  
> “Scope an iOS SDUI engine for CMS-driven home surfaces at ~30L DAU. I’ll do HLD, schema/API, then deep-dive versioning/fallbacks and action routing, and close on rollout metrics.”

### Prompt B — Networking + SSL pinning

**HLD layers:** Features → API client → interceptors → URLSession → pin/trust → cache → offline/reachability

**Strong deep dives (pick 2–3):**
1. Auth refresh single-flight + 401  
2. SPKI pinning + rotation/break-glass **design (S4-A1)**  
3. Caching / idempotency for POSTs  
4. Observability — journey p50/p90 (S5)  
5. Modular Ads client ownership (S4)

**Agenda script (Networking):**  
> “Scope a networking layer with auth and SSL pinning for a high-traffic iOS app. I’ll do HLD, API/error model, then deep-dive token refresh and pin rotation, and close on observability and failure modes.”

Full spoken walkthroughs: [`02-deep-dive.md`](02-deep-dive.md).

---

## 4. Ops closer (both prompts — last 5 min)

Always hit:

- Failure modes (schema fail / pin fail / CDN down)
- Metrics: CFS, journey p90, pin fail rate, SDUI fallback rate
- Rollout: flags, phased release, IMOC pause
- A/B or Remote Config gates

**60s ops closer template:**  
> “Failures I’d watch: X and Y. Metrics: crash-free, journey p90, Z rate. Rollout behind flags with phased release and pause if CFS or p90 cliffs — IMOC owns the stop.”

---

## 5. Communication habits

| Habit | Why |
|---|---|
| Checkpoint each phase | Silence ≠ agreement |
| Cut dive short to save ops | Ops is scored |
| Negotiate if asked both prompts | Primary + 5-min secondary |
| Interfaces over code dumps | Senior signal |

---

## 6. Teach-back

1. Spine timings  
2. Two agenda scripts  
3. Resume-only metrics discipline  
4. Ops never optional  

Next: full scripts in [`02-deep-dive.md`](02-deep-dive.md).
