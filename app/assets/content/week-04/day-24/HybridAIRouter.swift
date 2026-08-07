import Foundation

enum CoachAnswer: Equatable {
    case generated(String)
    case rules([String])
    case lexical([String])
    case empty(String)
}

/// Teaching router — FinTrack/GymFlow fail-soft shape in one place.
struct HybridAIRouter {
    var eligibility: DeviceAIEligibility
    var bm25: BM25Ranker
    var tfidf: TFIDFFallback
    var cloudConsented: Bool

    func answer(
        queryTokens: [String],
        ruleTips: [String],
        localGenerate: ([String]) -> String?,
        cloudGenerate: ([String]) -> String?
    ) -> CoachAnswer {
        let retrieved = bm25.rank(queryTokens: queryTokens, topK: 5).map(\.id)

        if retrieved.isEmpty {
            return .empty("No matching local context — showing generic tips.")
        }

        if eligibility.canRunGenerativeLocal, let text = localGenerate(retrieved) {
            return .generated(text)
        }

        if cloudConsented, let text = cloudGenerate(retrieved) {
            return .generated(text)
        }

        if eligibility.canRunTFLiteEmbeddings {
            // Embed path would rank here; on failure fall through.
        }

        let lexical = tfidf.rank(query: queryTokens, topK: 5)
        if !lexical.isEmpty { return .lexical(lexical) }

        return .rules(ruleTips)
    }
}

/*
 Privacy script hook:
 Analytics: coach_shown / fallback_rule / fallback_tfidf — never raw ledger rows.
 */
