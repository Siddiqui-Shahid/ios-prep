# Flashcards — ARC, Retain Cycles, weak/unowned, Instruments

> Active recall for `day-03`. Cover the answer, speak aloud, then reveal.

---

### Q1. Retain cycle

**Answer:**

> Reachable abandoned memory

---

### Q2. Instruments Leaks

**Answer:**

> Finds unreachable memory — not cycles

---

### Q3. Timer target:selector:

**Answer:**

> Timer strongly retains the target until invalidate

---

### Q4. NotificationCenter block API

**Answer:**

> Store the observer token and remove on teardown

---

### Q5. Uncertain lifetime (async UI)

**Answer:**

> Prefer [weak self]

---

### Q6. BookMyShow IMOC + crash-free at scale

**Answer:**

> Reliability culture — do not invent a BMS Memory Graph war story

---
