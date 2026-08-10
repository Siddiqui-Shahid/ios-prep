# 02 — Deep Dive: Pipeline, ImageIO, Video & Audio (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. End-to-end image loader HLD? `(45–60s)`
**Answer:**

> “text +-------------+ +--------------+ +-----------+ downsample (ImageIO) dedupe map cancel tokens API shape (interview):.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Downsampling (critical API)? `(45–60s)`
**Answer:**

> “Use ImageIO: - CGImageSourceCreateWithData / URL - CGImageSourceCreateThumbnailAtIndex - kCGImageSourceThumbnailMaxPixelSize - kCGImageSourceCreateThumbnailFromImageAlways.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Dedup & cancellation? `(45–60s)`
**Answer:**

> “text inflight[key] = Task observers... on complete → fan-out → clear inflight on cancel last observer → cancel Task (policy choice) Cell reuse:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Prefetch footguns? `(45–60s)`
**Answer:**

> “Benefits: warmer L1/L2 for next cells. Footguns: decode storms on fling; bandwidth waste. Fix: bound concurrency; cancel prefetch when direction changes; prioritize visible indexPaths; lower QoS for prefetch vs visible.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Memory pressure playbook? `(45–60s)`
**Answer:**

> “On warning / jetsam risk: 1. Trim L1 (NSCache helps; custom LRU must listen) 2. Pause non-visible video / decode work 3. Keep L2 (disk) — recreatable 4. Don’t wipe user Documents 5. Avoid main-thread purge storms.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. HeroWidget video (S1 deep)? `(45–60s)`
**Answer:**

> “Revenue Ads video must pause when: - Partially / fully off-screen (pager / scroll) - viewWillDisappear - App background - Cell prepareForReuse.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Aces audio + splash (S12 deep)? `(45–60s)`
**Answer:**

> “Audio ≠ image cache:.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Should Stories SDK own the image pipeline? (S10 bridge)? `(45–60s)`
**Answer:**

> “No hardcode Kingfisher inside SDK forever. Inject ImageLoading from host so portfolio apps share one loader/policy (Day 15). SDK stays reusable.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Trade-offs? `(45–60s)`
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

### Q10. Failure modes? `(45–60s)`
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

### Q11. Optional citations? `(45–60s)`
**Answer:**

> “- WWDC Image and Graphics Best Practices / Downsampling - ios-system-design/docs/image-loading-library.md (optional skim).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
