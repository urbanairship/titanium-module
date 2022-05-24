/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipPushIOSProxy)
public class TiAirshipPushIOSProxy: TiProxy {

    @objc
    public static let authorizedSettingAlert = AuthorizedNotificationSettingNames.alert

    @objc
    public static let authorizedSettingBadge = AuthorizedNotificationSettingNames.badge

    @objc
    public static let authorizedSettingSound = AuthorizedNotificationSettingNames.sound

    @objc
    public static let authorizedSettingAnnouncement = AuthorizedNotificationSettingNames.announcement

    @objc
    public static let authorizedSettingCarPlay = AuthorizedNotificationSettingNames.carPlay

    @objc
    public static let authorizedSettingCriticalAlert = AuthorizedNotificationSettingNames.criticalAlert

    @objc
    public static let authorizedSettingNotificationCenter = AuthorizedNotificationSettingNames.notificationCenter

    @objc
    public static let authorizedSettingScheduledDelivery = AuthorizedNotificationSettingNames.scheduledDelivery

    @objc
    public static let authorizedSettingTimeSensitive = AuthorizedNotificationSettingNames.timeSensitive

    @objc
    public static let authorizedSettingLockScreen = AuthorizedNotificationSettingNames.lockScreen

    @objc
    public static let presentationOptionAlert = NotificationPresentationOptionNames.alert

    @objc
    public static let presentationOptionBadge = NotificationPresentationOptionNames.badge

    @objc
    public static let presentationOptionSound = NotificationPresentationOptionNames.sound

    @objc
    public static let presentationOptionList = NotificationPresentationOptionNames.list

    @objc
    public static let presentationOptionBanner = NotificationPresentationOptionNames.banner

    @objc
    public static let notificationOptionAlert = NotificationOptionNames.alert

    @objc
    public static let notificationOptionBadge = NotificationOptionNames.badge

    @objc
    public static let notificationOptionSound = NotificationOptionNames.sound

    @objc
    public static let notificationOptionCarPlay = NotificationOptionNames.carPlay

    @objc
    public static let notificationOptionCriticalAlert = NotificationOptionNames.criticalAlert

    @objc
    public  static let notificationOptionProvidesAppNotificationSettings = NotificationOptionNames.providesAppNotificationSettings

    @objc
    public static let notificationOptionProvisional = NotificationOptionNames.provisional

    @objc
    public static let authorizedStatusAuthorized = AuthorizationStatusNames.authorized

    @objc
    public static let authorizedStatusEphemeral = AuthorizationStatusNames.ephemeral

    @objc
    public static let authorizedStatusProvisional = AuthorizationStatusNames.provisional

    @objc
    public static let authorizedStatusNotDetermined = AuthorizationStatusNames.notDetermined

    @objc
    public static let authorizedStatusDenied = AuthorizationStatusNames.denied
    
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
