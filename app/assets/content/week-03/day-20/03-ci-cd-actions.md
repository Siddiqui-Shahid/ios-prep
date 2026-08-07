# Sample 03 — CI/CD & GitHub Actions (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the BMS CI/CD pipeline shape?

**Answer:**

> **PR → GitHub Actions** (lint, build, unit tests) → merge → **archive + sign** → **TestFlight** (internal/external) → phased **App Store** → monitor CFS/perf → **pause** if needed. Verified BMS claim: automated Actions for build, lint, TestFlight — cut manual release ceremony.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Manual TestFlight when? | Tiny team early days — human error scales badly. |
| Fully auto prod? | Only with strong gates — weak gates = risk. |
| BMS CI ≤20s? | “Automated GitHub Actions for build, lint, and TestFlight upload.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What runs on every PR?

**Answer:**

> **Lint + build + unit tests** on macOS runners. With modularization: selective test targets when safe. **Quarantine flakes** — don’t train team to ignore red CI. Green PR is merge gate; not optional “best effort.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| UI tests every PR? | Often nightly or selective — cost/time trade-off. |
| Flaky test policy? | Quarantine + fix ticket — never silent retry forever. |
| AI on PRs? | District Free Parking + Clean/MVVM + AI tooling: assist only — humans own architecture/security. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How do you handle signing in CI?

**Answer:**

> Encrypted certs/profiles (match-style or cloud signing). Secrets in **CI secret store** / OIDC — **never commit `.p12` in clear**. Deterministic `CODE_SIGNING` settings. **Never log secrets** in build output. Rotate if leaked.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Secrets in git history? | Rotate immediately; move to CI secrets — failure mode in deep dive. |
| Fastlane Match? | Common pattern — encrypted repo or cloud bucket. |
| Per-branch profiles? | Ad hoc vs App Store — separate pipelines. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Why upload dSYM on every user-facing build?

**Answer:**

> **Day 18 triage depends on it** — Crashlytics symbolication without dSYM = useless stacks. Upload every build that can reach TestFlight or App Store users. Gate release on upload success when possible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bitcode era note? | Modern builds: dSYM from archive action. |
| TF internal only? | Still upload — internal crashes matter. |
| Missing dSYM symptom? | Hex addresses in Crashlytics. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. TestFlight workflow — internal vs external?

**Answer:**

> **Internal smoke** first (team, fast feedback) → **external** beta when stable → then App Store phased %. TF crash-loop while CI green? Check release flags, entitlements, environment — **smoke TF before wide phased**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| TF vs prod config? | Different API keys/endpoints — common crash source. |
| External beta review? | Apple beta review for external groups. |
| Feature flags in TF? | Decouple binary ship from exposure. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. How does AI-assisted PR review fit (District Free Parking + Clean/MVVM + AI tooling)?

**Answer:**

> “AI accelerates review for **obvious regressions**; humans still own **architecture, security, and product trade-offs**. I never say ‘AI approved so it’s fine.’” District Free Parking + Clean/MVVM + AI tooling judgment — assist, don’t own. Forbidden: “AI approved the release.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What AI catches well? | Style, obvious nil crashes, duplicate code. |
| What humans must own? | Threat model, pinning, router design, rollout. |
| Context Engineering? | District Free Parking + Clean/MVVM + AI tooling family — tooling augments, doesn’t replace. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. CI failure modes?

**Answer:**

> | Mode | Response |
> | TF crash-loop, CI green | Release flags / entitlements / env — smoke TF |
> | Secrets in git | Rotate; CI secrets store |
> | CFS drop at 10% phased | Pause — IMOC (BookMyShow IMOC + crash-free at scale) |
> | No dSYM | Fix upload step before widening rollout |
> | Flaky CI ignored | Culture problem — quarantine and fix |

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| macOS runner cost? | Parallelize; cache DerivedData. |
| Manual release overhead? | What BMS CI automation removed. |
| Next topic? | Release trains — [04-release-trains.md](04-release-trains.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

Next: [04-release-trains.md](04-release-trains.md)

---

