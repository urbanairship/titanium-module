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
        if let tags = arguments?.first as? [String] {
            self.editor.add(tags)
        } else if let tag = arguments?.first as? String {
            self.editor.add(tag)
        } else {
            rejectArguments(arguments)
        }
        return self
    }

    @objc(remove:)
    public func remove(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        logCall(arguments)
        if let tags = arguments?.first as? [String] {
            self.editor.remove(tags)
        } else if let tag = arguments?.first as? String {
            self.editor.remove(tag)
        } else {
            rejectArguments(arguments)
        }
        return self
    }

    @objc(clear:)
    public func clear(arguments: [Any]?) -> TiAirshipTagEditorProxy {
        logCall(arguments)
        self.editor.clear()
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        logCall(arguments)
        self.editor.apply()
    }
}
