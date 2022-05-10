/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import ti.airship.TIAirshipModule;

public class DeepLinkEvent implements Event {
    private final String deepLink;

    public DeepLinkEvent(@NonNull String deepLink) {
        this.deepLink = deepLink;
    }

    @NonNull
    @Override
    public String getName() {
        return TIAirshipModule.EVENT_DEEP_LINK_RECEIVED;
    }

    @NonNull
    @Override
    public Map<String, Object> getData() {
        HashMap<String, Object> data = new HashMap<>();
        data.put("deepLink", deepLink);
        return data;
    }
}
