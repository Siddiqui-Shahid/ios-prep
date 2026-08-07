# Flashcards — Image/Video Pipelines, Caching & Memory Pressure

> Active recall for `day-16`. Cover the answer, speak aloud, then reveal.

---

### Q1. HTTP cache

**Answer:**

> Not a UIImage cache — still need decode + L1 policy

---

### Q2. Decoded 1000×1000 ARGB

**Answer:**

> ≈ 4 MB — key by url + targetSize

---

### Q3. Wrong image in cell

**Answer:**

> Missing cancel/token on reuse

---

### Q4. HeroWidget

**Answer:**

> Pause when off-screen / background / reuse — product contract

---

### Q5. Aces audio

**Answer:**

> Not image LRU — AVAudioSession + interruptions

---

### Q6. BookMyShow Ads pipeline + HeroWidget lifecycle / Audio streaming + server-driven splash (Aces)

**Answer:**

> No invented fill-rate % or splash ms

---
