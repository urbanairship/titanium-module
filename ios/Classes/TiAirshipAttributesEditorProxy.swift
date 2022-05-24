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

    @objc(removeAttribute:)
    public func removeAttribute(arguments: [Any]?) -> TiAirshipAttributesEditorProxy {
        AirshipLogger.debug(describe(arguments))
        guard let attribute = arguments?.first as? String else { rejectArguments(arguments) }
        self.editor.remove(attribute)
        return self
    }

    @objc(setAttribute:)
    public func setAttribute(arguments: [Any]?) -> TiAirshipAttributesEditorProxy {
        AirshipLogger.debug(describe(arguments))
        guard let arguments = arguments,
              arguments.count == 2,
              let attribute = arguments[0] as? String
        else {
            rejectArguments(arguments)
        }


        let value = arguments[1]
        switch (value) {
        case let value as String:
            self.editor.set(string: value, attribute: attribute)
        case let value as Double:
            self.editor.set(double: value, attribute: attribute)
        case let value as Float:
            self.editor.set(float: value, attribute: attribute)
        case let value as Int:
            self.editor.set(int: value, attribute: attribute)
        case let value as NSNumber:
            self.editor.set(number: value, attribute: attribute)
        case let value as Date:
            self.editor.set(date: value, attribute: attribute)
        default:
            rejectArguments(arguments)
        }
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        AirshipLogger.debug(describe(arguments))
        self.editor.apply()
    }
}
