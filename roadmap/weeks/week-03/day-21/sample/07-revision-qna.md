# Sample 07 — Revision Q&A (day-21) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What is Mock #3’s timeboxed spine?
**Answer:**

> **45 minutes total:** 
> 0–5 min → **CLARIFY** (scope, scale, offline, in/out) 
> 5–15 min → **HLD** (4-layer diagram + data flow) 
> 15–25 min → **DATA/API** (entities, endpoints, pagination/versioning) 
> 25–40 min → **DEEP DIVE** (2–3 hardest subsystems) 
> 40–45 min → **OPS** (failures, metrics, rollout, pause) 
> Staff opener: “I’ll spend ~5 minutes on scope and scale, then architecture, then deep-dive X and Y — does that match?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ops optional? | **No** — ops is scored; cut dive short rather than skip. |
| Checkpoint each phase? | Yes — silence ≠ agreement. |
| 2× budget on one section? | Self-correct in one sentence; still scored on recovery. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Which two prompts — pick how?
**Answer:**

> **Prompt A — SDUI engine:** CMS → API → parser/registry → renderer → actions/cache. 
> **Prompt B — Networking + SSL pinning:** Features → APIClient → interceptors → URLSession pin → cache/Keychain. 
> **Live mock: coin flip ONE.** Skim the other after. Both full scripts live in [`02-deep-dive.md`](../02-deep-dive.md).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer asks both in 45? | Primary + 5-min secondary — or SDUI + security dive on allowlisted actions. |
| Which is “easier”? | Pick the one you can ground in resume proof (BookMyShow backend-driven header & search/Audio streaming + server-driven splash (Aces) vs BookMyShow SSL pinning + URLSession migration/BookMyShow Firebase Performance traces). |
| Code sketches? | Optional [`code/SDUISketch.swift`](../code/SDUISketch.swift) and [`NetworkPinSketch.swift`](../code/NetworkPinSketch.swift) — whiteboard crutches only. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search; BookMyShow SSL pinning + URLSession migration; BookMyShow Firebase Performance traces
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q3. How do you run the live mock (Exercise 4)?
**Answer:**

> 1. Coin flip Prompt A or B. 
> 2. Timer **45:00**. Blank paper only — **no notes**. 
> 3. **Record audio** + photo of diagram. 
> 4. **Force ops in final 5:00.** 
> 5. Score with Part II rubric in [`07-revision-qna.md`](07-revision-qna.md) — be harsh.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Script rehearsal first? | Exercise 2: read aloud one full script 30–40 min while drawing. |
| Lightning alternate? | Exercise 5: other prompt — clarify + HLD + one dive + ops (20 min). |
| Pass checklist? | ≥70 total, ops ≥6/10, no fabricated metrics, provenance labels correct. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What communication habits score senior?
**Answer:**

> **Checkpoint each phase** — “OK to deep-dive refresh next?” 
> **Cut dive to save ops** — ops is scored. 
> **Negotiate** if asked both prompts — primary + secondary. 
> **Interfaces over code dumps** — sketch pin challenge, schema enum, refresh actor — not table view cells.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Silent interviewer? | Ask rather than monologue past misunderstanding — T8 in 07-revision-qna. |
| Pulled into pixel UI? | Park pixels; one component example; return to schema/reliability — timebox 5 min. |
| End on class diagram? | **Anti-pattern** — close on failures + SLIs + pause. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What should you rehearse before the timed mock?
**Answer:**

> **Exercise 1 (5 min):** recite spine + both agenda openers (SDUI + Networking). 
> **Exercise 2 (30–40 min):** read aloud **one** full script from 02 while drawing. 
> **Exercise 3 (10 min):** skim code sketches — interfaces only. 
> Do **not** look at notes during the live 45-min mock.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Both scripts memorize? | One cold; skim the other post-mock. |
| Draw every time? | Muscle memory for layer boxes and arrows. |
| Voice rest? | After-action says rest voice — mock is vocal. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What are shared anti-patterns for both prompts?
**Answer:**

> Don’t: draw buttons 20 min · invent QPS · skip ops · claim Design: pin rotation / break-glass (not shipped runbook) runbook shipped · claim BookMyShow synchronised dictionaries = 99.95% CFS · hash SecKey as SPKI · end on class diagram only. 
> Do: failures + SLIs + pause in last 5 min · resume-true metrics · correct provenance labels.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent QPS? | Offer 30L+ DAU; labeled estimate if forced — transparent assumptions. |
| BookMyShow synchronised dictionaries in networking mock? | Path-scoped token races only — not sole CFS owner. |
| Averages in ops? | Use **p50/p90** journeys — BookMyShow Firebase Performance traces culture. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow SSL pinning + URLSession migration; BookMyShow Firebase Performance traces
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. After-action — what do you log?
**Answer:**

> Top 3 misses → flashcards / Week 4 Day 27. Self-review: **p50/p90 said?** rotation labeled design? unknown component handled? **fabricated metrics?** Rest voice. Pass requires ≥70, ops ≥6/10, zero fake numbers, SPKI ≠ SecKey, Design: pin rotation / break-glass (not shipped runbook) ≠ “shipped runbook.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Timed warm-up before mock? | 07-revision-qna: Q1, Q4, Q5 + T3, T6 — then full 45. |
| Week 4 link? | Day 27 gap logging from after-action. |
| Next sample topic? | Clarify phase — [02-clarify-phase.md](02-clarify-phase.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

Next: [02-clarify-phase.md](02-clarify-phase.md)

---

### Q8. How do you start any mobile SD interview?
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

### Q9. What scale numbers can you use honestly?
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

### Q10. What do you cut from scope by default?
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

### Q11. SDUI clarify script — what do you say?
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

### Q12. Networking + pinning clarify script?
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

### Q13. What do you ask about offline during clarify?
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

### Q14. How is clarify scored?
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

### Q15. SDUI action routing — worked deep-dive answer?
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


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “What is Mock #3’s timeboxed spine?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “45 minutes total: 0–5 min → CLARIFY (scope, scale, offline, in/out) 5–15 min → HLD (4-layer diagram + data flow) 15–25 min → DATA/API (entities, endpoints, pagination/versioning) 25–40 min → DEEP DIVE (2–3 hardest subsystems) 40–45 min → OPS (failures, metrics, rollout, pause) Staff opener: “I’ll spend ~5 minutes on scope and scale, then architecture, then deep-dive X and Y — does that match?”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is Mock #3’s timeboxed spine |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “Which two prompts — pick how” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Prompt A — SDUI engine: CMS → API → parser/registry → renderer → actions/cache. Prompt B — Networking + SSL pinning: Features → APIClient → interceptors → URLSession pin → cache/Keychain. Live mock: coin flip ONE. Skim the other after. Both full scripts live in 02-deep-dive.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Which two prompts — pick how |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “How do you run the live mock (Exercise 4)”. How do you diagnose? `(60–90s)`
**Answer:**

> “1. Coin flip Prompt A or B. 2. Timer 45:00. Blank paper only — no notes. 3. Record audio + photo of diagram. 4. Force ops in final 5:00. 5. Score with Part II rubric in 07-revision-qna.md — be harsh.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you run the live mock (Exercise 4) |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “What communication habits score senior”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “Checkpoint each phase — “OK to deep-dive refresh next?” Cut dive to save ops — ops is scored. Negotiate if asked both prompts — primary + secondary. Interfaces over code dumps — sketch pin challenge, schema enum, refresh actor — not table view cells.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What communication habits score senior |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “What should you rehearse before the timed mock”? `(60–90s)`
**Answer:**

> “Exercise 1 (5 min): recite spine + both agenda openers (SDUI + Networking). Exercise 2 (30–40 min): read aloud one full script from 02 while drawing. Exercise 3 (10 min): skim code sketches — interfaces only. Do not look at notes during the live 45-min mock.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What should you rehearse before the timed mock |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “What are shared anti-patterns for both prompts” and how you’d correct it? `(60–90s)`
**Answer:**

> “Don’t: draw buttons 20 min · invent QPS · skip ops · claim Design: pin rotation / break-glass (not shipped runbook) runbook shipped · claim BookMyShow synchronised dictionaries = 99.95% CFS · hash SecKey as SPKI · end on class diagram only. Do: failures + SLIs + pause in last 5 min · resume-true metrics · correct provenance labels.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What are shared anti-patterns for both prompts |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “After-action — what do you log?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “Top 3 misses → flashcards / Week 4 Day 27. Self-review: p50/p90 said? rotation labeled design? unknown component handled? fabricated metrics? Rest voice. Pass requires ≥70, ops ≥6/10, zero fake numbers, SPKI ≠ SecKey, Design: pin rotation / break-glass (not shipped runbook) ≠ “shipped runbook.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | After-action — what do you log |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “How do you start any mobile SD interview” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Propose a timed agenda — clarify, HLD, API, two deep dives, ops — confirm it matches what they want. Then ask scale, offline, explicit out-of-scope. Drawing silently without a plan is how seniors look junior. Target ≤5 minutes for clarify.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you start any mobile SD interview |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. They push you to invent a metric you don’t have? `(90–120s)`
**Answer:**

> “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
