/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipPushIOSProxy)
public class TiAirshipPushIOSProxy: TiProxy {

    @objc
    public var foregroundPresentationOptions: [String] {
        get {
            Airship.push.defaultPresentationOptions.toStringArray()
        }
        set {
            logCall(newValue)
            let options = try! UNNotificationPresentationOptions.parse(newValue)
            PluginStore.presentationOptions = options
            Airship.push.defaultPresentationOptions = options
        }
    }

    @objc
    public var notificationOptions: [String] {
        get {
            Airship.push.notificationOptions.toStringArray()
        }
        set {
            logCall(newValue)
            Airship.push.notificationOptions = try! UANotificationOptions.parse(newValue)
        }
    }

    @objc
    public var isAutoBadgeEnabled: Bool {
        get {
            Airship.push.autobadgeEnabled
        }
        set {
            logCall(newValue)
            Airship.push.autobadgeEnabled = newValue
        }
    }

    @objc
    public var badgeNumber: Int {
        get {
            Airship.push.badgeNumber
        }
        set {
            logCall(newValue)
            Airship.push.badgeNumber = newValue
        }
    }

    @objc(resetBadge:)
    public func resetBadge(arguments: [Any]?) {
        logCall(arguments)
        return Airship.push.resetBadge()
    }
}
