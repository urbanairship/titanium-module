/* Copyright Airship and Contributors */

import Foundation

struct OpenPreferenceCenterEvent: TiEvent {
    static let eventName = "openPreferenceCenterEvent"
    let name: String = eventName
    let data: [String: Any]
    init(preferenceCenterID: String) {
        self.data = ["preferenceCenterId": preferenceCenterID]
    }
}
