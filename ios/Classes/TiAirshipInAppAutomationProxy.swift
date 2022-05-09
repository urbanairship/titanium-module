/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;
import AirshipAutomation;


@objc(TIAirshipInAppAutomationProxy)
public class TiAirshipInAppAutomationProxy: TiProxy {

    @objc
    public var isPaused: Bool {
        get {
            InAppAutomation.shared.isPaused
        }
        set {
            logCall(newValue)
            InAppAutomation.shared.isPaused = newValue
        }
    }

    @objc
    public var displayIntervalMilliseconds: Double {
        get {
            InAppAutomation.shared.inAppMessageManager.displayInterval * 1000.0
        }
        set {
            logCall(newValue)
            InAppAutomation.shared.inAppMessageManager.displayInterval = (newValue / 1000.0)
        }
    }
}
