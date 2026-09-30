# Distilled interview notes (not dumped into the app UI)

Whisper `tiny.en` mis-hears names (Shahid, Swift, ARC, heap). Substance recovered from timestamps below.

## 21 Aug — coding / request vs download (~48 min, transcribed)

- Interviewer: difference between the generic request structure you built and a *specific download* request model. You kept talking about “the downloading part.”
- Guessed GET for a download API; unsure what to send besides book id.
- Two parallel book downloads: you offered callbacks; they said callbacks cannot handle that and pushed a download manager.
- Later: actors vs class for progress; `unowned self` crash.

**Keep:** Endpoint vs `URLSessionDownloadTask`; per-id progress/cancel.

## 26 Aug 15:06 — value vs reference (~51 min, transcribed)

- Sendable: “makes the class aggressive”; compile-time check mentioned.
- Value vs reference: structs “much more faster”; classes for “complex” view models / network.
- Heap/stack: “heat memory”; ARC heard as “CCR.”
- SwiftUI VM → view: you asked for five minutes / two screens parent-child. They wanted short.
- Later: SOLID, AI-written unit tests.

**Keep:** semantics over speed myth; 45s not 5 min.

## 28 Aug — DSA / architecture (~75 min, transcribed)

- Opening instruction: *think out loud*; algorithm OK; not judging Swift syntax.
- You still needed steering; class vs struct bug in a calculator-style prompt.
- Codable/JSON: “apart from decoder I don’t know.”
- Coordinators: “one class” for many screens; fuzzy why the pattern exists.

**Keep:** 6-step DSA opener; Codable structs; child coordinators = flows.

## 4 Sep — production crash / 1% rollout (~55 min, transcribed)

Interviewer: you rolled to **one percent of users** and you are seeing crashes. You went to a hotfix, then a **feature kill flag**. You did not lead with pause-the-ramp / dSYM / device-OS slice.

**Keep:** pause phased release, symbolicate, kill switch, then hotfix.

## Interview used, not fully transcribed here

- 19 Aug intro (~63 min) — AI-first intro. Sample clip only.
- 27 Aug 18:17 table reuse (~63 min) — could not name reuseIdentifier. Sample clip only.

## KT ignored (not in the app)

- 25 Aug “start with the KT part”
- 26 Aug 17:09 payment/checkout code walkthrough
- 27 Aug 19:36 ~164 min
