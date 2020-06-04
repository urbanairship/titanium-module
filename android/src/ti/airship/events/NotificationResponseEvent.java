/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.push.NotificationActionButtonInfo;

import java.util.HashMap;
import java.util.Map;

import ti.airship.AirshipTitaniumModule;
import ti.airship.TiNotificationResponse;
import ti.airship.TiPush;

public class NotificationResponseEvent implements Event {
    private final TiNotificationResponse response;

    public NotificationResponseEvent(@NonNull TiNotificationResponse response) {
        this.response = response;
    }

    @NonNull
    @Override
    public Map<String, Object> getData() {
        return response.toMap();
    }

    @NonNull
    @Override
    public String getName() {
        return AirshipTitaniumModule.EVENT_NOTIFICATION_RESPONSE;
    }
}
