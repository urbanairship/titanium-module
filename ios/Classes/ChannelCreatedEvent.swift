/* Copyright Airship and Contributors */

import Foundation

struct ChannelCreatedEvent: TiEvent {
    let name: String = EventNames.channelCreated
    let data: [String: Any]
    init(channelID: String) {
        self.data = ["channelId": channelID]
    }
}
