# Sample 03 — Warm-up & recovery (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How will you open the coding round?

**Answer:**

> “I restate the problem, clarify constraints, give a one-line brute force, name the optimized pattern — hash, heap, window, or tree — state complexity and edges, then code. I narrate throughout and leave a few minutes for edges.”  
> **30–45s** — then execute on the clock.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Brute force always required? | Yes — shows thinking before optimization. |
| Pattern wrong at min 5? | See W2 — narrate pivot. |
| No edges at 42? | Backfill from clarify list — duplicates, empty, single element. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. You misclassified the pattern at minute five — what now?

**Answer:**

> Say the **new classification aloud**, keep any reusable helpers, rewrite the core loop. **Communication of the pivot scores**; silent thrashing through the whole file doesn’t. Example: “This is really a hash map problem, not two pointers — I’ll keep the frequency map and rewrite the scan.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Start file over? | Salvage imports/helpers — don’t delete working pieces. |
| Hide the mistake? | Worse — interviewer sees silent rewrite. |
| Still wrong at 45? | State optimal approach + complexity for partial credit. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. GCD serial queue vs actor — 45s?

**Answer:**

> “A serial queue serializes work on shared state; we used that pattern around synchronised dictionaries at BookMyShow. A Swift actor is a reference type with isolated state and `await` at the boundary — I’d prefer it for greenfield shared maps. Actors can reenter across `await` — I design for that.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow synchronised dictionaries provenance? | BookMyShow synchronised dictionaries GCD prod; Design: actor SafeDict (not shipped) actor migration. |
| Concurrent queue for shared dict? | Wrong default — data races. |
| `@MainActor` vs custom actor? | Main for UI; custom for domain state. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q4. SDUI unknown type — 45s?

**Answer:**

> “Unknown components render a placeholder, emit a coarse analytics event, and never force-unwrap. Schema version gates fail closed. Same instinct as backend-driven header work — resilience over assuming perfect CMS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Crash on unknown? | Fail — senior answer is degrade + log. |
| BookMyShow backend-driven header & search provenance? | Soft backend-driven surfaces. |
| Force-unwrap JSON? | Never — map to fallback model. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How will you open system design?

**Answer:**

> “I’ll spend five minutes clarifying scope, DAU, offline needs, and latency expectations, then draw a four-layer client HLD, deep-dive two hard subsystems, and reserve the last five for failure modes, metrics, and kill switches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Four layers? | Presentation · domain/use cases · data/network · platform/services — adapt naming. |
| Skip “does that work?” | Optional but helps align with interviewer. |
| Clarify DAU why? | Drives cache, pagination, offline scope. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Name three production proofs?

**Answer:**

> “**30L+ DAU** context, **99.95%+ crash-free**, **30%+** LE navigation reduction — plus I’ll keep one specialty loaded: SDUI, pinning, SDK, or on-device AI depending on the prompt.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Only two proofs? | Add BookMyShow SSL pinning + URLSession migration pinning or Stories SDK (Raw / Miami Heat) SDK as fourth if needed. |
| Overclaim nav metric? | “Targeted flows” scope always. |
| District proof? | District Free Parking + Clean/MVVM + AI tooling for architecture/AI tooling — separate from FinTrack on-device AI. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; Stories SDK (Raw / Miami Heat); BookMyShow SSL pinning + URLSession migration; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q7. SD deep dive running long — what do you cut?

**Answer:**

> Summarize and **park the third deep dive**. Seniors protect the **last five minutes** for failure modes, metrics, and rollout. Happy-path forever is a mid signal. Say: “I’ll table caching details and cover kill switch and degrade paths.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Kill switch example? | Feature flag off bad SDUI schema version. |
| Metrics in ops block? | Crash-free, p90 latency, rollout % — concrete. |
| Never reach HLD? | Clarify overrun — reset at 5 min hard. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. They ask on-device AI but you prepared SDUI?

**Answer:**

> Pivot cleanly: privacy constraints, local retrieval, on-device inference, fail-soft matrix. **FinTrack BM25** and **GymFlow MiniLM** as proof. Still use four-layer client sketch; slightly shorter HLD is fine if clarify was strong.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| FinTrack on-device AI vs GymFlow on-device AI? | FinTrack rules+RAG vs GymFlow TF-IDF fallback. |
| Panic pivot? | State assumption — “I'll design on-device Q&A with local retrieval.” |
| Drop SDUI entirely? | Yes — match the prompt, keep structure. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q9. Pool E — retain cycle in 30s?

**Answer:**

> “A retain cycle is a **strong reference loop** keeping objects alive. Closures capturing `self` are the usual UIKit suspect — I break them with **`weak self`** and verify with Allocations/Leaks when needed.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unowned when? | Lifetime guaranteed shorter than capture — rare; prefer weak in UI. |
| Delegates? | Weak by convention — strong delegate = classic cycle. |
| Instruments tool? | Allocations / Leaks — Graph for abandoned heaps (Day 03/18). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q10. Pool E — SSL pinning one-liner + BookMyShow SSL pinning + URLSession migration?

**Answer:**

> “**ATS** is system TLS policy; **pinning** is an app-level identity check on the certificate or **SPKI**. On Ads we moved Alamofire to **URLSession** with HTTPS, pinning, and host whitelist.”  
> **Provenance:** BookMyShow SSL pinning + URLSession migration

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SPKI vs leaf? | Prefer SPKI hash — survives cert renewals better than leaf pin. |
| Pin all hosts? | No — allowlisted sensitive hosts. |
| Rotation? | Backup pins + ship client before rotate — design (Design: pin rotation / break-glass (not shipped runbook)). |

**How can I relate to my case:**
- **Shipped:** BookMyShow SSL pinning + URLSession migration
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q11. Pool E — why p50 / p90?

**Answer:**

> “Averages hide pain. **p50 and p90** on listing, checkout, and search traces show typical and **tail** experience — we instrumented those with **Firebase Performance**.”  
> **Provenance:** BookMyShow Firebase Performance traces

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Only average? | Mid signal — seniors name percentiles. |
| Which journeys? | Listing, checkout, search — resume-true. |
| Ops pause? | Cliff on p90 → pause rollout (BookMyShow IMOC + crash-free at scale culture). |

**How can I relate to my case:**
- **Shipped:** BookMyShow Firebase Performance traces; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q12. Pool E — fail-soft AI in 30s?

**Answer:**

> “If the model path can’t run, **FinTrack** falls to **deterministic rules** and **GymFlow** to **TF-IDF** — useful degrade, not a blank crash.”  
> **Provenance:** FinTrack on-device AI · GymFlow on-device AI

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Thermal mid-gen? | Pause infer; keep partial; rules/TF-IDF (Day 24). |
| Hide chrome? | Yes — don’t show generative UI when unavailable. |
| Next sample? | [04-fix-forwards.md](04-fix-forwards.md). |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [04-fix-forwards.md](04-fix-forwards.md)

---

