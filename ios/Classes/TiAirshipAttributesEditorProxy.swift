/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipAttributesEditorProxy)
public class TiAirshipAttributesEditorProxy: TiProxy {

    private let editor: AttributesEditor

    public init(editor: AttributesEditor) {
        self.editor = editor
    }

    @objc(remove:)
    public func remove(arguments: [Any]?) -> TiAirshipAttributesEditorProxy {
        logCall(arguments)
        guard let attribute = arguments?.first as? String else { rejectArguments(arguments) }
        self.editor.remove(attribute)
        return self
    }

    @objc(set:)
    public func set(arguments: [Any]?) -> TiAirshipAttributesEditorProxy {
        logCall(arguments)
        guard let arguments = arguments,
              arguments.count == 2,
              let attribute = arguments[0] as? String
        else {
            rejectArguments(arguments)
        }

        let value = arguments[1]
        if let value = value as? String {
            self.editor.set(string: value, attribute: attribute)
        } else if let value = value as? Double {
            self.editor.set(double: value, attribute: attribute)
        } else if let value = value as? Float {
            self.editor.set(float: value, attribute: attribute)
        } else if let value = value as? Int {
            self.editor.set(int: value, attribute: attribute)
        } else if let value = value as? NSNumber {
            self.editor.set(number: value, attribute: attribute)
        } else {
            rejectArguments(arguments)
        }
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        logCall(arguments)
        self.editor.apply()
    }
}
