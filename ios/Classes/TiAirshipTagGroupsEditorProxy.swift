/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipTagGroupsEditorProxy)
public class TiAirshipTagGroupsEditorProxy: TiProxy {

    private let editor: TagGroupsEditor

    public init(editor: TagGroupsEditor) {
        self.editor = editor
    }

    @objc(add:)
    public func add(arguments: [Any]?) -> TiAirshipTagGroupsEditorProxy {
        logCall(arguments)
        parseArgs(arguments) { group, tags in
            self.editor.add(tags, group: group)
        }
        return self
    }

    @objc(remove:)
    public func remove(arguments: [Any]?) -> TiAirshipTagGroupsEditorProxy {
        logCall(arguments)
        parseArgs(arguments) { group, tags in
            self.editor.remove(tags, group: group)
        }
        return self
    }

    @objc(set:)
    public func set(arguments: [Any]?) -> TiAirshipTagGroupsEditorProxy {
        logCall(arguments)
        parseArgs(arguments) { group, tags in
            self.editor.set(tags, group: group)
        }
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        logCall(arguments)
        self.editor.apply()
    }

    private func parseArgs(_ arguments: [Any]?, onComplete: (String, [String]) -> Void) {
        guard let arguments = arguments,
              arguments.count == 2,
              let group = arguments[0] as? String,
              let tags = parseTags(arguments[1])
        else {
            self.rejectArguments(arguments)
        }
        onComplete(group, tags)
    }

    private func parseTags(_ argument: Any?) -> [String]? {
        if let tags = argument as? [String] {
            return tags
        } else if let tag = argument as? String {
            return [tag]
        } else {
            return nil
        }
    }
}
