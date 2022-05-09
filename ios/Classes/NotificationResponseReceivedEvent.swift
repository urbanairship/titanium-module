/* Copyright Airship and Contributors */

import Foundation

struct NotificationResponseReceivedEvent: TiEvent {
    static let eventName = "notificationResponseReceivedEvent"

    let name: String = eventName
    let data: [String: Any]

    init(response: UNNotificationResponse) {
        self.data = EventUtils.responsePayload(response)
    }
}
