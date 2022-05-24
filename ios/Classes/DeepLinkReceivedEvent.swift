/* Copyright Airship and Contributors */

import Foundation

struct DeepLinkReceivedEvent: TiEvent {

    let name: String = EventNames.deepLinkReceived
    let data: [String: Any]
    init(deepLink: String) {
        self.data = ["deepLink": deepLink]
    }
}
