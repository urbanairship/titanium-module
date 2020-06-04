/* Copyright Airship and Contributors */

package ti.airship;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.urbanairship.UAirship;
import com.urbanairship.channel.AirshipChannelListener;
import com.urbanairship.push.NotificationActionButtonInfo;
import com.urbanairship.push.NotificationInfo;
import com.urbanairship.push.NotificationListener;

import ti.airship.events.ChannelRegistrationEvent;
import ti.airship.events.DeepLinkEvent;
import ti.airship.events.EventEmitter;
import ti.airship.events.PushReceivedEvent;

/**
 * Handles listeners and plugin state for the AirshipTitaniumModule. Needed
 * since the module lifecycle does not match the app lifecycle.
 */
class TiAirship {

    private static TiAirship instance = new TiAirship();

    // Store state
    private TiPush launchPush = null;
    private String deepLink = null;

    @NonNull
    static TiAirship shared() {
        return instance;
    }

    void onAirshipReady(@NonNull UAirship airship) {
        airship.setDeepLinkListener(deepLink -> {
            TiAirship.this.deepLink = deepLink;
            EventEmitter.shared().fireEvent(new DeepLinkEvent(deepLink));
            return true;
        });

        airship.getPushManager().addPushListener((message, notificationPosted) -> {
            if (!notificationPosted) {
                EventEmitter.shared().fireEvent(new PushReceivedEvent(TiPush.wrap(message)));
            }
        });

        airship.getPushManager().setNotificationListener(new NotificationListener() {
            @Override
            public void onNotificationPosted(@NonNull NotificationInfo notificationInfo) {
                EventEmitter.shared().fireEvent(new PushReceivedEvent(TiPush.wrap(notificationInfo)));
            }

            @Override
            public boolean onNotificationOpened(@NonNull NotificationInfo notificationInfo) {
                TiAirship.this.launchPush = TiPush.wrap(notificationInfo);
                return false;
            }

            @Override
            public boolean onNotificationForegroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
                TiAirship.this.launchPush = TiPush.wrap(notificationInfo);
                return false;
            }

            @Override
            public void onNotificationBackgroundAction(@NonNull NotificationInfo notificationInfo, @NonNull NotificationActionButtonInfo actionButtonInfo) {
                TiAirship.this.launchPush = TiPush.wrap(notificationInfo);
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
            }

            @Override
            public void onChannelUpdated(@NonNull String channelId) {
                String pushToken = UAirship.shared().getPushManager().getPushToken();
                EventEmitter.shared().fireEvent(new ChannelRegistrationEvent(channelId, pushToken));
            }
        });

    }

    @Nullable
    TiPush getLaunchPush(boolean clear) {
        TiPush push = this.launchPush;
        if (clear) {
            this.launchPush = null;
        }
        return push;
    }

    @Nullable
    String getDeepLink(boolean clear) {
        String link = this.deepLink;
        if (clear) {
            this.deepLink = null;
        }
        return link;
    }
}
