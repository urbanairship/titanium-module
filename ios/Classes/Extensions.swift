/* Copyright Airship and Contributors */

import Foundation
import TitaniumKit
import AirshipCore

extension TiProxy {
    func logCall(_ arguments: Any?){
        Log.debug("arguments: \(String(describing: arguments))")
    }

    func rejectArguments(_ arguments: Any?) -> Never {
        fatalError("Invalid arguments: \(String(describing: arguments))")
    }
}


extension UAAuthorizationStatus {
    func toStringValue() -> String {
        switch(self) {
        case .authorized: return "authorized"
        case .ephemeral: return "ephemeral"
        case .provisional: return "provisional"
        case .notDetermined: return "notDetermined"
        case .denied: return "denied"
        @unknown default: return "unknown"
        }
    }
}

extension UNNotificationPresentationOptions {
    static func parse(_ value: [String]) throws -> UNNotificationPresentationOptions {
        var options: UNNotificationPresentationOptions = []

        try value.forEach {
            switch ($0) {
            case "alert": options.update(with: .alert)
            case "badge": options.update(with: .badge)
            case "sound": options.update(with: .sound)
            case "list":
                if #available(iOS 14.0, *) {
                    options.update(with: .list)
                }
            case "banner":
                if #available(iOS 14.0, *) {
                    options.update(with: .banner)
                }
            default:
                throw AirshipErrors.error("Invalid option: \($0)")
            }
        }

        return options
    }

    func toStringArray() -> [String] {
        var value: [String] = []

        if (self.contains(.alert)) {
            value.append("alert")
        }

        if (self.contains(.badge)) {
            value.append("badge")
        }

        if (self.contains(.sound)) {
            value.append("sound")
        }

        if #available(iOS 14.0, *) {
            if (self.contains(.list)) {
                value.append("list")
            }

            if (self.contains(.banner)) {
                value.append("banner")
            }
        }

        return value
    }
}

extension UANotificationOptions {
    static func parse(_ value: [String]) throws -> UANotificationOptions {
        var options: UANotificationOptions = []

        try value.forEach {
            switch ($0) {
            case "alert": options.update(with: .alert)
            case "badge": options.update(with: .badge)
            case "sound": options.update(with: .sound)
            case "carPlay": options.update(with: .carPlay)
            case "criticalAlert": options.update(with: .criticalAlert)
            case "providesAppNotificationSettings": options.update(with: .providesAppNotificationSettings)
            case "provisional": options.update(with: .provisional)
            default: throw AirshipErrors.error("Invalid option: \($0)")
            }
        }

        return options
    }

    func toStringArray() -> [String] {
        var value: [String] = []

        if (self.contains(.alert)) {
            value.append("alert")
        }

        if (self.contains(.badge)) {
            value.append("badge")
        }

        if (self.contains(.sound)) {
            value.append("sound")
        }

        if (self.contains(.carPlay)) {
            value.append("carPlay")
        }

        if (self.contains(.criticalAlert)) {
            value.append("criticalAlert")
        }

        if (self.contains(.providesAppNotificationSettings)) {
            value.append("providesAppNotificationSettings")
        }

        if (self.contains(.provisional)) {
            value.append("provisional")
        }

        return value
    }
}


extension UAAuthorizedNotificationSettings {
    func toStringArray() -> [String] {
        var value: [String] = []

        if (self.contains(.alert)) {
            value.append("alert")
        }

        if (self.contains(.badge)) {
            value.append("badge")
        }

        if (self.contains(.announcement)) {
            value.append("announcement")
        }

        if (self.contains(.carPlay)) {
            value.append("carPlay")
        }

        if (self.contains(.criticalAlert)) {
            value.append("criticalAlert")
        }

        if (self.contains(.notificationCenter)) {
            value.append("notificationCenter")
        }

        if (self.contains(.scheduledDelivery)) {
            value.append("scheduledDelivery")
        }

        if (self.contains(.timeSensitive)) {
            value.append("timeSensitive")
        }

        if (self.contains(.lockScreen)) {
            value.append("lockScreen")
        }

        return value;
    }
}

extension Features {
    func toStringArray() -> [String] {
        var names: [String] = []
        if (self == .all) {
            return ["all"]
        }

        if (self == .none) {
            return ["none"]
        }

        if (self.contains(.push)) {
            names.append("push")
        }

        if (self.contains(.chat)) {
            names.append("chat")
        }

        if (self.contains(.contacts)) {
            names.append("contacts")
        }

        if (self.contains(.location)) {
            names.append("location")
        }

        if (self.contains(.messageCenter)) {
            names.append("messageCenter")
        }

        if (self.contains(.analytics)) {
            names.append("analytics")
        }

        if (self.contains(.tagsAndAttributes)) {
            names.append("tagsAndAttributes")
        }

        if (self.contains(.inAppAutomation)) {
            names.append("inAppAutomation")
        }

        return names
    }

    static func parse(_ names: [String]) throws -> Features {
        var features: Features = []
        try names.forEach {
            switch ($0) {
            case "push": features.update(with: .push)
            case "chat": features.update(with: .chat)
            case "contacts": features.update(with: .contacts)
            case "location": features.update(with: .location)
            case "messageCenter": features.update(with: .messageCenter)
            case "analytics": features.update(with: .analytics)
            case "tagsAndAttributes": features.update(with: .tagsAndAttributes)
            case "inAppAutomation": features.update(with: .inAppAutomation)
            case "all": features.update(with: .all)
            case "none": break
            default: throw AirshipErrors.error("Invalid feature \($0)")
            }
        }

        return features
    }
}

