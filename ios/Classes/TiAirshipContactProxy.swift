/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipContactProxy)
public class TiAirshipContactProxy: TiProxy {
    @objc(identify:)
    public func identify(arguments: Array<Any>?) {
        Log.debug("identify: \(String(describing: arguments))")
        guard let identifier = arguments?.first as? String else {
            fatalError("Invalid argument.")
        }
        Airship.contact.identify(identifier)
    }

    @objc(reset:)
    public func reset(arguments: Array<Any>?) {
        Log.debug("reset: \(String(describing: arguments))")
        Airship.contact.reset()
    }
    
}
