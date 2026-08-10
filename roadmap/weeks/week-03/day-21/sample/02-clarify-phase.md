# Sample 02 — Clarify phase (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How do you start any mobile SD interview?
**Answer:**

> Propose a **timed agenda** — clarify, HLD, API, two deep dives, ops — **confirm** it matches what they want. Then ask **scale, offline, explicit out-of-scope**. Drawing silently without a plan is how seniors look junior. Target **≤5 minutes** for clarify.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip confirm step? | Weak — interviewer may want different dives. |
| Clarify for 15 min? | Fails structure rubric — timebox ruthlessly. |
| Solo practice? | Speak agenda aloud; timer 5 min. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What scale numbers can you use honestly?
**Answer:**

> **30+ lakh DAU** when BMS-like consumer context — from resume. **99.95%+ CFS** as ops constraint when rollout discussed (BookMyShow IMOC + crash-free at scale). **Don’t invent precise QPS.** If forced to estimate, label assumptions transparently from DAU and session length — never fake precision as fact.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “What’s your QPS?” never measured | Offer DAU; labeled estimate; refocus on client arch — T2 in 04. |
| Journey metrics? | p50/p90 from BookMyShow Firebase Performance traces — listing, checkout, search instrumented. |
| Fabricate drop-off %? | **Forbidden** — resume-only metrics. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q3. What do you cut from scope by default?
**Answer:**

> Default **out of scope** unless interviewer pulls you in: **web CMS admin**, **Android parity**, **ML ranking**, **pixel-perfect design-tool export**, **arbitrary script execution on device**. Platform: **iOS** (SwiftUI/UIKit as relevant). State cuts explicitly — scope negotiation is senior signal.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They want Android notes? | 5-min parity bullets — don’t boil both oceans. |
| Backend service mesh? | Out for networking mock unless asked — client focus. |
| Admin CMS for SDUI? | Out — you design **client engine**, not editorial UI. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. SDUI clarify script — what do you say?
**Answer:**

> “I’ll design an iOS **server-driven UI engine** for CMS-driven home surfaces — header, splash-style screens — not full web admin. Scale: **~30L DAU** context. Assume **online-first with last-good cache** unless you want offline-first. Deep dives: **schema versioning + unknown-component fallback** and **action routing**. Ops with flags and crash-free pause. **Does that match?**”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Offline-first requested? | Adjust — cache TTL, native scaffold on empty first launch. |
| Which deep dives swap? | Caching/freshness or image pipeline if media-heavy — timebox judgment. |
| Provenance in clarify? | Light hooks OK — BookMyShow backend-driven header & search header/search, Audio streaming + server-driven splash (Aces) splash family. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. Networking + pinning clarify script?
**Answer:**

> “I’ll design a **first-party networking layer** with auth and SSL pinning for high-traffic consumer APIs — ads/checkout-adjacent. Scale: **30L+ DAU**. Out of scope: full backend mesh, Android. Deep dives: **single-flight token refresh** and **SPKI pinning with rotation as design**. Close on **p50/p90 observability**. Match?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Alamofire? | Prefer URLSession when owning trust — BookMyShow SSL pinning + URLSession migration Ads migration proof. |
| Pin all hosts? | No — allowlisted sensitive hosts only. |
| Design: pin rotation / break-glass (not shipped runbook) in clarify? | Mention rotation as **design** — not shipped runbook. |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q6. What do you ask about offline during clarify?
**Answer:**

> **Ask in clarify — don’t assume.** Default: **last-good layout cache** with TTL and stale-while-revalidate; **native scaffold** if cache empty on first launch. Splash can be server-driven for freshness without blocking forever. Networking mock: offline queue + reachability — idempotency on POSTs.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Offline-first product? | Stronger disk cache, sync strategy — still timebox. |
| White screen on decode fail? | **Refuse** — partial render + fallback metric. |
| Charge POST offline? | Queue with idempotency keys — BookMyShow payment processing-status popup intent. |

**How can I relate to my case:**
- **Shipped:** BookMyShow payment processing-status popup
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented checkout drop-off % from the status popup alone.

---

### Q7. How is clarify scored?
**Answer:**

> **Excellent (15 pts):** states plan aloud; asks scale/offline/in-out; gets **yes** before drawing; **≤5 min**. **Weak:** silent boxing or clarifying fifteen minutes. Structure layer — combined with HLD, API, dives, ops for **≥70 pass** with **ops ≥6/10**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mock partner silent? | Checkpoint — “Does this agenda work?” — T8. |
| Jump to diagram early? | Ask permission — agenda first. |
| Action routing dive? | Dedicated Q8 — allowlist + one DeepLinkRouter. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. SDUI action routing — worked deep-dive answer?
**Answer:**

> Actions are **data, not code**. **Allowlisted types only** — CMS cannot invent arbitrary native paths. Deeplink actions enter the **same DeepLinkRouter** as Universal Links and push — **one table** — so CMS doesn’t create a second navigation world. Sensitive routes still **auth-gate**. Analytics maps on components let PM change event names without an app release. **Kill switch** via remote config disables SDUI surfaces and falls back to native scaffolding.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Arbitrary native code from CMS? | Refuse — T5 in 04; allowlist + router only. |
| Sketch? | [`code/SDUISketch.swift`](../code/SDUISketch.swift) — `SDUIActionAllowlist`. |
| Next topic? | Cache & scroll — [03-cache-scroll.md](03-cache-scroll.md). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-cache-scroll.md](03-cache-scroll.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What scale numbers can you use honestly

**Ask yourself:** What scale numbers can you use honestly?

**Answer:** “**30+ lakh DAU** when BMS-like consumer context — from resume. **99.95%+ CFS** as ops constraint when rollout discussed (BookMyShow IMOC + crash-free at scale). **Don’t invent precise QPS.** If forced to estimate, label assumptions transparently from DAU and session length — never fake precision as fact.”

### Puzzle B — What do you cut from scope by default

**Ask yourself:** What do you cut from scope by default?

**Answer:** “Default **out of scope** unless interviewer pulls you in: **web CMS admin**, **Android parity**, **ML ranking**, **pixel-perfect design-tool export**, **arbitrary script execution on device**. Platform: **iOS** (SwiftUI/UIKit as relevant). State cuts explicitly — scope negotiation is senior signal.”

### Puzzle C — SDUI clarify script — what do you say

**Ask yourself:** SDUI clarify script — what do you say?

**Answer:** “I’ll design an iOS **server-driven UI engine** for CMS-driven home surfaces — header, splash-style screens — not full web admin. Scale: **~30L DAU** context. Assume **online-first with last-good cache** unless you want offline-first. Deep dives: **schema versioning + unknown-component fallback** and **action routing**. Ops with flags and crash-free pause. **Does that match?**”
