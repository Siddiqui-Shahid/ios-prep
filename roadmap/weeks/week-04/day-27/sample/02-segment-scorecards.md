# Sample 02 — Segment scorecards (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How is the coding segment timed (45 min)?

**Answer:**

> **0–3 min:** Clarify + say-this-first agenda.  
> **3–35 min:** Code + narrate continuously.  
> **35–42 min:** Edges / tests aloud; fix bugs.  
> **42–45 min:** Complexity recap + mention alternative approach.  
> Prefer **mixed unknown** Medium — trees, hash, heap, sliding window fair game.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Clarify too long? | 3 min cap — then brute + pattern. |
| No time for edges? | Major deduction — leave buffer by minute 35. |
| Silent coding? | Scores 1 on communication — narrate trade-offs. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What does the coding scorecard measure?

**Answer:**

> Six criteria, each **1 / 3 / 5**: Clarify + agenda · Correctness · Complexity · Communication · Edges/tests · Time use.  
> **5** = explicit timed agenda, passes cases, accurate complexity, continuous narration, edges covered, buffer left.  
> **3** = partial on most rows. **1** = jumped to code, wrong approach, silent, incomplete core.  
> **Target:** average ≥**3.5**; agenda ≥**4**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Minor bug — score? | Correctness **3** if fixable; **1** if wrong algorithm. |
| O(n) stated wrong? | Complexity row hits **1** or **3** — say it aloud correctly. |
| Partial solution at 45? | Time use **1** — communicate optimal approach for partial credit. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How is the iOS deep dive scored?

**Answer:**

> **4–6 topics** — answers **30–45s** or **90–120s**; one architecture answer **3–5 min** if “design X.”  
> Criteria: Timing · Mechanism · Trade-off · Production proof · Agenda on long answers · Honesty.  
> **Target:** ≥**4** on Normals; ≥**3** on Trickies; ≥**2** production hooks (BMS/Raw/District).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ramble 3 min on 45s question? | Timing **1** — self-correct with agenda. |
| Correct but generic? | Production proof **3** or **1** — add BookMyShow synchronised dictionaries/BookMyShow SSL pinning + URLSession migration/BookMyShow IMOC + crash-free at scale hook. |
| Bluff wrong mechanism? | Honesty **1** — state assumption instead. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow SSL pinning + URLSession migration; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q4. What topics appear in the iOS pool?

**Answer:**

> ARC/retain cycles · GCD vs actors · MVVM–Clean–DI · URLSession/pinning · SDUI fallbacks · SwiftUI identity/hybrid · Instruments p50/p90 · Crash/IMOC **99.95%** · SPM/Stories SDK · On-device AI fail-soft if pivoted (keep tight).  
> Every answer: definition → mechanism → trade-off → production proof.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow synchronised dictionaries bridge for concurrency? | Verified GCD prod vs Design: actor SafeDict (not shipped) actor migration. |
| SDUI unknown type? | Fallback + schema — BookMyShow backend-driven header & search instinct. |
| On-device AI pivot? | FinTrack on-device AI/GymFlow on-device AI — privacy + fail-soft, 30–45s tight. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI; BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. How is system design timed (45 min)?

**Answer:**

> **0–5** Clarify: scope, DAU, offline?, iOS-only?, latency SLO.  
> **5–15** HLD: 4-layer client + data flow.  
> **15–25** Data/API: entities, pagination, payloads, idempotency.  
> **25–40** Deep dive: 2–3 hardest subsystems.  
> **40–45** Ops: failure modes, metrics, rollout, kill switch.  
> Prompt options: SDUI engine · Networking+pinning · On-device AI · Image/feed.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Deep dive runs long? | Park third subsystem — **protect ops 5 min**. |
| No clarify? | Score **1** — assumptions without SLOs. |
| Happy path only? | Failure modes **1** — mid signal. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is the system design scorecard target?

**Answer:**

> Criteria: Clarify · HLD (4 layers) · Deep dive (2 crisp) · Failure modes · Metrics/rollout · Timing · Personal proof.  
> **Target:** average ≥**3.5**; clarify + failure modes ≥**4**.  
> **5** on HLD = four layers with clear data flow; **5** on ops = kill switch, degrade path, concrete metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Blob architecture? | HLD **1** or **3** — draw layers. |
| One shallow deep dive? | Deep dive **3** — need two crisp subsystems. |
| Generic “we’d monitor”? | Metrics **3** — name Firebase, crash-free, p90, etc. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What does 5 vs 3 vs 1 mean across segments?

**Answer:**

> **5** = on time, explicit agenda, correct mechanism, trade-off stated, production proof with honest provenance, follow-up ready.  
> **3** = correct core but fuzzy trade-off, weak timing (±30%), light production hook, or partial edges.  
> **1** = blank, wrong, bluff, silent, happy-path-only SD, or jumped in without clarify.  
> Mock pass = segment averages meet targets + **≤3** fix-forwards logged.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invented BMS metric? | Honesty **1** — worse than “I don’t know.” |
| 2× budget? | Self-correct in one sentence — still score recovery attempt. |
| Average 3.4? | One fix-forward priority — don’t rewrite whole week. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What are meta trade-offs for Mock #4?

**Answer:**

> **Expert human** = best signal, costs scheduling. **Self + recorded** = always on, blind spots remain. **Fresh DSA** = realism and stress — intended. **Reuse Day 25 app** = comfort but weaker coding signal. Choose fresh problem and honest debrief over comfort.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Re-run mock next day? | Day 28 taper — only if Mock #4 missed entirely. |
| Scorecards for proctor only? | Yes — not in candidate frame. |
| Expert briefing? | See [`../README.md`](../README.md) paste block for proctor. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-warmup-recovery.md](03-warmup-recovery.md)

---

