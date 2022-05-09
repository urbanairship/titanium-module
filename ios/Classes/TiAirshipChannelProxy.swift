/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipChannelProxy)
public class TiAirshipChannelProxy: TiProxy {

    @objc
    public var identifier: String? {
        return Airship.channel.identifier
    }

    @objc
    public var tags: [String] {
        get {
            return Airship.channel.tags
        }
        set {
            logCall(newValue)
            Airship.channel.tags = newValue
        }
    }

    @objc(editTags:)
    func editTags(arguments: [Any]?) -> Any {
        logCall(arguments)
        return TiAirshipTagEditorProxy(editor: Airship.channel.editTags())
    }

    @objc(editAttributes:)
    public func editAttributes(arguments: [Any]?) -> TiAirshipAttributesEditorProxy {
        logCall(arguments)
        return TiAirshipAttributesEditorProxy(editor: Airship.channel.editAttributes())
    }

    @objc(editSubscriptionLists:)
    public func editSubscriptionLists(arguments: [Any]?) -> TiAirshipSubscriptionListEditorProxy {
        logCall(arguments)
        return TiAirshipSubscriptionListEditorProxy(editor: Airship.channel.editSubscriptionLists())
    }

    @objc(editTagGroups:)
    public func editTagGroups(arguments: [Any]?) -> TiAirshipTagGroupsEditorProxy {
        logCall(arguments)
        return TiAirshipTagGroupsEditorProxy(editor: Airship.channel.editTagGroups())
    }

    @objc(fetchSubscriptionLists:)
    public func fetchSubscriptionLists(arguments: [Any]?) {
        logCall(arguments)
        guard let callback = arguments?.first as? KrollCallback else { rejectArguments(arguments) }

        Airship.channel.fetchSubscriptionLists { config, error in
            var result: [String: Any] = [:]

            if let error = error {
                result["error"] = "Failed to fetch subscription lists: \(error.localizedDescription)"
            } else {
                result["subscriptions"] = config ?? []
            }

            callback.callAsync([result], thisObject: self)
        }
    }
}
