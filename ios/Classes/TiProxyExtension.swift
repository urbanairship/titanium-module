/* Copyright Airship and Contributors */

import Foundation
import TitaniumKit
import AirshipCore

extension TiProxy {

    func describe(_ arguments: Any?) -> String {
        if let arguments = arguments {
            return "\(String(describing: arguments))"
        }
        return "nil"
    }

    func rejectArguments(_ arguments: Any?, fileID: String = #fileID, function: String = #function) -> Never {
        fatalError("Invalid arguments: \(String(describing: arguments))")
    }
}
