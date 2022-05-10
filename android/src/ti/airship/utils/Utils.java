/* Copyright Airship and Contributors */

package ti.airship.utils;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.PrivacyManager;
import com.urbanairship.json.JsonSerializable;
import com.urbanairship.json.JsonValue;
import com.urbanairship.push.PushMessage;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.titanium.util.TiConvert;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public abstract class Utils {

    private static final Map<String, Integer> featureMap = new HashMap<>();
    static {
        featureMap.put("none", PrivacyManager.FEATURE_NONE);
        featureMap.put("inAppAutomation", PrivacyManager.FEATURE_IN_APP_AUTOMATION);
        featureMap.put("messageCenter", PrivacyManager.FEATURE_MESSAGE_CENTER);
        featureMap.put("push", PrivacyManager.FEATURE_PUSH);
        featureMap.put("chat", PrivacyManager.FEATURE_CHAT);
        featureMap.put("analytics", PrivacyManager.FEATURE_ANALYTICS);
        featureMap.put("tagsAndAttributes", PrivacyManager.FEATURE_TAGS_AND_ATTRIBUTES);
        featureMap.put("contacts", PrivacyManager.FEATURE_CONTACTS);
        featureMap.put("location", PrivacyManager.FEATURE_LOCATION);
        featureMap.put("all", PrivacyManager.FEATURE_ALL);
    }

    @NonNull
    public static Set<String> convertToStringSet(@Nullable Object[] values) {
        if (values == null) {
            return Collections.emptySet();
        }
        return new HashSet<>(Arrays.asList(TiConvert.toStringArray(values)));
    }

    public static @NonNull <T> T checkNotNull(@Nullable T reference) {
        if (reference == null) {
            throw new NullPointerException();
        }
        return reference;
    }

    public static @NonNull String checkNotEmpty(@Nullable String reference) {
        if (reference == null) {
            throw new NullPointerException();
        }
        if (reference.isEmpty()) {
            throw new IllegalArgumentException();
        }

        return reference;
    }

    @Nullable
    public static Object convert(@Nullable JsonSerializable json) {
        if (json == null) {
            return null;
        }
        try {
            JsonValue jsonValue = json.toJsonValue();
            if (jsonValue.isJsonList()) {
                return new JSONArray(jsonValue.toString());
            } else if (jsonValue.isJsonMap()) {
                return new JSONObject(jsonValue.toString());
            } else {
                return jsonValue.getValue();
            }
        } catch (JSONException e) {
            PluginLogger.error(e);
            return null;
        }
    }

    public static void put(@NonNull KrollDict dict, @NonNull String key, @NonNull JsonSerializable json) {
        try {
            JsonValue jsonValue = json.toJsonValue();
            if (jsonValue.isJsonList()) {
                JSONArray array = new JSONArray(jsonValue.toString());
                dict.put(key, KrollDict.fromJSON(array));
            } else if (jsonValue.isJsonMap()) {
                JSONObject object = new JSONObject(jsonValue.toString());
                dict.put(key, KrollDict.fromJSON(object));
            } else {
                dict.put(key, jsonValue.getValue());
            }
        } catch (JSONException e) {
            PluginLogger.error(e);
        }
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

    public static int parseFeature(Object[] names) {
        int result = PrivacyManager.FEATURE_NONE;
        for (String name : convertToStringSet(names)) {
            result |= parseFeature(name);
        }
        return result;
    }

    public static int parseFeature(Collection<String> names) {
        int result = PrivacyManager.FEATURE_NONE;
        for (String name : names) {
            result |= parseFeature(name);
        }
        return result;
    }

    @PrivacyManager.Feature
    public static int parseFeature(String name) {
        Integer value = featureMap.get(name);
        if (value != null) {
            return value;
        }
        throw new IllegalArgumentException("Invalid feature: " + name);
    }

    public static List<String> featureNames(@PrivacyManager.Feature int features) {
        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : featureMap.entrySet()) {
            int value = entry.getValue();
            if (value == PrivacyManager.FEATURE_ALL) {
                if (features == value) {
                    return Collections.singletonList(entry.getKey());
                }
                continue;
            }

            if (value == PrivacyManager.FEATURE_NONE) {
                if (features == value) {
                    return Collections.singletonList(entry.getKey());
                }
                continue;
            }

            if ((value & features) == value) {
                result.add(entry.getKey());
            }
        }
        return result;
    }
}
