# Audio script — Drill — crash in 1% phased release, not locally

## §0 Introduction

Drill — crash in 1% phased release, not locally From: 4 Sep interview. They said you rolled the app to one percent of users and then saw crashes. Your first move on the recording was a hotfix then a feature kill flag . Good instincts — incomplete. Also say: pause the phased release, symbolicate, slice by OS/device, then flag.

## §1 Keywords

- Phased release (App Store % rollout — you cannot un-install bits already out). - dSYM (debug symbols so a crash address becomes a line of Swift). - MetricKit (Apple on-device hang/crash reports). - Kill switch (remote flag to disable the new path). - Jetsam / OOM (OS kills you for memory; often not a catchable NSException).

## §2 Target answer (90s)

“Pause the phased release if it’s still ramping. Pull crash logs + dSYMs; I don’t debug from the pie chart. Check device, OS, and whether it’s a language/locale-only path. If it’s the new feature, flip the kill switch so 99% never hit it. Local not repro: race, memory, specific GPU, or a server payload only production sends. Add a breadcrumb, ship a hotfix behind the flag, then resume rollout.”
