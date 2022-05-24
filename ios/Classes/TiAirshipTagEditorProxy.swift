/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipTagEditorProxy)
public class TiAirshipTagEditorProxy: TiProxy {

    private let editor: TagEditor

    public init(editor: TagEditor) {
        self.editor = editor
    }

    @objc(addTags:)
    public func addTags(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        AirshipLogger.debug(describe(arguments))
        self.editor.add(parseTags(arguments))
        return self
    }

    @objc(removeTags:)
    public func removeTags(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        AirshipLogger.debug(describe(arguments))
        self.editor.remove(parseTags(arguments))
        return self
    }

    @objc(clearTags:)
    public func clearTags(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        AirshipLogger.debug(describe(arguments))
        self.editor.clear()
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        AirshipLogger.debug(describe(arguments))
        self.editor.apply()
    }

    private func parseTags(_ arguments: [Any]?) -> [String] {
        if let tags = arguments?.first as? [String] {
            return tags
        } else if let tag = arguments?.first as? String {
            return [tag]
        } else {
            rejectArguments(arguments)
        }
    }
}
