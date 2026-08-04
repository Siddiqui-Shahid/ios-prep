# 04 — Warm-up Two-Layer Q Pools

> Use in the **15 min warm-up** or between segments — **not** instead of the mock.  
> Cover full answer; speak from points.

---

## Pool A — Coding openers

### W1. How will you open the coding round? `(30–45s)`

**Answer points:** Restate · clarify · brute · optimize · complexity · edges · code

**Full spoken answer:**  
> “I restate the problem, clarify constraints, give a one-line brute force, name the optimized pattern — hash, heap, window, or tree — state complexity and edges, then code. I narrate throughout and leave a few minutes for edges.”

**Provenance:** Learning-lab · Days 22–23

---

### W2. You misclassified the pattern at minute five — what now? `(45s)`

**Answer points:** Narrate pivot · don’t silent rewrite entire file · salvage correct pieces

**Full spoken answer:**  
> “I say the new classification aloud, keep any reusable helpers, and rewrite the core loop. Communication of the pivot scores; silent thrashing doesn’t.”

---

## Pool B — iOS deep dive warm-ups

### W3. GCD serial queue vs actor — 45s

**Answer points:** Both serialize · actor language-native isolation · S2 bridge · reentrancy caveat high-level

**Full spoken answer:**  
> “A serial queue serializes work on shared state; we used that pattern around synchronised dictionaries at BookMyShow. A Swift actor is a reference type with isolated state and await at the boundary — I’d prefer it for greenfield shared maps. Actors can reenter across await — I design for that.”

**Provenance:** Verified · S2; Applied · S2-A1

---

### W4. SDUI unknown type — 45s

**Answer points:** Fallback · don’t crash · log · schema version

**Full spoken answer:**  
> “Unknown components render a placeholder, emit a coarse analytics event, and never force-unwrap. Schema version gates fail closed. Same instinct as backend-driven header work — resilience over assuming perfect CMS.”

**Provenance:** Soft Verified · S3

---

### W5. Crash-free one-liner + ownership `(30–45s)`

**Answer points:** 99.95% · triage · IMOC · prevent

**Full spoken answer:**  
> “We treat **99.95%+ crash-free** as a product bar at **30L+ DAU**. I triage via Crashlytics workflows and as IMOC I drive stabilize-communicate-prevent on P0/P1 — not blame theater.”

**Provenance:** Verified · S8

---

## Pool C — System design warm-ups

### W6. How will you open system design? `(30–45s)`

**Answer points:** Staff agenda · 5 min clarify · DAU/offline/SLO

**Full spoken answer:**  
> “I’ll spend five minutes clarifying scope, DAU, offline needs, and latency expectations, then draw a four-layer client HLD, deep-dive two hard subsystems, and reserve the last five for failure modes, metrics, and kill switches.”

---

### W7. Name three production proofs `(30–45s)`

**Answer points:** Trio + one specialty

**Full spoken answer:**  
> “**30L+ DAU** context, **99.95%+ crash-free**, **30%+** LE navigation reduction — plus I’ll keep one specialty loaded: SDUI, pinning, SDK, or on-device AI depending on the prompt.”

---

## Pool D — Recovery / meta

### W8. What if you blank? `(30–45s)`

**Answer points:** Assumption · requirements · draw · brute · no apology spiral

**Full spoken answer:**  
> “I state an assumption, return to requirements, draw the shape I know, offer a brute approach, and recover. I don’t burn time apologizing.”

---

### W9. SD deep dive running long — what do you cut? `(90s)`

**Answer points:** Park third subsystem · **protect ops 5 min**

**Full spoken answer:**  
> “I summarize and park the third deep dive. Seniors protect the last five minutes for failure modes, metrics, and rollout. Happy-path forever is a mid signal.”

---

### W10. Coding still O(n²) near time `(90s)`

**Answer points:** State optimal · sketch key function · partial credit via communication

**Full spoken answer:**  
> “I stop polishing the suboptimal path, state the O(n) approach and complexity, sketch the key function, and note what I’d change. Communication recovers points; silent rewrite from zero usually doesn’t finish.”

---

### W11. Interviewer challenges a BMS metric `(90s)`

**Answer points:** Clarify measurement scope · don’t inflate · offer related proof

**Full spoken answer:**  
> “I clarify what the number measures — crash-free sessions, or nav reduction on targeted flows — and I don’t generalize beyond the resume. I can offer a related proof if they want another angle.”

---

### W12. They ask on-device AI but you prepared SDUI `(90s)`

**Answer points:** Pivot · privacy · RAG · fail-soft · FinTrack/GymFlow · reuse 4-layer client

**Full spoken answer:**  
> “I pivot cleanly: privacy constraints, local retrieval, on-device inference, fail-soft matrix, FinTrack BM25 and GymFlow MiniLM as proof. I still use a four-layer client sketch; a slightly shorter HLD is fine if clarify was strong.”

**Provenance:** Verified · S15 · S16

---

## Suggested warm-up set (15 min)

W1, W6, W7, W3 — speak once each. Save W9–W12 for mental rehearsal only.


---

## Pool E — Rapid iOS definitions (warm-up only)

### W13. Retain cycle 30s

**Answer points:** Strong ref loop · closures capture self · weak/unowned · Instruments

**Full spoken answer:**  
> “A retain cycle is a strong reference loop keeping objects alive. Closures capturing self are the usual UIKit suspect — I break them with weak self and verify with Allocations/Leaks when needed.”

---

### W14. SSL pinning one-liner + S4 `(45s)`

**Answer points:** ATS ≠ pinning · SPKI hash · Ads URLSession migration

**Full spoken answer:**  
> “ATS is system TLS policy; pinning is an app-level identity check on the certificate or SPKI. On Ads we moved Alamofire to URLSession with HTTPS, pinning, and host whitelist.”

**Provenance:** Verified · S4

---

### W15. p50/p90 why `(30–45s)`

**Answer points:** Tail latency · Firebase Performance · listing/checkout/search

**Full spoken answer:**  
> “Averages hide pain. p50 and p90 on listing, checkout, and search traces show typical and tail experience — we instrumented those with Firebase Performance.”

**Provenance:** Verified · S5

---

### W16. Fail-soft AI 30s

**Answer points:** Capability · rules/TF-IDF · no crash · S15/S16

**Full spoken answer:**  
> “If the model path can’t run, FinTrack falls to deterministic rules and GymFlow to TF-IDF — useful degrade, not a blank crash.”

**Provenance:** Verified · S15 · S16
