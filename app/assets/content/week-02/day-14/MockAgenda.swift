import Foundation

/// Printable agenda openers for Mock #2 practice (Learning-lab).
enum MockAgenda {
    static let ads = """
    I’ll cover problem scope, type-safe component pipeline (POP+generics),     HeroWidget lifecycle, networking/pinning on URLSession, and trade-offs vs SDUI for media.
    """

    static let sdui = """
    I’ll define SDUI scope, schema/versioning, registry+actions, fallback/cache for crash-free,     and BMS header / Aces splash examples — then limits vs native Ads.
    """

    static func printChosen(track: String) {
        switch track.lowercased() {
        case "ads", "a": print(ads)
        case "sdui", "b": print(sdui)
        default: print("Pick ads or sdui")
        }
    }
}
