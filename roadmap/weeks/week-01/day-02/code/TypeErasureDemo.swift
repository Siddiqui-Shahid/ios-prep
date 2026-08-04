// TypeErasureDemo.swift
// Day 02 Learning-lab — why type erasure exists for PAT / heterogeneous lists.
// NOT claimed as shipped BookMyShow source.

import Foundation

protocol Trackable {
    var id: String { get }
    func track()
}

struct Banner: Trackable {
    let id: String
    func track() { print("banner \(id)") }
}

struct Interstitial: Trackable {
    let id: String
    func track() { print("interstitial \(id)") }
}

/// Type eraser: one concrete type storing heterogeneous Trackables.
/// Cost: heap/closure indirection + lost specialization.
struct AnyTrackable: Trackable {
    private let _id: String
    private let _track: () -> Void

    var id: String { _id }

    init<T: Trackable>(_ base: T) {
        _id = base.id
        _track = { base.track() }
    }

    func track() { _track() }
}

enum TypeErasureDemo {
    static func run() {
        // Without erasure, mixing different conformers in one array is the pain PAT/existentials address.
        let feed: [AnyTrackable] = [
            AnyTrackable(Banner(id: "b1")),
            AnyTrackable(Interstitial(id: "i1"))
        ]
        feed.forEach { $0.track() }
    }
}

/*
 Prefer generics inside the pipeline:
   func install<T: Trackable>(_ t: T) { t.track() }

 Erase at boundaries / heterogeneous lists only.
 Combine’s AnyPublisher is the same idea for nested generic publisher types.
 */
