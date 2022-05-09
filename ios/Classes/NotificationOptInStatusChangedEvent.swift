/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct NotificationOptInStatusChangedEvent: TiEvent {
    static let eventName = "notificationOptInStatusChangedEvent"

    let name: String = eventName
    let data: [String: Any]
    
    init(authroizedSettings: UAAuthorizedNotificationSettings) {
        self.data = [
            "optIn": authroizedSettings != [],
            "authorizedSettings": authroizedSettings.toStringArray()
        ]
    }
}
