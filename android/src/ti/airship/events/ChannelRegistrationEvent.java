/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashMap;

import ti.airship.TIAirshipModule;

public class ChannelRegistrationEvent implements Event {
    private final String pushToken;
    private final String channelId;

    public ChannelRegistrationEvent(@NonNull String channelId, @Nullable String pushToken) {
        this.channelId = channelId;
        this.pushToken = pushToken;
    }

    @NonNull
    @Override
    public HashMap<String, Object> getData() {
        HashMap<String, Object> data = new HashMap<>();
        data.put("channelId", channelId);
        if (pushToken != null) {
            data.put("pushToken", pushToken);
        }
        return data;
    }

    @NonNull
    @Override
    public String getName() {
        return TIAirshipModule.EVENT_CHANNEL_UPDATED;
    }
}
