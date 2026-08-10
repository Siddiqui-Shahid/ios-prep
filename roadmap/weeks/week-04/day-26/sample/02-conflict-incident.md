# Sample 02 — Conflict & incident STARs (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How do I structure a conflict STAR (BookMyShow LE Bottom Sheet)?
**Answer:**

> Five beats: (1) Name the disagreement — API shape, scope, or UX. (2) What *you* did — data, options, user impact, contracts. (3) Disagree *with* people, not *at* them. (4) Resolution with relationship intact. (5) Lesson — contracts and metrics over opinions. 
> LE Bottom Sheet example: full-screen overview too heavy → lightweight bottom sheet → align PM/Design/Backend → reusable component → **30%+** flows fewer full-screen navigations.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What did Backend push back on? | API contract and content rules — be ready with one concrete example. |
| How measure 30%+? | Targeted flows in scope — clarify you don’t claim all BMS navigation. |
| What would you do differently? | Honest trade-off — e.g. earlier contract workshop, not “nothing.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What is the LE bottom sheet story in one pass?
**Answer:**

> Users took full-screen navigations for event overview more than needed — friction on high-traffic flows you shared ownership of. You led an end-to-end lightweight overview as a bottom sheet, aligned Product/Design/Backend on API contract and content rules, shipped a reusable component into targeted flows. Result: **30%+** fewer full-screen navigations in that scope. Lesson: small UI surface + clear contracts beats a big navigation rewrite.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Conflict with Design specifically? | Same story — contract and user impact, not taste war. |
| “Reusable component” — why matter? | Shows senior thinking — pattern others can adopt. |
| Overclaim risk? | Say “targeted flows” — not “all of BookMyShow nav.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do I structure an incident STAR (BookMyShow IMOC + crash-free at scale)?
**Answer:**

> (1) Severity + user impact at **30L+ DAU**. (2) IMOC role: **stabilize → communicate → RCA → prevent**. (3) Concrete technical/process action — Crashlytics triage, feature guards, hotfix paths. (4) Result tied to **99.95%+ crash-free** culture and minimized downtime in peaks. (5) Lesson: ownership + blast radius + rollback > hero debug alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Example mitigation you drove? | Feature guard, rollback, or hotfix path — pick one real example. |
| How prevent recurrence? | RCA action + checklist or monitoring — not “we tried harder.” |
| Conflict during incident? | Clear owner and comms channel — debate after stabilize. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q4. What does IMOC mean in your story?
**Answer:**

> **Incident Manager On Call** — you coordinated iOS, backend, and QA when P0/P1 hit during high-traffic events. Not solo debugging: stabilize first, communicate blast radius, then root cause and prevent. Crashlytics triage with structured workflows. Senior signal = clarity of owner and rollback, not being the only person in lldb.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sole credit for 99.95%? | No — “helped drive discipline on my paths” / culture participation. |
| IMOC vs regular on-call? | IMOC = coordination + comms + prevent, not just fixing your module. |
| Drama without process? | Weak — name stabilize/communicate/prevent steps. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How do you handle disagreement without being combative?
**Answer:**

> Bring **data, options, and user impact** — not “I’m right.” Make the interface contract explicit so PM/Design/Backend debate facts, not taste. Escalate early when safety, security, or revenue is at stake — costs political capital but beats silent risk. After resolution, relationship intact — you’ll ship the next feature together.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| PM wants scope you can’t meet? | Visible risk + MVP cut + protect crash-free — see deadline pushback Q. |
| Design wants full rewrite? | Small surface + contracts often wins — BookMyShow LE Bottom Sheet lesson. |
| Never disagree? | Disagree *with* people on trade-offs — not performative conflict. |

**How can I relate to my case:**
- **Shipped:** BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What is a good failure STAR approach?
**Answer:**

> Pick **one real miss** you can defend — pin rotation under-specified, SDUI unknown-type gap, race before sync maps. Spine: miss → impact → what you changed (checklist, test, guard, review bar) → how you detect recurrence. **No humblebrag** (“I worked too hard”). **No invented failure** for sympathy points.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| SDUI unknown-type miss? | Fallback + schemaVersion (BookMyShow backend-driven header & search-A1) as process change. |
| Race that escaped? | Concurrency boundary + tests (BookMyShow synchronised dictionaries) as prevention. |
| Too much detail on the miss? | 20s miss, 90s fix + prevention — stay forward-looking. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q7. How do you push back on a bad deadline?
**Answer:**

> Make **quality and reliability risk visible** with options: cut scope to MVP, shift date, or accept explicit risk — don’t silent-hero overtime as the only plan. At consumer scale, protect crash-free and incident load the way P0/P1 was treated at BookMyShow. Escalate with **data**, not vibes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Just work weekends”? | Name the trade-off — escaped defects and incident load at **30L+ DAU**. |
| No time for options meeting? | One slide or message: scope A vs B vs date — still senior. |
| Always say no to deadlines? | No — negotiate scope and risk visibility; sometimes MVP ship is right. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-mentorship-ai.md](03-mentorship-ai.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is the LE bottom sheet story in one pass

**Ask yourself:** What is the LE bottom sheet story in one pass?

**Answer:** “Users took full-screen navigations for event overview more than needed — friction on high-traffic flows you shared ownership of. You led an end-to-end lightweight overview as a bottom sheet, aligned Product/Design/Backend on API contract and content rules, shipped a reusable component into targeted flows. Result: **30%+** fewer full-screen navigations in that scope. Lesson: small UI surface + clear contracts beats a big navigation rewrite.”

### Puzzle B — How do I structure an incident STAR (BookMyShow IMOC + crash-free at scale)

**Ask yourself:** How do I structure an incident STAR (BookMyShow IMOC + crash-free at scale)?

**Answer:** “(1) Severity + user impact at **30L+ DAU**. (2) IMOC role: **stabilize → communicate → RCA → prevent**. (3) Concrete technical/process action — Crashlytics triage, feature guards, hotfix paths. (4) Result tied to **99.95%+ crash-free** culture and minimized downtime in peaks. (5) Lesson: ownership + blast radius + rollback > hero debug alone.”

### Puzzle C — What does IMOC mean in your story

**Ask yourself:** What does IMOC mean in your story?

**Answer:** “**Incident Manager On Call** — you coordinated iOS, backend, and QA when P0/P1 hit during high-traffic events. Not solo debugging: stabilize first, communicate blast radius, then root cause and prevent. Crashlytics triage with structured workflows. Senior signal = clarity of owner and rollback, not being the only person in lldb.”
