# 01 — Foundations: Images, Caches, Media (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Plain-English mental model? `(45–60s)`
**Answer:**

> “Showing a remote image is a pipeline, not Data(contentsOf:): 1. Ask for a URL at a target pixel size 2. Check memory for a decoded image already sized 3. Else check disk for bytes → decode/downsample off main 4. Else download, downsample, store, display 5. If the cell scrolled away — cancel and ignore late results.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Glossary? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Cache tiers (embedded teaching)? `(45–60s)`
**Answer:**

> “text imageView.load(url, targetSize: bounds × scale) → L1 NSCache (key: url + targetSize) HIT → UIImage → L2 Disk (hash(url) ± size variant) HIT → decode bg → L1 → UI → In-flight dedupe? YES → attach observer → URLSession fetch → ImageIO downsample (max pixel size) → Store L1 (+ L2 bytes) → notify observers.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Why URLCache alone is insufficient? `(45–60s)`
**Answer:**

> “URLCache may store response bytes. UI still needs: - Downsampled decode - Memory pressure policy - Dedupe across image views - Cancellation on reuse.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Scroll-safe loading (60s)? `(45–60s)`
**Answer:**

> “1. Cancel when off-screen 2. Dedup same key 3. Priority: visible > prefetch 4. Cap prefetch on fast fling 5. Never decode JPEG on main (<16ms frame budget).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Two production media stories (preview)? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Checkpoint? `(45–60s)`
**Answer:**

> “1. Draw L1/L2/L3 from memory 2. Say decoded-size math 3. Name one HeroWidget pause trigger → 02-deep-dive.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
