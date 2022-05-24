/* Copyright Airship and Contributors */
package ti.airship.events

import ti.airship.TiAirshipModule

class DeepLinkReceivedEvent(deepLink: String) : Event {
    override val data: Map<String, Any> = mapOf("deepLink" to deepLink)
    override val name: String = TiAirshipModule.eventDeepLinkReceived
}
