/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct NotificationOptionNames {

    static let map: [String: UANotificationOptions] = [
        alert: UANotificationOptions.alert,
        badge: UANotificationOptions.badge,
        sound: UANotificationOptions.sound,
        carPlay: UANotificationOptions.carPlay,
        criticalAlert: UANotificationOptions.criticalAlert,
        providesAppNotificationSettings: UANotificationOptions.providesAppNotificationSettings,
        provisional: UANotificationOptions.provisional
    ]

    static let alert = "alert"
    static let badge = "badge"
    static let sound = "sound"
    static let carPlay = "car_play"
    static let criticalAlert = "critical_alert"
    static let providesAppNotificationSettings = "provides_app_notification_settings"
    static let provisional = "provisional"

}

extension UANotificationOptions {

    static func parse(_ names: [String]) throws -> UANotificationOptions {
        var options: UANotificationOptions = []

        try names.forEach { name in
            guard let option = NotificationOptionNames.map[name.lowercased()] else {
                throw AirshipErrors.error("Invalid option \(name)")
            }

            options.update(with: option)
        }

        return options
    }

    func toStringArray() -> [String] {
        var names: [String] = []
        NotificationOptionNames.map.forEach { key, value in
            if (self.contains(value)) {
                names.append(key)
            }
        }

        return names
    }
}
