/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;

import java.util.Map;

import ti.airship.AirshipTitaniumModule;
import ti.airship.TiPush;

public class PushReceivedEvent implements Event {
    private final TiPush tiPush;

    public PushReceivedEvent(@NonNull TiPush tiPush) {
        this.tiPush = tiPush;
    }

    @NonNull
    @Override
    public Map<String, Object> getData() {
        return tiPush.toMap();
    }

    @NonNull
    @Override
    public String getName() {
        return AirshipTitaniumModule.EVENT_PUSH_RECEIVED;
    }
}
