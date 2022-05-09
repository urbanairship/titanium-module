/* Copyright Airship and Contributors */

import Foundation

struct ChannelCreatedEvent: TiEvent {
    static let eventName = "channelCreatedEvent"

    let name: String = eventName
    let data: [String: Any]
    init(channelID: String) {
        self.data = ["channelId": channelID]
    }
}
