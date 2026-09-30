# Audio script — iOS basics — app lifecycle, networking intro, and quality bar

## §0 Introduction

iOS basics — app lifecycle, networking intro, and quality bar

## §1 Process lifecycle

Foreground (user sees your UI). Background (app still running limited work — you get seconds unless you declare a background mode). Suspended (frozen in RAM; can be killed without applicationWillTerminate ). BGTaskScheduler (API to ask iOS to run a refresh or processing task later — not a guaranteed cron). Sample answer: “I never assume willTerminate runs. I persist drafts on scenePhase background and on each meaningful edit. Networking that must finish uses a background URLSession configuration. I do not fake a VoIP background mode to keep the process alive — App Review rejects that.” Scene (UIScene: modern multi-window lifecycle; AppDelegate is process-level, SceneDelegate / SwiftUI scenePhase is window-level).

## §2 Networking intro (full LLD is later)

URLSession (Apple’s HTTP client: data, download, upload, WebSocket tasks). ATS (App Transport Security: by default HTTPS only). Codable ( Encodable + Decodable : map JSON to structs). Status codes you must handle: 200 OK, 304 Not Modified (ETag hit), 401 Unauthorized (refresh token), 403 Forbidden, 409 Conflict (sync), 429 Rate limited, 5xx retry with backoff. ETag (entity tag: server hash of the body; send If-None-Match so 304 saves bandwidth).

## §3 Combine vs async streams

Combine (reactive framework: Publisher pushes values over time — still common in UIKit code). AsyncSequence / AsyncStream (concurrency-native stream). Interview rule: pick one per module. Bridging both without a boundary creates leaks ( AnyCancellable not stored = subscription dies; or stored forever = leak). cancellable (token that keeps a Combine subscription alive; store in Set<AnyCancellable on the owner).

## §4 Testing vocabulary

Unit test (fast, no UI — fake the network). Fake (working stand-in with canned data) vs Mock (object that records calls) vs Stub (returns programmed answers). Dependency injection (passing collaborators in instead of singletons so tests can swap fakes). XCTest / Swift Testing (Apple test runners).

## §5 Performance bar (say the numbers)

- 60fps → 16.7ms frame budget. - Decode images to display size , not raw camera size. Formula: width × height × 4 bytes for ARGB. A 4000×3000 photo is ~48MB decoded — that is how you OOM (Out Of Memory: jetsam kills the app). - os signpost (signposts in Instruments to mark “decode start/end”).

## §6 Accessibility and internationalization (30s so you don’t skip)

VoiceOver (screen reader: use accessibilityLabel , don’t ship icon-only buttons). Dynamic Type (user font size; don’t clip text). Localization ( .strings / String Catalogs — never concatenate sentences).

## §7 Security basics

Keychain for tokens. ATS on. Certificate pinning (SPKI pin: trust only your server’s public key — optional, operationally heavy when certs rotate). Jailbreak detection is theater; protect data at rest instead.

## §8 Sample mixed round (cover, then speak)

1. Why is DispatchQueue.main.async inside viewDidLoad sometimes a smell? → Work may already be on main; you delay one turn of the run loop without a reason. 2. Why not store JWT in UserDefaults? → Not encrypted; backups may include it. 3. What does nonisolated on an actor method mean? → It does not hop to the actor; it must only touch immutable/Sendable state. 4. Why is lazy var on a struct surprising? → lazy needs mutation of self, so the struct binding must be var .

## §9 Map to a 60–90 minute ride

This pair of iOS-basics chapters is reference . On the train you only speak the sample answers (about 15 minutes). Do not reread both chapters end-to-end unless Trip D.
