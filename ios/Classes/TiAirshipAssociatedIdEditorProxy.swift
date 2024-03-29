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

    @objc(setIdentifier:)
    public func setIdentifier(arguments: [Any]?) -> TiAirshipAssociatedIdEditorProxy {
        AirshipLogger.debug(describe(arguments))
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

    @objc(removeIdentifier:)
    public func removeIdentifier(arguments: [Any]?) -> TiAirshipAssociatedIdEditorProxy {
        AirshipLogger.debug(describe(arguments))
        guard let identifier = arguments?.first as? String else { rejectArguments(arguments) }

        mutations.append((identifier, nil))
        return self
    }

    @objc(apply:)
    public func apply(arguments: [Any]?) -> Void {
        AirshipLogger.debug(describe(arguments))
        self.onApply(mutations)
    }
}
