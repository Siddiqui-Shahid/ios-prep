# 05 — Exercises

## Exercise 1 — Honesty drill `(5 min)`

Speak both lines:

1. S8 CFS/IMOC one-liner  
2. S2 path-scoped contribution  

Then deliberately say the **wrong** line (“S2 caused 99.95%”) and correct yourself out loud.

---

## Exercise 2 — Signal-safety true/false `(10 min)`

1. You may `malloc` in a signal handler.  
2. Upload should happen inside the handler.  
3. Breadcrumbs should be filled on the happy path.  
4. OSLog is always async-signal-safe.  
5. dSYM UUID mismatch breaks symbolication.

**Answers:** F, F, T, F, T

---

## Exercise 3 — IMOC tabletop `(20 min)`

Scenario: CFS drops during a sale; iOS and backend disagree.

Write a 8-line script: confirm → owner → blast radius → mitigate → comms cadence → hotfix/flag decision → watch → postmortem.

Record yourself ≤2 min.

---

## Exercise 4 — Code read `(15 min)`

Read [`code/BreadcrumbRing.swift`](code/BreadcrumbRing.swift) and [`code/CrashReportNotes.swift`](code/CrashReportNotes.swift).  
Speak: why ring + scrub + no network in notes.

---

## Exercise 5 — Crash SDK whiteboard `(15 min)`

Boxes: handlers, mmap, ring, uploader, symbolication.  
Annotate: async-signal-safe; next-launch upload; CI dSYM.

---

## Timed drill

Q5, Q6, Q9 + T3, T4. Log misses: try/catch myth, CFS≠hangs, S2 sole-cause slip.
