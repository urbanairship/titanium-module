/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipAnalyticsProxy)
public class TiAirshipAnalyticsProxy: TiProxy {

    @objc(newEvent:)
    public func newEvent(arguments: [Any]?) -> TiAirshipCustomEventProxy {
        AirshipLogger.debug(describe(arguments))
        guard let name = arguments?.first as? String else { rejectArguments(arguments) }

        return TiAirshipCustomEventProxy(eventName: name)
    }

    @objc(trackScreen:)
    public func trackScreen(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        let screenName = arguments?.first as? String
        Airship.analytics.trackScreen(screenName)
    }

    @objc(editAssociatedIdentifiers:)
    public func editAssociatedIdentifiers(arguments: [Any]?) -> TiAirshipAssociatedIdEditorProxy {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipAssociatedIdEditorProxy { mutations in
            let identifiers = Analytics.shared.currentAssociatedDeviceIdentifiers()
            mutations.forEach { mutation in
                identifiers.set(identifier: mutation.1, key: mutation.0)
            }

            Analytics.shared.associateDeviceIdentifiers(identifiers)
        }
    }


}
