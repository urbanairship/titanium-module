/* Copyright Airship and Contributors */

package ti.airship.events

import com.urbanairship.push.NotificationInfo
import com.urbanairship.push.PushMessage
import ti.airship.TiAirshipModule

class PushReceivedEvent : Event {
    override val data: Map<String, Any>
    override val name: String = TiAirshipModule.eventPushReceived

    constructor(pushMessage: PushMessage) {
        data = pushMessage.eventPayload()
    }

    constructor(notificationInfo: NotificationInfo) {
        data = notificationInfo.eventPayload()
    }
}