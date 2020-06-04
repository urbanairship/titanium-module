/* Copyright Airship and Contributors */

package ti.airship;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.push.NotificationInfo;
import com.urbanairship.push.PushMessage;

import java.util.HashMap;

/**
 * Wraps Airship push messages.
 */
public class TiPush {

    private final PushMessage message;
    private final String notificationId;

    protected TiPush(@NonNull PushMessage message, @Nullable String notificationId) {
        this.message = message;
        this.notificationId = notificationId;
    }

    public static TiPush wrap(@NonNull PushMessage message) {
        return new TiPush(message, null);
    }

    public static TiPush wrap(@NonNull NotificationInfo notificationInfo) {
        return new TiPush(notificationInfo.getMessage(), getNotificationId(notificationInfo));
    }

    @NonNull
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> map = new HashMap<>();
        map.put("extras", Utils.convertToMap(message));

        if (message.getAlert() != null) {
            map.put("message", message.getAlert());
        }

        if (message.getTitle() != null) {
            map.put("title", message.getTitle());
        }

        if (notificationId != null) {
            map.put("notificationId", notificationId);
        }

        return map;
    }

    @NonNull
    private static String getNotificationId(@NonNull NotificationInfo notificationInfo) {
        if (notificationInfo.getNotificationTag() != null) {
            return notificationInfo.getNotificationTag() + ":" + notificationInfo.getNotificationId();
        } else {
            return String.valueOf(notificationInfo.getNotificationId());
        }
    }
}
