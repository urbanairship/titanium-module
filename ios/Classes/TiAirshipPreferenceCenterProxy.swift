/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipPreferenceCenter

@objc(TiAirshipPreferenceCenterProxy)
public class TiAirshipPreferenceCenterProxy: TiProxy {

    @objc(getConfig:)
    public func getConfig(arguments: [Any]?) {
        logCall(arguments)
        guard let arguments = arguments,
              arguments.count == 2,
              let preferenceCenterID = arguments[0] as? String,
              let callback = arguments[1] as? KrollCallback
        else {
            rejectArguments(arguments)
        }

        PreferenceCenter.shared.jsonConfig(preferenceCenterID: preferenceCenterID) { config in
            callback.callAsync([config], thisObject: self)
        }
    }

    @objc(open:)
    public func open(arguments: [Any]?) {
        logCall(arguments)
        guard let preferenceCenterID = arguments?.first as? String else { rejectArguments(arguments) }
        PreferenceCenter.shared.open(preferenceCenterID)
    }


    @objc(setUseCustomPreferenceCenter:)
    public func setUseCustomPreferenceCenter(arguments: [Any]?) {
        logCall(arguments)
        guard let arguments = arguments,
              arguments.count == 2,
              let preferenceCenterID = arguments[0] as? String,
              let enabled = arguments[1] as? Bool
        else {
            rejectArguments(arguments)
        }

        PluginStore.setUseCustomPreferenceCenter(preferenceCenterID, enabled: enabled)
    }
}
