/* Copyright Airship and Contributors */

package ti.airship;

import androidx.annotation.NonNull;

import java.util.HashSet;
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
}
