# Audio script — Sample 03 — Warm-up & recovery (Q&A)
> Listen-only sample Q&A from `03-warmup-recovery.md`. Spoken answers and follow-ups.

## §0 Q1. How will you open the coding round?

Next. Q1. How will you open the coding round? Answer. “I restate the problem, clarify constraints, give a one-line brute force, name the optimized pattern — hash, heap, window, or tree — state complexity and edges, then code. I narrate throughout and leave a few minutes for edges.” 30–45s — then execute on the clock. Follow-ups. Brute force always required?: Yes — shows thinking before optimization.. Pattern wrong at min 5?: See W2 — narrate pivot.. No edges at 42?: Backfill from clarify list — duplicates, empty, single element..

## §1 Q2. You misclassified the pattern at minute five — what now?

Next. Q2. You misclassified the pattern at minute five — what now? Answer. Say the new classification aloud, keep any reusable helpers, rewrite the core loop. Communication of the pivot scores; silent thrashing through the whole file doesn’t. Example: “This is really a hash map problem, not two pointers — I’ll keep the frequency map and rewrite the scan.” Follow-ups. Start file over?: Salvage imports/helpers — don’t delete working pieces.. Hide the mistake?: Worse — interviewer sees silent rewrite.. Still wrong at 45?: State optimal approach + complexity for partial credit..

## §2 Q3. GCD serial queue vs actor — 45s?

Next. Q3. GCD serial queue vs actor — 45s? Answer. “A serial queue serializes work on shared state; we used that pattern around synchronised dictionaries at BookMyShow. A Swift actor is a reference type with isolated state and await at the boundary — I’d prefer it for greenfield shared maps. Actors can reenter across await — I design for that.” Follow-ups. BookMyShow synchronised dictionaries provenance?: BookMyShow synchronised dictionaries G C D prod; Design: actor SafeDict (not shipped) actor migration.. Concurrent queue for shared dict?: Wrong default — data races.. @MainActor vs custom actor?: Main for U I; custom for domain state..

## §3 Q4. SDUI unknown type — 45s?

Next. Q4. SDUI unknown type — 45s? Answer. “Unknown components render a placeholder, emit a coarse analytics event, and never force-unwrap. Schema version gates fail closed. Same instinct as backend-driven header work — resilience over assuming perfect CMS.” Follow-ups. Crash on unknown?: Fail — senior answer is degrade + log.. BookMyShow backend-driven header & search provenance?: Soft backend-driven surfaces.. Force-unwrap JSON?: Never — map to fallback model..

## §4 Q5. How will you open system design?

Next. Q5. How will you open system design? Answer. “I’ll spend five minutes clarifying scope, daily active users, offline needs, and latency expectations, then draw a four-layer client high level design, deep-dive two hard subsystems, and reserve the last five for failure modes, metrics, and kill switches.” Follow-ups. Four layers?: Presentation · domain/use cases · data/network · platform/services — adapt naming.. Skip “does that work?”: Optional but helps align with interviewer.. Clarify daily active users why?: Drives cache, pagination, offline scope..

## §5 Q6. Name three production proofs?

Next. Q6. Name three production proofs? Answer. “30L+ daily active users context, 99.95%+ crash-free, 30%+ LE navigation reduction — plus I’ll keep one specialty loaded: S D U I, pinning, S D K, or on-device AI depending on the prompt.” Follow-ups. Only two proofs?: Add BookMyShow SSL pinning + URLSession migration pinning or Stories S D K (Raw / Miami Heat) S D K as fourth if needed.. Overclaim nav metric?: “Targeted flows” scope always.. District proof?: District Free Parking + Clean/M V V M + AI tooling for architecture/AI tooling — separate from FinTrack on-device AI..

## §6 Q7. SD deep dive running long — what do you cut?

Next. Q7. SD deep dive running long — what do you cut? Answer. Summarize and park the third deep dive. Seniors protect the last five minutes for failure modes, metrics, and rollout. Happy-path forever is a mid signal. Say: “I’ll table caching details and cover kill switch and degrade paths.” Follow-ups. Kill switch example?: Feature flag off bad S D U I schema version.. Metrics in ops block?: Crash-free, p90 latency, rollout % — concrete.. Never reach high level design?: Clarify overrun — reset at 5 min hard..

## §7 Q8. They ask on-device AI but you prepared SDUI?

Next. Q8. They ask on-device AI but you prepared SDUI? Answer. Pivot cleanly: privacy constraints, local retrieval, on-device inference, fail-soft matrix. FinTrack BM25 and GymFlow MiniLM as proof. Still use four-layer client sketch; slightly shorter high level design is fine if clarify was strong. Follow-ups. FinTrack on-device AI vs GymFlow on-device AI?: FinTrack rules+RAG vs GymFlow TF-IDF fallback.. Panic pivot?: State assumption — “I'll design on-device Q&A with local retrieval.”. Drop S D U I entirely?: Yes — match the prompt, keep structure..

## §8 Q9. Pool E — retain cycle in 30s?

Next. Q9. Pool E — retain cycle in 30s? Answer. “A retain cycle is a strong reference loop keeping objects alive. Closures capturing self are the usual UIKit suspect — I break them with weak self and verify with Allocations/Leaks when needed.” Follow-ups. Unowned when?: Lifetime guaranteed shorter than capture — rare; prefer weak in U I.. Delegates?: Weak by convention — strong delegate = classic cycle.. Instruments tool?: Allocations / Leaks — Graph for abandoned heaps (Day 03/18)..

## §9 Q10. Pool E — SSL pinning one-liner + BookMyShow SSL pinning + URLSession migration?

Next. Q10. Pool E — SSL pinning one-liner + BookMyShow SSL pinning + URLSession migration? Answer. “ATS is system TLS policy; pinning is an app-level identity check on the certificate or SPKI. On Ads we moved Alamofire to URLSession with HTTPS, pinning, and host whitelist.” Provenance: BookMyShow SSL pinning + URLSession migration Follow-ups. SPKI vs leaf?: Prefer SPKI hash — survives cert renewals better than leaf pin.. Pin all hosts?: No — allowlisted sensitive hosts.. Rotation?: Backup pins + ship client before rotate — design (Design: pin rotation / break-glass (not shipped runbook))..

## §10 Q11. Pool E — why p50 / p90?

Next. Q11. Pool E — why p50 / p90? Answer. “Averages hide pain. p50 and p90 on listing, checkout, and search traces show typical and tail experience — we instrumented those with Firebase Performance.” Provenance: BookMyShow Firebase Performance traces Follow-ups. Only average?: Mid signal — seniors name percentiles.. Which journeys?: Listing, checkout, search — resume-true.. Ops pause?: Cliff on p90 → pause rollout (BookMyShow I M O C + crash-free at scale culture)..

## §11 Q12. Pool E — fail-soft AI in 30s?

Next. Q12. Pool E — fail-soft AI in 30s? Answer. “If the model path can’t run, FinTrack falls to deterministic rules and GymFlow to TF-IDF — useful degrade, not a blank crash.” Provenance: FinTrack on-device AI · GymFlow on-device AI Follow-ups. Thermal mid-gen?: Pause infer; keep partial; rules/TF-IDF (Day 24).. Hide chrome?: Yes — don’t show generative U I when unavailable.. Next sample?: 04-fix-forwards.md..
