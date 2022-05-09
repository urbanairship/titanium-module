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

    @objc(subscribe:)
    public func subscribe(arguments: [Any]?) -> TiAirshipSubscriptionListEditorProxy {
        logCall(arguments)
        guard let list = arguments?.first as? String else { rejectArguments(arguments) }
        self.editor.subscribe(list)
        return self
    }

    @objc(unsubscribe:)
    public func unsubscribe(arguments: [Any]?) -> TiAirshipSubscriptionListEditorProxy {
        logCall(arguments)
        guard let list = arguments?.first as? String else { rejectArguments(arguments) }
        self.editor.unsubscribe(list)
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        logCall(arguments)
        self.editor.apply()
    }
}
