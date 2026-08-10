# Audio script — Sample 04 — FinTrack & GymFlow on-device AI (Q&A)
> Listen-only sample Q&A from `04-production-s15-s16.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under FinTrack on-device AI?

Next. Q1. What can you claim under FinTrack on-device AI? Answer. Flutter + Hive; biometric; no cloud sync of financial data. BM25 offline RAG + rule fallback. Bridge to Apple Foundation Models / platform AI. Play Store ops awareness (Crashlytics, Remote Config, AdMob) — qualitative. Forbidden: invented accuracy %, latency SLOs. Follow-ups. 2–3 min STAR spine?: Local-first finance → Hive+BM25+FM+rules → privacy coach with degrade → retrieval+fallback not model worship.. Money from model?: Never — DB/rules ground amounts.. Behavioral metrics?: 30L daily active users / 99.95% only as company context if drift — not FinTrack proof..

## §1 Q2. What can you claim under GymFlow on-device AI?

Next. Q2. What can you claim under GymFlow on-device AI? Answer. INT8 MiniLM TFLite + WordPiece. Cosine top-K + trainer context. TF-IDF fail-soft. Not claimed: cloud LLM dependency, invented model accuracy %. Follow-ups. Heap in production?: Top-K mental model — don’t claim CFBinaryHeap unless verified.. vs FinTrack?: Embeddings vs BM25; both on-device degrade paths.. STAR?: #GymFlow on-device AI in story-bank..

## §2 Q3. How do you contrast District Free Parking + Clean/MVVM + AI tooling District tooling?

Next. Q3. How do you contrast District Free Parking + Clean/MVVM + AI tooling District tooling? Answer. “District was context engineering for migrations/tests. FinTrack/GymFlow are product on-device systems with privacy and fail-soft. I don’t conflate Cursor with RAG.” Use District Free Parking + Clean/M V V M + AI tooling only to separate concerns when asked “how do you use AI?” Follow-ups. District Free Parking + Clean/M V V M + AI tooling in FinTrack answer?: Brief contrast — don’t lead with tooling.. Tests AI-generated?: District Free Parking + Clean/M V V M + AI tooling judgment — you own architecture and review.. Machine round Day 25?: Same rule — AI may scaffold tests; you own design..

## §3 Q4. What is soft BookMyShow IMOC + crash-free at scale applied to AI features?

Next. Q4. What is soft BookMyShow IMOC + crash-free at scale applied to AI features? Answer. Kill switches, capability flags, not crashing on model load — crash-free culture applied to AI features. At 30L+ daily active users, unconstrained on-device LLM on critical flows is a reliability/battery risk. FinTrack/GymFlow are personal-scale architecture proofs; BMS teaches when not to be reckless. Follow-ups. Invent P0 AI war story?: Forbidden unless verified later.. Feature flags?: Remote config disable bad model path.. Jetsam?: Unload weights on memory warning — fail-soft matrix..

## §4 Q5. What is the 45s bridge script?

Next. Q5. What is the 45s bridge script? Answer. “I treat on-device AI as retrieval plus guarded inference with an explicit degrade path — FinTrack BM25 and GymFlow MiniLM both ship that way. Money and recommendations stay grounded; models are optional.” Follow-ups. Provenance IDs?: FinTrack on-device AI · GymFlow on-device AI; contrast District Free Parking + Clean/M V V M + AI tooling; soft BookMyShow I M O C + crash-free at scale.. SD whiteboard?:../05-exercises.md §2 high level design 25–30 min.. Privacy 90s?: Sample 02 Q6 — memorize spine..

## §5 Q6. Anti-patterns in AI interview answers?

Next. Q6. Anti-patterns in AI interview answers? Answer. Don’t say “we fine-tuned on user ledgers.” Don’t invent latency ms or accuracy %. Don’t claim cloud sync of financial data. Don’t lead with District Cursor stories for product AI SD. Don’t skip fail-soft — seniors design degradation before happy path. Don’t treat generative text as financial source of truth. Follow-ups. Always-cloud demo?: Fast demo, fails privacy bar.. Skip retrieval?: Model doesn’t know Hive DB — RAG required.. After sample?: 07-revision-qna.md two-layer Q&A..
