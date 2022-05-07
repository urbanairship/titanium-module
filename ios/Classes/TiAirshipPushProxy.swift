/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TIAirshipPushProxy)
public class TIAirshipPushProxy: TiProxy {

    @objc
    public var userPushNotificationsEnabled: Bool {
        get {
            Airship.push.userPushNotificationsEnabled
        }
        set {
            Airship.push.userPushNotificationsEnabled = newValue
        }
    }
}
