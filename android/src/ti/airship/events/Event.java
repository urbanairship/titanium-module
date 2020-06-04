/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;

import java.util.Map;

public interface Event {

    @NonNull
    Map<String, Object> getData();

    @NonNull
    String getName();
}
