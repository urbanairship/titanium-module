/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipAnalyticsProxy)
public class TiAirshipAnalyticsProxy: TiProxy {

    @objc(addEvent:)
    public func addEvent(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        guard let event = arguments?.first as? [String: AnyHashable] else { rejectArguments(arguments) }

        // Using action for now to avoid parsing a custom event
        ActionRunner.run(AddCustomEventAction.name, value: event, situation: .manualInvocation)
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
