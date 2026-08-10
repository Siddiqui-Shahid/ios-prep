# Audio script — Sample 07 — Revision Q&A (day-24) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. What is on-device RAG? `(30–45s)`

Next. Q1. What is on-device RAG? `(30–45s)` Answer. On-device RAG means I keep the user’s private data local, retrieve the most relevant chunks for a query, and feed that context into generation or ranking. The model isn’t fine-tuned on the ledger — it reasons over retrieved rows. On FinTrack I use BM25 over a local spending index so retrieval works offline without an embedder. Follow-ups. BM25 vs embeddings?: BM25 ranks by term frequency/IDF with no embedder download; embeddings catch paraphrase but need an on-device model and vector index.. Empty retrieval behavior?: Show a clear empty state or fall back to deterministic rules on FinTrack — never invent spend insights from an empty local index..

## §1 Q2. Why quantize models on mobile? `(30–45s)`

Next. Q2. Why quantize models on mobile? `(30–45s)` Answer. Mobile RAM budgets can’t host large full-precision weights. Quantization shrinks parameters to INT8 or INT4 so we can mmap and run on the Neural Engine. You trade some quality for fit. GymFlow ships an INT8 MiniLM TFLite model for that reason — and still has TF-IDF if the model path fails. Follow-ups. How monitor quality regressions?: Track offline eval (precision@k / preference) plus production fallback and dismiss/retry rates — not invented live accuracy percentages.. FP16 vs INT8 when?: Prefer INT8 when RAM must fit a mmapped mobile model like GymFlow’s MiniLM; move toward FP16 only if eval shows INT8 quality loss and memory still allows it..

## §2 Q3. How do you stream tokens to UI without jank? `(30–45s)`

Next. Q3. How do you stream tokens to UI without jank? `(30–45s)` Answer. I run inference off the main thread and stream tokens through an AsyncSequence or callback into MainActor U I updates. I cancel the task when the user navigates away so work doesn’t outlive the screen. I batch rapid tokens to avoid layout thrash. Partial answers stay on screen if we pause for thermal. Follow-ups. Partial markdown rendering?: Render completed blocks or plain text until a fence/heading closes — don’t re-parse a broken partial fence on every token.. Backpressure if U I slower than decode?: Coalesce tokens into batches (or drop intermediate frames) so MainActor updates can’t queue unboundedly behind decode..

## §3 Q4. Privacy benefits of on-device AI? `(30–45s)`

Next. Q4. Privacy benefits of on-device AI? `(30–45s)` Answer. On-device AI keeps sensitive context on the phone, works offline, and reduces exfiltration risk. That matches Apple’s privacy narrative, but it’s not automatic — local vaults still need biometric locks and encryption at rest. FinTrack’s invariant is no cloud sync of financial records; analytics stay coarse events, not raw transactions. Follow-ups. Analytics design?: Emit coarse feature events (opened, fallback, cancelled) without transaction text or other PII payloads.. When is cloud ever OK?: Optional opt-in sync or non-sensitive telemetry — never as the default path for FinTrack’s financial ledger..

## §4 Q5. What is fail-soft in an AI feature? `(30–45s)`

Next. Q5. What is fail-soft in an AI feature? `(30–45s)` Answer. Fail-soft means I detect capability and runtime pressure, then degrade to a still-useful path — deterministic rules on FinTrack, TF-IDF on GymFlow — instead of crashing or showing a dead feature. I hide generative chrome when the model isn’t there, and I keep a remote-config kill switch. Users get honesty, not hallucinated magic. Follow-ups. Metrics for fallback rate?: Count model-path versus TF-IDF/rules-path sessions and thermal/cancel reasons — soft-fail rate, not fake accuracy numbers.. Thermal mid-generation?: Pause or cancel generation, keep partial U I text, and offer resume/retry after cooling — same fail-soft honesty as FinTrack/GymFlow..

## §5 Q6. BM25 vs vector search — when each? `(45s)`

Next. Q6. BM25 vs vector search — when each? `(45s)` Answer. BM25 is strong for keyword-ish personal text, fully offline, and explainable without shipping an embedder. Vector search with MiniLM handles paraphrase and semantic closeness better at the cost of model size and tokenizer complexity. FinTrack chose BM25 for spend text simplicity; GymFlow chose embeddings for exercise similarity — with TF-IDF as lexical fail-soft. Follow-ups. Hybrid reciprocal rank fusion?: Merge BM25 and vector ranked lists by reciprocal ranks so keyword and semantic hits both surface without brittle score calibration.. Why not BM25 alone for GymFlow?: Exercise names paraphrase (“bench press” vs “chest press”); embeddings catch that better than pure lexical BM25 on GymFlow..

## §6 Q7. What is the one rule to remember for day-24? `(30–45s)`

Next. Q7. What is the one rule to remember for day-24? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §7 Q8. What is the one rule to remember for day-24? `(30–45s)`

Next. Q8. What is the one rule to remember for day-24? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §8 Q9. What is the one rule to remember for day-24? `(30–45s)`

Next. Q9. What is the one rule to remember for day-24? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §9 Q10. What is the one rule to remember for day-24? `(30–45s)`

Next. Q10. What is the one rule to remember for day-24? `(30–45s)` Answer. “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §10 I1. A junior asks you in standup: “What is on-device RAG?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “What is on-device RAG?” — how do you answer without jargon? `(60–90s)` Answer. “On-device RAG means I keep the user’s private data local, retrieve the most relevant chunks for a query, and feed that context into generation or ranking. The model isn’t fine-tuned on the ledger — it reasons over retrieved rows. On FinTrack I use BM25 over a local spending index so retrieval works offline without an embedder.” Follow-ups. What concept is this really?: What is on-device RAG. How do you prove it?: Give a tiny example or production boundary..

## §11 I2. Production symptom: something related to “Why quantize models on mobile” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Why quantize models on mobile” just broke under load. What do you check first? `(60–90s)` Answer. “Mobile RAM budgets can’t host large full-precision weights. Quantization shrinks parameters to INT8 or INT4 so we can mmap and run on the Neural Engine. You trade some quality for fit. GymFlow ships an INT8 MiniLM TFLite model for that reason — and still has TF-IDF if the model path fails.” Follow-ups. What concept is this really?: Why quantize models on mobile. How do you prove it?: Give a tiny example or production boundary..

## §12 I3. Interviewer never names the topic. They describe a mess that maps to “How do you stream tokens to UI without jank”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “How do you stream tokens to UI without jank”. How do you diagnose? `(60–90s)` Answer. “I run inference off the main thread and stream tokens through an AsyncSequence or callback into MainActor U I updates. I cancel the task when the user navigates away so work doesn’t outlive the screen. I batch rapid tokens to avoid layout thrash. Partial answers stay on screen if we pause for thermal.” Follow-ups. What concept is this really?: How do you stream tokens to U I without jank. How do you prove it?: Give a tiny example or production boundary..

## §13 I4. Code review: you spot a smell around “Privacy benefits of on-device AI”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Privacy benefits of on-device AI”. What do you say and what fix do you propose? `(60–90s)` Answer. “On-device AI keeps sensitive context on the phone, works offline, and reduces exfiltration risk. That matches Apple’s privacy narrative, but it’s not automatic — local vaults still need biometric locks and encryption at rest. FinTrack’s invariant is no cloud sync of financial records; analytics stay coarse events, not raw transactions.” Follow-ups. What concept is this really?: Privacy benefits of on-device AI. How do you prove it?: Give a tiny example or production boundary..

## §14 I5. What happens if a teammate ignores the rule behind “What is fail-soft in an AI feature”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “What is fail-soft in an AI feature”? `(60–90s)` Answer. “Fail-soft means I detect capability and runtime pressure, then degrade to a still-useful path — deterministic rules on FinTrack, TF-IDF on GymFlow — instead of crashing or showing a dead feature. I hide generative chrome when the model isn’t there, and I keep a remote-config kill switch. Users get honesty, not hallucinated magic.” Follow-ups. What concept is this really?: What is fail-soft in an AI feature. How do you prove it?: Give a tiny example or production boundary..

## §15 I6. Walk me through a failed interview answer on “BM25 vs vector search — when each” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “BM25 vs vector search — when each” and how you’d correct it? `(60–90s)` Answer. “BM25 is strong for keyword-ish personal text, fully offline, and explainable without shipping an embedder. Vector search with MiniLM handles paraphrase and semantic closeness better at the cost of model size and tokenizer complexity. FinTrack chose BM25 for spend text simplicity; GymFlow chose embeddings for exercise similarity — with TF-IDF as lexical fail-soft.” Follow-ups. What concept is this really?: BM25 vs vector search — when each. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §16 T1. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T1. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §17 T2. They want a one-tool forever answer? `(90–120s)`

Next. T2. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §18 T3. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T3. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §19 T4. Main-thread rule under pressure? `(90–120s)`

Next. T4. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §20 T5. Cancellation honesty? `(90–120s)`

Next. T5. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T6. Cache invalidation trap? `(90–120s)`

Next. T6. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T7. Security theater vs real pinning? `(90–120s)`

Next. T7. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T8. SDUI unknown component in prod? `(90–120s)`

Next. T8. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T9. DI vs singletons under test? `(90–120s)`

Next. T9. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T10. Prefetch that hurts scrolling? `(90–120s)`

Next. T10. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
