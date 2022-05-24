/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct AuthorizedNotificationSettingNames {
    static let map: [String: UAAuthorizedNotificationSettings] = [
        alert: UAAuthorizedNotificationSettings.alert,
        badge: UAAuthorizedNotificationSettings.badge,
        sound: UAAuthorizedNotificationSettings.sound,
        announcement: UAAuthorizedNotificationSettings.announcement,
        carPlay: UAAuthorizedNotificationSettings.carPlay,
        criticalAlert: UAAuthorizedNotificationSettings.criticalAlert,
        notificationCenter: UAAuthorizedNotificationSettings.notificationCenter,
        scheduledDelivery: UAAuthorizedNotificationSettings.scheduledDelivery,
        timeSensitive: UAAuthorizedNotificationSettings.timeSensitive,
        lockScreen: UAAuthorizedNotificationSettings.lockScreen
    ]

    static let alert = "alert"
    static let badge = "badge"
    static let sound = "sound"
    static let announcement = "announcement"
    static let carPlay = "car_play"
    static let criticalAlert = "critical_alert"
    static let notificationCenter = "notification_center"
    static let scheduledDelivery = "scheduled_delivery"
    static let timeSensitive = "time_sensitive"
    static let lockScreen = "lock_screen"
}

extension UAAuthorizedNotificationSettings {
    func toStringArray() -> [String] {
        var names: [String] = []
        AuthorizedNotificationSettingNames.map.forEach { key, value in
            if (self.contains(value)) {
                names.append(key)
            }
        }

        return names
    }
}
