/* Copyright Airship and Contributors */

import Foundation

struct InboxUpdatedEvent: TiEvent {
    let name: String = EventNames.inboxUpdated
    let data: [String: Any] = [:]
}
