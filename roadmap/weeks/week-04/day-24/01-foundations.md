# 01 — Foundations: On-Device AI Primer

> Teach-back target: an intern can explain RAG + quantization + fail-soft before you deep-dive FinTrack/GymFlow.

---

## 0. North star

**On-device AI is retrieval + guarded inference + an explicit degrade path — not “call an LLM.” Private data stays local; models are optional accelerators behind capability checks.**

---

## 1. Staff-level pipeline (draw every time)

```text
User query
  → Device eligibility (OS, Neural Engine, memory, thermal, Low Power)
  → Retrieve local context (BM25 / vector / rules)
  → Assemble prompt (budget tokens; minimize PII for any cloud path)
  → Local generate OR cloud fallback OR deterministic template
  → Stream tokens to UI (AsyncSequence / partial updates)
  → Log quality + failure reason (not raw private prompts)
```

---

## 2. Primer glossary (45–60s each aloud)

| Concept | One-liner + mobile sting |
|---|---|
| **Token** | Model I/O unit ≈ ¾ word; context window is a hard budget |
| **Quantization** | FP16 3B ≈ huge RAM; INT4/INT8 makes on-device feasible; quality trade-off |
| **Embedding** | Fixed-dim vector of meaning; cosine ≈ semantic closeness |
| **RAG** | Retrieve private/local chunks → stuff into prompt; model not “trained” on your Hive DB |
| **KV-cache** | Speeds decode; eats RAM; drop under memory pressure |
| **Hybrid router** | Local first; cloud/rules when thermal, complexity, or capability fails |
| **BM25** | Classical lexical retrieval — strong offline, no embedder required |
| **TF-IDF** | Lexical weighting — GymFlow’s fail-soft cousin |
| **Fail-soft** | Feature degrades to a useful subset; never hard-crashes the app |
| **ANE / NPU** | Hardware path for inference; not always available / not always free thermally |

### Quantization intuition (say cleanly)

> “Unquantized multi-billion-parameter weights blow mobile RAM budgets. INT8/INT4 shrink weights so mmap + Neural Engine can run. You trade some quality for fit — and you still need a path when the model file is missing.”

### RAG intuition (say cleanly)

> “The model doesn’t know the user’s ledger. I retrieve relevant local rows or docs, put them in the prompt, and ground answers in that context. Numbers for money come from the database, not from free-form generation.”

---

## 3. Two products, one principle

| | FinTrack (S15) | GymFlow (S16) |
|---|---|---|
| Domain | Personal finance coach | Workout recommender |
| Retrieve | **BM25** over local spend index | **MiniLM** embeddings + cosine |
| Generate / rank | Apple Intelligence / FM when present | Embedding similarity top-K |
| Fail-soft | **Deterministic rules** | **TF-IDF** |
| Privacy invariant | **No cloud sync** of financial records | Prefer on-device; no cloud LLM required |

**Say aloud:** “Same architecture shape — different retrieval and fallback knobs.”

---

## 4. Fail-soft before happy path (senior habit)

| Failure | Fallback |
|---|---|
| No Foundation Model / no TFLite | Rules / TF-IDF; hide generative chrome |
| Model missing / checksum fail | Same |
| Thermal / Low Power | Pause infer; lexical or cached tips |
| Memory warning | Unload weights; clear KV |
| Empty retrieval | Honest empty + generic tips — **don’t hallucinate** |

---

## 5. Product AI vs tooling AI (do not conflate)

| | Product (S15/S16) | Tooling (S9 District) |
|---|---|---|
| Who uses it | End user in the app | You as engineer |
| Risk | Privacy, hallucination, thermal | Bad tests, false greens |
| Story | Architecture + fail-soft | Context engineering + review |

---

## 6. Complexity / ops scripts

**Privacy 90s** (memorize spine): local-first → retrieve local → generative optional → analytics coarse → cloud only consent + minimize.

**SD agenda 10s:** privacy → retrieve → infer → fallback → metrics.

→ [`02-deep-dive.md`](02-deep-dive.md)
