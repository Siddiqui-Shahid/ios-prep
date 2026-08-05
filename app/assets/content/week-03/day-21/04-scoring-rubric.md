# Sample 04 — Scoring rubric (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is two-layer scoring?

**Points to:** [04-questions · Part II intro](../04-questions.md#part-ii--two-layer-scoring-questions) · [04-questions · SB3](../04-questions.md#sb3-two-layer-scoring--how-do-you-combine-60s)

**Answer:**

> **Layer A — Structure:** how you used 45 minutes (agenda, HLD, API, dives, ops, communication).  
> **Layer B — Content honesty:** resume-true hooks, correct provenance labels, technical correctness (SPKI DER, unknown components, etc.).  
> **Pass Mock #3 at ≥70** with **ops ≥6/10** and **zero fabricated metrics**. Beautiful diagram with fake QPS and no ops **still fails**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One layer only? | Both matter — structure without honest content caps score. |
| Self-grade when? | Immediately after Exercise 4 — be harsh. |
| Partner mock? | Same rubric — peer uses Part II questions. |

---

### Q2. Full 100-point rubric — dimensions?

**Points to:** [04-questions · Full rubric](../04-questions.md#full-rubric-100-pts)

**Answer:**

> | Dimension | Pts |
> | Agenda & clarify | 15 |
> | HLD clarity | 20 |
> | API / data model | 15 |
> | Deep dive quality | 25 |
> | Production grounding | 10 |
> | Ops / rollout | 10 |
> | Communication | 5 |
> **Pass:** ≥70 total, **ops ≥6/10**, no fabricated metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Highest weight? | Deep dive quality (25) — pick hard subsystems. |
| Ops only 10 pts? | Still **pass gate** — zero ops fails bar. |
| Communication low weight? | Checkpoints and timeboxes still differentiate senior. |

---

### Q3. What does “excellent agenda & clarify” look like?

**Points to:** [04-questions · SA1](../04-questions.md#sa1-what-does-excellent-agenda--clarify-look-like-45s)

**Answer:**

> Stated plan aloud; asked **scale, offline, in/out**; got interviewer **yes** before drawing; finished within **≤5 min**. Weak: silent boxing or **15-minute clarify**. Score yourself **15/15** only if all four hold.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Drew first, agenda after? | Cap structure — recovery helps but doesn’t earn full 15. |
| Forgot scale? | Deduct production grounding too if you invent later. |
| Timed warm-up? | Q1 from 04 before live mock. |

---

### Q4. What fails HLD clarity?

**Points to:** [04-questions · SA2](../04-questions.md#sa2-what-fails-hld-clarity-45s)

**Answer:**

> **Mystery boxes** without labels; **no data-flow arrows**; peer cannot narrate request path from CMS/client to UI. Buzzword list without layers scores poorly regardless of ornament. Excellent: layered diagram + clear flow — **20/20** when narratable in 30s by a stranger.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Too much UI detail in HLD? | Park pixels — schema/reliability layers matter more. |
| Modules in diagram? | Features → protocols → core — Q8 in 04. |
| One giant box “Backend”? | Split CMS, API, auth as relevant. |

---

### Q5. How do you score deep dive quality (25 pts)?

**Points to:** [04-questions · SB2](../04-questions.md#sb2-deep-dive-quality--what-earns-25-45s) · [04-questions · Q6](../04-questions.md#q6-which-deep-dives-for-networking-mock-3045s)

**Answer:**

> **Excellent:** 2–3 **hard** subsystems with **trade-offs** and **failure modes inside the dive** — unknown components, refresh single-flight, SPKI rotation design. **Poor:** six shallow topics, happy-path only. Equal time on every box looks **junior** — seniors choose hard seams.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI dives? | Versioning/fallback + action routing — or cache if media-heavy. |
| Networking dives? | Single-flight refresh + SPKI rotation design. |
| Cert lecture? | Stop — SPKI vs leaf, rotation, metrics — T4 in 04. |

---

### Q6. How do you score production grounding?

**Points to:** [04-questions · SB1](../04-questions.md#sb1-how-do-you-score-production-grounding-45s) · [Production bridge](../03-production-bridge.md)

**Answer:**

> Full points: SDUI cites **S3/S12**-style proof or networking cites **S4/S5** without fake QPS; **S4-A1 labeled design** when discussing rotation; **S2 path-scoped** only — not sole CFS. Caps score: invented metrics, “S2 caused 99.95% CFS,” “shipped pin runbook,” SecKey as SPKI.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S6 in SDUI? | Optional lightweight LE sheet beat — not whole engine. |
| S8 in ops? | IMOC pause, CFS bar — ops vocabulary. |
| No resume hook for topic? | Say “learning-lab” — don’t fabricate BMS war stories. |

---

### Q7. Why is ops weighted even in the last 5 minutes?

**Points to:** [04-questions · SA3](../04-questions.md#sa3-why-is-ops-weighted-even-if-small-minutes-45s) · [04-questions · Q7](../04-questions.md#q7-ops-metrics-at-the-end-3045s)

**Answer:**

> Ops shows you **ship**, not just draw. **10 pts** — but **pass needs ops ≥6/10**. Zero ops — no metrics, no pause criteria — **fails pass bar** even with pretty boxes. Practice **60s closer:** failures, CFS/p90, flags, phased rollout, IMOC pause. **Cut dive rather than skip ops** — T6 in 04.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s ops template? | Foundations §4 — failures X/Y, CFS, p90, Z rate, flags, pause. |
| Forgot ops in mock? | Log as top miss → Week 4 flashcard. |
| After scoring? | [`../05-exercises.md`](../05-exercises.md) pass checklist + revision twin. |

---

Next: [`../05-exercises.md`](../05-exercises.md)
