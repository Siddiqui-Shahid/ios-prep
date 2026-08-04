# Curated Resource Index

Prefer Apple docs and WWDC over random blogs. Repo specs live under `ios-system-design/docs/`.

---

## Swift language & POP

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| Value vs reference, COW | [The Swift Programming Language — Classes and Structures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/) | [WWDC — Understanding Swift performance](https://developer.apple.com/videos/) (search) | Day 01 |
| Protocols & generics | [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/) · [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/) | [Swift Generics Manifesto](https://github.com/apple/swift/blob/main/docs/GenericsManifesto.md) | Day 02 |
| Error handling | [Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/) | — | Day 02 |

## Memory

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| ARC | [Automatic Reference Counting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/) | Instruments Leaks / Allocations docs | Day 03 |

## Concurrency

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| GCD | [Dispatch documentation](https://developer.apple.com/documentation/dispatch) | Apple Concurrency Programming Guide (legacy but solid for queues) | Day 04 |
| Swift Concurrency | [Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/) | WWDC: Meet async/await; Protect mutable state with Swift actors; Swift concurrency: Behind the scenes | Day 05 |
| Sendable / strict | [Sendable](https://developer.apple.com/documentation/swift/sendable) | SE-0302 / SE-0306 | Day 05 |

## Architecture

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| MVVM / Clean / DI | Day 08 notes | [app-modularization.md](../../ios-system-design/docs/app-modularization.md) | Days 08, 15 |
| Networking | [URLSession](https://developer.apple.com/documentation/foundation/urlsession) | [networking-layer.md](../../ios-system-design/docs/networking-layer.md) | Day 09 |
| SDUI | Day 10 notes | [sdui-engine.md](../../ios-system-design/docs/sdui-engine.md) | Day 10 |
| Search | — | [search-autocomplete.md](../../ios-system-design/docs/search-autocomplete.md) | Week 2 |
| Payments | — | [payment-checkout.md](../../ios-system-design/docs/payment-checkout.md) | Week 2 |

## UI

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| UIKit lifecycle | [UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller) | WWDC UIKit sessions | Day 11 |
| SwiftUI state | [State and data flow](https://developer.apple.com/documentation/swiftui/state-and-data-flow) | WWDC: Demystify SwiftUI; SwiftUI performance | Day 12 |
| Hybrid UIKit↔SwiftUI | [UIViewControllerRepresentable](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable) | WWDC interop sessions | Days 11–12 |

## Performance & observability

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| Instruments | [Analyzing your app’s performance](https://developer.apple.com/documentation/xcode/analyzing-your-app-s-performance) | [app-performance-monitoring.md](../../ios-system-design/docs/app-performance-monitoring.md) | Day 17 |
| Images / cache | — | [image-loading-library.md](../../ios-system-design/docs/image-loading-library.md) | Day 16 |
| Crashes | Firebase Crashlytics docs | [crash-reporting-sdk.md](../../ios-system-design/docs/crash-reporting-sdk.md) | Day 18 |
| Feeds | — | [social-feed.md](../../ios-system-design/docs/social-feed.md) | Week 1 |

## Security & identity

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| ATS / TLS | [App Transport Security](https://developer.apple.com/documentation/security/preventing_insecure_network_connections) | [mobile-security-privacy-engine.md](../../ios-system-design/docs/mobile-security-privacy-engine.md) | Day 19 |
| Auth / Keychain | [Keychain Services](https://developer.apple.com/documentation/security/keychain_services) | [authentication-oauth-biometric.md](../../ios-system-design/docs/authentication-oauth-biometric.md) | Day 19 |

## Platform

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| Universal Links | [Allowing apps and websites to link](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content) | [deep-linking-universal-links.md](../../ios-system-design/docs/deep-linking-universal-links.md) | Day 20 |
| Push | [User Notifications](https://developer.apple.com/documentation/usernotifications) | [push-notification-system.md](../../ios-system-design/docs/push-notification-system.md) | Day 20 |
| CI/CD | Xcode Cloud / Fastlane docs | [mobile-ci-cd-pipeline.md](../../ios-system-design/docs/mobile-ci-cd-pipeline.md) | Day 20 |
| Cheatsheet | — | [cheatsheet.md](../../ios-system-design/docs/cheatsheet.md) | All SD mocks |

## On-device AI

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| On-device LLM / RAG | Apple Foundation Models (WWDC) | [on-device-llm-ai-engine.md](../../ios-system-design/docs/on-device-llm-ai-engine.md) · [how-ai-summarization-agents-work.md](../../ios-system-design/docs/how-ai-summarization-agents-work.md) | Day 24 |

## Testing

| Topic | Must-read | Deepen | Repo / notes |
|---|---|---|---|
| XCTest / XCUITest | [Testing](https://developer.apple.com/documentation/xctest) | District AI-assisted test generation story | Days 08, 25 |

## DSA practice sites

- [LeetCode](https://leetcode.com/) — filter Easy/Medium; solve in Swift
- Pattern list: [coding/dsa-track.md](../coding/dsa-track.md)
