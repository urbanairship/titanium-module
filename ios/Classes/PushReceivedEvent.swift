/* Copyright Airship and Contributors */

import Foundation

struct PushReceivedEvent: TiEvent {
    static let eventName = "pushReceivedEvent"

    let name: String = eventName
    let data: [String: Any]
    
    init(userInfo: [AnyHashable : Any]) {
        self.data = EventUtils.contentPayload(userInfo)
    }
}
