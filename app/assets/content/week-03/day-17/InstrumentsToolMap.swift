import Foundation

/// Learning-lab: route symptoms → Instruments / field tools.
/// Critical: retain cycles ≠ Leaks instrument.

enum PerfSymptom: String {
    case scrollJank
    case coldStartRegression
    case memoryClimbsOnNavigate
    case slowButIdleCPU
    case fieldOnlyDeviceClass
    case suspectedRetainCycle
}

enum PerfTool: String {
    case timeProfiler
    case hitches
    case appLaunch
    case allocations
    case memoryGraph
    case leaks
    case network
    case metricKitOrFirebaseField
}

enum InstrumentsToolMap {
    static func firstTool(for symptom: PerfSymptom) -> PerfTool {
        switch symptom {
        case .scrollJank:
            return .hitches // then Time Profiler on main
        case .coldStartRegression:
            return .appLaunch
        case .memoryClimbsOnNavigate:
            return .allocations // pair Memory Graph for ownership
        case .slowButIdleCPU:
            return .network // wait-bound; also Firebase journey p90
        case .fieldOnlyDeviceClass:
            return .metricKitOrFirebaseField
        case .suspectedRetainCycle:
            return .memoryGraph // NOT .leaks
        }
    }

    static func explain(_ tool: PerfTool) -> String {
        switch tool {
        case .timeProfiler:
            return "CPU hot stacks / main-thread self-time"
        case .hitches:
            return "Missed frame deadlines / scroll jank"
        case .appLaunch:
            return "Pre-main vs post-main launch cost"
        case .allocations:
            return "Persistent growth across generations"
        case .memoryGraph:
            return "Ownership edges / retain cycles (reachable abandoned memory)"
        case .leaks:
            return "Unreachable allocations ONLY — not retain cycles"
        case .network:
            return "Payload / chatter / latency when CPU is clean"
        case .metricKitOrFirebaseField:
            return "Fleet percentiles & device-class segments before lab"
        }
    }
}

/*
 Say aloud:

 "Retain cycles stay reachable, so Leaks often looks clean.
  I use Memory Graph for edges and Allocations for persistent growth."

 Provenance: Learning-lab · Instruments correctness
 */
