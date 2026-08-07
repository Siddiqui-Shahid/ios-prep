# Audio script — Sample 04 — Debrief & structure Q&A (Q&A)
> Listen-only sample Q&A from `04-debrief-structure.md`. Spoken answers and follow-ups.

## §0 Q1. How do I self-grade with the rubric?

Next. Q1. How do I self-grade with the rubric? Answer. Score 1–5 on: Correctness, Architecture, Cache or S D U I depth, Tests, Communication, Time honesty. Pass bar: average ≥3.5, correctness ≥4, tests ≥3. A polished unfinished core scores low on correctness and time honesty even if U I pretty. Follow-ups. 3 on tests?: Borderline — pass needs ≥3 rubric dimension, prefer 4+ on correctness.. Document gaps?: README in buffer — time honesty dimension.. Debrief mandatory?:../05-exercises.md §3 — 60 min..

## §1 Q2. How do I structure a post-build architecture answer?

Next. Q2. How do I structure a post-build architecture answer? Answer. (1) Restate goal in one sentence. (2) Layer diagram aloud (U I → VM → protocol → sources). (3) One decision you made + trade-off (SWR cache vs LRU; enum factory vs protocol). (4) One cut line you chose and why. (5) One test that proves the risky path (stale response / unknown type). Under 90s unless asked to deep-dive. Follow-ups. “What would you do with 2 more hours?”: Disk cache, error retry, 4th component, U I test — prioritized list.. “What failed?”: Honest — generation bug, forgot removeFirst cost — plus fix.. Over-engineered?: Admit if yes — what minimal slice would be..

## §2 Q3. Brief A debrief — cache policy question?

Next. Q3. Brief A debrief — cache policy question? Answer. Name policy picked: SWR shows stale immediately, fetches fresh, swaps on success; generation id drops stale responses. Trade-off: user may see outdated data briefly vs blank spinner. Failure on refresh keeps stale + error banner — nonblocking. Test: mock cache hit then network update. Follow-ups. TTL?: Optional enhancement — say “would add TTL field in production.”. Disk vs memory?: Disk survives kill — cost serialization + invalidation.. Pagination + cache?: Cache page 1 only vs full list — pick and defend..

## §3 Q4. Brief B debrief — unknown type question?

Next. Q4. Brief B debrief — unknown type question? Answer. Factory default →.unknown(type) → PlaceholderView with visible “unsupported” + analytics stub. Renderer never crashes on bad server JSON. schemaVersion mismatch: degrade to empty or minimal doc — policy stated at clarify. Same instinct as CMS unknown widgets in BookMyShow backend-driven header & search-shaped apps — without claiming this repo is BMS. Follow-ups. Log PII in props?: Strip in analytics — coarse event only.. Retry decode?: No — fail-soft U I; fix server schema.. Max nesting depth?: Design: placeholder after N — crash-free culture..

## §4 Q5. “Why protocol repository / factory?” — structure?

Next. Q5. “Why protocol repository / factory?” — structure? Answer. Testability — inject fake remote/cache or JSON fixture without U I. Progress — vertical slice on stub before network/CMS ready. Swap — live A P I or new component types without rewriting VM/renderer. Cost: extra types/files — acceptable in 3hr rubric for architecture ≥4. Follow-ups. God ViewModel anti-pattern?: All logic in VM with no protocol — rubric architecture 1–2.. Over-abstract?: 5 protocols for one screen — say what you’d collapse given time.. District Free Parking + Clean/M V V M + AI tooling AI scaffold?: OK if you chose boundaries and reviewed tests..

## §5 Q6. Production bridge — what may I say after the round?

Next. Q6. Production bridge — what may I say after the round? Answer. ≤20s: “In machine rounds I optimize for a tested vertical slice — same bias shipping S D U I and list UX: contracts, fallbacks, and observable state.” BookMyShow backend-driven header & search: pagination/debounce + S D U I fallback thinking. District Free Parking + Clean/M V V M + AI tooling: you own architecture if AI helped tests. Audio streaming + server-driven splash (Aces): server-driven splash — schema resilience. Do not claim the 3hr build is production BMS code. Follow-ups. Resume bullet from today?: Learning-lab — describe as practice, not shipped feature.. 30L daily active users mention?: Only behavioral drift — not machine round proof.. Day 27 link?: Brief B prep for S D U I system design..

## §6 Q7. Exit — what should I record after debrief?

Next. Q7. Exit — what should I record after debrief? Answer. Rubric scores written. 60s demo recording or bullet script. Three architecture Q&A spoken from../04-questions.md. Cut lines README committed. One improvement for next machine round (e.g. “tests before 2:30”, “SWR stated at 0:18”). Pass/fail against bar — if fail, one focused redo block scheduled. Follow-ups. Build both briefs later?: Second session — don’t combine in one 3hr.. No Xcode artifact?: Today’s artifact is the project — no code/ folder.. Week 4 exit?: Day 26+ behavioral/architecture — this day is build muscle..

## §7 Q8. Tricky debrief T1 — cache served stale event prices; defend?

Next. Q8. Tricky debrief T1 — cache served stale event prices; defend? Answer. For the machine round I optimized perceived performance with SWR on a generic list. In production at consumer scale I’d classify fields: price and seat availability get short TTL or bypass cache, pull-to-refresh is obvious, U I shows last-updated, and caches are keyed per user/session. Stale generic metadata is acceptable; stale money is not. Document that split in the README as the next hardening step. Learning-lab + soft BookMyShow I M O C + crash-free at scale/BookMyShow backend-driven header & search judgment — no fake incident. Follow-ups. Cross-user cache?: Never for personalized/price paths — session or user key.. SWR still OK?: Yes for non-money metadata; money fields bypass or micro-TTL.. Provenance?: Practice hardening note — not a Verified BMS outage story..

## §8 Q9. Tricky debrief T2 — why not generate the whole app with AI?

Next. Q9. Tricky debrief T2 — why not generate the whole app with AI? Answer. AI can scaffold boilerplate, but I own architecture, edge cases, and tests, and I must explain every line to the proctor. Same District rule — accelerator inside a review bar, not author of record. Provenance: District Free Parking + Clean/M V V M + AI tooling judgment applied to machine-round honesty. Follow-ups. When is AI OK?: Boilerplate + tests you reviewed and can defend.. Proctor asks “did AI write this?”: Yes where it helped; here’s the seam I chose and the test I wrote.. Rubric risk?: Can’t explain → architecture/communication score collapses..

## §9 Q10. Tricky debrief T3 — unfinished image loading = fail?

Next. Q10. Tricky debrief T3 — unfinished image loading = fail? Answer. Image pipeline was an explicit cut line at minute twenty. Core pagination and cache work; cells use placeholders. In production I’d plug a shared image loader — soft nod to lifecycle-sensitive media (HeroWidget-class work) — but finishing images here would have traded away tests. Honesty spiraling. Soft BookMyShow Ads pipeline + HeroWidget lifecycle media lifecycle nod · learning-lab cuts. Follow-ups. When is cut a fail?: If core acceptance (pager/cache) unfinished — images alone aren’t.. Say cut when?: Minute ~20 clarify — write in README.. Placeholder enough?: For 3hr yes if core paths tested..

## §10 Q11. Tricky debrief T4 — show concurrency bugs in your pager?

Next. Q11. Tricky debrief T4 — show concurrency bugs in your pager? Answer. ViewModel holds a monotonic requestID. Each fetch captures the id; only matching ids commit. Refresh cancels the in-flight Task. State mutations hop to MainActor. I won’t append page N+1 from a stale task after a reset. Same class of discipline as serializing shared mutable maps — don’t let concurrent writers corrupt state. Soft BookMyShow synchronised dictionaries. Follow-ups. Generation vs cancel?: Both — cancel stops work; generation drops late commits.. Out-of-order pages?: Guard in-flight + id check before append.. Actor instead?: Fine if VM/@MainActor — say why you picked it..

## §11 Q12. Tricky debrief T5 — proctor asks you to add auth mid-round?

Next. Q12. Tricky debrief T5 — proctor asks you to add auth mid-round? Answer. Acknowledge, park auth behind an AuthProviding dependency on the remote data source, stub a static token now, and document real refresh as out of scope. I won’t rebuild the pager to chase auth unless the brief made it acceptance-critical. Learning-lab honesty — protect the vertical slice. Follow-ups. If auth is acceptance-critical?: Narrowest stub that unblocks fetch — still don’t overbuild.. Where does token live?: Injected provider — not hard-coded across layers.. README line?: “Auth: stubbed; refresh/Keychain out of scope.”.
