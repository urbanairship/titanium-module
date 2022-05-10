package ti.airship.events;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.push.NotificationActionButtonInfo;
import com.urbanairship.push.NotificationInfo;

import java.util.HashMap;

public class TiNotificationResponse  {
    private final NotificationInfo notificationInfo;
    @Nullable
    private final NotificationActionButtonInfo actionButtonInfo;

    private TiNotificationResponse(@NonNull NotificationInfo notificationInfo, @Nullable NotificationActionButtonInfo actionButtonInfo) {
        this.notificationInfo = notificationInfo;
        this.actionButtonInfo = actionButtonInfo;
    }

    public static TiNotificationResponse wrap(@NonNull NotificationInfo notificationInfo) {
        return new TiNotificationResponse(notificationInfo, null);
    }

    public static TiNotificationResponse wrap(@NonNull NotificationInfo notificationInfo, NotificationActionButtonInfo actionButtonInfo) {
        return new TiNotificationResponse(notificationInfo, actionButtonInfo);
    }

    @NonNull
    public HashMap<String, Object> toMap() {
        HashMap<String, Object> map = new HashMap<>(TiPush.wrap(notificationInfo.getMessage()).toMap());
        if (actionButtonInfo != null) {
            map.put("actionId", actionButtonInfo.getButtonId());
            map.put("isForeground", actionButtonInfo.isForeground());
        } else {
            map.put("isForeground", true);
        }
        return map;
    }
}
