package ti.airship;

import java.util.HashSet;
import java.util.Set;

public abstract class Utils {
    public static Set<String> convertToStringSet(Object[] values) {
        HashSet<String> set = new HashSet<String>();
        for (Object value : values) {
            set.add(String.valueOf(value));
        }
        return set;
    }
}
