/* Copyright Airship and Contributors */

import UIKit
import TitaniumKit
import AirshipCore

@objc(TiAirshipAssociatedIdEditorProxy)
public class TiAirshipAssociatedIdEditorProxy: TiProxy {

    private let onApply: ([(String, String?)]) -> Void
    private var mutations: [(String, String?)] = []

    public init(onApply: @escaping ([(String, String?)]) -> Void) {
        self.onApply = onApply
    }

    @objc(set:)
    public func set(arguments: [Any]?) -> TiAirshipAssociatedIdEditorProxy {
        logCall(arguments)
        guard let arguments = arguments,
              arguments.count == 2,
              let identifier = arguments[0] as? String,
              let value = arguments[1] as? String
        else {
            rejectArguments(arguments)
        }

        mutations.append((identifier, value))
        return self
    }

    @objc(unsubscribe:)
    public func remove(arguments: [Any]?) -> TiAirshipAssociatedIdEditorProxy {
        logCall(arguments)
        guard let identifier = arguments?.first as? String else { rejectArguments(arguments) }

        mutations.append((identifier, nil))
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        logCall(arguments)
        self.onApply(mutations)
    }
}
