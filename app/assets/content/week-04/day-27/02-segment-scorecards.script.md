# Audio script — Sample 02 — Segment scorecards (Q&A)
> Listen-only sample Q&A from `02-segment-scorecards.md`. Spoken answers and follow-ups.

## §0 Q1. How is the coding segment timed (45 min)?

Next. Q1. How is the coding segment timed (45 min)? Answer. 0–3 min: Clarify + say-this-first agenda. 3–35 min: Code + narrate continuously. 35–42 min: Edges / tests aloud; fix bugs. 42–45 min: Complexity recap + mention alternative approach. Prefer mixed unknown Medium — trees, hash, heap, sliding window fair game. Follow-ups. Clarify too long?: 3 min cap — then brute + pattern.. No time for edges?: Major deduction — leave buffer by minute 35.. Silent coding?: Scores 1 on communication — narrate trade-offs..

## §1 Q2. What does the coding scorecard measure?

Next. Q2. What does the coding scorecard measure? Answer. Six criteria, each 1 / 3 / 5: Clarify + agenda · Correctness · Complexity · Communication · Edges/tests · Time use. 5 = explicit timed agenda, passes cases, accurate complexity, continuous narration, edges covered, buffer left. 3 = partial on most rows. 1 = jumped to code, wrong approach, silent, incomplete core. Target: average ≥3.5; agenda ≥4. Follow-ups. Minor bug — score?: Correctness 3 if fixable; 1 if wrong algorithm.. O(n) stated wrong?: Complexity row hits 1 or 3 — say it aloud correctly.. Partial solution at 45?: Time use 1 — communicate optimal approach for partial credit..

## §2 Q3. How is the iOS deep dive scored?

Next. Q3. How is the iOS deep dive scored? Answer. 4–6 topics — answers 30–45s or 90–120s; one architecture answer 3–5 min if “design X.” Criteria: Timing · Mechanism · Trade-off · Production proof · Agenda on long answers · Honesty. Target: ≥4 on Normals; ≥3 on Trickies; ≥2 production hooks (BMS/Raw/District). Follow-ups. Ramble 3 min on 45s question?: Timing 1 — self-correct with agenda.. Correct but generic?: Production proof 3 or 1 — add BookMyShow synchronised dictionaries/BookMyShow SSL pinning + URLSession migration/BookMyShow I M O C + crash-free at scale hook.. Bluff wrong mechanism?: Honesty 1 — state assumption instead..

## §3 Q4. What topics appear in the iOS pool?

Next. Q4. What topics appear in the iOS pool? Answer. A R C/retain cycles · G C D vs actors · M V V M–Clean–DI · URLSession/pinning · S D U I fallbacks · SwiftUI identity/hybrid · Instruments p50/p90 · Crash/I M O C 99.95% · SPM/Stories S D K · On-device AI fail-soft if pivoted (keep tight). Every answer: definition → mechanism → trade-off → production proof. Follow-ups. BookMyShow synchronised dictionaries bridge for concurrency?: Verified G C D prod vs Design: actor SafeDict (not shipped) actor migration.. S D U I unknown type?: Fallback + schema — BookMyShow backend-driven header & search instinct.. On-device AI pivot?: FinTrack on-device AI/GymFlow on-device AI — privacy + fail-soft, 30–45s tight..

## §4 Q5. How is system design timed (45 min)?

Next. Q5. How is system design timed (45 min)? Answer. 0–5 Clarify: scope, daily active users, offline?, i O S-only?, latency SLO. 5–15 high level design: 4-layer client + data flow. 15–25 Data/A P I: entities, pagination, payloads, idempotency. 25–40 Deep dive: 2–3 hardest subsystems. 40–45 Ops: failure modes, metrics, rollout, kill switch. Prompt options: S D U I engine · Networking+pinning · On-device AI · Image/feed. Follow-ups. Deep dive runs long?: Park third subsystem — protect ops 5 min.. No clarify?: Score 1 — assumptions without SLOs.. Happy path only?: Failure modes 1 — mid signal..

## §5 Q6. What is the system design scorecard target?

Next. Q6. What is the system design scorecard target? Answer. Criteria: Clarify · high level design (4 layers) · Deep dive (2 crisp) · Failure modes · Metrics/rollout · Timing · Personal proof. Target: average ≥3.5; clarify + failure modes ≥4. 5 on high level design = four layers with clear data flow; 5 on ops = kill switch, degrade path, concrete metrics. Follow-ups. Blob architecture?: high level design 1 or 3 — draw layers.. One shallow deep dive?: Deep dive 3 — need two crisp subsystems.. Generic “we’d monitor”?: Metrics 3 — name Firebase, crash-free, p90, etc..

## §6 Q7. What does 5 vs 3 vs 1 mean across segments?

Next. Q7. What does 5 vs 3 vs 1 mean across segments? Answer. 5 = on time, explicit agenda, correct mechanism, trade-off stated, production proof with honest provenance, follow-up ready. 3 = correct core but fuzzy trade-off, weak timing (±30%), light production hook, or partial edges. 1 = blank, wrong, bluff, silent, happy-path-only SD, or jumped in without clarify. Mock pass = segment averages meet targets + ≤3 fix-forwards logged. Follow-ups. Invented BMS metric?: Honesty 1 — worse than “I don’t know.”. 2× budget?: Self-correct in one sentence — still score recovery attempt.. Average 3.4?: One fix-forward priority — don’t rewrite whole week..

## §7 Q8. What are meta trade-offs for Mock #4?

Next. Q8. What are meta trade-offs for Mock #4? Answer. Expert human = best signal, costs scheduling. Self + recorded = always on, blind spots remain. Fresh D S A = realism and stress — intended. Reuse Day 25 app = comfort but weaker coding signal. Choose fresh problem and honest debrief over comfort. Follow-ups. Re-run mock next day?: Day 28 taper — only if Mock #4 missed entirely.. Scorecards for proctor only?: Yes — not in candidate frame.. Expert briefing?: See../README.md paste block for proctor..
