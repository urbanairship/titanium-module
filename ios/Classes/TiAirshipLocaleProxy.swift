/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipLocaleProxy)
public class TiAirshipLocaleProxy: TiProxy {

    @objc
    public var currentLocale: String {
        get {
            Airship.shared.localeManager.currentLocale.identifier
        }
        set {
            logCall(newValue)
            let locale = Locale(identifier: newValue)
            Airship.shared.localeManager.currentLocale = locale
        }
    }

    @objc(clearLocale:)
    public func clearLocale(arguments: [Any]?) {
        logCall(arguments)
        return Airship.shared.localeManager.clearLocale()
    }
}
