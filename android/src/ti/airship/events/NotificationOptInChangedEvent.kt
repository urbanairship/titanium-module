/* Copyright Airship and Contributors */

package ti.airship.events

import ti.airship.TiAirshipModule

class NotificationOptInChangedEvent(optInStatus: Boolean) : Event {
    override val data: Map<String, Any> = mapOf("optIn" to optInStatus)
    override val name: String = TiAirshipModule.eventNotificationOptInStatusChanged
}