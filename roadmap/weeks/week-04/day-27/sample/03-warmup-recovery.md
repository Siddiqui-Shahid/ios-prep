# Sample 03 — Warm-up & recovery (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How will you open the coding round?

**Points to:** [Questions · W1](../04-questions.md#w1-how-will-you-open-the-coding-round-3045s) · [Foundations · §2 Openers](../01-foundations.md#2-openers-rehearse-30s-each-before-segment)

**Answer:**

> “I restate the problem, clarify constraints, give a one-line brute force, name the optimized pattern — hash, heap, window, or tree — state complexity and edges, then code. I narrate throughout and leave a few minutes for edges.”  
> **30–45s** — then execute on the clock.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Brute force always required? | Yes — shows thinking before optimization. |
| Pattern wrong at min 5? | See W2 — narrate pivot. |
| No edges at 42? | Backfill from clarify list — duplicates, empty, single element. |

---

### Q2. You misclassified the pattern at minute five — what now?

**Points to:** [Questions · W2](../04-questions.md#w2-you-misclassified-the-pattern-at-minute-five--what-now-45s)

**Answer:**

> Say the **new classification aloud**, keep any reusable helpers, rewrite the core loop. **Communication of the pivot scores**; silent thrashing through the whole file doesn’t. Example: “This is really a hash map problem, not two pointers — I’ll keep the frequency map and rewrite the scan.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Start file over? | Salvage imports/helpers — don’t delete working pieces. |
| Hide the mistake? | Worse — interviewer sees silent rewrite. |
| Still wrong at 45? | State optimal approach + complexity for partial credit. |

---

### Q3. GCD serial queue vs actor — 45s?

**Points to:** [Questions · W3](../04-questions.md#w3-gcd-serial-queue-vs-actor--45s)

**Answer:**

> “A serial queue serializes work on shared state; we used that pattern around synchronised dictionaries at BookMyShow. A Swift actor is a reference type with isolated state and `await` at the boundary — I’d prefer it for greenfield shared maps. Actors can reenter across `await` — I design for that.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S2 provenance? | Verified S2 GCD prod; Applied S2-A1 actor migration. |
| Concurrent queue for shared dict? | Wrong default — data races. |
| `@MainActor` vs custom actor? | Main for UI; custom for domain state. |

---

### Q4. SDUI unknown type — 45s?

**Points to:** [Questions · W4](../04-questions.md#w4-sdui-unknown-type--45s)

**Answer:**

> “Unknown components render a placeholder, emit a coarse analytics event, and never force-unwrap. Schema version gates fail closed. Same instinct as backend-driven header work — resilience over assuming perfect CMS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crash on unknown? | Fail — senior answer is degrade + log. |
| S3 provenance? | Soft Verified · backend-driven surfaces. |
| Force-unwrap JSON? | Never — map to fallback model. |

---

### Q5. How will you open system design?

**Points to:** [Questions · W6](../04-questions.md#w6-how-will-you-open-system-design-3045s)

**Answer:**

> “I’ll spend five minutes clarifying scope, DAU, offline needs, and latency expectations, then draw a four-layer client HLD, deep-dive two hard subsystems, and reserve the last five for failure modes, metrics, and kill switches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Four layers? | Presentation · domain/use cases · data/network · platform/services — adapt naming. |
| Skip “does that work?” | Optional but helps align with interviewer. |
| Clarify DAU why? | Drives cache, pagination, offline scope. |

---

### Q6. Name three production proofs?

**Points to:** [Questions · W7](../04-questions.md#w7-name-three-production-proof-3045s) · [Production bridge · Proof trio](../03-production-bridge.md)

**Answer:**

> “**30L+ DAU** context, **99.95%+ crash-free**, **30%+** LE navigation reduction — plus I’ll keep one specialty loaded: SDUI, pinning, SDK, or on-device AI depending on the prompt.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Only two proofs? | Add S4 pinning or S10 SDK as fourth if needed. |
| Overclaim nav metric? | “Targeted flows” scope always. |
| District proof? | S9 for architecture/AI tooling — separate from S15. |

---

### Q7. SD deep dive running long — what do you cut?

**Points to:** [Questions · W9](../04-questions.md#w9-sd-deep-dive-running-long--what-do-you-cut-90s) · [Deep dive · Protect ops](../02-deep-dive.md#segment-c--system-design-45)

**Answer:**

> Summarize and **park the third deep dive**. Seniors protect the **last five minutes** for failure modes, metrics, and rollout. Happy-path forever is a mid signal. Say: “I’ll table caching details and cover kill switch and degrade paths.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Kill switch example? | Feature flag off bad SDUI schema version. |
| Metrics in ops block? | Crash-free, p90 latency, rollout % — concrete. |
| Never reach HLD? | Clarify overrun — reset at 5 min hard. |

---

### Q8. They ask on-device AI but you prepared SDUI?

**Points to:** [Questions · W12](../04-questions.md#w12-they-ask-on-device-ai-but-you-prepared-sdui-90s)

**Answer:**

> Pivot cleanly: privacy constraints, local retrieval, on-device inference, fail-soft matrix. **FinTrack BM25** and **GymFlow MiniLM** as proof. Still use four-layer client sketch; slightly shorter HLD is fine if clarify was strong.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S15 vs S16? | FinTrack rules+RAG vs GymFlow TF-IDF fallback. |
| Panic pivot? | State assumption — “I'll design on-device Q&A with local retrieval.” |
| Drop SDUI entirely? | Yes — match the prompt, keep structure. |

---

Next: [04-fix-forwards.md](04-fix-forwards.md)
