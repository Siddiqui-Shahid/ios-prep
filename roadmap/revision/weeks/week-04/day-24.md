# Day 24 — On-Device AI Architecture (FinTrack / GymFlow)

> Week 4 · Phase: AI system design + privacy judgment · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- End-to-end **on-device AI assistant** architecture from [on-device-llm-ai-engine.md](../../../ios-system-design/docs/on-device-llm-ai-engine.md): RAG → prompt assemble → local inference → stream tokens → **hybrid fail-soft** fallback.
- **FinTrack:** BM25 offline RAG + Apple Intelligence / Foundation Models bridge + deterministic rule fallback; **privacy-first** (no cloud sync of financial data).
- **GymFlow:** INT8 **MiniLM TFLite** embeddings + cosine top-K + **TF-IDF fail-soft**.
- Why seniors design **degradation paths** (unsupported device, thermal, model missing, low battery) before demoing the happy path.
- Answer both **normal** and **tricky** AI interview questions with agenda + trade-off + production proof (S15/S16).

## 2. Concept deep dive

### 2.1 Staff-level mental model (draw this every time)

```text
User query
   → Device eligibility (OS, Neural Engine, memory, thermal, Low Power)
   → Retrieve local context (BM25 / vector / rules)
   → Assemble prompt (budget tokens; strip/minimize PII for any cloud path)
   → Local generate OR cloud fallback OR deterministic template
   → Stream tokens to UI (AsyncSequence / partial updates)
   → Log quality + failure reason (not raw private prompts in cleartext analytics)
```

**Agenda opener for SD (10s):**  
> “I’ll cover privacy constraints, retrieval, on-device inference, hybrid fallback, and ops metrics — starting with FinTrack/GymFlow as concrete instances.”

### 2.2 Primer you must say cleanly (45–60s each)

| Concept | One-liner + mobile sting |
|---|---|
| **Token** | Model I/O unit ≈ ¾ word; context window is a hard budget |
| **Quantization** | FP16 3B ≈ huge RAM; INT4/INT8 makes on-device feasible; quality trade-off |
| **Embedding** | Fixed-dim vector of meaning; cosine ≈ semantic closeness |
| **RAG** | Retrieve private/local chunks → stuff into prompt; model never “trained” on your Hive DB |
| **KV-cache** | Speeds decode; eats RAM; drop under memory pressure |
| **Hybrid router** | Local first; cloud/rules when thermal, complexity, or capability fails |
| **BM25** | Classical lexical retrieval — strong offline, no embedder required |
| **Fail-soft** | Feature degrades to useful subset, never hard-crashes the app |

### 2.3 FinTrack — privacy-first Savings Coach

**Problem:** Expense coach that must not ship ledger data to a cloud LLM by default.

**Architecture you shipped / can defend:**

1. **Local store:** Flutter + Hive; biometric lock; no cloud sync of financial records.
2. **Retrieval:** **BM25** over local spending index (lexical, offline, explainable).
3. **Generation path:** `flutter_native_ai` → **Apple Foundation Models** / platform AI where available; else Gemini Nano-class path when present.
4. **Fail-soft:** **Deterministic rule engine** (budget thresholds, category heuristics) when model unavailable — still a coach, not a blank screen.
5. **Privacy invariant:** Prefer on-device; if any cloud path exists in a design interview variant, **PII sanitize + user consent + minimize fields**.

**Interview line (≤20s):**  
> “FinTrack is local-first — BM25 RAG over Hive, Apple Intelligence when present, rules when not; financial data doesn’t leave the device.”

→ STAR: [story-bank.md](../../stories/story-bank.md)#S15

### 2.4 GymFlow — edge embeddings recommender

**Problem:** Workout recommendations without cloud LLM cost/latency/privacy drag.

**Architecture:**

1. **INT8 MiniLM TFLite** + WordPiece tokenizer in Dart.
2. Embed query / user context; **cosine similarity** over exercise catalog; trainer routine as RAG context.
3. **Fail-soft:** **TF-IDF** lexical fallback if TFLite model missing/slow/thermal.
4. Same product principle as FinTrack: **retrieval + ranking + degradation**, not “call an LLM.”

→ STAR: [story-bank.md](../../stories/story-bank.md)#S16

### 2.5 Map portfolio → generic on-device LLM doc

Use the repo doc as the **interview HLD**; use FinTrack/GymFlow as **proof you shipped a slice**.

| Doc subsystem | Your proof |
|---|---|
| Local RAG / vector or lexical index | FinTrack BM25; GymFlow MiniLM + cosine |
| Quantized runtime | GymFlow INT8 TFLite; Apple FM path on FinTrack |
| Hybrid router / thermal | Speak design intent; implement eligibility checks |
| Token streaming UI | Partial answer updates; cancel on navigate away |
| Memory / Jetsam | Unload model, clear caches on warning |
| Privacy guard | FinTrack no-sync invariant; cloud only with sanitize |

### 2.6 Trade-offs

| Choice | When | Cost |
|---|---|---|
| BM25 lexical RAG | Offline, explainable, no embedder binary | Weaker paraphrase matching (“UBER” vs “rideshare”) |
| MiniLM / vector RAG | Semantic paraphrase | Model size, tokenizer bugs, ANR/jank if on main |
| On-device LLM generate | Privacy, latency, offline | Quality, thermal, device coverage |
| Cloud LLM fallback | Hard reasoning, huge context | Privacy, cost, latency, consent |
| Deterministic rules / TF-IDF | Fail-soft always-on | Less “magical”; must set user expectation |
| Apple Intelligence / FM | Native path, privacy story | OS/device gating; abstraction for Android |
| Always-cloud “AI feature” | Fast demo | Fails senior privacy + offline bars — avoid as default |

### 2.7 Fail-soft matrix (memorize)

| Failure | Detection | Fallback |
|---|---|---|
| OS / device lacks FM / TFLite | Capability flag at launch | Rules / TF-IDF; hide generative UI chrome |
| Model file missing / checksum fail | Load error | Same; remote config to disable |
| Thermal `.serious` / Low Power | `ProcessInfo` | Pause inference; lexical or cached tips |
| Memory warning | Notification | Unload weights, clear KV; degrade |
| Retrieval empty | Top-K = 0 | Honest empty state + generic tips — don’t hallucinate spend data |
| Cloud path needed (design) | Router decision | Sanitize PII; TLS; timeout → local message |

### 2.8 Privacy-first script (90s)

> “Financial and health-adjacent data stays on device. Retrieval runs locally. Generative models are optional accelerators behind capability checks. Analytics get coarse events — coach_shown, fallback_rule — not raw transactions. If a hybrid cloud path is required, it’s consent-gated, field-minimized, and never the only path.”

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [on-device-llm-ai-engine.md](../../../ios-system-design/docs/on-device-llm-ai-engine.md) | HLD, RAG, memory, hybrid router, mock Qs |
| Must | [story-bank.md](../../stories/story-bank.md) S15, S16 | Timed STAR proof |
| Deepen | [how-ai-summarization-agents-work.md](../../../ios-system-design/docs/how-ai-summarization-agents-work.md) | Agent loop vocabulary if asked |
| Deepen | Apple Foundation Models / WWDC on-device AI sessions | Platform vocabulary |
| Repo | [cheatsheet.md](../../../ios-system-design/docs/cheatsheet.md) | 45-min SD timing for Day 27 |

## 4. Map to your work

**Company / feature:** FinTrack Savings Coach; GymFlow recommender; contrast with BMS scale judgment (you know when *not* to run heavy on-device on 30L DAU paths without caps).  
**What you did:** Privacy-first RAG + native AI bridge + deterministic/TF-IDF fail-soft; Play Store ops awareness (Crashlytics, Remote Config).  
**Interview line (≤20s):**  
> “I treat on-device AI as retrieval plus guarded inference with an explicit degrade path — FinTrack BM25 and GymFlow MiniLM both ship that way.”

→ Full STAR: [story-bank.md](../../stories/story-bank.md)#S15 · #S16

**Scale anchors (use when contrasting consumer apps):** BookMyShow **30L+ DAU**, **99.95% crash-free** — you would not roll unconstrained on-device LLM on main checkout without kill switch + sampling (tie to feature-flag thinking).

## 5. Normal questions

### Q1. What is on-device RAG? `(30–45s)`
**Skeleton:** Embed or index local docs → retrieve top-K → inject into prompt → generate. Keeps private data local; model stays general.  
**Follow-up:** BM25 vs embeddings?  
**Story:** FinTrack BM25.

### Q2. Why quantize models on mobile? `(30–45s)`
**Skeleton:** RAM/disk; INT8/INT4 trade accuracy for fit; mmap + Neural Engine. Unquantized 3B blows Jetsam budgets.  
**Follow-up:** Quality monitoring?  
**Story:** GymFlow INT8 MiniLM.

### Q3. How do you stream tokens to UI without jank? `(30–45s)`
**Skeleton:** Background inference; `AsyncSequence`/callbacks; main-actor append; cancel on dismiss; batch UI updates.  
**Follow-up:** Partial markdown rendering?  
**Story:** —

### Q4. Privacy benefits of on-device AI? `(30–45s)`
**Skeleton:** Data minimization; offline; lower exfil risk; aligns Apple privacy narrative; still need local disk security (biometric, encryption).  
**Follow-up:** Analytics?  
**Story:** FinTrack no cloud sync.

### Q5. What is fail-soft in an AI feature? `(30–45s)`
**Skeleton:** Capability detect → degrade to rules/TF-IDF/cached → user-visible honesty; never crash; remote config kill.  
**Follow-up:** How do you measure fallback rate?  
**Story:** S15/S16.

### Q6. BM25 vs vector search — when each? `(45s)`
**Skeleton:** BM25: keyword, offline light, explainable. Vector: paraphrase/semantic. Hybrid retrieval often best. FinTrack chose BM25 for spend text + simplicity.  
**Follow-up:** Hybrid reciprocal rank fusion?  
**Story:** FinTrack vs GymFlow split.

## 6. Tricky questions

### T1. “Your on-device model hallucinates a transaction amount — who’s at fault and how do you prevent it?” `(90–120s)`
**Trap:** “Models just do that” with no product control.  
**Senior answer:** Never let generative text be source of truth for money. RAG must ground numbers from **deterministic DB reads**; prompt instructs “only use provided context”; UI shows retrieved rows; rules path for balances; eval set of prompts; fallback if retrieval score low.  
**Follow-up:** Show citation chips from retrieved chunks.

### T2. “Why not always call GPT-4o from the phone?” `(90–120s)`
**Trap:** Cost-only answer.  
**Senior answer:** Privacy, offline, latency, cost, App Store review optics for finance; cloud as optional escalate with consent. On-device for personal context; cloud for heavy reasoning if ever needed.  
**Follow-up:** How would BMS ads AI differ at 30L DAU? → sampling, server-side, strict budgets.

### T3. “Thermal throttling mid-generation — design the behavior.” `(90–120s)`
**Trap:** Ignore ProcessInfo; block UI.  
**Senior answer:** Observe thermal/Low Power; pause or switch to cloud/rules; keep last partial answer; don’t spin until Jetsam. GymFlow: skip embed refresh, use TF-IDF.  
**Follow-up:** Metrics: throttle_events, completion_rate.

### T4. “How is this different from a server RAG demo you copied from a blog?” `(90–120s)`
**Trap:** Buzzword soup.  
**Senior answer:** Mobile constraints (RAM ≤ hundreds of MB, battery, offline), **fail-soft**, privacy invariants, capability matrix across devices, cancelation/lifecycle, and shipped FinTrack/GymFlow proof — not notebook cosine demos.  
**Follow-up:** Walk FinTrack vs doc HLD mapping (§2.5).

### T5. “PII in prompts when hybrid cloud is on — concrete steps.” `(90–120s)`
**Trap:** “We encrypt HTTPS” only.  
**Senior answer:** HTTPS necessary not sufficient. Redact account numbers, names; send category aggregates not raw SMS; user toggle; retention limits; audit logs; prefer local.  
**Follow-up:** Keychain/biometric for local vault (FinTrack).

### T6. “District used AI for tests — isn’t that the same as on-device AI?” `(90–120s)`
**Trap:** Tool-worship conflation.  
**Senior answer:** Separate concerns. District: AI as **engineering accelerator** for tests (judgment on review). FinTrack/GymFlow: **product AI** with privacy/fallback architecture. Seniors don’t confuse Cursor/codegen with on-device RAG.  
**Follow-up:** Day 26 leadership — context engineering without tool-worship.

## 7. Flashcards for today

| Front | Back |
|---|---|
| On-device RAG | Local retrieve → prompt → generate · Trap: “fine-tune on user data” · Prod: FinTrack BM25 |
| Fail-soft AI | Rules/TF-IDF/capability flags · Trap: blank error only · Prod: S15/S16 |
| Quantization why | Fit RAM/ANE; INT8/INT4 · Trap: ignore quality · Prod: GymFlow MiniLM |
| Hybrid router inputs | Thermal, battery, tokens, capability · Trap: cloud always · Prod: doc HybridAIRouter |
| Privacy script | Local-first; minimize; consent cloud · Trap: HTTPS = privacy · Prod: FinTrack no sync |
| BM25 vs MiniLM | Lexical vs semantic · Trap: one-size · Prod: FinTrack vs GymFlow |
| Hallucinated money | DB is source of truth · Trap: trust tokens · Prod: FinTrack |
| KV-cache | Faster decode; RAM cost; drop on warning · Trap: ignore Jetsam · Prod: doc model manager |
| Token stream UI | Background + main append + cancel · Trap: sync main inference · Prod: — |
| AI tooling vs product AI | Accelerator ≠ on-device architecture · Trap: tool worship · Prod: District vs FinTrack |
| 30L DAU caution | Kill switch, sample, budgets · Trap: run LLM on all sessions · Prod: BMS judgment |
| Empty retrieval | No invent; generic + CTA · Trap: hallucinate · Prod: coach empty state |

## 8. Practice

- **Coding / SD:**  
  1. Whiteboard (25–30 min) full HLD from [on-device-llm-ai-engine.md](../../../ios-system-design/docs/on-device-llm-ai-engine.md) using cheatsheet timing micro: Clarify 5 + HLD 10.  
  2. Deep-dive verbally (15 min): FinTrack BM25 path **or** GymFlow TFLite path with fail-soft matrix.  
  3. Optional: sketch Swift `actor` RAG + router pseudocode from the doc (don’t rewrite the whole file).

- **Complexity / agenda to say first:** For SD: “privacy → retrieve → infer → fallback → metrics.” For STAR S15/S16: 2–3 min timed each.

## 9. Timed drill

1. Pick **3 Normal + 2 Tricky** (include T1 or T4). Record.
2. Score vs [answer-timing-guide.md](../../timing/answer-timing-guide.md) — architecture answers use **3–5 min** budget once; others 45s/120s.
3. Deliver **S15 and S16** once each at 2:30; re-cut to 2:00.
4. Log gotchas: hallucination on money, tool-vs-product AI confusion, missing fail-soft.
