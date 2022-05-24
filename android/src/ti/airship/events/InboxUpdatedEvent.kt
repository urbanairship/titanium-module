/* Copyright Airship and Contributors */

package ti.airship.events

import ti.airship.TiAirshipModule

class InboxUpdatedEvent : Event {
    override val data: Map<String, Any> = emptyMap()
    override val name: String = TiAirshipModule.eventInboxUpdated
}