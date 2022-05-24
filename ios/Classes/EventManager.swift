/* Copyright Airship and Contributors */

import Foundation
import TitaniumKit

class EventManager {
    static let shared = EventManager()
    private var pending: [TiEvent] = []

    var onDispatch: ((TiEvent) -> Bool)?  {
        didSet {
            self.dispatchPending()
        }
    }

    public func dispatchEvent(_ event: TiEvent) {
        DispatchQueue.main.async {
            self.attemptDispatch(event)
        }
    }

    public func onListenerAdded() {
        self.dispatchPending()
    }

    private func dispatchPending() {
        DispatchQueue.main.async {
            let copy = self.pending
            self.pending = []
            copy.forEach { self.attemptDispatch($0) }
        }
    }

    private func attemptDispatch(_ event: TiEvent) {
        if (self.onDispatch?(event) != true) {
            self.pending.append(event)
        }
    }
}


