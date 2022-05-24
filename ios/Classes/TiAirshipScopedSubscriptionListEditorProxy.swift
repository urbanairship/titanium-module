/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipScopedSubscriptionListEditorProxy)
public class TiAirshipScopedSubscriptionListEditorProxy: TiProxy {

    private let editor: ScopedSubscriptionListEditor

    public init(editor: ScopedSubscriptionListEditor) {
        self.editor = editor
    }

    @objc(subscribe:)
    public func subscribe(arguments: [Any]?) -> TiAirshipScopedSubscriptionListEditorProxy {
        AirshipLogger.debug(describe(arguments))
        self.parseArgs(arguments) { list, scope in
            self.editor.subscribe(list, scope: scope)
        }
        return self
    }

    @objc(unsubscribe:)
    public func unsubscribe(arguments: [Any]?) -> TiAirshipScopedSubscriptionListEditorProxy {
        AirshipLogger.debug(describe(arguments))
        self.parseArgs(arguments) { list, scope in
            self.editor.unsubscribe(list, scope: scope)
        }
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        AirshipLogger.debug(describe(arguments))
        self.editor.apply()
    }

    private func parseArgs(_ arguments: [Any]?, onComplete: (String, ChannelScope) -> Void) {
        guard let arguments = arguments,
              arguments.count == 2,
              let list = arguments[0] as? String,
              let scopeString = arguments[1] as? String,
              let scope = try? ChannelScope.fromString(scopeString)
        else {
            self.rejectArguments(arguments)
        }

        onComplete(list, scope)
    }
}
