/* Copyright Airship and Contributors */

package ti.airship.events

import com.urbanairship.push.NotificationActionButtonInfo
import com.urbanairship.push.NotificationInfo
import ti.airship.TiAirshipModule

class NotificationResponseEvent(notificationInfo: NotificationInfo, buttonInfo: NotificationActionButtonInfo?) : Event {
    override val data: Map<String, Any> = notificationInfo.eventPayload(buttonInfo)
    override val name: String = TiAirshipModule.eventNotificationResponseReceived
}