# Day 15 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 15 modules. 
> Use this when you want concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../07-revision-qna.md`](../07-revision-qna.md) and drills in [`../05-exercises.md`](../05-exercises.md).

## Module map

Main curriculum modules for this day — see [`../README.md`](../README.md#module-map).

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-modularization-basics.md](01-modularization-basics.md) | Why modules, glossary, golden dependency rule | Foundations |
| [02-spm-di-graphs.md](02-spm-di-graphs.md) | SPM targets, DI graphs, linking, anti-patterns | Deep dive |
| [03-stories-sdk.md](03-stories-sdk.md) | SDK extraction, public API, shared models, build times | Deep dive |
| [04-production-s10.md](04-production-s10.md) | Verified S10 Stories SDK interview language | Production bridge |
| [05-system-design-mock.md](05-system-design-mock.md) | SD mock — Modularization / SDK boundary | ios-system-design/docs |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Feature A → Feature B | Depend on **B’s Interface**, never B’s Impl |
| Composition root | **App target** wires concrete builders |
| `NetworkManager.shared` in features | Anti-pattern — hides DI graph |
| Packaging vs architecture | Clean boundary can live in CocoaPods **or** SPM |
| Service locator | Runtime missing deps — constructor/tree DI is safer |
| Verified S10 | Standalone Stories SDK + portfolio adoption — **no** invented build-time % |

## Suggested order

`01` → `02` → `03` → `04` → `05` → then main [`../07-revision-qna.md`](../07-revision-qna.md).

## App

The Flutter audiobook app lists **these sample Q&A chapters only** for Day 15 (not the full curriculum modules).

```bash
python3 app/scripts/generate_sample_scripts.py
./app/scripts/sync_content.sh
```
