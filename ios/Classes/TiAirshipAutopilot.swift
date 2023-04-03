/* Copyright Airship and Contributors */

import Foundation
import AirshipCore
import AirshipMessageCenter
import AirshipPreferenceCenter
import TitaniumKit

@objc(TiAirshipAutopilot)
public class TiAirshipAutopilot: NSObject {
    private static let version = "9.2.0"

    private static let airshipDelegate = TiAirshipDelegate()

    @objc(attemptTakeOffWithLaunchOptions:)
    public static func attemptTakeOff(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        AirshipLogger.debug("attemptTakeOff: \(String(describing: launchOptions))")

        guard !Airship.isFlying else {
            return;
        }

        guard let configDict = PluginStore.config else {
            return
        }

        do {
            let config = try Config.parse(configDict)
            AirshipLogger.debug("Taking off! \(config)")

            Airship.takeOff(config, launchOptions: launchOptions)
        } catch {
            AirshipLogger.error("Failed to takeOff \(error)")
        }
        guard Airship.isFlying else {
            return;
        }

        Airship.shared.deepLinkDelegate = self.airshipDelegate
        Airship.push.registrationDelegate = self.airshipDelegate
        Airship.push.pushNotificationDelegate = self.airshipDelegate
        PreferenceCenter.shared.openDelegate = self.airshipDelegate
        Airship.analytics.registerSDKExtension(.titanium, version: self.version)
        Airship.push.defaultPresentationOptions = PluginStore.presentationOptions
    }
}
