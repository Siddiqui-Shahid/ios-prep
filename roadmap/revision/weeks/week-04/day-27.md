# Day 27 — Expert Mock #4 (Full Loop)

> Week 4 · Phase: Expert mock · Time budget today: **~4.5–5.5 hrs** (3×45 min + breaks + debrief)

## 1. Outcome

By end of day you can explain aloud (no notes):

- Execute a **full senior loop**: **Coding 45 + iOS deep dive 45 + System design 45** with calendar discipline.
- Open each segment with the correct **agenda** from [answer-timing-guide.md](../../timing/answer-timing-guide.md).
- Self-/expert-score against the **scorecards** below; identify ≤3 fix-forward items for Day 28 (flashcards only — no new topics).
- Keep production proof ready: BMS **30L+ DAU**, **99.95% crash-free**, **30%+ nav** LE sheet; District S9; FinTrack/GymFlow if AI asked; Raw SDK/hybrid as needed.

**Mock #4 is the dress rehearsal.** Treat it like the real loop: no notes in-frame, timer visible, water, breaks.

## 2. Concept deep dive

### 2.1 Day schedule (stick to it)

| Block | Duration | Mode |
|---|---|---|
| Warm-up | 15 min | Flashcards weak only; one STAR opener (S6 or S8) |
| **Coding** | **45 min** | Expert or self-proctor |
| Break | 10–15 min | Walk; no phone doomscroll |
| **iOS deep dive** | **45 min** | Conceptual + production |
| Break | 10–15 min | |
| **System design** | **45 min** | Full cheatsheet timing |
| Debrief | 45–60 min | Scorecards + gotchas; **stop** |

### 2.2 Segment A — Coding (45 min)

**Timing inside the 45:**

| Min | Action |
|---|---|
| 0–3 | Clarify + “say this first” (brute → optimize → complexity → edges) |
| 3–35 | Code + narrate; run mental/examples |
| 35–42 | Tests / edge cases aloud; fix bugs |
| 42–45 | Complexity recap + alternative |

**Problem sources:** [dsa-track.md](../../coding/dsa-track.md) Medium — prefer **mixed unknown pattern** (Day 23 skill). Trees / hash / heap / window all fair.

**Scorecard — Coding**

| Criterion | 5 | 3 | 1 |
|---|---|---|---|
| Clarify + agenda | Explicit, timed | Partial | Jumped to code |
| Correctness | Passes cases | Minor bug | Wrong approach |
| Complexity | Stated accurately | Vague | Missing/wrong |
| Communication | Continuous narrate | Occasional | Silent |
| Edges / tests | Covered | One mention | None |
| Time use | Finished with buffer | Barely done | Incomplete core |

**Target:** average ≥3.5; agenda ≥4.

### 2.3 Segment B — iOS deep dive (45 min)

**Format:** Interviewer drives 4–6 topics. You answer with **30–45s** definitions or **90–120s** deep dives. Sprinkle architecture **3–5 min** once if asked “design X.”

**Likely topic pools (Week 1–3 spine):**

- Memory / ARC / retain cycles (S2 adjacent)
- Concurrency: GCD vs actors / races
- MVVM–Clean–DI (District)
- URLSession, pinning, refresh (S4)
- SDUI + fallbacks (S3)
- SwiftUI identity / hybrid UIKit (S13)
- Perf: Instruments, p50/p90 (S5)
- Crash / IMOC / 99.95% (S8)
- Modularization / SPM / Stories SDK (S10)
- On-device AI privacy/fail-soft if they pivot (S15/S16) — keep tight

**Scorecard — iOS deep dive**

| Criterion | 5 | 3 | 1 |
|---|---|---|---|
| Timing discipline | Hits budgets | ±30% | Ramble / blank |
| Mechanism accuracy | Correct | Fuzzy | Wrong |
| Trade-off | Present | Weak | None |
| Production proof | BMS/Raw/District | Generic “in apps” | None |
| Agenda on long answers | Yes | Sometimes | Never |
| Honesty | Clear assumptions | Hedge filler | Bluff |

**Target:** ≥4 on Normals; ≥3 on Trickies; at least **two** production hooks.

### 2.4 Segment C — System design (45 min)

**Use cheatsheet clock** from [cheatsheet.md](../../../ios-system-design/docs/cheatsheet.md) / timing guide:

```text
0–5   Clarify: scope, DAU, offline?, iOS-only?, latency SLO
5–15  HLD: 4-layer client + data flow
15–25 Data/API: entities, pagination, payloads, idempotency
25–40 Deep dive: 2–3 hardest subsystems
40–45 Ops: failure modes, metrics, rollout, kill switch
```

**Pick one primary prompt (expert chooses; otherwise rotate):**

| Option | Doc | Why |
|---|---|---|
| SDUI engine | [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) | Your strongest BMS/Raw hook |
| Networking + security | [networking-layer.md](../../../ios-system-design/docs/networking-layer.md) + pinning | S4 proof |
| On-device AI assistant | [on-device-llm-ai-engine.md](../../../ios-system-design/docs/on-device-llm-ai-engine.md) | Differentiator FinTrack/GymFlow |
| Image pipeline / feed | [image-loading-library.md](../../../ios-system-design/docs/image-loading-library.md) / [social-feed.md](../../../ios-system-design/docs/social-feed.md) | Perf depth |

**Staff opener:**  
> “I’ll spend 5 minutes on scope, then architecture, then deep-dive retrieval/fallback and ops. Does that work?”

**Scorecard — System design**

| Criterion | 5 | 3 | 1 |
|---|---|---|---|
| Clarify quality | Constraints + SLOs | Few Qs | Assumed all |
| HLD clarity | 4 layers drawn | Blob diagram | No structure |
| Deep dive | 2 subsystems crisp | One shallow | Skipped |
| Failure modes | Kill switch, degrade | Mention only | Happy path only |
| Metrics / rollout | Concrete | Vague | None |
| Timing | On cheatsheet | Drifted 10+ min | Chaos |
| Personal proof | Tied to shipped work | Light | Generic blog |

**Target:** ≥3.5 overall; clarify + failure modes ≥4.

### 2.5 Trade-offs (meta — how you run the mock)

| Choice | When | Cost |
|---|---|---|
| Expert human proctor | Best signal | Scheduling |
| Self + recorded | Always available | Blind spots |
| Peer iOS eng | Good pushback | May go soft |
| New problem never seen | Realism | Higher stress — intended |
| Reusing Day 25 machine code | Comfort | Weaker coding signal — prefer fresh DSA |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [timing/answer-timing-guide.md](../../timing/answer-timing-guide.md) | All segment budgets |
| Must | [cheatsheet.md](../../../ios-system-design/docs/cheatsheet.md) | SD clock |
| Must | [coding/dsa-track.md](../../coding/dsa-track.md) | Coding problem pick |
| Deepen | Primary SD doc for your chosen prompt | Refresh diagrams only — no new reading rabbit holes |
| Repo | [stories/story-bank.md](../../stories/story-bank.md) | One warmup STAR |

## 4. Map to your work

**Company / feature:** Full career spine — BMS scale/reliability/SDUI/security; District architecture + AI judgment; Raw modularity/hybrid; FinTrack/GymFlow on-device AI.  
**What you did:** Own the narrative: senior = trade-offs + production proof + calm timing.  
**Interview line (≤20s) before mock:**  
> “I’ll run this like a real loop — agenda first, trade-offs, and metrics I actually shipped.”

→ Stories on demand from [story-bank.md](../../stories/story-bank.md).

## 5. Normal questions

*(Warmup / between segments — not instead of the mock.)*

### Q1. How will you open the coding round? `(30–45s)`
**Skeleton:** Restate → clarify → brute → optimize → complexity → edges → code.  
**Follow-up:**  
**Story:** —

### Q2. How will you open system design? `(30–45s)`
**Skeleton:** Staff agenda + 5 min clarify; ask DAU/offline/SLO.  
**Follow-up:**  
**Story:** —

### Q3. Name three production proofs you’ll keep loaded. `(30–45s)`
**Skeleton:** 30L+ DAU context; 99.95% crash-free; 30%+ nav LE sheet — plus one of SDUI/pinning/SDK/AI.  
**Follow-up:**  
**Story:** S6/S8/S3/S4/S10/S15.

### Q4. What do you do if you blank? `(30–45s)`
**Skeleton:** Say assumption; start from requirements; draw; offer brute; recover. No apology spiral.  
**Follow-up:**  
**Story:** —

### Q5. What’s out of scope for today’s debrief? `(30s)`
**Skeleton:** Learning brand-new frameworks tonight; rewriting Day 25 app; new LeetCode topics.  
**Follow-up:**  
**Story:** —

## 6. Tricky questions

### T1. “Your SD deep dive is running long — what do you cut?” `(90s)`
**Trap:** Panic-skip ops.  
**Senior answer:** Park third subsystem; always reserve **ops/failure modes** 5 min — seniors protect that. Summarize remaining.  
**Follow-up:** —

### T2. “Coding solution is O(n²) and time is almost up.” `(90s)`
**Trap:** Silent rewrite from scratch.  
**Senior answer:** State optimal approach + complexity; sketch key function; note what you’d change; partial credit via communication.  
**Follow-up:** —

### T3. “Interviewer challenges your BMS metric.” `(90s)`
**Trap:** Inflate or collapse.  
**Senior answer:** Clarify what the number measures (crash-free sessions; nav reduction on targeted flows); don’t generalize beyond resume. Offer related proof.  
**Follow-up:** —

### T4. “They ask on-device AI but you prepared SDUI.” `(90s)`
**Trap:** Force SDUI anyway.  
**Senior answer:** Pivot gracefully — privacy, RAG, fail-soft, FinTrack/GymFlow; reuse 4-layer client; shorter HLD OK if clarify strong.  
**Follow-up:** Day 24 matrix.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Coding first 3 min | Clarify brute optimize complex edges · Trap: silent code · Prod: — |
| SD 45 clock | 5–10–10–15–5 · Trap: deep dive forever · Prod: cheatsheet |
| Deep dive budget | 45s / 120s / 5 min arch · Trap: lecture · Prod: timing guide |
| Proof trio | 30L DAU / 99.95% / 30% nav · Trap: invent · Prod: resume |
| Protect ops | Always last 5 SD · Trap: cut metrics · Prod: kill switch |
| Blank recovery | Assumption + draw + brute · Trap: apology loop · Prod: — |
| Mock breaks | 10–15 min real · Trap: cram mid-loop · Prod: — |
| Debrief cap | ≤3 fix-forwards · Trap: rewrite life · Prod: Day 28 |
| AI pivot | Fail-soft + privacy · Trap: tool worship · Prod: S15/S9 |
| Score target | ≥3.5 segments · Trap: ignore timing · Prod: — |

## 8. Practice

- **Coding / SD:** The mock *is* the practice. No extra LeetCode volume after.
- **Complexity / agenda to say first:** Before each segment, 30s quiet rehearsal of the opener only.
- **Materials to have open for proctor (not you mid-answer):** scorecards printed; problem statement; SD prompt; timer.

**Expert briefing (paste to interviewer):**

> Muhammed is targeting senior iOS. Please run Coding 45 (Medium, unlabeled pattern), iOS deep dive 45 (concurrency, architecture, networking/SDUI, perf/crashes — push for trade-offs), System design 45 (SDUI **or** networking+pinning **or** on-device AI). Score communication and timing, not only correctness. Metrics he may use: 30L+ DAU, 99.95% crash-free, 30%+ nav reduction.

## 9. Timed drill

1. Run the **full three segments** with scorecards.
2. Debrief: write scores; list **exactly three** weak flashcard fronts for Day 28.
3. One STAR only if an iOS answer needed a story and failed timing — else rest.
4. **Hard stop.** Sleep hygiene starts tonight for Day 28 → interview readiness.
