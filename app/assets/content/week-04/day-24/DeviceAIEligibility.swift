import Foundation

/// Teaching sketch — capability + thermal gates before inference.
struct DeviceAIEligibility: Sendable {
    var supportsFoundationModels: Bool
    var tfliteModelPresent: Bool
    var thermalState: ProcessInfo.ThermalState
    var isLowPowerMode: Bool

    var canRunGenerativeLocal: Bool {
        supportsFoundationModels
            && thermalState != .serious
            && thermalState != .critical
            && !isLowPowerMode
    }

    var canRunTFLiteEmbeddings: Bool {
        tfliteModelPresent
            && thermalState != .critical
            && !isLowPowerMode
    }

    static func snapshot(
        supportsFoundationModels: Bool,
        tfliteModelPresent: Bool
    ) -> DeviceAIEligibility {
        DeviceAIEligibility(
            supportsFoundationModels: supportsFoundationModels,
            tfliteModelPresent: tfliteModelPresent,
            thermalState: ProcessInfo.processInfo.thermalState,
            isLowPowerMode: ProcessInfo.processInfo.isLowPowerModeEnabled
        )
    }
}
