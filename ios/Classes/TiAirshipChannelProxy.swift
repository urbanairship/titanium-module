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
        return Airship.channel.tags
    }

    @objc(setTags:)
    public func setTags(arg: Any) {
        AirshipLogger.debug(describe(arg))
        guard let tags = arg as? [String] else {
            rejectArguments(arg)
        }
        Airship.channel.tags = tags
    }

    @objc(editTags:)
    func editTags(arguments: [Any]?) -> Any {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipTagEditorProxy(editor: Airship.channel.editTags())
    }

    @objc(editAttributes:)
    public func editAttributes(arguments: [Any]?) -> TiAirshipAttributesEditorProxy {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipAttributesEditorProxy(editor: Airship.channel.editAttributes())
    }

    @objc(editSubscriptionLists:)
    public func editSubscriptionLists(arguments: [Any]?) -> TiAirshipSubscriptionListEditorProxy {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipSubscriptionListEditorProxy(editor: Airship.channel.editSubscriptionLists())
    }

    @objc(editTagGroups:)
    public func editTagGroups(arguments: [Any]?) -> TiAirshipTagGroupsEditorProxy {
        AirshipLogger.debug(describe(arguments))
        return TiAirshipTagGroupsEditorProxy(editor: Airship.channel.editTagGroups())
    }

    @objc(fetchSubscriptionLists:)
    public func fetchSubscriptionLists(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
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
