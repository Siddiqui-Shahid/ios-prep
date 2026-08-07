# Sample 04 — Scoring rubric (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is two-layer scoring?

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

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Full 100-point rubric — dimensions?

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

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What does “excellent agenda & clarify” look like?

**Answer:**

> Stated plan aloud; asked **scale, offline, in/out**; got interviewer **yes** before drawing; finished within **≤5 min**. Weak: silent boxing or **15-minute clarify**. Score yourself **15/15** only if all four hold.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Drew first, agenda after? | Cap structure — recovery helps but doesn’t earn full 15. |
| Forgot scale? | Deduct production grounding too if you invent later. |
| Timed warm-up? | Q1 from 04 before live mock. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What fails HLD clarity?

**Answer:**

> **Mystery boxes** without labels; **no data-flow arrows**; peer cannot narrate request path from CMS/client to UI. Buzzword list without layers scores poorly regardless of ornament. Excellent: layered diagram + clear flow — **20/20** when narratable in 30s by a stranger.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Too much UI detail in HLD? | Park pixels — schema/reliability layers matter more. |
| Modules in diagram? | Features → protocols → core — Q8 in 04. |
| One giant box “Backend”? | Split CMS, API, auth as relevant. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How do you score deep dive quality (25 pts)?

**Answer:**

> **Excellent:** 2–3 **hard** subsystems with **trade-offs** and **failure modes inside the dive** — unknown components, refresh single-flight, SPKI rotation design. **Poor:** six shallow topics, happy-path only. Equal time on every box looks **junior** — seniors choose hard seams.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI dives? | Versioning/fallback + action routing — or cache if media-heavy. |
| Networking dives? | Single-flight refresh + SPKI rotation design. |
| Cert lecture? | Stop — SPKI vs leaf, rotation, metrics — T4 in 04. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. How do you score production grounding?

**Answer:**

> Full points: SDUI cites **BookMyShow backend-driven header & search/Audio streaming + server-driven splash (Aces)**-style proof or networking cites **BookMyShow SSL pinning + URLSession migration/BookMyShow Firebase Performance traces** without fake QPS; **Design: pin rotation / break-glass (not shipped runbook) labeled design** when discussing rotation; **BookMyShow synchronised dictionaries path-scoped** only — not sole CFS. Caps score: invented metrics, “BookMyShow synchronised dictionaries caused 99.95% CFS,” “shipped pin runbook,” SecKey as SPKI.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow LE Bottom Sheet in SDUI? | Optional lightweight LE sheet beat — not whole engine. |
| BookMyShow IMOC + crash-free at scale in ops? | IMOC pause, CFS bar — ops vocabulary. |
| No resume hook for topic? | Say “learning-lab” — don’t fabricate BMS war stories. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search; BookMyShow SSL pinning + URLSession migration; BookMyShow Firebase Performance traces; BookMyShow LE Bottom Sheet; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: pin rotation / break-glass (not shipped runbook)
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q7. Why is ops weighted even in the last 5 minutes?

**Answer:**

> Ops shows you **ship**, not just draw. **10 pts** — but **pass needs ops ≥6/10**. Zero ops — no metrics, no pause criteria — **fails pass bar** even with pretty boxes. Practice **60s closer:** failures, CFS/p90, flags, phased rollout, IMOC pause. **Cut dive rather than skip ops** — T6 in 04.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s ops template? | Foundations §4 — failures X/Y, CFS, p90, Z rate, flags, pause. |
| Forgot ops in mock? | Log as top miss → Week 4 flashcard. |
| After scoring? | [`../05-exercises.md`](../05-exercises.md) pass checklist + revision twin. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [`../05-exercises.md`](../05-exercises.md)

---

