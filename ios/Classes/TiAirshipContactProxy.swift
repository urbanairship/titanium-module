/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;
import Darwin

@objc(TiAirshipContactProxy)
public class TiAirshipContactProxy: TiProxy {

    @objc
    public var namedUserId: String? {
        Airship.contact.namedUserID
    }

    @objc(identify:)
    public func identify(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        guard let identifier = arguments?.first as? String else {
            rejectArguments(arguments)
        }
        Airship.contact.identify(identifier)
    }

    @objc(reset:)
    public func reset(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        Airship.contact.reset()
    }

    @objc(editAttributes:)
    public func editAttributes(arguments: [Any]?) -> TiAirshipAttributesEditorProxy {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipAttributesEditorProxy(editor: Airship.contact.editAttributes())
    }

    @objc(editSubscriptionLists:)
    public func editSubscriptionLists(arguments: [Any]?) -> TiAirshipScopedSubscriptionListEditorProxy {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipScopedSubscriptionListEditorProxy(editor: Airship.contact.editSubscriptionLists())
    }

    @objc(editTagGroups:)
    public func editTagGroups(arguments: [Any]?) -> TiAirshipTagGroupsEditorProxy {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipTagGroupsEditorProxy(editor: Airship.contact.editTagGroups())
    }

    @objc(fetchSubscriptionLists:)
    public func fetchSubscriptionLists(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        guard let callback = arguments?.first as? KrollCallback else { rejectArguments(arguments) }

        Airship.contact.fetchSubscriptionLists { config, error in
            var result: [String: Any] = [:]

            if let error = error {
                result["error"] = "Failed to fetch subscription lists: \(error.localizedDescription)"
            } else {
                result["subscriptions"] = config?.mapValues { $0.values.map { $0.stringValue } } ?? [:]
            }
            callback.callAsync([result], thisObject: self)
        }
    }
}


