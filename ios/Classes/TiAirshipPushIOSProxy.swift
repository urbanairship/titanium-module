/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipPushIOSProxy)
public class TiAirshipPushIOSProxy: TiProxy {

    @objc
    public var foregroundPresentationOptions: [String] {
        Airship.push.defaultPresentationOptions.toStringArray()
    }

    @objc(setForegroundPresentationOptions:)
    public func setForegroundPresentationOptions(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let optionNames = arg as? [String] else {
            rejectArguments(arg)
        }
        let options = try! UNNotificationPresentationOptions.parse(optionNames)
        PluginStore.presentationOptions = options
        Airship.push.defaultPresentationOptions = options
    }

    @objc
    public var notificationOptions: [String] {
        Airship.push.notificationOptions.toStringArray()
    }

    @objc(setNotificationOptions:)
    public func setNotificationOptions(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let options = arg as? [String] else {
            rejectArguments(arg)
        }
        Airship.push.notificationOptions = try! UANotificationOptions.parse(options)
    }

    @objc
    public var isAutoBadgeEnabled: Bool {
        Airship.push.autobadgeEnabled
    }

    @objc(setIsAutoBadgeEnabled:)
    public func setIsAutoBadgeEnabled(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let enabled = arg as? Bool else {
            rejectArguments(arg)
        }
        Airship.push.autobadgeEnabled = enabled
    }

    @objc
    public var badgeNumber: Int {
        Airship.push.badgeNumber
    }

    @objc(setBadgeNumber:)
    public func setBadgeNumber(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let value = arg as? Int else {
            rejectArguments(arg)
        }
        Airship.push.badgeNumber = value
    }

    @objc(resetBadge:)
    public func resetBadge(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        return Airship.push.resetBadge()
    }
}
