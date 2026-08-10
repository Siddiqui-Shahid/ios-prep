# Audio script — Sample 05 — System-design mock: Mobile Platform Engineering (EM/Staff) (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Mobile Platform Engineering (EM/Staff).” How do you open?

Next. Q1. Interviewer: “Design Mobile Platform Engineering (EM/Staff).” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Phased rollout gates and Sev-1 triage, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Release train + feature-flag kill switches? 2. Crash-free gate for phased rollout? 3. Monorepo Interface/Impl? 4. Sev-1 expectations? 5. Out: product feature high level design? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Phased 1→100% rollout; auto-pause gates; flag kill <5m; Sev-1 playbook; build budgets. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Platform view: monorepo modules → CI budgets → ASC phased release → Remote Config kill → I M O C. Load/governance: weekly train; flags mandatory on new surfaces; pause if crash free sessions <99.85% class. Follow-ups. Product SD instead?: Redirect — this prompt is platform/EM.. AI tooling?: District envelope — review bar, not platform train..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. Remote Config kill-switch; ASC halt rollout; expedited review path (process). Follow-ups. Who flips kill?: On-call + EM; SLA <5m.. Canary metrics?: crash free sessions, hang, 5xx ≥3× baseline → pause..

## §4 Q5. Deep dive 1 — Phased rollout gates?

Next. Q5. Deep dive 1 — Phased rollout gates? Answer. 1→2→5→10→20→50→100%; auto pause; don’t vibe-ship. Follow-ups. Hotfix during phase?: Halt; flag; expedite.. CI flaky?: <1.5% flaky budget..

## §5 Q6. Deep dive 2 — Sev-1 triage?

Next. Q6. Deep dive 2 — Sev-1 triage? Answer. Flag kill <5m → halt ASC → communicate → hotfix train. Breadcrumbs from crash S D K. Follow-ups. Blame?: Systems first — I M O C culture.. Mentorship?: Standards via architecture envelopes — Day 26 STAR..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. crash free sessions 99.9% target, hang <0.1%, kill SLA, CI time. This is the ops-heavy prompt. Follow-ups. Production?: I M O C + crash-free culture participation; Ads protocol standards as leadership.. Invent Sev counts?: Forbidden..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
