/* Copyright Airship and Contributors */

import Foundation

protocol TiEvent {
    var name: String { get }
    var data: [String: Any] { get }
}

extension TiEvent {
    func dispatch() {
        EventManager.shared.dispatchEvent(self)
    }
}
