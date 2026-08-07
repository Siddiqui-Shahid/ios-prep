# Flashcards — URLSession Networking Layer

> Active recall for `day-09`. Cover the answer, speak aloud, then reveal.

---

### Q1. Pipeline

**Answer:**

> Endpoint → build → intercept → execute → decode → map errors

---

### Q2. Single-flight

**Answer:**

> Many concurrent 401s share one refresh; retry originals once

---

### Q3. Async cancel

**Answer:**

> URLSession.data(for:) participates in Task cancellation

---

### Q4. Callback cancel

**Answer:**

> Explicit task.cancel() + generation/stale guard

---

### Q5. ATS ≠ pinning

**Answer:**

> ATS is HTTPS baseline; pinning is extra identity check

---

### Q6. SPKI

**Answer:**

> Hash SPKI DER — not raw SecKeyCopyExternalRepresentation bytes

---

### Q7. BookMyShow SSL pinning + URLSession migration verified

**Answer:**

> Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist

---

### Q8. Design: pin rotation / break-glass (not shipped runbook)

**Answer:**

> Pin rotation / backup pins / break-glass = design, not shipped runbook

---
