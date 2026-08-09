# Audio script — Sample 05 — System-design mock: Social Feed (warm retrieval) (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Social Feed (warm retrieval).” How do you open?

Next. Q1. Interviewer: “Design Social Feed (warm retrieval).” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Cheatsheet spine only and Pivot kit, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Only restate agenda + clarify list — confirm? 2. Which prompt might appear — feed / S D U I / networking / on-device AI? 3. Ops block still last 5? 4. No new diagrams today? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Warm retrieval: agenda, clarify Qs, spine times, kill-switch reminder. Pivot kit: FinTrack/GymFlow if AI. No new design invention. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Do not draw a new full high level design today. Skim remembered 4 layers + backend touchpoints for the likely prompt. If forced: Social Feed one-liner — cursor pages, SQLite last-good, image pipeline, optimistic like — then stop and protect calm. Follow-ups. Interviewer asks deep dive?: Park: “I’ll use the standard spine — clarify already done in warmup.”. Forgot numbers?: daily active users labeled; NFR from cheatsheet — don’t invent..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. Retrieve only: cursor offset; Idempotency-Key on payments; debounce search; single-flight refresh. Follow-ups. Blank mind?: Speak agenda first — buys 20s.. Wrong prompt?: Re-clarify in/out 30s..

## §4 Q5. Deep dive 1 — Cheatsheet spine only?

Next. Q5. Deep dive 1 — Cheatsheet spine only? Answer. 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Say it once aloud. Follow-ups. Skip sleep for study?: No — game day rule.. Flashcards only?: Yes — stories + openers..

## §5 Q6. Deep dive 2 — Pivot kit?

Next. Q6. Deep dive 2 — Pivot kit? Answer. On-device AI: privacy, local RAG, thermal, fail-soft — FinTrack/GymFlow. Networking: refresh+pin. S D U I: registry+fallback. Follow-ups. New topic appears?: Clarify hard; use 4 layers; pick two dives; protect ops.. Behavioral?: 2-min STAR openers ready..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Remember: failure modes, concrete metrics, kill switch. Last five minutes sacred. Follow-ups. Calm opener?: “Five minutes on scope, then architecture, deep dives, and ops.”. Draw today?: Skim only..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Light game-day retrieval only: restate agenda + clarify list; skim high level design bullets — do not invent a new design from scratch. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
