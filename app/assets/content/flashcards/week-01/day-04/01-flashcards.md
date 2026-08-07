# Flashcards — GCD Queues, sync/async, Barriers, Thread-Safe Dictionary

> Active recall for `day-04`. Cover the answer, speak aloud, then reveal.

---

### Q1. Shared dict without sync

**Answer:**

> Data race — undefined behavior

---

### Q2. main.sync from main

**Answer:**

> Deadlock — same rule for any serial queue

---

### Q3. Async write + sync read

**Answer:**

> May not see write until write runs — prefer sync set for read-after-write

---

### Q4. Hide the queue

**Answer:**

> Expose safe methods only — BookMyShow synchronised dictionaries lesson

---

### Q5. Barrier on concurrent queue

**Answer:**

> Exclusive writer; plain reads may overlap

---

### Q6. · BookMyShow synchronised dictionaries

**Answer:**

> Path-specific race elimination on synchronised dictionaries

---

### Q7. Design: actor SafeDict (not shipped) actor

**Answer:**

> How I would apply it — not a claim you rewrote production

---

### Q8. Spell it

**Answer:**

> final class, never Final class

---
