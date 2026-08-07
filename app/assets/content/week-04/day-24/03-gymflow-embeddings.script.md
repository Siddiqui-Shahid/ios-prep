# Audio script — Sample 03 — GymFlow embeddings & fallback (Q&A)
> Listen-only sample Q&A from `03-gymflow-embeddings.md`. Spoken answers and follow-ups.

## §0 Q1. What problem does GymFlow solve?

Next. Q1. What problem does GymFlow solve? Answer. Workout recommendations without cloud LLM cost, latency, or privacy drag. On-device ranking over exercise catalog with trainer routine as RAG-style context. Follow-ups. Cloud LLM dependency?: Not claimed.. Generative chat?: Rank/recommend — not required to stream tokens.. Day 23 link?: Top-K cosine = heap mental model..

## §1 Q2. Defend the GymFlow architecture.

Next. Q2. Defend the GymFlow architecture Answer. (1) INT8 MiniLM TFLite + WordPiece tokenizer (Dart in shipped app). (2) Embed query/user context; cosine similarity over exercise catalog; trainer routine as retrieval context. (3) Fail-soft: TF-IDF lexical fallback if TFLite missing, slow, or thermal-limited. Principle: retrieval + ranking + degradation — not “call an LLM.” Follow-ups. ≤20s line?: “GymFlow ranks exercises with on-device MiniLM embeddings and falls back to TF-IDF when the model path can’t run.”. INT8 why?: Fits mobile RAM; quality trade-off vs FP32.. STAR?: story-bank #GymFlow on-device AI..

## §2 Q3. How does cosine top-K work?

Next. Q3. How does cosine top-K work? Answer. score(a,b) = dot(a,b) / (|a| |b|). Rank exercises by score; take top-K. Same “best K under a score” instinct as Day 23 heap patterns — mental model only unless verified heap shipped. Follow-ups. Normalize vectors?: Often pre-normalized for cosine ≈ dot product.. K too large on main thread?: Batch/off-main; thermal guard.. Empty catalog?: Honest empty — don’t hallucinate exercises..

## §3 Q4. When does TF-IDF fallback kick in?

Next. Q4. When does TF-IDF fallback kick in? Answer. TFLite model missing, load/checksum fail, thermal.serious, Low Power, or memory warning → TF-IDF lexical similarity. Hide or downgrade embedding-powered U I chrome. User still gets recommendations — less “magical,” set expectations. Follow-ups. Code sketch?: code/TFIDFFallback.swift — teaching.. vs BM25 FinTrack?: Both lexical fail-soft cousins — TF-IDF for GymFlow catalog text.. Paraphrase gap?: Embeddings handle better; TF-IDF weaker — accepted degrade..

## §4 Q5. Trade-offs: BM25/lexical vs MiniLM/vector?

Next. Q5. Trade-offs: BM25/lexical vs MiniLM/vector? Answer. BM25/lexical: offline, explainable, no embedder — weaker paraphrase. MiniLM/vector: semantic paraphrase — model size, tokenizer bugs, main-thread jank if careless. On-device LLM generate: privacy/latency — quality, thermal, coverage cost. Rules/TF-IDF fail-soft: always-on, less magical. Follow-ups. FinTrack picks?: BM25 + rules — sample 02.. Always-cloud “AI feature”?: Fails senior privacy + offline bars.. Apple FM on GymFlow?: Not claimed — TFLite path verified..

## §5 Q6. Map portfolio to generic on-device HLD?

Next. Q6. Map portfolio to generic on-device HLD? Answer. Local RAG/index: FinTrack BM25; GymFlow MiniLM+cosine. Quantized runtime: GymFlow INT8 TFLite; FinTrack Apple FM path. Hybrid router + thermal: eligibility checks (code/DeviceAIEligibility.swift). Streaming U I: partial updates. Memory/jetsam: unload on warning. Privacy: FinTrack no-sync. Follow-ups. Optional deepen doc?: ios-system-design/docs/on-device-llm-ai-engine.md after chapter solid.. Day 27 link?: SD timing cheatsheet for system design day.. Scale caution BMS?: 30L daily active users — unconstrained on-device LLM on checkout is reckless..

## §6 Q7. Hybrid router — speak the design?

Next. Q7. Hybrid router — speak the design? Answer. If !eligible || thermal || lowPower → rulesOrTfIdf. Else retrieve (BM25 or embeddings). If ctx empty → emptyState. If canLocalGenerate → streamLocal. Else if cloudAllowed && consented → streamCloud(sanitize). Else rulesOrTfIdf. See code/HybridAIRouter.swift. Follow-ups. FinTrack cloud branch?: Design-only with consent — not shipped default.. Eligibility checks?: OS, memory, model file, thermal at launch and per request.. Next sample?: Production FinTrack on-device AI/GymFlow on-device AI honest proof..
