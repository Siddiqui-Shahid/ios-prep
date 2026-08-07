# Flashcards — Crash Reporting, Observability & Incident Response (IMOC)

> Active recall for `day-18`. Cover the answer, speak aloud, then reveal.

---

### Q1. BookMyShow synchronised dictionaries alone caused 99.95% CFS

**Answer:**

> Forbidden — BookMyShow synchronised dictionaries ⊂ reliability; BookMyShow IMOC + crash-free at scale = system

---

### Q2. try/catch catches SEGV

**Answer:**

> No — signals need handlers + discipline

---

### Q3. Upload in signal handler

**Answer:**

> Never — persist async-signal-safe; upload next launch

---

### Q4. CFS fine ⇒ no freezes

**Answer:**

> False — hangs/OOM may not move CFS

---

### Q5. Leaks for retain cycles

**Answer:**

> Wrong tool — Graph + Allocations

---

### Q6. BookMyShow IMOC + crash-free at scale

**Answer:**

> 30L+ DAU, 99.95%+ CFS, Crashlytics triage, IMOC

---
