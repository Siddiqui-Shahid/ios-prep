# Sample 03 — Mentorship & AI judgment (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How do you lead without a manager title?

**Points to:** [Deep dive · §3 Mentorship / leadership without title](../02-deep-dive.md#3-mentorship--leadership-without-title-s1-and-friends) · [Questions · Q4](../04-questions.md#q4-mentored--led-without-authority-23-min)

**Answer:**

> “Leadership was setting technical direction, unblocking others, and owning rollout checklists — not waiting for a manager title.”  
> S1 angle: define protocol contracts on Ads so teammates add ad types without forking the pipeline; explicit HeroWidget lifecycle rules so reviewers have a clear bar. S10/S14: SDK boundaries and zero-regression checklists. Mentorship through **architecture** — people move faster when the envelope is obvious.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Concrete unblock example? | Review bar, pairing on contract, or checklist before rollout. |
| vs “I mentored juniors”? | Name the **standard** you set, not vague coaching. |
| No direct reports? | Fine — senior is scope and standards, not headcount. |

---

### Q2. How do you answer “how do you use AI in your workflow?”

**Points to:** [Deep dive · §4 AI tooling judgment](../02-deep-dive.md#4-ai-tooling-judgment-s9--no-tool-worship) · [Questions · Q5](../04-questions.md#q5-how-do-you-use-ai-in-your-workflow-4590s)

**Answer:**

> **45–90s compressed S9:**  
> “I use AI inside a strict envelope — clear module boundaries, acceptance criteria, and review. It accelerates boilerplate and test drafts; I still own architecture and reject bad output. That’s District context engineering. Separately, FinTrack and GymFlow are product on-device AI with privacy and fail-soft — different story.”  
> Timed opener: “At District I used AI as an accelerator for migration/tests — the skill was context engineering and review judgment, not prompting theater.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Example rejected AI output? | Weak test assertion or wrong module boundary — you rewrote it. |
| When forbid AI? | Money, identity, crash paths — human-designed tests and architecture. |
| Copilot on critical path? | Allowed for boilerplate; not for sole design of revenue logic. |

---

### Q3. What is wrong vs senior AI tooling behavior (S9)?

**Points to:** [Deep dive · §4 AI tooling judgment](../02-deep-dive.md#4-ai-tooling-judgment-s9--no-tool-worship)

**Answer:**

> **Wrong:** “AI writes my code; I’m 10×.”  
> **Senior:** (1) Problem — migration/tests needed leverage without surrendering design. (2) Shaped **context** — modules, conventions, acceptance, review bar. (3) Rejected bad generations; human oracle on critical tests. (4) Separate product AI (S15/S16). (5) Lesson: tools amplify clear thinking; ownership stays yours at **30L+ DAU** stakes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Structured logging tie-in? | Debug faster during migration — part of S9 envelope, not separate brag. |
| “Did AI do the migration?” | No — AI assisted; you own architecture and review. |
| Team ships junk with Copilot? | See T2 — review bar + human tests on critical paths. |

---

### Q4. What if the team leans on Copilot and ships junk?

**Points to:** [Questions · T2](../04-questions.md#t2-team-leans-on-copilot-and-ships-junk-90120s)

**Answer:**

> “I don’t ban tools and I don’t shrug. I set a review bar, require human-designed tests on money/identity/crash paths, pair on architecture so context is shared, and watch escaped defects. I teach the same context-engineering habit I used at District — tools stay, accountability stays.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Escalate to manager? | After setting bar and measuring escapes — with data, not moralizing. |
| Ban Copilot? | No — ban **unreviewed** critical-path merges. |
| Junior dev dependency? | Pair on context shaping — teach the envelope, not prompts. |

---

### Q5. Why senior vs mid?

**Points to:** [Questions · T3](../04-questions.md#t3-why-senior-vs-mid-90120s) · [Foundations · §2 Prompt router](../01-foundations.md#2-prompt--story-router-10s)

**Answer:**

> “Senior for me means scope and judgment: shipping on **30L+ DAU** surfaces, owning revenue-critical UI architecture, participating in **99.95%+** crash-free culture and incident coordination, delivering measurable UX wins like **30%+** nav reduction, designing reusable SDK boundaries, migrating architecture with checklists, and separating product AI privacy work from engineering-tooling AI. Mid executes tickets; senior owns trade-offs and blast radius.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What mid still does well? | Executes well within a defined envelope — senior defines the envelope. |
| Raw / side projects role? | SDK thinking (S10) and on-device AI (S15) show breadth. |
| Overclaim risk? | “Participating in” crash-free culture — not “I am the CFS number.” |

---

### Q6. How do you answer mentorship prompts in 2–3 min?

**Points to:** [Questions · Q4](../04-questions.md#q4-mentored--led-without-authority-23-min)

**Answer:**

> Pick **S1 standards** or **S10/S14 checklist** — direction + unblock + rollout ownership. S1-angled script: Ads protocol contracts + HeroWidget lifecycle bar = mentorship through architecture. Same pattern for SDK boundaries and migration checklists on other teams. Result: teammates ship faster inside a clear envelope. Lesson: leadership is making the path obvious, not holding gatekeeper meetings.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Formal mentor program? | Optional — technical standard-setting counts. |
| Conflict while mentoring? | Contract clarity — same S6 instincts. |
| No story ID? | Default S1 or S10 — both are resume-backed. |

---

### Q7. Did AI do the District migration?

**Points to:** [Questions · T4](../04-questions.md#t4-did-ai-do-the-district-migration-90120s) · [Production bridge · S9](../03-production-bridge.md)

**Answer:**

> Compressed **S9**: AI accelerated drafts inside context and review; you **rejected** weak output and kept human ownership on architecture and critical-path assertions. Feature shipped; migration progressed with velocity **and** discipline. If they push: name one module boundary or test you rewrote after rejecting AI output.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Free Parking feature role? | Shipped billing adjustments — AI was leverage, not author. |
| MVVM/Clean migration? | Checklists + review bar — same S9 envelope. |
| FinTrack pivot? | “Different story — product on-device AI, not tooling.” |

---

Next: [04-production-provenance.md](04-production-provenance.md)
