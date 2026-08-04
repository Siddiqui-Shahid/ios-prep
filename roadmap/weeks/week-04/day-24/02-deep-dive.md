# 02 — Deep Dive: FinTrack, GymFlow, Router, Privacy

> Full teaching in-chapter. Repo HLD doc is optional deepen after this.

---

## 1. FinTrack — privacy-first Savings Coach (Verified · S15)

### 1.1 Problem

Expense coach that must **not** ship ledger data to a cloud LLM by default.

### 1.2 Architecture you can defend

1. **Local store:** Flutter + Hive; biometric lock; **no cloud sync** of financial records.
2. **Retrieval:** **BM25** over local spending index (lexical, offline, explainable).
3. **Generation path:** `flutter_native_ai` → **Apple Foundation Models** / platform AI where available; else on-device Nano-class path when present.
4. **Fail-soft:** **Deterministic rule engine** (budget thresholds, category heuristics) when model unavailable — still a coach, not a blank screen.
5. **Privacy invariant:** Prefer on-device; if a design interview adds cloud, **PII sanitize + user consent + minimize fields**.

### 1.3 BM25 teaching (enough for interviews)

BM25 scores a document against a query using term frequency, document length normalization, and inverse document frequency. You do **not** need to derive the formula live.

**Say:**  
> “BM25 ranks local spend notes and category text by lexical relevance. It’s offline, explainable, and needs no embedder binary — weaker on paraphrase (‘UBER’ vs ‘rideshare’), which is an accepted trade-off for FinTrack’s text.”

### 1.4 Grounding money (non-negotiable)

Generative text is **never** source of truth for balances or amounts. Prompt: only use provided context. UI can show retrieved rows / citations. Rules path reads DB deterministically.

### 1.5 Interview line (≤20s)

> “FinTrack is local-first — BM25 RAG over Hive, Apple Intelligence when present, rules when not; financial data doesn’t leave the device.”

→ STAR: [story-bank.md](../../../stories/story-bank.md)#S15

---

## 2. GymFlow — edge embeddings recommender (Verified · S16)

### 2.1 Problem

Workout recommendations without cloud LLM cost/latency/privacy drag.

### 2.2 Architecture

1. **INT8 MiniLM TFLite** + WordPiece tokenizer (Dart in the shipped app).
2. Embed query / user context; **cosine similarity** over exercise catalog; trainer routine as RAG context.
3. **Fail-soft:** **TF-IDF** lexical fallback if TFLite model missing/slow/thermal.
4. Principle: **retrieval + ranking + degradation**, not “call an LLM.”

### 2.3 Cosine teaching

```text
score(a,b) = dot(a,b) / (|a| |b|)
```

Top-K by score. Same “best K” instinct as Day 23 heaps (mental model only).

### 2.4 Interview line (≤20s)

> “GymFlow ranks exercises with on-device MiniLM embeddings and falls back to TF-IDF when the model path can’t run.”

→ STAR: #S16

---

## 3. Map portfolio → generic on-device HLD

| Doc subsystem | Your proof |
|---|---|
| Local RAG / vector or lexical index | FinTrack BM25; GymFlow MiniLM + cosine |
| Quantized runtime | GymFlow INT8 TFLite; Apple FM path on FinTrack |
| Hybrid router / thermal | Speak design + eligibility checks |
| Token streaming UI | Partial updates; cancel on navigate away |
| Memory / Jetsam | Unload model, clear caches on warning |
| Privacy guard | FinTrack no-sync; cloud only with sanitize |

---

## 4. Trade-offs

| Choice | When | Cost |
|---|---|---|
| BM25 lexical RAG | Offline, explainable, no embedder | Weaker paraphrase |
| MiniLM / vector RAG | Semantic paraphrase | Model size, tokenizer bugs, jank if on main |
| On-device LLM generate | Privacy, latency, offline | Quality, thermal, device coverage |
| Cloud LLM fallback | Hard reasoning, huge context | Privacy, cost, latency, consent |
| Deterministic rules / TF-IDF | Fail-soft always-on | Less “magical”; set expectations |
| Apple Intelligence / FM | Native path, privacy story | OS/device gating; Android abstraction |
| Always-cloud “AI feature” | Fast demo | Fails senior privacy + offline bars |

---

## 5. Fail-soft matrix (memorize)

| Failure | Detection | Fallback |
|---|---|---|
| OS / device lacks FM / TFLite | Capability flag at launch | Rules / TF-IDF; hide generative chrome |
| Model file missing / checksum fail | Load error | Same; remote config disable |
| Thermal `.serious` / Low Power | `ProcessInfo` | Pause inference; lexical or cached tips |
| Memory warning | Notification | Unload weights, clear KV; degrade |
| Retrieval empty | Top-K = 0 | Honest empty + generic tips — don’t hallucinate |
| Cloud path needed (design) | Router decision | Sanitize PII; TLS; timeout → local message |

---

## 6. Privacy-first script (90s) — speak verbatim until automatic

> “Financial and health-adjacent data stays on device. Retrieval runs locally. Generative models are optional accelerators behind capability checks. Analytics get coarse events — coach_shown, fallback_rule — not raw transactions. If a hybrid cloud path is required, it’s consent-gated, field-minimized, and never the only path.”

---

## 7. Hybrid router sketch (teaching)

```text
func route(query):
  if !eligible || thermalSerious || lowPower: return rulesOrTfIdf(query)
  ctx = retrieve(query)          // BM25 or embeddings
  if ctx.isEmpty: return emptyState()
  if canLocalGenerate: return streamLocal(ctx, query)
  if cloudAllowed && consented: return streamCloud(sanitize(ctx, query))
  return rulesOrTfIdf(query)
```

See `code/HybridAIRouter.swift`.

---

## 8. Scale caution (BookMyShow judgment)

At **30L+ DAU**, unconstrained on-device LLM on checkout is a reliability/battery risk. You’d want feature flags, sampling, kill switches — same culture as **99.95% crash-free** (Verified · S8). FinTrack/GymFlow are personal-scale proofs of architecture; BMS teaches when *not* to be reckless.

---

## 9. Optional citations (after mastery)

- [on-device-llm-ai-engine.md](../../../../ios-system-design/docs/on-device-llm-ai-engine.md)
- Apple Foundation Models / WWDC on-device sessions
- [cheatsheet.md](../../../../ios-system-design/docs/cheatsheet.md) for Day 27 SD timing

→ [`03-production-bridge.md`](03-production-bridge.md)
