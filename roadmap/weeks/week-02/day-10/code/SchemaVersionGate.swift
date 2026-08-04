import Foundation

// Learning-lab — Day 10
// Schema version gate. Cousin to S3-A1 design (not a shipped named BMS service).

struct SDUIDocument: Codable, Equatable, Sendable {
    var schemaVersion: Int
    var id: String
    var root: SDUINode
}

struct SDUINode: Codable, Equatable, Sendable {
    var id: String?
    var type: String
    var props: [String: String]?
    var children: [SDUINode]?
    var action: SDUIAction?
}

struct SDUIAction: Codable, Equatable, Sendable {
    var type: String
    var payload: [String: String]?
}

enum VersionGateResult: Equatable, Sendable {
    case accept(SDUIDocument)
    case rejectTooNew(found: Int, maxSupported: Int)
    case rejectTooOld(found: Int, minSupported: Int)
}

struct SchemaVersionGate: Sendable {
    var minSupported: Int
    var maxSupported: Int

    func evaluate(_ document: SDUIDocument) -> VersionGateResult {
        if document.schemaVersion > maxSupported {
            return .rejectTooNew(found: document.schemaVersion, maxSupported: maxSupported)
        }
        if document.schemaVersion < minSupported {
            return .rejectTooOld(found: document.schemaVersion, minSupported: minSupported)
        }
        return .accept(document)
    }
}
