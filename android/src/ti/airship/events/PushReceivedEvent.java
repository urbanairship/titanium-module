/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import ti.airship.AirshipTitaniumModule;
import ti.airship.TiPush;

public class PushReceivedEvent implements Event {
    private final TiPush tiPush;
    private final boolean receivedInForeground;

    public PushReceivedEvent(@NonNull TiPush tiPush, boolean receivedInForeground) {
        this.tiPush = tiPush;
        this.receivedInForeground = receivedInForeground;
    }

    @NonNull
    @Override
    public Map<String, Object> getData() {
        Map<String, Object> map = new HashMap<>(tiPush.toMap());
        map.put("receivedInForeground", receivedInForeground);
        return map;
    }

    @NonNull
    @Override
    public String getName() {
        return AirshipTitaniumModule.EVENT_PUSH_RECEIVED;
    }
}
