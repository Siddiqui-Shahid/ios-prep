# Audio script — Questions 21–30 — platform, observability, AI, calling

## §0 Introduction

Questions 21–30 — platform, observability, AI, calling

## §1 Q21. Design deep links and Universal Links

Answer: “ Universal Links (HTTPS that opens the app via AASA file — Apple App Site Association; must not be on a CDN that breaks the apple-app-site-association rules). Router/coordinator maps path → screen. Deferred (install then route) needs a vendor or clipboard hack I won’t invent. Cold-start race: wait for session restore before navigating. Web fallback if the app is missing.”

## §2 Q22. Design crash reporting

Answer: “Signal/exception handler writes a minidump off the crashing thread carefully. dSYM (debug symbols) for symbolication on the server. Breadcrumb ring buffer (last N actions). OOM is often not a catchable exception — infer from Jetsam / MetricKit. Never block the crashing thread on network. Upload on next launch.”

## §3 Q23. Design an analytics SDK

Answer: “Ring buffer → SQLite journal → batch upload. Flush on background, 30s, or N events. Sample high-volume events. Identify with anonymous id + later user id. Battery-aware. Crash recovery: don’t lose the last batch. I don’t print PII. Schema: event name + small property map.”

## §4 Q24. Design A/B testing

Answer: “ Deterministic hash of userId + experimentId (e.g. Murmur) so the bucket is stable. Sticky assignment stored locally. Kill switch via remote config / silent push. Don’t bucket on the client only if users can reinstall to cheat a paywall. Exposure event when the UI actually shows, not at download.”

## §5 Q25. Design app performance monitoring

Answer: “ MetricKit (Apple’s on-device performance reports). Cold start: pre-main vs first frame. Hitch vs hang (main thread blocked). Network: template URLs so /user/123 doesn’t explode cardinality. Signposts around decode. I quote 16.7ms frames, not vibes.”

## §6 Q26. Design app modularization and DI

Answer: “Modules: Feature → Interface → Core. Features don’t import each other — they import interfaces (protocols). DI (Dependency Injection: compose in a root, not singletons inside views). SPM (Swift Package Manager) for boundaries. Needle/Swinject optional; a manual AppContainer is interview-honest. Goal: compile times and test fakes, not diagram vanity.”

## §7 Q27. Design mobile CI/CD

Answer: “ Fastlane match or Xcode Cloud for signing. PR: tests + lint. Main: archive, dSYM upload, TestFlight. Phased release (App Store %). Rollback: phased pause + server kill switch — you cannot un-ship bits already installed. Version the API forever; old binaries live.”

## §8 Q28. Design an on-device LLM feature

Answer: “Don’t load FP16 weights with Data(contentsOf:) . Quantize (INT4/INT8: smaller weights). Memory-map. Cap working set. Stream tokens to UI via AsyncSequence . Thermal throttle. Fallback to cloud if the device is too small. Privacy: on-device is the point — don’t log prompts. I won’t fake a 70B model on an iPhone.”

## §9 Q29. Design in-app video calling (WebRTC)

Answer: “ WebRTC : ICE/STUN/TURN for NAT, SFU (Selective Forwarding Unit: server routes media, doesn’t mix everyone into one encode). AVAudioSession playAndRecord. Grid of RTCMTLVideoView . Thermal: drop remote quality. Permissions. I don’t write a custom RTP stack in a 45-minute round.”

## §10 Q30. Design a crash-free, observable release (platform / EM lens)

Answer: “This is the Staff/EM wrap: canary (1% → 100%), feature flags, MetricKit + crash-free sessions, Sev-1 playbook, kill switch. Client still has the 4-layer stack. I pick two deep dives from the 29 above instead of designing Kubernetes. Mobile constraints: battery, offline, App Review, old versions. That’s the closer.” --- How to use these 30 on a 60–90 minute ride Pick one question. Speak the answer. Then name: one HLD box, one LLD type, one failure. Stop. Do not binge all 30 on the train.
