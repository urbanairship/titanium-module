package ti.airship.events;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import ti.airship.TIAirshipModule;

public class NotificationOptInChangedEvent implements Event {
    private final boolean optInStatus;

    public NotificationOptInChangedEvent(boolean optInStatus) {
        this.optInStatus = optInStatus;
    }

    @NonNull
    @Override
    public String getName() {
        return TIAirshipModule.EVENT_NOTIFICATION_OPT_IN_CHANGED;
    }

    @NonNull
    @Override
    public Map<String, Object> getData() {
        HashMap<String, Object> data = new HashMap<>();
        data.put("optIn", optInStatus);
        return data;
    }
}