# Audio script — Sample 05 — System-design mock: On-Device LLM / AI Engine (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design On-Device LLM / AI Engine.” How do you open?

Next. Q1. Interviewer: “Design On-Device LLM / AI Engine.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on HybridAIRouter and RAG + memory/thermal, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. On-device inference + local RAG? 2. Cloud hybrid fallback allowed? 3. RAM budget ≤500MB? 4. PII must not leave device by default? 5. Streaming tokens to U I? 6. Out: training/quant math? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: HybridAIRouter; on-device RAG; thermal/memory guards; streaming; PII scrub before cloud; out: training. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. U I stream ← Router ← (local ANE model + vector store) OR cloud SSE. Unmap weights on memory warning. Load: cloud if ~2k tokens or thermal serious; KV-cache example ~128MB; TTFT <100ms class. Follow-ups. FinTrack vs GymFlow?: Same shape — BM25 vs MiniLM knobs.. Tooling AI?: District Copilot ≠ product on-device — separate story..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. Local AsyncSequence tokens; cloud SSE TLS; never log raw financial text. Follow-ups. Fail-soft?: Rules/TF-IDF if model absent.. Kill?: Remote disable generative; retrieval-only..

## §4 Q5. Deep dive 1 — HybridAIRouter?

Next. Q5. Deep dive 1 — HybridAIRouter? Answer. Policy: privacy class → local only; else thermal/size → cloud; mid-stream switch on thermal. Follow-ups. User toggle?: Respect; default private for finance.. Hallucination?: Ground in retrieved docs; cite..

## §5 Q6. Deep dive 2 — RAG + memory/thermal?

Next. Q6. Deep dive 2 — RAG + memory/thermal? Answer. HNSW/VSS top-K; purge KV on warning; throttle gen; hard stop ~1024 tokens. Follow-ups. Embeddings size?: INT8 MiniLM — GymFlow angle.. Battery?: Throttle; prefer plug-in for large jobs..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. TTFT, tok/s, memory, thermal events, cloud fallback rate. Kill generative path. Follow-ups. Production?: FinTrack/GymFlow learning-lab — label honestly.. Cheatsheet?: AI stack section..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
