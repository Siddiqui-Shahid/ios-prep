# Full chapter templates

Use these when authoring `roadmap/weeks/week-XX/day-YY/`.

## Files required

| File | Purpose |
|---|---|
| `README.md` | Outcomes, time budget, module order, link to revision twin |
| `01-foundations.md` | Mental model as spoken Q&A cards |
| `02-deep-dive.md` | Mechanics / trade-offs as spoken Q&A cards |
| `03-production-bridge.md` | Verified / Applied / Learning-lab as spoken Q&A |
| `05-exercises.md` | Drills as Q&A (+ solutions pointers) |
| `code/` | Swift examples |
| `sample/0N-*.md` | Teaching sample Q&A (Day-04 card shape) |
| `sample/05-system-design-mock.md` | Daily SD mock interview Q&A |
| `sample/07-revision-qna.md` | Thick revision: Normal + Indirect + Tricky |

> Root `04-questions.md` is **retired**. Revision practice lives in `sample/07-revision-qna.md` so the Flutter app syncs it.

## Sample revision required shape

`sample/07-revision-qna.md` must include:

1. `## Normal questions` — ≥10 `### Qn.` cards  
2. `## Indirect questions` — ≥6 `### In.` scenario / “what happens if…” cards  
3. `## Tricky questions / brain puzzles` — ≥10 `### Tn.` production-depth cards  

Each card:

```markdown
### Q1. … `(30–45s)`

**Answer:**

> “Spoken answer…”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| … | … |

**How can I relate to my case:**
- **Concept-only / Shipped / Design / Don’t claim**
```

## Teaching sample card shape

Same Answer / Follow-ups / How can I relate shape. Prefer a closing `## Brain puzzles` section on teaching samples.

## Self-contained rule

No “go read Apple docs first.” Links only as optional appendix citations.
