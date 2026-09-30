# Prototype — copy-paste Swift skeleton (read even without Xcode)

This is the **entire** 90-minute prototype in one place. Type it if you have Xcode; otherwise read it until you can rewrite it from memory.

## Models

```swift
import Foundation

struct Item: Identifiable, Codable, Equatable, Sendable {
    let id: String
    let title: String
    let subtitle: String
}

struct Page: Codable, Sendable {
    let items: [Item]
    let nextCursor: String?
}

enum LoadState<T>: Equatable {
    case idle
    case loading
    case loaded(T)
    case failed(String)
}
```

## HTTP seam

```swift
protocol HTTPClient: Sendable {
    func getFeed(after cursor: String?) async throws -> Page
}

struct FakeHTTPClient: HTTPClient {
    var delayNanos: UInt64 = 300_000_000
    var failOnce: Bool = false
    private let page = Page(
        items: [
            Item(id: "1", title: "Pune Intercity", subtitle: "Platform 7"),
            Item(id: "2", title: "SDUI hero", subtitle: "Offer card"),
            Item(id: "3", title: "Checkout hold", subtitle: "2 min TTL"),
        ],
        nextCursor: "cursor-2"
    )

    func getFeed(after cursor: String?) async throws -> Page {
        try await Task.sleep(nanoseconds: delayNanos)
        if failOnce { throw URLError(.notConnectedToInternet) }
        if cursor == nil { return page }
        return Page(
            items: [Item(id: "4", title: "Page 2", subtitle: "Cursor pagination")],
            nextCursor: nil
        )
    }
}
```

## Repository (cache then network)

```swift
actor FeedRepository {
    private var memory: [Item] = [
        Item(id: "cache", title: "Cached row", subtitle: "Shown instantly")
    ]
    private let client: HTTPClient

    init(client: HTTPClient) { self.client = client }

    func cached() -> [Item] { memory }

    func refresh() async throws -> [Item] {
        let page = try await client.getFeed(after: nil)
        memory = page.items
        return memory
    }

    func loadMore(cursor: String) async throws -> [Item] {
        let page = try await client.getFeed(after: cursor)
        memory.append(contentsOf: page.items)
        return memory
    }
}
```

## ViewModel

```swift
import SwiftUI

@MainActor
final class FeedViewModel: ObservableObject {
    @Published private(set) var state: LoadState<[Item]> = .idle
    @Published var banner: String?
    private let repo: FeedRepository
    private var nextCursor: String? = "cursor-2"

    init(repo: FeedRepository) { self.repo = repo }

    func appear() async {
        let cached = await repo.cached()
        state = .loaded(cached)
        banner = "Cached · refreshing"
        await refresh()
    }

    func refresh() async {
        do {
            let items = try await repo.refresh()
            state = .loaded(items)
            banner = nil
        } catch {
            if case .loaded = state {
                banner = "Offline — showing cache"
            } else {
                state = .failed("Network failed. Retry.")
            }
        }
    }
}
```

## View

```swift
struct FeedView: View {
    @StateObject var vm: FeedViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch vm.state {
                case .idle, .loading:
                    ProgressView("Loading")
                case .failed(let message):
                    Text(message)
                    Button("Retry") { Task { await vm.refresh() } }
                case .loaded(let items):
                    List(items) { item in
                        VStack(alignment: .leading) {
                            Text(item.title).font(.headline)
                            Text(item.subtitle).font(.subheadline)
                        }
                    }
                    .refreshable { await vm.refresh() }
                }
            }
            .navigationTitle("Travel prototype")
            .overlay(alignment: .bottom) {
                if let banner = vm.banner { Text(banner).padding() }
            }
        }
        .task { await vm.appear() }
    }
}
```

## What you will say if they open your laptop

> “Composition root injects FakeHTTPClient. Production swaps a URLSession client. State is an enum. Cache is an actor. MainActor on the view-model. Pagination cursor is a string, not page=2.”

That is LLD evidence, not a side project résumé.
