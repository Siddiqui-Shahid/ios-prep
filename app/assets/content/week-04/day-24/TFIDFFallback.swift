import Foundation

/// GymFlow-style lexical fail-soft when TFLite embeddings unavailable (Verified · S16 shape).
struct TFIDFFallback: Sendable {
    let documents: [String: [String]] // id → tokens

    func rank(query: [String], topK: Int) -> [String] {
        let df = Dictionary(uniqueKeysWithValues: Set(documents.values.flatMap { $0 }).map { term in
            (term, documents.values.filter { $0.contains(term) }.count)
        })
        let n = Double(documents.count)
        var scored: [(String, Double)] = []
        for (id, tokens) in documents {
            var tf: [String: Double] = [:]
            for t in tokens { tf[t, default: 0] += 1 }
            let len = Double(tokens.count)
            var score = 0.0
            for q in query {
                guard let f = tf[q], let dfi = df[q], dfi > 0 else { continue }
                let tfNorm = f / max(len, 1)
                let idf = log(n / Double(dfi))
                score += tfNorm * idf
            }
            if score > 0 { scored.append((id, score)) }
        }
        return scored.sorted { $0.1 > $1.1 }.prefix(topK).map(\.0)
    }
}
