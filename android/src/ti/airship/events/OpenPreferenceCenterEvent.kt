/* Copyright Airship and Contributors */

package ti.airship.events

import ti.airship.TiAirshipModule

class OpenPreferenceCenterEvent(preferenceCenterId: String) : Event {
    override val data: Map<String, Any> = mapOf("preferenceCenterId" to preferenceCenterId)
    override val name: String = TiAirshipModule.eventOpenPreferenceCenter
}