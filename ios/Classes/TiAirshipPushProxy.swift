/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipPushProxy)
public class TiAirshipPushProxy: TiProxy {

    @objc
    public let iOS = TiAirshipPushIOSProxy()

    @objc
    public var notificationStatus: [String: Any] {
        return [
            "airshipOptIn": Airship.push.isPushNotificationsOptedIn,
            "airshipEnabled": Airship.push.userPushNotificationsEnabled,
            "systemEnabled": Airship.push.authorizedNotificationSettings != [],
            "iOS": [
                "authorizedSettings": Airship.push.authorizedNotificationSettings.toStringArray(),
                "authorizedStatus": Airship.push.authorizationStatus.toStringValue()
            ]
        ]
    }

    @objc
    public var userPushNotificationsEnabled: Bool {
        get {
            Airship.push.userPushNotificationsEnabled
        }
        set {
            Airship.push.userPushNotificationsEnabled = newValue
        }
    }

    @objc(enableUserNotifications:)
    public func enableUserNotifications(arguments: [Any]?) {
        logCall(arguments)
        let callback = arguments?.first as? KrollCallback

        Airship.push.enableUserPushNotifications { success in
            callback?.callAsync([success], thisObject: self)
        }
    }
}
