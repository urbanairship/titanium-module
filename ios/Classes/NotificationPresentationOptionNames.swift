/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct NotificationPresentationOptionNames {

    static let map: [String: UNNotificationPresentationOptions] = {
        var map: [String: UNNotificationPresentationOptions] = [
            alert: UNNotificationPresentationOptions.alert,
            badge: UNNotificationPresentationOptions.badge,
            sound: UNNotificationPresentationOptions.sound,
        ]

        if #available(iOS 14.0, *) {
            map[list] = UNNotificationPresentationOptions.list
            map[banner] = UNNotificationPresentationOptions.banner
        }

        return map
    }()

    static let alert = "alert"
    static let badge = "badge"
    static let sound = "sound"
    static let list = "list"
    static let banner = "banner"
}

extension UNNotificationPresentationOptions {

    static func parse(_ names: [String]) throws -> UNNotificationPresentationOptions {
        var options: UNNotificationPresentationOptions = []

        try names.forEach { name in
            guard let option = NotificationPresentationOptionNames.map[name.lowercased()] else {
                throw AirshipErrors.error("Invalid option \(name)")
            }

            options.update(with: option)
        }

        return options
    }

    func toStringArray() -> [String] {
        var names: [String] = []
        NotificationPresentationOptionNames.map.forEach { key, value in
            if (self.contains(value)) {
                names.append(key)
            }
        }

        return names
    }
}
