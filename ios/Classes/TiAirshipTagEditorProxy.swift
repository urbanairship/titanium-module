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

    @objc(add:)
    public func add(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        logCall(arguments)
        self.editor.add(parseTags(arguments))
        return self
    }

    @objc(remove:)
    public func remove(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        logCall(arguments)
        self.editor.remove(parseTags(arguments))
        return self
    }

    @objc(clear:)
    public func clear(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        logCall(arguments)
        self.editor.clear()
        return self
    }

    @objc(set:)
    public func set(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        logCall(arguments)
        self.editor.set(parseTags(arguments))
        return self
    }


    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        logCall(arguments)
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