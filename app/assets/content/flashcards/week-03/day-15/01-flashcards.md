# Flashcards — App Modularization, SPM & DI Graphs

> Active recall for `day-15`. Cover the answer, speak aloud, then reveal.

---

### Q1. Feature A → Feature B

**Answer:**

> Depend on B’s Interface, never B’s Impl

---

### Q2. Composition root

**Answer:**

> App target wires concrete builders

---

### Q3. NetworkManager.shared in features

**Answer:**

> Anti-pattern — hides DI graph

---

### Q4. Packaging vs architecture

**Answer:**

> Clean boundary can live in CocoaPods or SPM

---

### Q5. Service locator

**Answer:**

> Runtime missing deps — constructor/tree DI is safer

---

### Q6. Stories SDK (Raw / Miami Heat)

**Answer:**

> Standalone Stories SDK + portfolio adoption — no invented build-time %

---
