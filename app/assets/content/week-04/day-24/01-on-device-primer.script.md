# Audio script — Sample 01 — On-device AI primer (Q&A)
> Listen-only sample Q&A from `01-on-device-primer.md`. Spoken answers and follow-ups.

## §0 Q1. What is on-device AI in one sentence?

Next. Q1. What is on-device AI in one sentence? Answer. Retrieval + guarded inference + an explicit degrade path — not “call an LLM.” Private data stays local; models are optional accelerators behind capability checks. Draw the pipeline every time: eligibility → retrieve → prompt → local infer / fallback → stream → metrics. Follow-ups. Always generate?: No — rank-only (GymFlow) or rules (FinTrack fallback) are valid outputs.. Cloud default?: Fails senior privacy + offline bars for finance/health-adjacent data.. SD agenda 10s?: Privacy → retrieve → infer → fallback → metrics..

## §1 Q2. Walk the staff-level pipeline.

Next. Q2. Walk the staff-level pipeline Answer. User query → device eligibility (OS, Neural Engine, memory, thermal, Low Power) → retrieve local context (BM25 / vector / rules) → assemble prompt (token budget; minimize PII for any cloud path) → local generate OR cloud fallback OR deterministic template → stream tokens to U I → log quality + failure reason (not raw private prompts). Follow-ups. Eligibility examples?: No FM, thermal serious, memory warning → skip infer.. Stream U I?: AsyncSequence / partial updates; cancel on navigate away.. Metrics?: Coarse events — coach_shown, fallback_rule — not ledger text..

## §2 Q3. What do token, quantization, and embedding mean on mobile?

Next. Q3. What do token, quantization, and embedding mean on mobile? Answer. Token: model I/O unit ≈ ¾ word; context window is a hard budget. Quantization: FP16 multi-B weights blow RAM; INT8/INT4 shrink weights for mmap + Neural Engine — quality trade-off. Embedding: fixed-dim meaning vector; cosine ≈ semantic closeness. KV-cache: speeds decode, eats RAM — drop under memory pressure. Follow-ups. Unquantized 3B on phone?: Usually infeasible — say why quant matters.. BM25 vs embedding retrieve?: Lexical vs semantic paraphrase — different trade-offs.. ANE / NPU?: Hardware path — not always available or thermally free..

## §3 Q4. What is RAG in plain words?

Next. Q4. What is RAG in plain words? Answer. Retrieve relevant local chunks (ledger rows, exercises, docs), put them in the prompt, ground answers in that context. The model is not “trained on your Hive DB.” For money, numbers come from the database, not free-form generation. Follow-ups. Empty retrieval?: Honest empty + generic tips — don’t hallucinate balances.. Cloud RAG?: Only with sanitize + consent + minimize — never only path for FinTrack.. Hybrid router?: Local first; cloud/rules when capability or thermal fails..

## §4 Q5. What is fail-soft and why before happy path?

Next. Q5. What is fail-soft and why before happy path? Answer. Feature degrades to a useful subset — never hard-crashes the app. Seniors design degrade paths first: no FM/TFLite → rules/TF-IDF; thermal/Low Power → pause infer; memory warning → unload weights; empty retrieval → honest empty state. Hide generative chrome when infer unavailable. Follow-ups. Model checksum fail?: Same fallback; remote config disable.. User sees blank?: Bad — rules/TF-IDF still coach/recommend.. Kill switch?: S 8 culture — feature flags at consumer scale..

## §5 Q6. Product AI vs tooling AI (S9)?

Next. Q6. Product AI vs tooling AI (S9)? Answer. Product (S15/S16): end user in app — risks are privacy, hallucination, thermal. Tooling (S9 District): engineer uses AI for migrations/tests — risks are bad tests, false greens. Don’t conflate Cursor/context engineering with FinTrack RAG. Follow-ups. Interview trap?: “How do you use AI?” — separate product architecture from IDE tooling.. S9 in STAR?: Only as contrast — not as on-device proof.. Same hybrid router?: Shape similar; stakes and privacy differ..

## §6 Q7. FinTrack vs GymFlow — same shape, different knobs?

Next. Q7. FinTrack vs GymFlow — same shape, different knobs? Answer. FinTrack: BM25 lexical retrieve; Apple FM when present; deterministic rules fail-soft; no cloud sync of financial records. GymFlow: INT8 MiniLM embeddings + cosine top-K; TF-IDF fail-soft; on-device, no cloud LLM required. Say aloud: “Same architecture shape — different retrieval and fallback knobs.” Follow-ups. Both RAG?: FinTrack yes; GymFlow retrieval+rank — generative optional/absent.. Privacy invariant FinTrack?: Financial data stays on device.. Next samples?: Deep dive each product in 02 and 03.. Next: 02-fintrack-rag.md.
