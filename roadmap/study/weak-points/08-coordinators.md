# Drill — coordinators and Codable

**From:** 28 Aug wrap-up. They asked how many coordinator classes for several screens, why the pattern exists, and how JSON models are decoded. You guessed one coordinator, then drifted. On models: “apart from decoder I don’t know.”

## Keywords

- **Coordinator** (object that owns *navigation*, not UIKit views).
- **Child coordinator** (login flow vs tab flow; parent starts/stops children).
- **Codable** (`Encodable` + `Decodable`: map JSON keys to Swift properties).
- **JSONDecoder** (turns `Data` into a Codable type; date strategies, key decoding).

## Target answer (60s)

> “I use a coordinator so view controllers don’t push each other. One app coordinator owns the window. Child coordinators own login, the tab bar, a checkout flow. Count is *flows*, not *screens*. Models are structs that conform to Codable; JSONDecoder decodes Data. I do not subclass a mystery ‘decoder class.’”
