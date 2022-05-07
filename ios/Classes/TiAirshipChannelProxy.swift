/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore;

@objc(TiAirshipChannelProxy)
public class TiAirshipChannelProxy: TiProxy {

    @objc
    public var identifier: String? {
        return Airship.channel.identifier
    }

    @objc(editTags:)
    func editTags(arguments: [Any]?) -> Any {
        logCall(arguments)
        return TiAirshipTagEditorProxy(editor: Airship.channel.editTags())
    }
}
