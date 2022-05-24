/* Copyright Airship and Contributors */

import Foundation

struct PushReceivedEvent: TiEvent {
    let name: String = EventNames.pushReceived
    let data: [String: Any]
    
    init(userInfo: [AnyHashable : Any]) {
        self.data = EventUtils.contentPayload(userInfo)
    }
}
