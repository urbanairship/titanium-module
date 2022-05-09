/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipPrivacyManagerProxy)
public class TiAirshipPrivacyManagerProxy: TiProxy {

    @objc
    public var enabledFeatures: [String] {
        get {
            Airship.shared.privacyManager.enabledFeatures.toStringArray()
        }
        set {
            logCall(newValue)
            Airship.shared.privacyManager.enabledFeatures = try! Features.parse(newValue)
        }
    }

    @objc(enable:)
    public func enable(arguments: [Any]?) {
        logCall(arguments)

        guard let names = arguments?.first as? [String] else {
            rejectArguments(arguments)
        }
        
        Airship.shared.privacyManager.enableFeatures(try! Features.parse(names))
    }

    @objc(disable:)
    public func disable(arguments: [Any]?) {
        logCall(arguments)

        guard let names = arguments?.first as? [String] else {
            rejectArguments(arguments)
        }

        Airship.shared.privacyManager.disableFeatures(try! Features.parse(names))
    }
}
