/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipSubscriptionListEditorProxy)
public class TiAirshipSubscriptionListEditorProxy: TiProxy {

    private let editor: SubscriptionListEditor

    public init(editor: SubscriptionListEditor) {
        self.editor = editor
    }

    @objc(subscribeLists:)
    public func subscribeList(arguments: [Any]?) -> TiAirshipSubscriptionListEditorProxy {
        AirshipLogger.debug(describe(arguments))
        guard let list = arguments?.first as? String else { rejectArguments(arguments) }
        self.editor.subscribe(list)
        return self
    }

    @objc(unsubscribeLists:)
    public func unsubscribeList(arguments: [Any]?) -> TiAirshipSubscriptionListEditorProxy {
        AirshipLogger.debug(describe(arguments))
        guard let list = arguments?.first as? String else { rejectArguments(arguments) }
        self.editor.unsubscribe(list)
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        AirshipLogger.debug(describe(arguments))
        self.editor.apply()
    }
}
