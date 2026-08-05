# Audio script — Sample 03 — CI/CD & GitHub Actions (Q&A)
> Listen-only sample Q&A from `03-ci-cd-actions.md`. Spoken answers and follow-ups.

## §0 Q1. What is the BMS CI/CD pipeline shape?

Next. Q1. What is the BMS CI/CD pipeline shape? Answer. PR → GitHub Actions (lint, build, unit tests) → merge → archive + sign → TestFlight (internal/external) → phased App Store → monitor crash free sessions/perf → pause if needed. Verified BMS claim: automated Actions for build, lint, TestFlight — cut manual release ceremony. Follow-ups. Manual TestFlight when?: Tiny team early days — human error scales badly.. Fully auto prod?: Only with strong gates — weak gates = risk.. BMS CI ≤20s?: “Automated GitHub Actions for build, lint, and TestFlight upload.”.

## §1 Q2. What runs on every PR?

Next. Q2. What runs on every PR? Answer. Lint + build + unit tests on macOS runners. With modularization: selective test targets when safe. Quarantine flakes — don’t train team to ignore red CI. Green PR is merge gate; not optional “best effort.” Follow-ups. U I tests every PR?: Often nightly or selective — cost/time trade-off.. Flaky test policy?: Quarantine + fix ticket — never silent retry forever.. AI on PRs?: S9: assist only — humans own architecture/security..

## §2 Q3. How do you handle signing in CI?

Next. Q3. How do you handle signing in CI? Answer. Encrypted certs/profiles (match-style or cloud signing). Secrets in CI secret store / OIDC — never commit.p12 in clear. Deterministic CODE_SIGNING settings. Never log secrets in build output. Rotate if leaked. Follow-ups. Secrets in git history?: Rotate immediately; move to CI secrets — failure mode in deep dive.. Fastlane Match?: Common pattern — encrypted repo or cloud bucket.. Per-branch profiles?: Ad hoc vs App Store — separate pipelines..

## §3 Q4. Why upload dSYM on every user-facing build?

Next. Q4. Why upload dSYM on every user-facing build? Answer. Day 18 triage depends on it — Crashlytics symbolication without dSYM = useless stacks. Upload every build that can reach TestFlight or App Store users. Gate release on upload success when possible. Follow-ups. Bitcode era note?: Modern builds: dSYM from archive action.. TF internal only?: Still upload — internal crashes matter.. Missing dSYM symptom?: Hex addresses in Crashlytics..

## §4 Q5. TestFlight workflow — internal vs external?

Next. Q5. TestFlight workflow — internal vs external? Answer. Internal smoke first (team, fast feedback) → external beta when stable → then App Store phased %. TF crash-loop while CI green? Check release flags, entitlements, environment — smoke TF before wide phased. Follow-ups. TF vs prod config?: Different A P I keys/endpoints — common crash source.. External beta review?: Apple beta review for external groups.. Feature flags in TF?: Decouple binary ship from exposure..

## §5 Q6. How does AI-assisted PR review fit (S9)?

Next. Q6. How does AI-assisted PR review fit (S9)? Answer. “AI accelerates review for obvious regressions; humans still own architecture, security, and product trade-offs. I never say ‘AI approved so it’s fine.’” Verified S9 judgment — assist, don’t own. Forbidden: “AI approved the release.” Follow-ups. What AI catches well?: Style, obvious nil crashes, duplicate code.. What humans must own?: Threat model, pinning, router design, rollout.. Context Engineering?: S9 family — tooling augments, doesn’t replace..

## §6 Q7. CI failure modes?

Next. Q7. CI failure modes? Answer. | Mode | Response | TF crash-loop, CI green: Release flags / entitlements / env — smoke TF. Secrets in git: Rotate; CI secrets store. crash free sessions drop at 10% phased: Pause — I M O C (S 8). No dSYM: Fix upload step before widening rollout. Flaky CI ignored: Culture problem — quarantine and fix. Follow-ups. macOS runner cost?: Parallelize; cache DerivedData.. Manual release overhead?: What BMS CI automation removed.. Next topic?: Release trains — 04-release-trains.md. Next: 04-release-trains.md.
