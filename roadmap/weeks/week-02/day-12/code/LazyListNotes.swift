import Foundation

// Learning-lab — Day 12
// List performance checklist as data — speak from this in interviews.

enum ListContainerAdvice: String, Sendable {
    case list = "List — platform behaviors, edit mode"
    case lazyVStack = "LazyVStack in ScrollView — custom large stacks"
    case eagerVStack = "VStack — tiny static only; never thousands"
}

struct ListPerfRule: Sendable {
    var title: String
    var detail: String
}

enum LazyListNotes {
    static let rules: [ListPerfRule] = [
        .init(title: "Stable Identifiable", detail: "Model keys; no UUID in body; avoid id:\\.self on mutating values"),
        .init(title: "Cheap body", detail: "Precompute formatting in model; no JSON sort in body"),
        .init(title: "Narrow observation", detail: "Don’t observe whole catalog in each row; pass row slices"),
        .init(title: "Async images", detail: "Size budgets; cancel on disappear; Week 3 pipeline"),
        .init(title: "Scoped animation", detail: "Animate local transactions; not entire tree"),
        .init(title: "Profile jank", detail: "If Lazy still janks, fix decode/main-thread work — not only container"),
    ]

    static let interviewParagraph = """
    For large collections I use List or LazyVStack with stable Identifiable models,
    keep row body cheap, and avoid observing a god-object catalog from every row.
    Eager VStacks of thousands are a footgun. If it’s still janky after Lazy,
    I profile image decode and main-thread work — container choice alone isn’t enough.
    """
}

/// Illustrative row model — formatted fields precomputed.
struct FeedRowModel: Identifiable, Equatable, Sendable {
    let id: String
    var title: String
    var subtitleFormatted: String
    var imageURL: URL?
}
