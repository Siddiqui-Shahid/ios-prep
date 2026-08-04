import Foundation

#if canImport(UIKit)
import UIKit
#endif

/// Learning-lab HeroWidget-shaped lifecycle contract (S1-shaped).
/// Not a claim of exact BMS source.

protocol AdMediaPlaying: AnyObject {
    func play()
    func pause()
    func tearDown()
}

protocol AdVisibilityObserving: AnyObject {
    var isVisiblyEnoughForPlayback: Bool { get }
}

/// Policy differs for ads vs editorial — inject it.
enum AutoplayPolicy: Sendable {
    case adsViewabilityRequired
    case editorialMuteAutoplay
    case neverAutoplay
}

@MainActor
final class HeroWidgetController {
    private let player: AdMediaPlaying
    private let visibility: AdVisibilityObserving
    private let policy: AutoplayPolicy
    private var isAppeared = false
    private var isAppActive = true

    init(player: AdMediaPlaying, visibility: AdVisibilityObserving, policy: AutoplayPolicy) {
        self.player = player
        self.visibility = visibility
        self.policy = policy
    }

    func viewWillAppear() {
        isAppeared = true
        evaluatePlayback()
    }

    func viewWillDisappear() {
        isAppeared = false
        player.pause()
    }

    func appDidEnterBackground() {
        isAppActive = false
        player.pause()
    }

    func appWillEnterForeground() {
        isAppActive = true
        evaluatePlayback()
    }

    func visibilityDidChange() {
        evaluatePlayback()
    }

    /// Cell reuse — must stop and release, not only pause.
    func prepareForReuse() {
        player.pause()
        player.tearDown()
    }

    private func evaluatePlayback() {
        guard isAppeared, isAppActive, visibility.isVisiblyEnoughForPlayback else {
            player.pause()
            return
        }
        switch policy {
        case .neverAutoplay:
            player.pause()
        case .adsViewabilityRequired, .editorialMuteAutoplay:
            player.play()
        }
    }
}

// MARK: - Demo doubles

final class FakePlayer: AdMediaPlaying {
    enum State { case idle, playing, paused, tornDown }
    private(set) var state: State = .idle
    func play() { state = .playing }
    func pause() { state = .paused }
    func tearDown() { state = .tornDown }
}

final class FakeVisibility: AdVisibilityObserving {
    var isVisiblyEnoughForPlayback = true
}

enum HeroWidgetDemo {
    @MainActor
    static func run() {
        let player = FakePlayer()
        let visibility = FakeVisibility()
        let widget = HeroWidgetController(
            player: player,
            visibility: visibility,
            policy: .adsViewabilityRequired
        )
        widget.viewWillAppear()
        assert(player.state == .playing)
        visibility.isVisiblyEnoughForPlayback = false
        widget.visibilityDidChange()
        assert(player.state == .paused)
        widget.prepareForReuse()
        assert(player.state == .tornDown)
        print("HeroWidgetLifecycle demo OK")
    }
}
