# Sample 02 — Clarify phase (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How do you start any mobile SD interview?

**Points to:** [Foundations · §1 Universal spine](../01-foundations.md#1-universal-spine-memorize) · [04-questions · Q1](../04-questions.md#q1-how-do-you-start-any-mobile-sd-interview-3045s)

**Answer:**

> Propose a **timed agenda** — clarify, HLD, API, two deep dives, ops — **confirm** it matches what they want. Then ask **scale, offline, explicit out-of-scope**. Drawing silently without a plan is how seniors look junior. Target **≤5 minutes** for clarify.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip confirm step? | Weak — interviewer may want different dives. |
| Clarify for 15 min? | Fails structure rubric — timebox ruthlessly. |
| Solo practice? | Speak agenda aloud; timer 5 min. |

---

### Q2. What scale numbers can you use honestly?

**Points to:** [Foundations · §2 Clarify checklist](../01-foundations.md#2-clarify-checklist-resume-true-numbers-only) · [04-questions · Q2](../04-questions.md#q2-what-scale-number-do-you-use-3045s)

**Answer:**

> **30+ lakh DAU** when BMS-like consumer context — from resume. **99.95%+ CFS** as ops constraint when rollout discussed (S8). **Don’t invent precise QPS.** If forced to estimate, label assumptions transparently from DAU and session length — never fake precision as fact.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “What’s your QPS?” never measured | Offer DAU; labeled estimate; refocus on client arch — T2 in 04. |
| Journey metrics? | p50/p90 from S5 — listing, checkout, search instrumented. |
| Fabricate drop-off %? | **Forbidden** — resume-only metrics. |

---

### Q3. What do you cut from scope by default?

**Points to:** [Foundations · §2 Clarify checklist](../01-foundations.md#2-clarify-checklist-resume-true-numbers-only) · [Deep dive · A0 Clarify](../02-deep-dive.md#a0-clarify-05)

**Answer:**

> Default **out of scope** unless interviewer pulls you in: **web CMS admin**, **Android parity**, **ML ranking**, **pixel-perfect design-tool export**, **arbitrary script execution on device**. Platform: **iOS** (SwiftUI/UIKit as relevant). State cuts explicitly — scope negotiation is senior signal.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They want Android notes? | 5-min parity bullets — don’t boil both oceans. |
| Backend service mesh? | Out for networking mock unless asked — client focus. |
| Admin CMS for SDUI? | Out — you design **client engine**, not editorial UI. |

---

### Q4. SDUI clarify script — what do you say?

**Points to:** [Deep dive · A0 Clarify](../02-deep-dive.md#a0-clarify-05) · [Foundations · Prompt A agenda](../01-foundations.md#prompt-a--sdui-engine)

**Answer:**

> “I’ll design an iOS **server-driven UI engine** for CMS-driven home surfaces — header, splash-style screens — not full web admin. Scale: **~30L DAU** context. Assume **online-first with last-good cache** unless you want offline-first. Deep dives: **schema versioning + unknown-component fallback** and **action routing**. Ops with flags and crash-free pause. **Does that match?**”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Offline-first requested? | Adjust — cache TTL, native scaffold on empty first launch. |
| Which deep dives swap? | Caching/freshness or image pipeline if media-heavy — timebox judgment. |
| Provenance in clarify? | Light hooks OK — S3 header/search, S12 splash family. |

---

### Q5. Networking + pinning clarify script?

**Points to:** [Deep dive · B0 Clarify](../02-deep-dive.md#b0-clarify-05) · [Foundations · Prompt B agenda](../01-foundations.md#prompt-b--networking--ssl-pinning)

**Answer:**

> “I’ll design a **first-party networking layer** with auth and SSL pinning for high-traffic consumer APIs — ads/checkout-adjacent. Scale: **30L+ DAU**. Out of scope: full backend mesh, Android. Deep dives: **single-flight token refresh** and **SPKI pinning with rotation as design**. Close on **p50/p90 observability**. Match?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Alamofire? | Prefer URLSession when owning trust — S4 Ads migration proof. |
| Pin all hosts? | No — allowlisted sensitive hosts only. |
| S4-A1 in clarify? | Mention rotation as **design** — not shipped runbook. |

---

### Q6. What do you ask about offline during clarify?

**Points to:** [04-questions · Q10](../04-questions.md#q10-offline-for-sdui-3045s) · [Deep dive · A0](../02-deep-dive.md#a0-clarify-05)

**Answer:**

> **Ask in clarify — don’t assume.** Default: **last-good layout cache** with TTL and stale-while-revalidate; **native scaffold** if cache empty on first launch. Splash can be server-driven for freshness without blocking forever. Networking mock: offline queue + reachability — idempotency on POSTs.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Offline-first product? | Stronger disk cache, sync strategy — still timebox. |
| White screen on decode fail? | **Refuse** — partial render + fallback metric. |
| Charge POST offline? | Queue with idempotency keys — S7 intent. |

---

### Q7. How is clarify scored?

**Points to:** [04-questions · SA1](../04-questions.md#sa1-what-does-excellent-agenda--clarify-look-like-45s) · [04-questions · Full rubric](../04-questions.md#full-rubric-100-pts)

**Answer:**

> **Excellent (15 pts):** states plan aloud; asks scale/offline/in-out; gets **yes** before drawing; **≤5 min**. **Weak:** silent boxing or clarifying fifteen minutes. Structure layer — combined with HLD, API, dives, ops for **≥70 pass** with **ops ≥6/10**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mock partner silent? | Checkpoint — “Does this agenda work?” — T8. |
| Jump to diagram early? | Ask permission — agenda first. |
| Next topic? | Cache & scroll — [03-cache-scroll.md](03-cache-scroll.md). |

---

Next: [03-cache-scroll.md](03-cache-scroll.md)
