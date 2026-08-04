# 03 — Production Bridge: S15 / S16 Honest Proof

---

## Verified · S15 — FinTrack

| Claim | Status |
|---|---|
| Flutter + Hive; biometric; no cloud sync of financial data | Verified |
| BM25 offline RAG + rule fallback | Verified |
| Bridge to Apple Foundation Models / platform AI | Verified |
| Play Store ops awareness (Crashlytics, Remote Config, AdMob) | Verified qualitative |
| Invented accuracy % / latency SLOs | **Forbidden** |

**2–3 min STAR spine:** Situation local-first finance → Action Hive+BM25+FM+rules → Result privacy coach with degrade path → Lesson retrieval+fallback not model worship.

## Verified · S16 — GymFlow

| Claim | Status |
|---|---|
| INT8 MiniLM TFLite + WordPiece | Verified |
| Cosine top-K + trainer context | Verified |
| TF-IDF fail-soft | Verified |
| Cloud LLM dependency | **Not claimed** |

## Contrast · S9 — District tooling

Use only to **separate** concerns when asked “how do you use AI?”

> “District was context engineering for migrations/tests. FinTrack/GymFlow are product on-device systems with privacy and fail-soft. I don’t conflate Cursor with RAG.”

## Soft · S8

Kill switches, capability flags, not crashing on model load — crash-free culture applied to AI features.

## Bridge script (45s)

> “I treat on-device AI as retrieval plus guarded inference with an explicit degrade path — FinTrack BM25 and GymFlow MiniLM both ship that way. Money and recommendations stay grounded; models are optional.”

**Provenance:** Verified · S15 · S16; contrast S9; soft S8

→ [`04-questions.md`](04-questions.md)
