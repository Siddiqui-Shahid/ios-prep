# 01 — Foundations: Machine-Round Operating System

---

## 0. North star

**Ship a tested happy path with documented cut lines. A polished unfinished cathedral loses to a demoable core.**

---

## 1. Clock (memorize)

| Phase | Clock | Do | Don’t |
|---|---|---|---|
| 0. Clarify | 0:00–0:15 | Restate, API shape, offline?, UIKit/SwiftUI, tests | Code immediately |
| 1. Agenda | 0:15–0:20 | Layers + milestones aloud | Silent architecture |
| 2. Skeleton | 0:20–0:45 | Types, protocols, empty UI, fake repo | Pixel-perfect UI |
| 3. Vertical slice | 0:45–2:00 | One happy path E2E | All edges first |
| 4. Depth | 2:00–2:30 | Cache **or** 2nd component | Aesthetic refactor |
| 5. Tests | 2:30–2:50 | 3–6 meaningful unit tests | 100% coverage chase |
| 6. Buffer | 2:50–3:00 | Trade-offs + known gaps README | New features |

---

## 2. Vertical slice definition

You can demo in **60 seconds**: load → show data → one secondary behavior (next page **or** unknown component fallback) → mention test.

If you cannot demo, you do not have a slice yet.

---

## 3. Anti-perfectionism checklist

- [ ] Styling fonts while pagination broken? → stop
- [ ] Demo in 60s now? → if no, slice
- [ ] ≥1 test after 2:30? → write two now
- [ ] Narrated cache/SDUI policy? → say in buffer
- [ ] Renaming for beauty? → stop

---

## 4. Pick A or B

| Choose A if | Choose B if |
|---|---|
| Weaker on networking/state/cache | Weaker on SDUI / decoding / fallbacks |
| Want list UX proof | High ROI before Day 27 SDUI SD |

Outline the other in 20 min notes only if surplus time — do not build both.

→ [`02-deep-dive.md`](02-deep-dive.md)
