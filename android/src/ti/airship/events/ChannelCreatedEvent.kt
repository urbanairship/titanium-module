/* Copyright Airship and Contributors */
package ti.airship.events

import ti.airship.TiAirshipModule

class ChannelCreatedEvent(channelId: String) : Event {
    override val data: Map<String, Any> = mapOf("channelId" to channelId)
    override val name: String = TiAirshipModule.eventChannelCreated
}