/* Copyright Urban Airship and Contributors */

package ti.airship.utils;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.json.JsonException;
import com.urbanairship.json.JsonMap;
import com.urbanairship.json.JsonValue;

/**
 * Stores shared preferences and checks preference-dependent state.
 */
public class PluginStore {
    private static final String SHARED_PREFERENCES_FILE = "ti.airship";

    private static PluginStore sharedInstance;
    private static final Object sharedInstanceLock = new Object();

    private static final String AIRSHIP_CONFIG = "AIRSHIP_CONFIG";
    private static final String PREFERENCE_CENTER_CUSTOM_UI_PREFIX = "PREFERENCE_CENTER_CUSTOM_UI-";

    private SharedPreferences preferences;

    private PluginStore(@NonNull Context context) {
        this.preferences = context.getSharedPreferences(SHARED_PREFERENCES_FILE, Context.MODE_PRIVATE);
    }

    public static PluginStore shared(@NonNull Context context) {
        synchronized (sharedInstanceLock) {
            if (sharedInstance == null) {
                sharedInstance = new PluginStore(context);
            }
            return sharedInstance;
        }
    }

    @Nullable
    public JsonMap getAirshipConfig() {
        String config = preferences.getString(AIRSHIP_CONFIG, null);
        if (config == null) {
            return JsonMap.EMPTY_MAP;
        }

        try {
            return JsonValue.parseString(config).getMap();
        } catch (JsonException e) {
            PluginLogger.error("Failed to parse config.", e);
            return null;
        }
    }

    public void setAirshipConfig(JsonMap config) {
        preferences.edit().putString(AIRSHIP_CONFIG, config.toString()).apply();
    }

    public void setUseCustomPreferenceCenter(@NonNull String preferenceId, boolean useCustom) {
        preferences.edit()
                .putBoolean(useCustomPreferenceCenterKey(preferenceId), useCustom)
                .apply();
    }

    public boolean getUseCustomPreferenceCenter(@NonNull String preferenceId) {
        return preferences.getBoolean(useCustomPreferenceCenterKey(preferenceId), false);
    }

    private static String useCustomPreferenceCenterKey(String preferenceId) {
        return PREFERENCE_CENTER_CUSTOM_UI_PREFIX + preferenceId;
    }
}
