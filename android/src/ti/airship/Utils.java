/* Copyright Airship and Contributors */

package ti.airship;

import androidx.annotation.NonNull;

import com.urbanairship.push.PushMessage;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public abstract class Utils {
    @NonNull
    public static Set<String> convertToStringSet(@NonNull Object[] values) {
        HashSet<String> set = new HashSet<String>();
        for (Object value : values) {
            if (value instanceof String) {
                set.add((String) value);
            }
        }
        return set;
    }

    public static Map<String, String> convertToMap(@NonNull PushMessage message) {
        Map<String, String> map = new HashMap<>();
        for (String key : message.getPushBundle().keySet()) {
            if ("android.support.content.wakelockid".equals(key)) {
                continue;
            }
            if ("google.sent_time".equals(key)) {
                map.put(key, Long.toString(message.getPushBundle().getLong(key)));
                continue;
            }
            if ("google.ttl".equals(key)) {
                map.put(key, Integer.toString(message.getPushBundle().getInt(key)));
                continue;
            }
            map.put(key, message.getPushBundle().getString(key));
        }

        return map;
    }
}
