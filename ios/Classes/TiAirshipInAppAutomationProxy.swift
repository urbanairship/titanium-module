/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;
import AirshipAutomation;


@objc(TIAirshipInAppAutomationProxy)
public class TiAirshipInAppAutomationProxy: TiProxy {

    @objc
    public var isPaused: Bool {
        InAppAutomation.shared.isPaused
    }

    @objc(setIsPaused:)
    public func setIsPaused(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let paused = arg as? Bool else {
            rejectArguments(arg)
        }
        InAppAutomation.shared.isPaused = paused
    }

    @objc
    public var displayIntervalMilliseconds: Double {
        InAppAutomation.shared.inAppMessageManager.displayInterval * 1000.0
    }

    @objc(setDisplayIntervalMilliseconds:)
    public func setDisplayIntervalMilliseconds(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let value = arg as? Double else {
            rejectArguments(arg)
        }

        InAppAutomation.shared.inAppMessageManager.displayInterval = (value / 1000.0)
    }
}
