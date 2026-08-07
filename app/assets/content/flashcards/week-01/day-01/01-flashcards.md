# Flashcards — Value vs Reference, COW, Enums, Actors Intro

> Active recall for `day-01`. Cover the answer, speak aloud, then reveal.

---

### Q1. Value vs reference

**Answer:**

> Structs copy snapshots; classes share identity on the heap

---

### Q2. let vs var

**Answer:**

> Controls binding mutability — not the same as value vs reference

---

### Q3. COW

**Answer:**

> Share buffer until write; then copy if not uniquely referenced

---

### Q4. Enum state

**Answer:**

> Impossible combinations become compile errors, not runtime bugs

---

### Q5. Actor intro

**Answer:**

> Isolated reference type; await to touch state — not “replace all classes”

---

### Q6. BookMyShow Ads pipeline + HeroWidget lifecycle

**Answer:**

> Type-safe ads pipeline + HeroWidget lifecycle — no invented fill-rate %

---

### Q7. BookMyShow payment processing-status popup

**Answer:**

> Processing popup with explicit status — no invented drop-off %

---

### Q8. Design: payment status pattern (not shipped) / Design: actor SafeDict (not shipped)

**Answer:**

> How I would apply it — design patterns, not shipped claims

---
