# Flashcards — Security: ATS, SSL Pinning, Keychain & Persistence

> Active recall for `day-19`. Cover the answer, speak aloud, then reveal.

---

### Q1. ATS

**Answer:**

> System HTTPS/TLS baseline — not pinning

---

### Q2. SPKI

**Answer:**

> Hash of SPKI DER — not SecKeyCopyExternalRepresentation raw bytes

---

### Q3. BookMyShow SSL pinning + URLSession migration

**Answer:**

> Ads Alamofire → URLSession; HTTPS; SSL pinning; domain whitelist

---

### Q4. Design: pin rotation / break-glass (not shipped runbook)

**Answer:**

> Rotation / backup / break-glass = design judgment — not “shipped runbook”

---

### Q5. Tokens

**Answer:**

> Keychain only — never UserDefaults

---

### Q6. Persistence

**Answer:**

> Pick store from sensitivity + access pattern — not one tool for everything

---
