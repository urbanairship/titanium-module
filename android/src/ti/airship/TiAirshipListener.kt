/* Copyright Airship and Contributors */
package ti.airship

import android.content.Context
import ti.airship.utils.PluginStore
import com.urbanairship.channel.AirshipChannelListener
import com.urbanairship.actions.DeepLinkListener
import com.urbanairship.messagecenter.InboxListener
import com.urbanairship.app.SimpleApplicationListener
import com.urbanairship.UAirship
import com.urbanairship.app.GlobalActivityMonitor
import com.urbanairship.preferencecenter.PreferenceCenter
import com.urbanairship.push.*
import ti.airship.events.*

internal class TiAirshipListener(val context: Context) :
    NotificationListener,
    AirshipChannelListener,
    DeepLinkListener, PushListener, InboxListener,
    PreferenceCenter.OnOpenListener {

    private var areNotificationsOptedIn = false

    private fun init() {
        GlobalActivityMonitor.shared(context).addApplicationListener(object : SimpleApplicationListener() {
            override fun onForeground(time: Long) {
                super.onForeground(time)
                this@TiAirshipListener.onForeground()
            }
        })

        areNotificationsOptedIn = UAirship.shared().pushManager.areNotificationsOptedIn()
    }

    private fun onForeground() {
        if (UAirship.shared().pushManager.areNotificationsOptedIn() != this.areNotificationsOptedIn) {
            EventManager.dispatch(NotificationOptInChangedEvent(areNotificationsOptedIn))
            this.areNotificationsOptedIn = UAirship.shared().pushManager.areNotificationsOptedIn()
        }
    }

    override fun onDeepLink(deepLink: String): Boolean {
        EventManager.dispatch(DeepLinkReceivedEvent(deepLink))
        return true
    }

    override fun onChannelCreated(channelId: String) {
        EventManager.dispatch(ChannelCreatedEvent(channelId))
    }

    override fun onChannelUpdated(channelId: String) {}

    override fun onNotificationPosted(notificationInfo: NotificationInfo) {
        EventManager.dispatch(PushReceivedEvent(notificationInfo))
    }

    override fun onNotificationOpened(notificationInfo: NotificationInfo): Boolean {
        EventManager.dispatch(PushReceivedEvent(notificationInfo))
        return false
    }

    override fun onNotificationForegroundAction(
        notificationInfo: NotificationInfo,
        actionButtonInfo: NotificationActionButtonInfo
    ): Boolean {
        EventManager.dispatch(NotificationResponseEvent(notificationInfo, actionButtonInfo))
        return false
    }

    override fun onNotificationBackgroundAction(
        notificationInfo: NotificationInfo,
        actionButtonInfo: NotificationActionButtonInfo
    ) {
        EventManager.dispatch(NotificationResponseEvent(notificationInfo, actionButtonInfo))
    }

    override fun onNotificationDismissed(notificationInfo: NotificationInfo) {}

    override fun onPushReceived(message: PushMessage, notificationPosted: Boolean) {
        if (!notificationPosted) {
            EventManager.dispatch(PushReceivedEvent(message))
        }
    }

    override fun onInboxUpdated() {
        EventManager.dispatch(InboxUpdatedEvent())
    }

    override fun onOpenPreferenceCenter(preferenceCenterId: String): Boolean {
        if (PluginStore.shared(context).getUseCustomPreferenceCenter(preferenceCenterId)) {
            EventManager.dispatch(OpenPreferenceCenterEvent(preferenceCenterId))
            return true
        }
        return false
    }
}