/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipLocaleProxy)
public class TiAirshipLocaleProxy: TiProxy {

    @objc
    public var currentLocale: String {
        Airship.shared.localeManager.currentLocale.identifier
    }

    @objc(setCurrentLocale:)
    public func setCurrentLocale(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let identifier = arg as? String else {
            rejectArguments(arg)
        }
        let locale = Locale(identifier: identifier)
        Airship.shared.localeManager.currentLocale = locale
    }

    @objc(clearLocale:)
    public func clearLocale(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        return Airship.shared.localeManager.clearLocale()
    }
}
