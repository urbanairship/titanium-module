/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipPrivacyManagerProxy)
public class TiAirshipPrivacyManagerProxy: TiProxy {

    @objc
    public var enabledFeatures: [String] {
        Airship.shared.privacyManager.enabledFeatures.toStringArray()
    }

    @objc(setEnabledFeatures:)
    public func setEnabledFeatures(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let names = arg as? [String] else {
            rejectArguments(arg)
        }
        Airship.shared.privacyManager.enabledFeatures = try! Features.parse(names)
    }
    
    @objc(enable:)
    public func enable(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))

        guard let names = arguments?.first as? [String] else {
            rejectArguments(arguments)
        }
        
        Airship.shared.privacyManager.enableFeatures(try! Features.parse(names))
    }

    @objc(disable:)
    public func disable(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))

        guard let names = arguments?.first as? [String] else {
            rejectArguments(arguments)
        }

        Airship.shared.privacyManager.disableFeatures(try! Features.parse(names))
    }
}
