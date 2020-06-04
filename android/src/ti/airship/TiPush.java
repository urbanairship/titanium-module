/* Copyright Airship and Contributors */

package ti.airship;

import androidx.annotation.NonNull;

import com.urbanairship.push.NotificationInfo;
import com.urbanairship.push.PushMessage;

import java.util.HashMap;
import java.util.Map;

/**
 * Wraps Airship push messages.
 */
public class TiPush {

    private final PushMessage message;
    private final Integer notificationId;

    private TiPush(PushMessage message, Integer notificationId) {
        this.message = message;
        this.notificationId = notificationId;
    }

    public static TiPush wrap(@NonNull PushMessage message) {
        return new TiPush(message, null);
    }

    public static TiPush wrap(@NonNull NotificationInfo notificationInfo) {
        return new TiPush(notificationInfo.getMessage(), notificationInfo.getNotificationId());
    }

    @NonNull
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> pushMap = new HashMap<>();
        Map<String, String> extras = new HashMap<>();
        for (String key : message.getPushBundle().keySet()) {
            if ("android.support.content.wakelockid".equals(key)) {
                continue;
            }

            if ("google.sent_time".equals(key)) {
                extras.put(key, Long.toString(message.getPushBundle().getLong(key)));
                continue;
            }

            if ("google.ttl".equals(key)) {
                extras.put(key, Integer.toString(message.getPushBundle().getInt(key)));
                continue;
            }

            extras.put(key, message.getPushBundle().getString(key));
        }
        pushMap.put("extras", extras);

        if (message.getAlert() != null) {
            pushMap.put("message", message.getAlert());
        }

        if (notificationId != null) {
            pushMap.put("notificationId", notificationId);
        }

        return pushMap;
    }
}
