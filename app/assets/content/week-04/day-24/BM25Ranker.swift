import Foundation

/// Simplified BM25-style lexical ranker for interview teaching.
/// Not a production-grade IR library — illustrates FinTrack retrieve shape (Verified · S15).
struct BM25Document: Sendable {
    let id: String
    let tokens: [String]
}

struct BM25Ranker: Sendable {
    var documents: [BM25Document]
    var k1: Double = 1.2
    var b: Double = 0.75

    private var avgDl: Double {
        guard !documents.isEmpty else { return 0 }
        return documents.map { Double($0.tokens.count) }.reduce(0, +) / Double(documents.count)
    }

    private func df(_ term: String) -> Int {
        documents.filter { $0.tokens.contains(term) }.count
    }

    private func idf(_ term: String) -> Double {
        let n = Double(documents.count)
        let dfi = Double(df(term))
        return log((n - dfi + 0.5) / (dfi + 0.5) + 1)
    }

    func rank(queryTokens: [String], topK: Int) -> [(id: String, score: Double)] {
        let avg = avgDl
        var scores: [(String, Double)] = []
        for doc in documents {
            var score = 0.0
            let dl = Double(doc.tokens.count)
            var tf: [String: Int] = [:]
            for t in doc.tokens { tf[t, default: 0] += 1 }
            for term in queryTokens {
                guard let f = tf[term] else { continue }
                let freq = Double(f)
                let denom = freq + k1 * (1 - b + b * dl / max(avg, 1))
                score += idf(term) * (freq * (k1 + 1) / denom)
            }
            if score > 0 { scores.append((doc.id, score)) }
        }
        return scores.sorted { $0.1 > $1.1 }.prefix(topK).map { ($0.0, $0.1) }
    }
}

/*
 Say this first:
 “BM25 lexical retrieve over local docs — offline, explainable, no embedder. Then prompt or rules.”
 */
