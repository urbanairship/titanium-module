package ti.airship.utils;

import android.content.Context;
import android.graphics.Color;
import android.net.Uri;
import android.util.Log;

import androidx.annotation.ColorInt;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.PrivacyManager;
import com.urbanairship.json.JsonList;
import com.urbanairship.json.JsonMap;
import com.urbanairship.json.JsonValue;
import com.urbanairship.util.UAStringUtil;

public class ConfigUtils {

    public static AirshipConfigOptions parseConfig(@NonNull Context context, @Nullable JsonMap config) {
        AirshipConfigOptions.Builder builder = AirshipConfigOptions.newBuilder();
        if (config == null || config.isEmpty()) {
            return builder.build();
        }

        JsonMap developmentEnvironment = config.opt("development").getMap();
        JsonMap productionEnvironment = config.opt("production").getMap();
        JsonMap defaultEnvironment = config.opt("default").getMap();

        if (developmentEnvironment != null) {
            builder.setDevelopmentAppKey(developmentEnvironment.opt("appKey").getString())
                    .setDevelopmentAppSecret(developmentEnvironment.opt("appSecret").getString());

            String logLevel = developmentEnvironment.opt("logLevel").getString();
            if (logLevel != null) {
                builder.setLogLevel(convertLogLevel(logLevel, Log.DEBUG));
            }
        }

        if (productionEnvironment != null) {
            builder.setProductionAppKey(productionEnvironment.opt("appKey").getString())
                    .setProductionAppSecret(productionEnvironment.opt("appSecret").getString());

            String logLevel = productionEnvironment.opt("logLevel").getString();
            if (logLevel != null) {
                builder.setProductionLogLevel(convertLogLevel(logLevel, Log.ERROR));
            }
        }

        if (defaultEnvironment != null) {
            builder.setAppKey(defaultEnvironment.opt("appKey").getString())
                    .setAppSecret(defaultEnvironment.opt("appSecret").getString());

            String logLevel = defaultEnvironment.opt("logLevel").getString();
            if (logLevel != null) {
                builder.setLogLevel(convertLogLevel(logLevel, Log.ERROR));
            }
        }

        String site = config.opt("site").getString();
        if (site != null) {
            try {
                builder.setSite(parseSite(site));
            } catch (Exception e) {
                PluginLogger.error("Invalid site " + site, e);
            }
        }

        if (config.containsKey("inProduction")) {
            builder.setInProduction(config.opt("inProduction").getBoolean(false));
        }

        if (config.containsKey("isChannelCreationDelayEnabled")) {
            builder.setChannelCreationDelayEnabled(config.opt("isChannelCreationDelayEnabled").getBoolean(false));
        }

        if (config.containsKey("requireInitialRemoteConfigEnabled")) {
            builder.setRequireInitialRemoteConfigEnabled(config.opt("requireInitialRemoteConfigEnabled").getBoolean(false));
        }

        String[] urlAllowList = parseArray(config.opt("urlAllowList"));
        if (urlAllowList != null) {
            builder.setUrlAllowList(urlAllowList);
        }

        String[] urlAllowListScopeJavaScriptInterface = parseArray(config.opt("urlAllowListScopeJavaScriptInterface"));
        if (urlAllowListScopeJavaScriptInterface != null) {
            builder.setUrlAllowListScopeJavaScriptInterface(urlAllowListScopeJavaScriptInterface);
        }

        String[] urlAllowListScopeOpenUrl = parseArray(config.opt("urlAllowListScopeOpenUrl"));
        if (urlAllowListScopeOpenUrl != null) {
            builder.setUrlAllowListScopeOpenUrl(urlAllowListScopeOpenUrl);
        }

        JsonMap chat = config.opt("chat").getMap();
        if (chat != null) {
            builder.setChatSocketUrl(chat.opt("webSocketUrl").optString())
                    .setChatUrl(chat.opt("url").optString());
        }

        JsonMap android = config.opt("android").getMap();
        if (android != null) {
            if (android.containsKey("appStoreUri")) {
                builder.setAppStoreUri(Uri.parse(android.opt("appStoreUri").optString()));
            }

            if (android.containsKey("fcmFirebaseAppName")) {
                builder.setFcmFirebaseAppName(android.opt("fcmFirebaseAppName").optString());
            }

            if (android.containsKey("notificationConfig")) {
                applyNotificationConfig(context, android.opt("notificationConfig").optMap(), builder);
            }
        }

        JsonList enabledFeatures = config.opt("enabledFeatures").getList();
        try {
            if (enabledFeatures != null) {
                builder.setEnabledFeatures(parseFeatures(enabledFeatures));
            }
        } catch (Exception e) {
            PluginLogger.error("Invalid enabled features: " + enabledFeatures);
        }

        return builder.build();
    }

    private static void applyNotificationConfig(@NonNull Context context, @NonNull JsonMap notificationConfig, @NonNull AirshipConfigOptions.Builder builder) {
        String icon = notificationConfig.opt("icon").getString();
        if (icon != null) {
            int resourceId = getNamedResource(context, icon, "drawable");
            builder.setNotificationIcon(resourceId);
        }

        String largeIcon = notificationConfig.opt("largeIcon").getString();
        if (largeIcon != null) {
            int resourceId = getNamedResource(context, largeIcon, "drawable");
            builder.setNotificationLargeIcon(resourceId);
        }

        String accentColor = notificationConfig.opt("accentColor").getString();
        if (accentColor != null) {
            builder.setNotificationAccentColor(getHexColor(accentColor, 0));
        }

        String channelId = notificationConfig.opt("defaultChannelId").getString();
        if (channelId != null) {
            builder.setNotificationChannel(channelId);
        }
    }

    @ColorInt
    public static int getHexColor(@NonNull String hexColor, @ColorInt int defaultColor) {
        if (!UAStringUtil.isEmpty(hexColor)) {
            try {
                return Color.parseColor(hexColor);
            } catch (IllegalArgumentException e) {
                PluginLogger.error(e, "Unable to parse color: %s", hexColor);
            }
        }
        return defaultColor;
    }

    public static int getNamedResource(Context context, @NonNull String resourceName, @NonNull String resourceFolder) {
        if (!UAStringUtil.isEmpty(resourceName)) {
            int id = context.getResources().getIdentifier(resourceName, resourceFolder, context.getPackageName());
            if (id != 0) {
                return id;
            } else {
                PluginLogger.error("Unable to find resource with name: %s", resourceName);
            }
        }
        return 0;
    }

    private static int convertLogLevel(@NonNull String logLevel, int defaultValue) {
        switch (logLevel) {
            case "verbose":
                return Log.VERBOSE;
            case "debug":
                return Log.DEBUG;
            case "info":
                return Log.INFO;
            case "warning":
                return Log.WARN;
            case "error":
                return Log.ERROR;
            case "none":
                return Log.ASSERT;
        }
        return defaultValue;
    }

    @Nullable
    private static String[] parseArray(@Nullable JsonValue value) {
        if (value == null || !value.isJsonList()) {
            return null;
        }

        String[] result = new String[value.optList().size()];
        for (int i = 0; i < value.optList().size(); i++) {
            String string = value.optList().get(i).getString();
            if (string == null) {
                PluginLogger.error("Invalid string array: " + value);
                return null;
            }
            result[i] = string;
        }

        return result;
    }

    @PrivacyManager.Feature
    private static int parseFeatures(@NonNull JsonList jsonList) {
        int result = PrivacyManager.FEATURE_NONE;
        for (JsonValue value : jsonList) {
            result |= Utils.parseFeature(value.optString());
        }
        return result;
    }

    @AirshipConfigOptions.Site
    @NonNull
    private static String parseSite(@NonNull String value) {
        switch (value) {
            case "eu":
                return AirshipConfigOptions.SITE_EU;

            case "us":
                return AirshipConfigOptions.SITE_US;
        }

        throw new IllegalArgumentException("Invalid site: " + value);
    }
}
