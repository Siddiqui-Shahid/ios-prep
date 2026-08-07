# Flashcards — async/await, Structured Concurrency, Actors, Sendable

> Active recall for `day-05`. Cover the answer, speak aloud, then reveal.

---

### Q1. await

**Answer:**

> Suspension point — not “always background thread”

---

### Q2. Structured concurrency

**Answer:**

> Parent owns children; cancel and errors can propagate

---

### Q3. Unstructured Task

**Answer:**

> You own lifetime and cancellation (UI boundaries)

---

### Q4. Cancellation

**Answer:**

> Cooperative — not preemptive thread killing

---

### Q5. Actor

**Answer:**

> Prevents data races on isolated state — reentrant at await

---

### Q6. Sendable

**Answer:**

> Value types are Sendable only if stored properties are

---

### Q7. BookMyShow synchronised dictionaries

**Answer:**

> GCD synchronised dictionaries at BMS — not org-wide actor rewrite

---

### Q8. Design: actor SafeDict (not shipped)

**Answer:**

> Greenfield actor migration — How I would apply it

---
