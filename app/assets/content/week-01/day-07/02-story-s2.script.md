# Audio script — Sample 02 — Story S2 (Q&A)
> Listen-only sample Q&A from `02-story-s2.md`. Spoken answers and follow-ups.

## §0 Q1. What is the ≤20s elevator pitch for S2?

Next. Q1. What is the ≤20s elevator pitch for S2? Answer. “We gated shared dictionaries behind a serial queue A P I so call sites couldn’t race the storage — crashes went away on that path.” Label Verified · S 2 · BookMyShow · synchronised dictionaries. Do not claim sole ownership of 99.95% crash free sessions from this story alone. Follow-ups. Must-not?: Fake crash-percent drop you cannot prove.. Scale context?: 30L+ daily active users / crash free sessions culture is S 8 — cite softly, do not paste onto every beat.. vs generic “I fixed a race”?: Named mechanism: serial A P I around shared dicts..

## §1 Q2. Walk the ≤3 min STAR beats.

Next. Q2. Walk the ≤3 min STAR beats Answer. Situation: Shared dictionaries accessed from many threads on a high-traffic path — intermittent races/crashes. Task: Stop callers from touching unsynchronized storage. Action: Serial queue (or RW pattern) behind get/set/snapshot A P I; stress testing; Crashlytics to confirm path fixed. Result: Crashes eliminated on that path — qualitative, path-specific. Lesson: Hide concurrency; don’t trust every call site to dispatch correctly. Follow-ups. Missing beat?: Interviewer scores STAR table in deep dive — fill each row.. Crashlytics role?: Confirm fix on the affected crash signature — not invented %.. Actor coda?: One sentence at end — leads to S 2-A1 follow-up..

## §2 Q3. Required follow-up: “How would you design this today?”

Next. Q3. Required follow-up: “How would you design this today?” Answer. How I would apply it · S 2-A1: Expose an actor with the same get/set/snapshot surface — callers await; isolation moves into the type system. Production was G C D; this is migration language, not “we rewrote everything as actors last quarter.” Follow-ups. Provenance label?: Say “Applied” or “how I’d apply it” — not Verified for actor rewrite.. A P I surface?: Keep safe methods — don’t expose raw dict + external locks.. Big-bang?: Module-by-module façade — deep pool D4..

## §3 Q4. Why hide the queue instead of documenting “always dispatch here”?

Next. Q4. Why hide the queue instead of documenting “always dispatch here”? Answer. Documentation does not survive scale — new call sites forget, copy-paste wrong queue, or mix sync/async. An A P I forces synchronization at compile/link boundaries. Same reason actors beat “please don’t touch my dict”: the type enforces the contract. Follow-ups. Performance?: Serial queue contention — acceptable vs data races on hot path fix.. Reader-writer variant?: Many reads, barrier writes — if profiling showed read dominance.. Test strategy?: Stress + thread sanitizer mindset — path-specific validation..

## §4 Q5. What must you NOT claim in S2?

Next. Q5. What must you NOT claim in S2? Answer. Do not invent fill-rate, crash-percent, or “I single-handedly raised crash free sessions to 99.95%.” Do not say Memory Graph was your primary prod tool unless labeled Applied. Honest result: path-specific crash reduction after serializing dictionary access. Use S 8 only for scale/reliability culture context. Follow-ups. Interviewer cut line?: “Don’t invent a metric — what’s the honest result?”. Qualitative OK?: Yes — “crashes on this signature stopped” is strong.. S 1 confusion?: S 1 is ads P O P — different story; optional encore..

## §5 Q6. How is S8 adjacent without stealing the story?

Next. Q6. How is S8 adjacent without stealing the story? Answer. When asked why races matter at BMS scale: 30L+ daily active users, 99.95%+ crash-free culture, Crashlytics / I M O C — Verified · S 8. One or two sentences max. Do not paste crash free sessions onto every answer or imply S 2 alone delivered company-wide crash free sessions. Follow-ups. I M O C?: Incident management on-call culture — reliability spine.. Every mock answer?: No — use when risk/scale question appears.. vs S 2 result?: S 2 = specific fix; S 8 = environment why it mattered..

## §6 Q7. Score yourself on S2 — what earns a 4 or 5?

Next. Q7. Score yourself on S2 — what earns a 4 or 5? Answer. 4: On time (≤3 min), clear STAR, trade-off or prod hook, honest provenance. 5: All of 4 + crisp Verified vs Applied labels + ready for actor follow-up. 2 or below: invented metrics, missing action mechanism, or crash free sessions ownership theft. Target S 2 ≥4 for Mock #1 pass. Follow-ups. Time box?: 3 min story + ~90s actor follow-up in mock script.. Record yourself?: Self-mock mode in deep dive §7.. Weak story?: Re-drill production bridge before full mock.. Next: 03-mock-interview.md.
