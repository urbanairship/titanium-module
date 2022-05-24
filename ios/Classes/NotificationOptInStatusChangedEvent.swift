/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct NotificationOptInStatusChangedEvent: TiEvent {
    let name: String = EventNames.notificationOptInStatusChanged
    let data: [String: Any]
    
    init(authroizedSettings: UAAuthorizedNotificationSettings) {
        self.data = [
            "optIn": authroizedSettings != [],
            "authorizedSettings": authroizedSettings.toStringArray()
        ]
    }
}
