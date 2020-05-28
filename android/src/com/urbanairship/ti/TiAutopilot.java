/* Copyright Airship and Contributors */

package com.urbanairship.ti;

import android.content.Context;
import android.graphics.Color;

import androidx.annotation.NonNull;

import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.Autopilot;
import com.urbanairship.UAirship;
import com.urbanairship.channel.AirshipChannelListener;
import com.urbanairship.push.NotificationActionButtonInfo;
import com.urbanairship.push.NotificationInfo;
import com.urbanairship.push.NotificationListener;
import com.urbanairship.util.UAStringUtil;

import org.appcelerator.kroll.common.Log;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.TiProperties;

public class TiAutopilot extends Autopilot {

    static final String PRODUCTION_KEY = "com.urbanairship.production_app_key";
    static final String PRODUCTION_SECRET = "com.urbanairship.production_app_secret";
    static final String DEVELOPMENT_KEY = "com.urbanairship.development_app_key";
    static final String DEVELOPMENT_SECRET = "com.urbanairship.development_app_secret";
    static final String IN_PRODUCTION = "com.urbanairship.in_production";
    static final String GCM_SENDER = "com.urbanairship.gcm_sender";
    static final String NOTIFICATION_ICON = "com.urbanairship.notification_icon";
    static final String NOTIFICATION_ACCENT_COLOR = "com.urbanairship.notification_accent_color";

    private static final String TAG = "UrbanAirshipModule";

    @Override
    public void onAirshipReady(UAirship airship) {
        Log.i(TAG, "Airship ready");

        airship.setDeepLinkListener(deepLink -> {
            UrbanAirshipModule.deepLinkReceived(deepLink);
            return true;
        });

        airship.getPushManager().addPushListener((message, notificationPosted) -> {
            Log.i(TAG, "Received push. Alert: " + message.getAlert());
            if (!notificationPosted) {
                UrbanAirshipModule.onPushReceived(message, null);
            }
        });

        airship.getPushManager().setNotificationListener(new NotificationListener() {
            @Override
            public void onNotificationPosted(@NonNull NotificationInfo notificationInfo) {
                Log.i(TAG, "Notification posted. Alert: " + notificationInfo.getMessage().getAlert());
                UrbanAirshipModule.onPushReceived(notificationInfo.getMessage(), notificationInfo.getNotificationId());
            }

            @Override
            public boolean onNotificationOpened(@NonNull NotificationInfo notificationInfo) {
                Log.i(TAG, "Notification Opened. Alert: " + notificationInfo.getMessage().getAlert());
                UrbanAirshipModule.onNotificationOpened(notificationInfo.getMessage(), notificationInfo.getNotificationId());
                return false;
            }

            @Override
            public boolean onNotificationForegroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
                Log.i(TAG, "User clicked notification button. Button ID: " + actionButtonInfo.getButtonId() + " Alert: " + notificationInfo.getMessage().getAlert());
                UrbanAirshipModule.onNotificationOpened(notificationInfo.getMessage(), notificationInfo.getNotificationId());
                return false;
            }

            @Override
            public void onNotificationBackgroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
                Log.i(TAG, "User clicked notification button. Button ID: " + actionButtonInfo.getButtonId() + " Alert: " + notificationInfo.getMessage().getAlert());
                UrbanAirshipModule.onNotificationOpened(notificationInfo.getMessage(), notificationInfo.getNotificationId());
            }

            @Override
            public void onNotificationDismissed(@NonNull NotificationInfo notificationInfo) {
                Log.i(TAG, "Notification dismissed. Alert: " + notificationInfo.getMessage().getAlert());
            }
        });

        airship.getChannel().addChannelListener(new AirshipChannelListener() {
            @Override
            public void onChannelCreated(@NonNull String channelId) {
                Log.i(TAG, "Channel created. Channel ID:" + channelId + ".");
                UrbanAirshipModule.onChannelUpdated(channelId);
            }

            @Override
            public void onChannelUpdated(@NonNull String channelId) {
                Log.i(TAG, "Channel updated. Channel ID:" + channelId + ".");
                UrbanAirshipModule.onChannelUpdated(channelId);
            }
        });

    }

    @Override
    public boolean allowEarlyTakeOff(Context context) {
        return TiApplication.getInstance().getAppProperties() != null;
    }

    @Override
    public AirshipConfigOptions createAirshipConfigOptions(Context context) {
        TiProperties properties = TiApplication.getInstance().getAppProperties();

        AirshipConfigOptions.Builder options = new AirshipConfigOptions.Builder()
                .setDevelopmentAppKey(properties.getString(DEVELOPMENT_KEY, ""))
                .setDevelopmentAppSecret(properties.getString(DEVELOPMENT_SECRET, ""))
                .setProductionAppKey(properties.getString(PRODUCTION_KEY, ""))
                .setProductionAppSecret(properties.getString(PRODUCTION_SECRET, ""))
                .setInProduction(properties.getBool(IN_PRODUCTION, false))
                .setFcmSenderId(properties.getString(GCM_SENDER, null));

        // Accent color
        String accentColor = properties.getString(NOTIFICATION_ACCENT_COLOR, null);
        if (!UAStringUtil.isEmpty(accentColor)) {
            try {
                options.setNotificationAccentColor(Color.parseColor(accentColor));
            } catch (IllegalArgumentException e) {
                Log.e(TAG, "Unable to parse notification accent color: " + accentColor, e);
            }
        }

        // Notification icon
        String notificationIconName = properties.getString(NOTIFICATION_ICON, null);
        if (!UAStringUtil.isEmpty(notificationIconName)) {
            int id  = context.getResources().getIdentifier(notificationIconName, "drawable", context.getPackageName());
            if (id > 0) {
                options.setNotificationIcon(id);
            } else {
                Log.e(TAG, "Unable to find notification icon with name: " + notificationIconName);
            }
        }

        return options.build();
    }
}
