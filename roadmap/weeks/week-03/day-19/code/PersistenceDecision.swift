import Foundation

/// Learning-lab: persistence decision tree as executable teaching API.
/// Mirrors the in-chapter table — recite this in interviews.

enum PersistenceKind: String {
    case secretsTokens
    case simplePreferences
    case structuredQueries
    case objectGraph
    case largeMedia
    case inSessionAutoEvict
    case concurrentInSession
}

enum PersistenceStore: String {
    case keychain
    case userDefaults
    case sqliteWAL
    case coreData
    case fileManagerCaches
    case fileManagerAppSupport
    case nsCacheLRU
    case actorOrSerialQueue
}

enum PersistenceDecision {
    static func store(for kind: PersistenceKind) -> PersistenceStore {
        switch kind {
        case .secretsTokens: return .keychain
        case .simplePreferences: return .userDefaults
        case .structuredQueries: return .sqliteWAL
        case .objectGraph: return .coreData
        case .largeMedia: return .fileManagerCaches // or App Support if durable user data
        case .inSessionAutoEvict: return .nsCacheLRU
        case .concurrentInSession: return .actorOrSerialQueue
        }
    }

    static func note(for store: PersistenceStore) -> String {
        switch store {
        case .keychain:
            return "Tokens/secrets; AccessibleAfterFirstUnlock or stricter; prefer synchronizable=false for auth"
        case .userDefaults:
            return "Non-sensitive prefs only — NEVER tokens"
        case .sqliteWAL:
            return "WAL mode; off-main writes; concurrent readers"
        case .coreData:
            return "Object graph needs; background context for writes"
        case .fileManagerCaches:
            return "Purgeable media/binaries"
        case .fileManagerAppSupport:
            return "Durable user documents/data"
        case .nsCacheLRU:
            return "Session images; memory-pressure aware"
        case .actorOrSerialQueue:
            return "Race-free shared in-session mutation"
        }
    }

    /// Interview drill: refresh token + theme + image disk + feed queries
    static func exampleSplit() -> [String: PersistenceStore] {
        [
            "refreshToken": .keychain,
            "theme": .userDefaults,
            "imageFiles": .fileManagerCaches,
            "imageMemory": .nsCacheLRU,
            "offlineFeed": .sqliteWAL,
        ]
    }
}

/*
 Recite opener:
 "Depends on sensitivity and access pattern…"
 Full 7-row tree lives in 01-foundations.md — keep this file in sync mentally.
 */
