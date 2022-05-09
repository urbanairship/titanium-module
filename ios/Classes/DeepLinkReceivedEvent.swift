/* Copyright Airship and Contributors */

import Foundation

struct DeepLinkReceivedEvent: TiEvent {
    static let eventName = "deepLinkReceivedEvent"

    let name: String = eventName
    let data: [String: Any]
    init(deepLink: String) {
        self.data = ["deepLink": deepLink]
    }
}
