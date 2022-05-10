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
    public var pushToken: String? {
        Airship.push.deviceToken
    }

    @objc
    public var userNotificationsEnabled: Bool {
        Airship.push.userPushNotificationsEnabled
    }

    @objc(setUserNotificationsEnabled:)
    public func setUserNotificationsEnabled(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let enabled = arg as? Bool else {
            rejectArguments(arg)
        }
        Airship.push.userPushNotificationsEnabled = enabled
    }

    @objc(enableUserNotifications:)
    public func enableUserNotifications(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        let callback = arguments?.first as? KrollCallback

        Airship.push.enableUserPushNotifications { success in
            callback?.callAsync([success], thisObject: self)
        }
    }
}
