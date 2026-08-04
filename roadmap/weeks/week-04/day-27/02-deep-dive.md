# 02 — Deep Dive: Segment Playbooks & Scorecards

---

## Segment A — Coding (45)

| Min | Action |
|---|---|
| 0–3 | Clarify + say-this-first |
| 3–35 | Code + narrate |
| 35–42 | Edges / tests aloud; fix |
| 42–45 | Complexity recap + alternative |

**Sources:** [dsa-track.md](../../../coding/dsa-track.md) Medium — prefer **mixed unknown** (Day 23). Trees/hash/heap/window fair.

### Scorecard — Coding

| Criterion | 5 | 3 | 1 |
|---|---|---|---|
| Clarify + agenda | Explicit, timed | Partial | Jumped to code |
| Correctness | Passes cases | Minor bug | Wrong approach |
| Complexity | Accurate | Vague | Missing/wrong |
| Communication | Continuous | Occasional | Silent |
| Edges / tests | Covered | One mention | None |
| Time use | Buffer | Barely done | Incomplete core |

**Target:** average ≥3.5; agenda ≥4.

---

## Segment B — iOS deep dive (45)

Format: 4–6 topics. Answers **30–45s** or **90–120s**; one architecture **3–5 min** if asked “design X.”

**Topic pools:** ARC/retain · GCD vs actors · MVVM–Clean–DI · URLSession/pinning · SDUI fallbacks · SwiftUI identity/hybrid · Instruments p50/p90 · Crash/IMOC 99.95% · SPM/Stories SDK · On-device AI fail-soft if pivoted (tight)

### Scorecard — iOS deep dive

| Criterion | 5 | 3 | 1 |
|---|---|---|---|
| Timing | Hits budgets | ±30% | Ramble/blank |
| Mechanism | Correct | Fuzzy | Wrong |
| Trade-off | Present | Weak | None |
| Production proof | BMS/Raw/District | Generic | None |
| Agenda on long answers | Yes | Sometimes | Never |
| Honesty | Clear assumptions | Hedge | Bluff |

**Target:** ≥4 Normals; ≥3 Trickies; ≥2 production hooks.

---

## Segment C — System design (45)

```text
0–5   Clarify: scope, DAU, offline?, iOS-only?, latency SLO
5–15  HLD: 4-layer client + data flow
15–25 Data/API: entities, pagination, payloads, idempotency
25–40 Deep dive: 2–3 hardest subsystems
40–45 Ops: failure modes, metrics, rollout, kill switch
```

**Prompt options:** SDUI engine · Networking+pinning · On-device AI · Image/feed

### Scorecard — System design

| Criterion | 5 | 3 | 1 |
|---|---|---|---|
| Clarify | Constraints + SLOs | Few Qs | Assumed all |
| HLD | 4 layers | Blob | None |
| Deep dive | 2 crisp | One shallow | Skipped |
| Failure modes | Kill switch, degrade | Mention | Happy only |
| Metrics / rollout | Concrete | Vague | None |
| Timing | On clock | Drifted 10+ | Chaos |
| Personal proof | Shipped work | Light | Generic |

**Target:** ≥3.5; clarify + failure modes ≥4.

**Protect ops:** If deep dive runs long, park third subsystem — **never** skip last 5 for failures/metrics.

---

## Meta trade-offs

| Choice | When | Cost |
|---|---|---|
| Expert human | Best signal | Scheduling |
| Self + recorded | Always | Blind spots |
| Fresh DSA | Realism | Stress — intended |
| Reuse Day 25 app | Comfort | Weaker coding signal |

→ [`03-production-bridge.md`](03-production-bridge.md)
