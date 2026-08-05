# Sample 03 — CI/CD & GitHub Actions (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the BMS CI/CD pipeline shape?

**Points to:** [Foundations · §3 CI/CD & release trains](../01-foundations.md#3-cicd--release-trains) · [Deep dive · §5 CI/CD deep dive](../02-deep-dive.md#5-cicd-deep-dive)

**Answer:**

> **PR → GitHub Actions** (lint, build, unit tests) → merge → **archive + sign** → **TestFlight** (internal/external) → phased **App Store** → monitor CFS/perf → **pause** if needed. Verified BMS claim: automated Actions for build, lint, TestFlight — cut manual release ceremony.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Manual TestFlight when? | Tiny team early days — human error scales badly. |
| Fully auto prod? | Only with strong gates — weak gates = risk. |
| BMS CI ≤20s? | “Automated GitHub Actions for build, lint, and TestFlight upload.” |

---

### Q2. What runs on every PR?

**Points to:** [Deep dive · §5.1 PR checks](../02-deep-dive.md#51-pr-checks)

**Answer:**

> **Lint + build + unit tests** on macOS runners. With modularization: selective test targets when safe. **Quarantine flakes** — don’t train team to ignore red CI. Green PR is merge gate; not optional “best effort.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| UI tests every PR? | Often nightly or selective — cost/time trade-off. |
| Flaky test policy? | Quarantine + fix ticket — never silent retry forever. |
| AI on PRs? | S9: assist only — humans own architecture/security. |

---

### Q3. How do you handle signing in CI?

**Points to:** [Deep dive · §5.2 Signing](../02-deep-dive.md#52-signing) · [Foundations · §3](../01-foundations.md#3-cicd--release-trains)

**Answer:**

> Encrypted certs/profiles (match-style or cloud signing). Secrets in **CI secret store** / OIDC — **never commit `.p12` in clear**. Deterministic `CODE_SIGNING` settings. **Never log secrets** in build output. Rotate if leaked.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Secrets in git history? | Rotate immediately; move to CI secrets — failure mode in deep dive. |
| Fastlane Match? | Common pattern — encrypted repo or cloud bucket. |
| Per-branch profiles? | Ad hoc vs App Store — separate pipelines. |

---

### Q4. Why upload dSYM on every user-facing build?

**Points to:** [Deep dive · §5.4 dSYM](../02-deep-dive.md#54-dsym) · [Foundations · §3](../01-foundations.md#3-cicd--release-trains)

**Answer:**

> **Day 18 triage depends on it** — Crashlytics symbolication without dSYM = useless stacks. Upload every build that can reach TestFlight or App Store users. Gate release on upload success when possible.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bitcode era note? | Modern builds: dSYM from archive action. |
| TF internal only? | Still upload — internal crashes matter. |
| Missing dSYM symptom? | Hex addresses in Crashlytics. |

---

### Q5. TestFlight workflow — internal vs external?

**Points to:** [Deep dive · §5.3 TestFlight + phased release](../02-deep-dive.md#53-testflight--phased-release)

**Answer:**

> **Internal smoke** first (team, fast feedback) → **external** beta when stable → then App Store phased %. TF crash-loop while CI green? Check release flags, entitlements, environment — **smoke TF before wide phased**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| TF vs prod config? | Different API keys/endpoints — common crash source. |
| External beta review? | Apple beta review for external groups. |
| Feature flags in TF? | Decouple binary ship from exposure. |

---

### Q6. How does AI-assisted PR review fit (S9)?

**Points to:** [Deep dive · §5.5 AI on PRs](../02-deep-dive.md#55-ai-on-prs-s9) · [Production bridge · §4](../03-production-bridge.md#4-ai-review-breath-s9)

**Answer:**

> “AI accelerates review for **obvious regressions**; humans still own **architecture, security, and product trade-offs**. I never say ‘AI approved so it’s fine.’” Verified S9 judgment — assist, don’t own. Forbidden: “AI approved the release.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What AI catches well? | Style, obvious nil crashes, duplicate code. |
| What humans must own? | Threat model, pinning, router design, rollout. |
| Context Engineering? | S9 family — tooling augments, doesn’t replace. |

---

### Q7. CI failure modes?

**Points to:** [Deep dive · §8 Failure modes](../02-deep-dive.md#8-failure-modes)

**Answer:**

> | Mode | Response |
> | TF crash-loop, CI green | Release flags / entitlements / env — smoke TF |
> | Secrets in git | Rotate; CI secrets store |
> | CFS drop at 10% phased | Pause — IMOC (S8) |
> | No dSYM | Fix upload step before widening rollout |
> | Flaky CI ignored | Culture problem — quarantine and fix |

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| macOS runner cost? | Parallelize; cache DerivedData. |
| Manual release overhead? | What BMS CI automation removed. |
| Next topic? | Release trains — [04-release-trains.md](04-release-trains.md) |

---

Next: [04-release-trains.md](04-release-trains.md)
