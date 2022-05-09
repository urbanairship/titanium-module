/* Copyright Airship and Contributors */

import Foundation

struct InboxUpdatedEvent: TiEvent {
    static let eventName = "inboxUpdatedEvent"
    let name: String = eventName
    let data: [String: Any] = [:]
}
