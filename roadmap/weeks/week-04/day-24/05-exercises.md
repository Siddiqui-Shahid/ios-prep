# 05 — Exercises: On-Device AI

---

## 1. Code lab (teaching sketches)

| File | Role |
|---|---|
| [`code/BM25Ranker.swift`](code/BM25Ranker.swift) | Lexical retrieve teaching model |
| [`code/HybridAIRouter.swift`](code/HybridAIRouter.swift) | Eligibility + fail-soft routing |
| [`code/TFIDFFallback.swift`](code/TFIDFFallback.swift) | GymFlow-style lexical fallback |
| [`code/DeviceAIEligibility.swift`](code/DeviceAIEligibility.swift) | Thermal / low power / capability flags |

These are **learning-lab Swift** sketches of concepts verified in Flutter/Dart products — not a claim the production apps are Swift.

---

## 2. Whiteboard HLD (25–30 min)

Using SD timing micro: Clarify 5 + HLD 10 + fail-soft 5 + metrics 5.

Prompt: “Design an on-device savings coach for iOS.”

Must include: privacy invariant, BM25 retrieve, FM path, rules fallback, ops events.

---

## 3. Verbal deep-dive (15 min)

Pick **one**: FinTrack BM25 path **or** GymFlow TFLite path. Speak fail-soft matrix end-to-end.

---

## 4. STAR timing

- S15 once at 2:30; re-cut to 2:00
- S16 once at 2:30; re-cut to 2:00

---

## 5. Timed Q drill

3 Normal + 2 Tricky (include T1 or T4). Score vs timing guide. Architecture answers use **3–5 min** once.

---

## 6. Exit criteria

- [ ] Pipeline drawn from memory
- [ ] Fail-soft matrix recited
- [ ] Privacy 90s script clean
- [ ] S15 + S16 timed
- [ ] Revision twin: [../../../revision/weeks/week-04/day-24.md](../../../revision/weeks/week-04/day-24.md)

**Tomorrow:** Day 25 machine round — different muscle; keep AI flashcards weak-only if needed.
