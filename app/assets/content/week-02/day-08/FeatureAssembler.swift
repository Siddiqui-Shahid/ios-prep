import Foundation

// Learning-lab — Day 08
// Feature assembler: constructor DI without a container religion.
// Wires protocols at the composition root.

protocol NetworkClient: Sendable {
    func data(path: String, query: [String: String]) async throws -> Data
}

struct SearchRepositoryImpl: SearchRepository {
    var client: NetworkClient
    var decoder: JSONDecoder = JSONDecoder()

    func search(query: String) async throws -> [String] {
        let data = try await client.data(path: "/v1/search", query: ["q": query])
        // Illustrative DTO → domain map (here domain == [String])
        let dto = try decoder.decode([String].self, from: data)
        return dto
    }
}

enum FeatureAssembler {
    /// Composition root for the search feature.
    static func makeSearchViewModel(client: NetworkClient) -> SearchViewModel {
        let repository = SearchRepositoryImpl(client: client)
        return SearchViewModel(repository: repository)
    }

    static func makeFreeParkingViewModel(repository: BillingRepository) -> FreeParkingViewModel {
        let useCase = AdjustFreeParkingBilling(repository: repository)
        return FreeParkingViewModel(useCase: useCase)
    }
}

// Tests skip the assembler and inject fakes directly:
// let vm = SearchViewModel(repository: FakeSearchRepository(result: .success(["A"])))
