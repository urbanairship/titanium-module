/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct EventUtils {
    static func responsePayload(_ response: UNNotificationResponse) -> [String : Any] {
        var payload = self.contentPayload(response.notification.request.content.userInfo)
        if (response.actionIdentifier == UNNotificationDefaultActionIdentifier) {
            payload["isForeground"] = true
        } else {
            if let action = self.findAction(response) {
                payload["isForeground"] = action.options.contains(.foreground)
            } else {
                payload["isForeground"] = true
            }
            payload["actionId"] = response.actionIdentifier
        }
        return payload
    }

    static func contentPayload(_ userInfo: [AnyHashable: Any]) -> [String : Any] {
        var payload = ["payload": userInfo]
        var notificationPayload: [String: Any] = [:]
        
        if let aps = userInfo["aps"] as? [String : Any] {
            if let alert = aps["alert"] as? [String : Any] {
                if let body = alert["body"] {
                    notificationPayload["alert"] = body
                }
                if let title = alert["title"] {
                    notificationPayload["title"] = title
                }
            } else if let alert = aps["alert"] as? String {
                notificationPayload["alert"] = alert
            }
        }

        var extras = userInfo
        extras["_"] = nil
        extras["aps"] = nil

        notificationPayload["extras"] = extras
        payload["notification"] = notificationPayload

        return payload
    }

    static func findAction(_ notificationResponse: UNNotificationResponse) -> UNNotificationAction? {
        return Airship.push.combinedCategories.first(where: { (category) -> Bool in
            return category.identifier == notificationResponse.notification.request.content.categoryIdentifier
        })?.actions.first(where: { (action) -> Bool in
            return action.identifier == notificationResponse.actionIdentifier
        })
    }
}
