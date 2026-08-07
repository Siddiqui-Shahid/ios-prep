// AdsPipeline.swift
// Day 02 Learning-lab — teaching shape for Verified · S1 (POP + Generics).
// NOT claimed as shipped BookMyShow source.

import Foundation

// MARK: - Capabilities (POP)

protocol AdTrackable {
    var creativeID: String { get }
    func trackImpression()
    func trackClick()
}

extension AdTrackable {
    /// Default click tracking — fine when identical across creatives.
    /// If subclasses/conformers must override polymorphically through an existential,
    /// declare `trackClick()` as a protocol *requirement* only (already is) and
    /// avoid relying on extension-only methods for customization.
    func trackClick() {
        print("[track] click \(creativeID)")
    }
}

protocol Creative {
    associatedtype Body
    var creativeID: String { get }
    func makeBody() -> Body
}

protocol PlaybackControllable: AnyObject {
    func play()
    func pause()
}

// MARK: - Concrete creatives

struct ImageCreative: Creative, AdTrackable {
    let creativeID: String
    let title: String

    func makeBody() -> String {
        "Image(\(title))"
    }

    func trackImpression() {
        print("[track] impression image \(creativeID)")
    }
}

final class VideoCreative: Creative, AdTrackable, PlaybackControllable {
    let creativeID: String
    let title: String
    private(set) var isPlaying = false

    func makeBody() -> String {
        "Video(\(title))"
    }

    func trackImpression() {
        print("[track] impression video \(creativeID)"
    }

    func play() { isPlaying = true }
    func pause() { isPlaying = false }
}

// MARK: - Generic pipeline (prefer this inside hot path)

struct AdPipeline<C: Creative & AdTrackable> {
    let creative: C

    func install() -> C.Body {
        creative.trackImpression()
        return creative.makeBody()
    }
}

enum AdPipelineDemo {
    static func run() {
        let image = ImageCreative(creativeID: "img-1", title: "Showtime")
        let imageBody = AdPipeline(creative: image).install()

        let video = VideoCreative(creativeID: "vid-1", title: "Trailer")
        let videoBody = AdPipeline(creative: video).install()
        bindPlayback(video)

        _ = (imageBody, videoBody)
    }

    /// Capability composition: only playback-capable creatives.
    static func bindPlayback<C: Creative & PlaybackControllable>(_ creative: C) {
        creative.pause()
        // Visibility appeared:
        creative.play()
    }
}

// MARK: - HeroWidget-shaped lifecycle owner (class identity)

/// Sketch of S1 HeroWidget idea: reference type owns player lifecycle.
/// Pause/play tied to visibility — product contract, not an afterthought.
final class HeroWidget: PlaybackControllable {
    private let creative: VideoCreative

    init(creative: VideoCreative) {
        self.creative = creative
    }

    func play() { creative.play() }
    func pause() { creative.pause() }

    func didEnterVisibleViewport() { play() }
    func didLeaveVisibleViewport() { pause() }
}

/*
 Interview pitch (Verified · S1):
 “Protocol contracts + generics kept the ads pipeline type-safe.
  HeroWidget handled video pause/play against visibility as a lifecycle class.”
 */
