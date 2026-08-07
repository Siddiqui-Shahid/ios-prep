# Audio script — Sample 01 — Machine round operating system (Q&A)
> Listen-only sample Q&A from `01-machine-round-os.md`. Spoken answers and follow-ups.

## §0 Q1. What is the north star for a 3-hour machine round?

Next. Q1. What is the north star for a 3-hour machine round? Answer. Ship a tested happy path with documented cut lines. A polished unfinished cathedral loses to a demoable core. If you cannot demo in 60 seconds — load, show data, one secondary behavior (next page or unknown fallback), mention a test — you do not have a slice yet. Follow-ups. Proctor opener 0:15?: “Clarify briefly, then vertical slice: U I → ViewModel → protocol repository — fake data first. Time for tests and cut lines.”. Build both briefs?: Pick A or B — outline other in notes only if surplus time.. Perfectionism?: Stop styling when pagination/S D U I core broken..

## §1 Q2. What is the 3-hour clock?

Next. Q2. What is the 3-hour clock? Answer. 0:00–0:15 Clarify — restate, A P I shape, offline?, UIKit/SwiftUI, tests; don’t code yet. 0:15–0:20 Agenda — layers + milestones aloud. 0:20–0:45 Skeleton — types, protocols, empty U I, fake repo. 0:45–2:00 Vertical slice — one happy path E2E. 2:00–2:30 Depth — cache or 2nd component. 2:30–2:50 Tests — 3–6 meaningful unit tests. 2:50–3:00 Buffer — trade-offs + known gaps README. Follow-ups. Silent first 10 min?: Fail communication rubric — narrate agenda by 0:20.. Pixel-perfect at 1:00?: Wrong priority — happy path first.. No tests at 2:40?: Write two immediately — pass bar needs tests ≥3..

## §2 Q3. What is a vertical slice in practice?

Next. Q3. What is a vertical slice in practice? Answer. End-to-end path a proctor can watch: U I triggers ViewModel → repository returns data → U I updates. Plus one depth feature: append page 2 (Brief A) or render unknown component safely (Brief B). Mention at least one test by name in buffer. Follow-ups. Fake repo first?: Yes — stub remote, swap live if time; tests depend on protocol.. Real network?: Impressive if stable — flaky Wi‑Fi; prefer stub + one live.. README in buffer?: Known gaps, cache policy, cut lines — graders read this..

## §3 Q4. Anti-perfectionism — what should trigger a stop?

Next. Q4. Anti-perfectionism — what should trigger a stop? Answer. Styling fonts while pagination broken → stop. Cannot demo in 60s now → slice. After 2:30 with zero tests → write two now. Haven’t narrated cache/S D U I policy → say in buffer. Renaming for beauty → stop. Follow-ups. Diffable animations?: Cut line for Brief A unless core done early.. Full Clean Architecture?: Rarely fits 3 hrs — pragmatic M V V M + protocols.. 100% coverage chase?: Fail — 3–6 meaningful tests win..

## §4 Q5. Brief A or Brief B — how do I choose?

Next. Q5. Brief A or Brief B — how do I choose? Answer. Choose A if weaker on networking/state/cache — list UX proof. Choose B if weaker on S D U I/decoding/fallbacks — high ROI before Day 27 S D U I system design. Do not build both in 3 hours. Follow-ups. BookMyShow backend-driven header & search hook?: Both touch list/search and S D U I instincts — honest ≤20s only.. UIKit vs SwiftUI?: Clarify at 0:15; state assumption aloud.. Surplus time?: Second brief notes only — 20 min max..

## §5 Q6. What do graders hear at key minutes?

Next. Q6. What do graders hear at key minutes? Answer. 0:10 — restated brief + 2 clarifying Qs. 0:18 — layer plan + cut lines. 1:00 — “happy path compiling.” 2:10 — cache policy or unknown-type policy named. 2:40 — test names aloud while writing. 2:55 — known gaps README. Follow-ups. Trade-offs when?: Buffer + debrief — not only at end if asked.. AI scaffolding tests?: District Free Parking + Clean/M V V M + AI tooling — you own architecture and review.. Pass bar?: Rubric avg ≥3.5, correctness ≥4, tests ≥3..

## §6 Q7. What should I say at 0:15 (proctor opener)?

Next. Q7. What should I say at 0:15 (proctor opener)? Answer. “I’ll clarify briefly, then build a vertical slice: U I → ViewModel → protocol repository — fake data first. I’ll leave time for tests and document cut lines.” Then pick Brief A or B 90s plan from sample 02 or 03. Follow-ups. Clarifying Q examples?: Pagination cursor vs page? Cache stale-while-revalidate? S D U I unknown behavior? Agenda layers?: ListView/Renderer → ViewModel → Repository protocol → Remote + Cache or Decoder + Factory.. Next?: Brief-specific sample 02 or 03..
