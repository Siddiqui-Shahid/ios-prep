import Foundation

/// Learning-lab notes as typed constants — interview cues, not a crash SDK.

enum CrashReportNotes {
    static let pipeline = """
    init handlers → breadcrumb ring → crash → signal-safe persist → next launch upload → dSYM symbolicate
    """

    static let signalSafety = """
    No malloc, ObjC, Swift alloc, or locks in the signal handler. Preallocate mmap; write safely; abort.
    """

    static let cfsHonesty = """
    Verified S8: 30L+ DAU, 99.95%+ CFS, Crashlytics, IMOC.
    Verified S2: path-scoped race fix via synchronised dictionaries — CONTRIBUTOR, not sole CFS cause.
    """

    static let hangGap = """
    Healthy CFS does not prove absence of hangs/OOM. Use hang metrics + MetricKit.
    """

    static let uploadTiming = """
    Persist on crash. Upload on next launch with backoff. Never network inside the handler.
    """
}

/*
 Provenance tags to speak:
 - Verified · S8 · CFS / IMOC
 - Verified · S2 · path-scoped only
 - Learning-lab · signal-safety teaching
 */
