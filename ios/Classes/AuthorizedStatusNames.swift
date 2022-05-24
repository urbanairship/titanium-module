/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct AuthorizationStatusNames {
    static let map: [String: UAAuthorizationStatus] = [
        authorized: UAAuthorizationStatus.authorized,
        ephemeral: UAAuthorizationStatus.ephemeral,
        provisional: UAAuthorizationStatus.provisional,
        notDetermined: UAAuthorizationStatus.notDetermined,
        denied: UAAuthorizationStatus.denied
    ]

    static let authorized = "authorized"
    static let ephemeral = "ephemeral"
    static let provisional = "provisional"
    static let notDetermined = "not_determined"
    static let denied = "denied"
}

extension UAAuthorizationStatus {
    func toStringValue() -> String {
        return AuthorizationStatusNames.map.first(where: {
            $0.value == self
        })?.key ?? "unknown"
    }
}
