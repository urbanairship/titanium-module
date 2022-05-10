/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;

import java.util.Map;

import ti.airship.TIAirshipModule;

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
        return TIAirshipModule.EVENT_NOTIFICATION_RESPONSE;
    }
}
