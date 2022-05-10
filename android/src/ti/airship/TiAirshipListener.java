/* Copyright Airship and Contributors */

package ti.airship;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.UAirship;
import com.urbanairship.actions.DeepLinkListener;
import com.urbanairship.analytics.Analytics;
import com.urbanairship.app.ActivityMonitor;
import com.urbanairship.app.GlobalActivityMonitor;
import com.urbanairship.app.SimpleActivityListener;
import com.urbanairship.app.SimpleApplicationListener;
import com.urbanairship.channel.AirshipChannelListener;
import com.urbanairship.push.NotificationActionButtonInfo;
import com.urbanairship.push.NotificationInfo;
import com.urbanairship.push.NotificationListener;
import com.urbanairship.push.PushListener;
import com.urbanairship.push.PushMessage;

import ti.airship.events.ChannelRegistrationEvent;
import ti.airship.events.DeepLinkEvent;
import ti.airship.events.Event;
import ti.airship.events.EventEmitter;
import ti.airship.events.NotificationOptInChangedEvent;
import ti.airship.events.NotificationResponseEvent;
import ti.airship.events.PushReceivedEvent;
import ti.airship.events.TiNotificationResponse;
import ti.airship.events.TiPush;

/**
 * Handles listeners and plugin state for the AirshipTitaniumModule. Needed
 * since the module lifecycle does not match the app lifecycle.
 */
class TiAirshipListener implements NotificationListener, AirshipChannelListener, DeepLinkListener, PushListener {


    private final ActivityMonitor activityMonitor;

    private TiAirshipListener(ActivityMonitor activityMonitor) {
        this.activityMonitor = activityMonitor;
    }


    static TiAirshipListener newListener(ActivityMonitor activityMonitor) {
        TiAirshipListener listener = new TiAirshipListener(activityMonitor);
        listener.activityMonitor.addApplicationListener(new SimpleApplicationListener() {
            @Override
            public void onForeground(long time) {
                super.onForeground(time);
                listener.checkNotificationOptInStatus();
            }
        });
        return listener;
    }

    void onAirshipReady(@NonNull UAirship airship) {
        airship.setDeepLinkListener(deepLink -> {
            TiAirshipListener.this.deepLink = deepLink;
            return true;
        });



        airship.getPushManager().setNotificationListener(new NotificationListener() {

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

    @Override
    public boolean onDeepLink(@NonNull String deepLink) {
        dispatch(new DeepLinkEvent(deepLink));
        return true;
    }

    @Override
    public void onChannelCreated(@NonNull String channelId) {
        String pushToken = UAirship.shared().getPushManager().getPushToken();
        EventEmitter.shared().fireEvent(new ChannelRegistrationEvent(channelId, pushToken));
    }

    @Override
    public void onChannelUpdated(@NonNull String channelId) {

    }

    @Override
    public void onNotificationPosted(@NonNull NotificationInfo notificationInfo) {
        boolean isForegrounded = UAirship.shared().getAnalytics().isAppInForeground();
        EventEmitter.shared().fireEvent(new PushReceivedEvent(TiPush.wrap(notificationInfo), isForegrounded));
    }

    @Override
    public boolean onNotificationOpened(@NonNull NotificationInfo notificationInfo) {
        TiNotificationResponse response = TiNotificationResponse.wrap(notificationInfo);
        EventEmitter.shared().fireEvent(new NotificationResponseEvent(response));
        return false;
    }

    @Override
    public boolean onNotificationForegroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
        TiNotificationResponse response = TiNotificationResponse.wrap(notificationInfo, actionButtonInfo);
        EventEmitter.shared().fireEvent(new NotificationResponseEvent(response));
        return false;
    }

    @Override
    public void onNotificationBackgroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
        TiNotificationResponse response = TiNotificationResponse.wrap(notificationInfo, actionButtonInfo);
        EventEmitter.shared().fireEvent(new NotificationResponseEvent(response));
    }

    @Override
    public void onNotificationDismissed(@NonNull NotificationInfo notificationInfo) {
    }

    @Override
    public void onPushReceived(@NonNull PushMessage message, boolean notificationPosted) {
        if (!notificationPosted) {
            boolean isForegrounded = activityMonitor.isAppForegrounded();
            EventEmitter.shared().fireEvent(new PushReceivedEvent(TiPush.wrap(message), isForegrounded));
        }
    }

    private static void dispatch(@NonNull Event event) {
        EventEmitter.shared().fireEvent(event);
    }


}
