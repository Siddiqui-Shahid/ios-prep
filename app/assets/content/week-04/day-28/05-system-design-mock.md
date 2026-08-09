# Sample 05 — System-design mock: Social Feed (warm retrieval) (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 28 game day — **light retrieval only** (no new HLD from scratch).

---

### Q1. Interviewer: “Design Social Feed (warm retrieval).” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **Cheatsheet spine only** and **Pivot kit**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. Only restate agenda + clarify list — confirm?
> 2. Which prompt might appear — feed / SDUI / networking / on-device AI?
> 3. Ops block still last 5?
> 4. No new diagrams today?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** Warm retrieval: agenda, clarify Qs, spine times, kill-switch reminder. Pivot kit: FinTrack/GymFlow if AI. No new design invention.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> **Do not draw a new full HLD today.** Skim remembered 4 layers + backend touchpoints for the likely prompt.
> If forced: Social Feed one-liner — cursor pages, SQLite last-good, image pipeline, optimistic like — then stop and protect calm.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer asks deep dive? | Park: “I’ll use the standard spine — clarify already done in warmup.” |
| Forgot numbers? | DAU labeled; NFR from cheatsheet — don’t invent. |

**How can I relate to my case:**
- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> Retrieve only: cursor > offset; Idempotency-Key on payments; debounce search; single-flight refresh.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Blank mind? | Speak agenda first — buys 20s. |
| Wrong prompt? | Re-clarify in/out 30s. |

**How can I relate to my case:**
- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.

---

### Q5. Deep dive 1 — Cheatsheet spine only?

**Answer:**

> 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops. Say it once aloud.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip sleep for study? | No — game day rule. |
| Flashcards only? | Yes — stories + openers. |

**How can I relate to my case:**
- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.

---

### Q6. Deep dive 2 — Pivot kit?

**Answer:**

> On-device AI: privacy, local RAG, thermal, fail-soft — FinTrack/GymFlow. Networking: refresh+pin. SDUI: registry+fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| New topic appears? | Clarify hard; use 4 layers; pick two dives; protect ops. |
| Behavioral? | 2-min STAR openers ready. |

**How can I relate to my case:**
- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> Remember: failure modes, concrete metrics, kill switch. Last five minutes sacred.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Calm opener? | “Five minutes on scope, then architecture, deep dives, and ops.” |
| Draw today? | Skim only. |

**How can I relate to my case:**
- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> **Light game-day retrieval only:** restate agenda + clarify list; skim HLD bullets — **do not** invent a new design from scratch.
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

