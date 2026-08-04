import Foundation

// Learning-lab — Day 12
// Stories player model: state machine + stable page identity.
// Provenance cousin: Verified · S10 Stories SDK (illustrative API shape).
// Note: @Observable is iOS 17+. This file stays Foundation-only for portability.

enum StoriesPhase: Equatable, Sendable {
    case idle
    case loading
    case playing
    case paused
    case finished
    case failed(message: String)
}

struct StoryPage: Identifiable, Equatable, Sendable {
    let id: String          // stable server/host id — never regenerate in body
    var mediaURL: URL
    var duration: TimeInterval
}

struct StoryGroup: Identifiable, Equatable, Sendable {
    let id: String
    var pages: [StoryPage]
}

protocol StoriesDataSource: Sendable {
    func loadGroups() async throws -> [StoryGroup]
}

protocol StoriesEventSink: Sendable {
    func onOpen(groupId: String)
    func onClose(groupId: String)
    func onPage(groupId: String, pageId: String)
    func onCTA(groupId: String, pageId: String)
}

/// Non-UI timeline owner. Views render; they don’t invent parallel timers.
final class StoriesPlayerModel: @unchecked Sendable {
    private(set) var phase: StoriesPhase = .idle
    private(set) var groups: [StoryGroup] = []
    private(set) var groupIndex = 0
    private(set) var pageIndex = 0
    private(set) var progress: Double = 0 // 0...1 for current page

    private var ticker: Task<Void, Never>?
    private let dataSource: StoriesDataSource
    private let events: StoriesEventSink

    init(dataSource: StoriesDataSource, events: StoriesEventSink) {
        self.dataSource = dataSource
        self.events = events
    }

    var currentGroup: StoryGroup? {
        groups.indices.contains(groupIndex) ? groups[groupIndex] : nil
    }

    var currentPage: StoryPage? {
        guard let group = currentGroup, group.pages.indices.contains(pageIndex) else { return nil }
        return group.pages[pageIndex]
    }

    func start() {
        ticker?.cancel()
        phase = .loading
        Task { [weak self] in
            guard let self else { return }
            do {
                let loaded = try await dataSource.loadGroups()
                self.groups = loaded
                self.groupIndex = 0
                self.pageIndex = 0
                self.progress = 0
                if let g = self.currentGroup {
                    self.events.onOpen(groupId: g.id)
                    if let p = self.currentPage { self.events.onPage(groupId: g.id, pageId: p.id) }
                }
                self.phase = .playing
                self.runTicker()
            } catch {
                self.phase = .failed(message: "Couldn’t load stories")
            }
        }
    }

    func pause() {
        guard phase == .playing else { return }
        phase = .paused
        ticker?.cancel()
        ticker = nil
    }

    func resume() {
        guard phase == .paused else { return }
        phase = .playing
        runTicker()
    }

    /// Call from onDisappear / scene background.
    func handleDisappear() {
        pause()
    }

    func advance() {
        guard let group = currentGroup else { return }
        if pageIndex + 1 < group.pages.count {
            pageIndex += 1
            progress = 0
            if let p = currentPage { events.onPage(groupId: group.id, pageId: p.id) }
            return
        }
        if groupIndex + 1 < groups.count {
            groupIndex += 1
            pageIndex = 0
            progress = 0
            if let g = currentGroup {
                events.onOpen(groupId: g.id)
                if let p = currentPage { events.onPage(groupId: g.id, pageId: p.id) }
            }
            return
        }
        phase = .finished
        ticker?.cancel()
        if let g = currentGroup { events.onClose(groupId: g.id) }
    }

    private func runTicker() {
        ticker?.cancel()
        ticker = Task { [weak self] in
            while let self, self.phase == .playing, let page = self.currentPage {
                let step = 0.05
                try? await Task.sleep(nanoseconds: UInt64(step * 1_000_000_000))
                if Task.isCancelled { return }
                self.progress += step / max(page.duration, 0.1)
                if self.progress >= 1 {
                    self.progress = 0
                    self.advance()
                }
            }
        }
    }
}
