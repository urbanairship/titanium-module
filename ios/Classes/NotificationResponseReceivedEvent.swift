/* Copyright Airship and Contributors */

import Foundation

struct NotificationResponseReceivedEvent: TiEvent {
    let name: String = EventNames.notificationResponseReceived
    let data: [String: Any]

    init(response: UNNotificationResponse) {
        self.data = EventUtils.responsePayload(response)
    }
}
