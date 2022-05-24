/* Copyright Airship and Contributors */

package ti.airship.events

import com.urbanairship.push.NotificationActionButtonInfo
import com.urbanairship.push.NotificationInfo
import com.urbanairship.push.PushMessage
import java.util.*

fun NotificationInfo.canonicalNotificationId(): String {
    return if (notificationTag != null) {
        "$notificationId:$notificationTag"
    } else {
        "$notificationId"
    }
}

fun NotificationInfo.eventPayload(buttonInfo: NotificationActionButtonInfo? = null): Map<String, Any> {
    val data = message.eventPayload(canonicalNotificationId()).toMutableMap()
    if (buttonInfo != null) {
        data["actionId"] = buttonInfo.buttonId
        data["isForeground"] = buttonInfo.isForeground
    } else {
        data["isForeground"] = true
    }
    return data
}

fun PushMessage.eventPayload(notificationId: String? = null): Map<String, Any> {
    val ignoredKeys = listOf(
        "android.support.content.wakelockid",
        "google.sent_time",
        "google.ttl"
    )

    val payload: MutableMap<String, Any> = HashMap()
    val extras: MutableMap<String, Any> = HashMap()
    val notification: MutableMap<String, Any?> = HashMap()
    if (notificationId != null) {
        notification["notificationId"] = notificationId
    }

    for (key in pushBundle.keySet()) {
        if (ignoredKeys.contains(key)) {
            continue
        }
        val value = getExtra(key) ?: continue
        payload[key] = value
        when (key) {
            PushMessage.EXTRA_ALERT -> notification["alert"] = getExtra(key)
            PushMessage.EXTRA_TITLE -> notification["title"] = getExtra(key)
            else -> extras[key] = value
        }
    }
    return mapOf("notification" to notification, "payload" to payload, "extras" to extras)
}