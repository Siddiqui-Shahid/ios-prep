# Audio script — Sample 07 — Revision Q&A (day-27) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. What is Mock #4’s full day schedule?

Next. Q1. What is Mock #4’s full day schedule? Answer. Warm-up 15 min → Coding 45 → break 10–15 → i O S deep dive 45 → break 10–15 → System design 45 → debrief 45–60 min. Total ~4.5–5.5 hours. Timer visible. No notes in-frame. Debrief ends with exactly three fix-forwards — then stop. Follow-ups. Expert vs self-proctor?: Expert = best signal; self + recorded = always available.. Break rules?: Walk — no doomscroll; keep cognitive freshness.. Skip debrief?: No — fix-forwards feed Day 28 flashcards..

## §1 Q2. What are the three main segments?

Next. Q2. What are the three main segments? Answer. Coding 45 — Medium D S A, unlabeled pattern preferred (trees/hash/heap/window fair). i O S deep dive 45 — 4–6 topics: A R C, G C D vs actors, architecture, URLSession/pinning, S D U I, perf/crashes, S D K, on-device AI if pivoted. System design 45 — S D U I or networking+pinning or on-device AI; staff timing with ops block protected. Follow-ups. Behavioral segment?: Pulled ad hoc during i O S or SD — use 2-min STAR opener.. Reuse Day 25 app problem?: Weaker coding signal — prefer fresh D S A.. SD prompt chosen when?: Before mock or expert chooses day-of..

## §2 Q3. How do you open each segment?

Next. Q3. How do you open each segment? Answer. Coding: Clarify → brute → optimize → complexity → edges → code. Deep dive: Definition → mechanism → trade-off → production. System design: “I’ll spend 5 minutes on scope, then architecture, then deep-dive and ops. Does that work?” Behavioral if pulled: “I’ll take ~2 minutes — context, what I owned, outcome.” Rehearse each opener 30s quietly before the segment starts. Follow-ups. Opener overtime?: 30s max — then execute; agenda scores.. Skip opener under stress?: Common failure mode — practice makes it automatic.. SD “does that work?”: Invites interviewer alignment — senior communication..

## §3 Q4. What is the warm-up block for?

Next. Q4. What is the warm-up block for? Answer. 15 minutes before Coding: weak flashcards + one STAR opener (BookMyShow LE Bottom Sheet or BookMyShow I M O C + crash-free at scale). Speak warm-up pool once each — suggested set W1, W6, W7, W3. Save W9–W12 for mental rehearsal. Purpose: activate recall, not learn new material. Follow-ups. Full warm-up pool location?: 07-revision-qna.md Pools A–E. STAR in warm-up timed?: One full opener — 2 min max — then coding focus.. Skip warm-up?: Lose confidence ramp — keep 15 min..

## §4 Q5. What materials do you need before starting?

Next. Q5. What materials do you need before starting? Answer. Scorecards printed or in proctor notes doc (not in your frame). Timer, water, breaks planned. SD prompt chosen or expert-assigned. Fresh D S A problem — unlabeled Medium. D S A track reference for proctor:../../../coding/dsa-track.md. Follow-ups. Notes during mock?: Closed-book for candidate — proctor holds scorecard.. Recording?: Recommended for self-proctor blind spots.. IDE setup?: Ready only for coding segment..

## §5 Q6. What is Mock #4’s north star?

Next. Q6. What is Mock #4’s north star? Answer. Dress rehearsal. Timer visible. No notes in-frame. Agenda first every segment. Debrief ends with exactly three fix-forwards — then stop. Not a learning day — a performance day with honest scoring. Follow-ups. Fix more than three gaps?: Park the rest — Day 28 is flashcards only, capped.. New topics after mock?: Forbidden — no Day 25 rewrite, no new LC pattern.. One STAR if story failed?: Only if i O S answer needed story and blew timing — else rest..

## §6 Q7. How do you recover when you blank?

Next. Q7. How do you recover when you blank? Answer. Say an assumption → return to requirements → draw → offer brute → recover. No apology spiral. Burn zero time on “sorry, I’m nervous.” Seniors recover in one sentence and move. Follow-ups. Blank in coding?: Restate problem + brute O(n²) while thinking — narrate.. Blank in SD?: Clarify scope again — buys 2 min and resets structure.. Apology spiral cost?: Signals junior — recovery communication scores..

## §7 Q8. How is the coding segment timed (45 min)?

Next. Q8. How is the coding segment timed (45 min)? Answer. 0–3 min: Clarify + say-this-first agenda. 3–35 min: Code + narrate continuously. 35–42 min: Edges / tests aloud; fix bugs. 42–45 min: Complexity recap + mention alternative approach. Prefer mixed unknown Medium — trees, hash, heap, sliding window fair game. Follow-ups. Clarify too long?: 3 min cap — then brute + pattern.. No time for edges?: Major deduction — leave buffer by minute 35.. Silent coding?: Scores 1 on communication — narrate trade-offs..

## §8 Q9. What does the coding scorecard measure?

Next. Q9. What does the coding scorecard measure? Answer. Six criteria, each 1 / 3 / 5: Clarify + agenda · Correctness · Complexity · Communication · Edges/tests · Time use. 5 = explicit timed agenda, passes cases, accurate complexity, continuous narration, edges covered, buffer left. 3 = partial on most rows. 1 = jumped to code, wrong approach, silent, incomplete core. Target: average ≥3.5; agenda ≥4. Follow-ups. Minor bug — score?: Correctness 3 if fixable; 1 if wrong algorithm.. O(n) stated wrong?: Complexity row hits 1 or 3 — say it aloud correctly.. Partial solution at 45?: Time use 1 — communicate optimal approach for partial credit..

## §9 Q10. How is the iOS deep dive scored?

Next. Q10. How is the iOS deep dive scored? Answer. 4–6 topics — answers 30–45s or 90–120s; one architecture answer 3–5 min if “design X.” Criteria: Timing · Mechanism · Trade-off · Production proof · Agenda on long answers · Honesty. Target: ≥4 on Normals; ≥3 on Trickies; ≥2 production hooks (BMS/Raw/District). Follow-ups. Ramble 3 min on 45s question?: Timing 1 — self-correct with agenda.. Correct but generic?: Production proof 3 or 1 — add BookMyShow synchronised dictionaries/BookMyShow SSL pinning + URLSession migration/BookMyShow I M O C + crash-free at scale hook.. Bluff wrong mechanism?: Honesty 1 — state assumption instead..

## §10 Q11. What topics appear in the iOS pool?

Next. Q11. What topics appear in the iOS pool? Answer. A R C/retain cycles · G C D vs actors · M V V M–Clean–DI · URLSession/pinning · S D U I fallbacks · SwiftUI identity/hybrid · Instruments p50/p90 · Crash/I M O C 99.95% · SPM/Stories S D K · On-device AI fail-soft if pivoted (keep tight). Every answer: definition → mechanism → trade-off → production proof. Follow-ups. BookMyShow synchronised dictionaries bridge for concurrency?: Verified G C D prod vs Design: actor SafeDict (not shipped) actor migration.. S D U I unknown type?: Fallback + schema — BookMyShow backend-driven header & search instinct.. On-device AI pivot?: FinTrack on-device AI/GymFlow on-device AI — privacy + fail-soft, 30–45s tight..

## §11 Q12. How is system design timed (45 min)?

Next. Q12. How is system design timed (45 min)? Answer. 0–5 Clarify: scope, daily active users, offline?, i O S-only?, latency SLO. 5–15 high level design: 4-layer client + data flow. 15–25 Data/A P I: entities, pagination, payloads, idempotency. 25–40 Deep dive: 2–3 hardest subsystems. 40–45 Ops: failure modes, metrics, rollout, kill switch. Prompt options: S D U I engine · Networking+pinning · On-device AI · Image/feed. Follow-ups. Deep dive runs long?: Park third subsystem — protect ops 5 min.. No clarify?: Score 1 — assumptions without SLOs.. Happy path only?: Failure modes 1 — mid signal..

## §12 Q13. What is the system design scorecard target?

Next. Q13. What is the system design scorecard target? Answer. Criteria: Clarify · high level design (4 layers) · Deep dive (2 crisp) · Failure modes · Metrics/rollout · Timing · Personal proof. Target: average ≥3.5; clarify + failure modes ≥4. 5 on high level design = four layers with clear data flow; 5 on ops = kill switch, degrade path, concrete metrics. Follow-ups. Blob architecture?: high level design 1 or 3 — draw layers.. One shallow deep dive?: Deep dive 3 — need two crisp subsystems.. Generic “we’d monitor”?: Metrics 3 — name Firebase, crash-free, p90, etc..

## §13 Q14. What does 5 vs 3 vs 1 mean across segments?

Next. Q14. What does 5 vs 3 vs 1 mean across segments? Answer. 5 = on time, explicit agenda, correct mechanism, trade-off stated, production proof with honest provenance, follow-up ready. 3 = correct core but fuzzy trade-off, weak timing (±30%), light production hook, or partial edges. 1 = blank, wrong, bluff, silent, happy-path-only SD, or jumped in without clarify. Mock pass = segment averages meet targets + ≤3 fix-forwards logged. Follow-ups. Invented BMS metric?: Honesty 1 — worse than “I don’t know.”. 2× budget?: Self-correct in one sentence — still score recovery attempt.. Average 3.4?: One fix-forward priority — don’t rewrite whole week..

## §14 Q15. What are meta trade-offs for Mock #4?

Next. Q15. What are meta trade-offs for Mock #4? Answer. Expert human = best signal, costs scheduling. Self + recorded = always on, blind spots remain. Fresh D S A = realism and stress — intended. Reuse Day 25 app = comfort but weaker coding signal. Choose fresh problem and honest debrief over comfort. Follow-ups. Re-run mock next day?: Day 28 taper — only if Mock #4 missed entirely.. Scorecards for proctor only?: Yes — not in candidate frame.. Expert briefing?: See../README.md paste block for proctor.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §15 I1. A junior asks you in standup: “What is Mock #4’s full day schedule?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “What is Mock #4’s full day schedule?” — how do you answer without jargon? `(60–90s)` Answer. “Warm-up 15 min → Coding 45 → break 10–15 → i O S deep dive 45 → break 10–15 → System design 45 → debrief 45–60 min. Total ~4.5–5.5 hours. Timer visible. No notes in-frame. Debrief ends with exactly three fix-forwards — then stop.” Follow-ups. What concept is this really?: What is Mock #4’s full day schedule. How do you prove it?: Give a tiny example or production boundary..

## §16 I2. Production symptom: something related to “What are the three main segments” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “What are the three main segments” just broke under load. What do you check first? `(60–90s)` Answer. “Coding 45 — Medium D S A, unlabeled pattern preferred (trees/hash/heap/window fair). i O S deep dive 45 — 4–6 topics: A R C, G C D vs actors, architecture, URLSession/pinning, S D U I, perf/crashes, S D K, on-device AI if pivoted. System design 45 — S D U I or networking+pinning or on-device AI; staff timing with ops block protected.” Follow-ups. What concept is this really?: What are the three main segments. How do you prove it?: Give a tiny example or production boundary..

## §17 I3. Interviewer never names the topic. They describe a mess that maps to “How do you open each segment”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “How do you open each segment”. How do you diagnose? `(60–90s)` Answer. “Coding: Clarify → brute → optimize → complexity → edges → code. Deep dive: Definition → mechanism → trade-off → production. System design: “I’ll spend 5 minutes on scope, then architecture, then deep-dive and ops. Does that work?” Behavioral if pulled: “I’ll take ~2 minutes — context, what I owned, outcome.” Rehearse each opener 30s quietly before the segment starts.” Follow-ups. What concept is this really?: How do you open each segment. How do you prove it?: Give a tiny example or production boundary..

## §18 I4. Code review: you spot a smell around “What is the warm-up block for”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “What is the warm-up block for”. What do you say and what fix do you propose? `(60–90s)` Answer. “15 minutes before Coding: weak flashcards + one STAR opener (BookMyShow LE Bottom Sheet or BookMyShow I M O C + crash-free at scale). Speak warm-up pool once each — suggested set W1, W6, W7, W3. Save W9–W12 for mental rehearsal. Purpose: activate recall, not learn new material.” Follow-ups. What concept is this really?: What is the warm-up block for. How do you prove it?: Give a tiny example or production boundary..

## §19 I5. What happens if a teammate ignores the rule behind “What materials do you need before starting”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “What materials do you need before starting”? `(60–90s)` Answer. “Scorecards printed or in proctor notes doc (not in your frame). Timer, water, breaks planned. SD prompt chosen or expert-assigned. Fresh D S A problem — unlabeled Medium. D S A track reference for proctor:../../../coding/dsa-track.md.” Follow-ups. What concept is this really?: What materials do you need before starting. How do you prove it?: Give a tiny example or production boundary..

## §20 I6. Walk me through a failed interview answer on “What is Mock #4’s north star” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “What is Mock #4’s north star” and how you’d correct it? `(60–90s)` Answer. “Dress rehearsal. Timer visible. No notes in-frame. Agenda first every segment. Debrief ends with exactly three fix-forwards — then stop. Not a learning day — a performance day with honest scoring.” Follow-ups. What concept is this really?: What is Mock #4’s north star. How do you prove it?: Give a tiny example or production boundary..

## §21 I7. A junior asks you in standup: “How do you recover when you blank?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “How do you recover when you blank?” — how do you answer without jargon? `(60–90s)` Answer. “Say an assumption → return to requirements → draw → offer brute → recover. No apology spiral. Burn zero time on “sorry, I’m nervous.” Seniors recover in one sentence and move.” Follow-ups. What concept is this really?: How do you recover when you blank. How do you prove it?: Give a tiny example or production boundary..

## §22 I8. Production symptom: something related to “How is the coding segment timed (45 min)” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “How is the coding segment timed (45 min)” just broke under load. What do you check first? `(60–90s)` Answer. “0–3 min: Clarify + say-this-first agenda. 3–35 min: Code + narrate continuously. 35–42 min: Edges / tests aloud; fix bugs. 42–45 min: Complexity recap + mention alternative approach. Prefer mixed unknown Medium — trees, hash, heap, sliding window fair game.” Follow-ups. What concept is this really?: How is the coding segment timed (45 min). How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §23 T1. Main-thread rule under pressure? `(90–120s)`

Next. T1. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T2. Cancellation honesty? `(90–120s)`

Next. T2. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T3. Cache invalidation trap? `(90–120s)`

Next. T3. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T4. Security theater vs real pinning? `(90–120s)`

Next. T4. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T5. SDUI unknown component in prod? `(90–120s)`

Next. T5. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T6. DI vs singletons under test? `(90–120s)`

Next. T6. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T7. Prefetch that hurts scrolling? `(90–120s)`

Next. T7. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §30 T8. Actor reentrancy surprise? `(90–120s)`

Next. T8. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §31 T9. They push you to invent a metric you don’t have? `(90–120s)`

Next. T9. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §32 T10. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T10. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
