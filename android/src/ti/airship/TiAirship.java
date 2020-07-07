/* Copyright Airship and Contributors */

package ti.airship;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.UAirship;
import com.urbanairship.analytics.Analytics;
import com.urbanairship.app.GlobalActivityMonitor;
import com.urbanairship.app.SimpleApplicationListener;
import com.urbanairship.channel.AirshipChannelListener;
import com.urbanairship.push.NotificationActionButtonInfo;
import com.urbanairship.push.NotificationInfo;
import com.urbanairship.push.NotificationListener;


import ti.airship.events.ChannelRegistrationEvent;
import ti.airship.events.DeepLinkEvent;
import ti.airship.events.EventEmitter;
import ti.airship.events.NotificationOptInChangedEvent;
import ti.airship.events.NotificationResponseEvent;
import ti.airship.events.PushReceivedEvent;

/**
 * Handles listeners and plugin state for the AirshipTitaniumModule. Needed
 * since the module lifecycle does not match the app lifecycle.
 */
class TiAirship {

    private static final String SHARED_PREFERENCES_FILE = "ti.airship.shared_preferences";
    public static final String NOTIFICATION_OPT_IN_STATUS = "NOTIFICATION_OPT_IN_STATUS";
    private static TiAirship instance = new TiAirship();

    // Store state
    private TiNotificationResponse launchNotificationResponse = null;
    private String deepLink = null;
    private SharedPreferences sharedPreferences;

    @NonNull
    static TiAirship shared() {
        return instance;
    }

    void onAirshipReady(@NonNull UAirship airship) {
        sharedPreferences = UAirship.getApplicationContext()
                .getSharedPreferences(SHARED_PREFERENCES_FILE, Context.MODE_PRIVATE);

        if (!sharedPreferences.contains(NOTIFICATION_OPT_IN_STATUS)) {
            sharedPreferences.edit()
                    .putBoolean(NOTIFICATION_OPT_IN_STATUS, UAirship.shared().getPushManager().isOptIn())
                    .apply();
        }

        airship.setDeepLinkListener(deepLink -> {
            TiAirship.this.deepLink = deepLink;
            EventEmitter.shared().fireEvent(new DeepLinkEvent(deepLink));
            return true;
        });

        airship.getPushManager().addPushListener((message, notificationPosted) -> {
            if (!notificationPosted) {
                boolean isForegrounded = UAirship.shared().getAnalytics().isAppInForeground();
                EventEmitter.shared().fireEvent(new PushReceivedEvent(TiPush.wrap(message), isForegrounded));
            }
        });

        airship.getPushManager().setNotificationListener(new NotificationListener() {
            @Override
            public void onNotificationPosted(@NonNull NotificationInfo notificationInfo) {
                boolean isForegrounded = UAirship.shared().getAnalytics().isAppInForeground();
                EventEmitter.shared().fireEvent(new PushReceivedEvent(TiPush.wrap(notificationInfo), isForegrounded));
            }

            @Override
            public boolean onNotificationOpened(@NonNull NotificationInfo notificationInfo) {
                TiNotificationResponse response = TiNotificationResponse.wrap(notificationInfo);
                TiAirship.this.launchNotificationResponse = response;
                EventEmitter.shared().fireEvent(new NotificationResponseEvent(response));
                return false;
            }

            @Override
            public boolean onNotificationForegroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
                TiNotificationResponse response = TiNotificationResponse.wrap(notificationInfo, actionButtonInfo);
                TiAirship.this.launchNotificationResponse = response;
                EventEmitter.shared().fireEvent(new NotificationResponseEvent(response));
                return false;
            }

            @Override
            public void onNotificationBackgroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
                TiNotificationResponse response = TiNotificationResponse.wrap(notificationInfo, actionButtonInfo);
                TiAirship.this.launchNotificationResponse = response;
                EventEmitter.shared().fireEvent(new NotificationResponseEvent(response));
            }

            @Override
            public void onNotificationDismissed(@NonNull NotificationInfo notificationInfo) {
            }
        });

        airship.getChannel().addChannelListener(new AirshipChannelListener() {
            @Override
            public void onChannelCreated(@NonNull String channelId) {
                String pushToken = UAirship.shared().getPushManager().getPushToken();
                EventEmitter.shared().fireEvent(new ChannelRegistrationEvent(channelId, pushToken));
                checkNotificationOptInStatus();
            }

            @Override
            public void onChannelUpdated(@NonNull String channelId) {
                String pushToken = UAirship.shared().getPushManager().getPushToken();
                EventEmitter.shared().fireEvent(new ChannelRegistrationEvent(channelId, pushToken));
                checkNotificationOptInStatus();
            }
        });

        GlobalActivityMonitor.shared(UAirship.getApplicationContext())
                .addApplicationListener(new SimpleApplicationListener() {
                    @Override
                    public void onForeground(long l) {
                        checkNotificationOptInStatus();
                    }
                });

        airship.getAnalytics().registerSDKExtension(Analytics.EXTENSION_TITANIUM, TiAirshipModuleVersion.tiAirshipModuleVersion);
    }

    @Nullable
    TiNotificationResponse getLaunchNotificationResponse(boolean clear) {
        TiNotificationResponse response = this.launchNotificationResponse;
        if (clear) {
            this.launchNotificationResponse = null;
        }
        return response;
    }

    @Nullable
    String getDeepLink(boolean clear) {
        String link = this.deepLink;
        if (clear) {
            this.deepLink = null;
        }
        return link;
    }

    private void checkNotificationOptInStatus() {
        boolean currentOptInStatus = UAirship.shared().getPushManager().isOptIn();
        boolean previousOptInStatus = sharedPreferences.getBoolean(NOTIFICATION_OPT_IN_STATUS, false);
        if (currentOptInStatus != previousOptInStatus) {
            EventEmitter.shared().fireEvent(new NotificationOptInChangedEvent(currentOptInStatus));
            sharedPreferences.edit().putBoolean(NOTIFICATION_OPT_IN_STATUS, currentOptInStatus).apply();
        }
    }
}
