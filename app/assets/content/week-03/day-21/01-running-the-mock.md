# Sample 01 — Running Mock #3 (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

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
> 5. Score with Part II rubric in [`04-questions.md`](../04-questions.md) — be harsh.

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
| Silent interviewer? | Ask rather than monologue past misunderstanding — T8 in 04-questions. |
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
| Timed warm-up before mock? | 04-questions: Q1, Q4, Q5 + T3, T6 — then full 45. |
| Week 4 link? | Day 27 gap logging from after-action. |
| Next sample topic? | Clarify phase — [02-clarify-phase.md](02-clarify-phase.md). |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

Next: [02-clarify-phase.md](02-clarify-phase.md)

---

