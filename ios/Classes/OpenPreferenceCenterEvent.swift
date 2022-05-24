/* Copyright Airship and Contributors */

import Foundation

struct OpenPreferenceCenterEvent: TiEvent {
    let name: String = EventNames.openPreferenceCenter
    let data: [String: Any]
    init(preferenceCenterID: String) {
        self.data = ["preferenceCenterId": preferenceCenterID]
    }
}
