# Audio script — Sample 04 — Scoring rubric (Q&A)
> Listen-only sample Q&A from `04-scoring-rubric.md`. Spoken answers and follow-ups.

## §0 Q1. What is two-layer scoring?

Next. Q1. What is two-layer scoring? Answer. Layer A — Structure: how you used 45 minutes (agenda, high level design, A P I, dives, ops, communication). Layer B — Content honesty: resume-true hooks, correct provenance labels, technical correctness (SPKI DER, unknown components, etc.). Pass Mock #3 at ≥70 with ops ≥6/10 and zero fabricated metrics. Beautiful diagram with fake QPS and no ops still fails. Follow-ups. One layer only?: Both matter — structure without honest content caps score.. Self-grade when?: Immediately after Exercise 4 — be harsh.. Partner mock?: Same rubric — peer uses Part II questions..

## §1 Q2. Full 100-point rubric — dimensions?

Next. Q2. Full 100-point rubric — dimensions? Answer. | Dimension | Pts | Agenda & clarify: 15. high level design clarity: 20. A P I / data model: 15. Deep dive quality: 25. Production grounding: 10. Ops / rollout: 10. Communication: 5. Pass: ≥70 total, ops ≥6/10, no fabricated metrics. Follow-ups. Highest weight?: Deep dive quality (25) — pick hard subsystems.. Ops only 10 pts?: Still pass gate — zero ops fails bar.. Communication low weight?: Checkpoints and timeboxes still differentiate senior..

## §2 Q3. What does “excellent agenda & clarify” look like?

Next. Q3. What does “excellent agenda & clarify” look like? Answer. Stated plan aloud; asked scale, offline, in/out; got interviewer yes before drawing; finished within ≤5 min. Weak: silent boxing or 15-minute clarify. Score yourself 15/15 only if all four hold. Follow-ups. Drew first, agenda after?: Cap structure — recovery helps but doesn’t earn full 15.. Forgot scale?: Deduct production grounding too if you invent later.. Timed warm-up?: Q1 from 04 before live mock..

## §3 Q4. What fails HLD clarity?

Next. Q4. What fails HLD clarity? Answer. Mystery boxes without labels; no data-flow arrows; peer cannot narrate request path from CMS/client to U I. Buzzword list without layers scores poorly regardless of ornament. Excellent: layered diagram + clear flow — 20/20 when narratable in 30s by a stranger. Follow-ups. Too much U I detail in high level design?: Park pixels — schema/reliability layers matter more.. Modules in diagram?: Features → protocols → core — Q8 in 04.. One giant box “Backend”?: Split CMS, A P I, auth as relevant..

## §4 Q5. How do you score deep dive quality (25 pts)?

Next. Q5. How do you score deep dive quality (25 pts)? Answer. Excellent: 2–3 hard subsystems with trade-offs and failure modes inside the dive — unknown components, refresh single-flight, SPKI rotation design. Poor: six shallow topics, happy-path only. Equal time on every box looks junior — seniors choose hard seams. Follow-ups. S D U I dives?: Versioning/fallback + action routing — or cache if media-heavy.. Networking dives?: Single-flight refresh + SPKI rotation design.. Cert lecture?: Stop — SPKI vs leaf, rotation, metrics — T4 in 04..

## §5 Q6. How do you score production grounding?

Next. Q6. How do you score production grounding? Answer. Full points: S D U I cites S3/S12-style proof or networking cites S4/S5 without fake QPS; S4-A1 labeled design when discussing rotation; S 2 path-scoped only — not sole crash free sessions. Caps score: invented metrics, “S 2 caused 99.95% crash free sessions,” “shipped pin runbook,” SecKey as SPKI. Follow-ups. S6 in S D U I?: Optional lightweight LE sheet beat — not whole engine.. S 8 in ops?: I M O C pause, crash free sessions bar — ops vocabulary.. No resume hook for topic?: Say “learning-lab” — don’t fabricate BMS war stories..

## §6 Q7. Why is ops weighted even in the last 5 minutes?

Next. Q7. Why is ops weighted even in the last 5 minutes? Answer. Ops shows you ship, not just draw. 10 pts — but pass needs ops ≥6/10. Zero ops — no metrics, no pause criteria — fails pass bar even with pretty boxes. Practice 60s closer: failures, crash free sessions/p90, flags, phased rollout, I M O C pause. Cut dive rather than skip ops — T6 in 04. Follow-ups. 60s ops template?: Foundations §4 — failures X/Y, crash free sessions, p90, Z rate, flags, pause.. Forgot ops in mock?: Log as top miss → Week 4 flashcard.. After scoring?:../05-exercises.md pass checklist + revision twin.. Next:../05-exercises.md.
