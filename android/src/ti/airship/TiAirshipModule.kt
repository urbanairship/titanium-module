/* Copyright Airship and Contributors */
package ti.airship

import androidx.arch.core.util.Function
import org.appcelerator.kroll.annotations.Kroll.module
import org.appcelerator.kroll.KrollModule
import ti.airship.components.ChannelProxy
import ti.airship.components.AnalyticsProxy
import ti.airship.components.ContactProxy
import ti.airship.components.InAppAutomationProxy
import ti.airship.components.LocaleProxy
import ti.airship.components.MessageCenterProxy
import ti.airship.components.PreferenceCenterProxy
import ti.airship.components.PrivacyManagerProxy
import ti.airship.components.PushProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.getProperty
import com.urbanairship.UAirship
import org.appcelerator.kroll.KrollDict
import ti.airship.utils.PluginLogger
import com.urbanairship.json.JsonValue
import ti.airship.utils.PluginStore
import com.urbanairship.Autopilot
import org.appcelerator.titanium.TiApplication
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.constant
import ti.airship.events.Event
import ti.airship.events.EventManager
import ti.airship.utils.ConfigParser

@module(name = "TiAirship", id = "ti.airship")
class TiAirshipModule : KrollModule() {

    companion object {
        @constant
        val siteEu = "eu"
        @constant
        val siteUs = "US"

        @constant
        val logLevelVerbose = "verbose"
        @constant
        val logLevelDebug = "debug"
        @constant
        val logLevelInfo = "info"
        @constant
        val logLevelWarning = "warning"
        @constant
        val logLevelError = "error"
        @constant
        val logLevelNone = "none"

        @constant
        val eventPushReceived = "push_received"
        @constant
        val eventNotificationResponseReceived = "notification_response_received"
        @constant
        val eventNotificationOptInStatusChanged = "notification_opt_in_status_changed"
        @constant
        val eventChannelCreated = "channel_created"
        @constant
        val eventDeepLinkReceived = "deep_link_received"
        @constant
        val eventInboxUpdated = "inbox_updated"
        @constant
        val eventOpenPreferenceCenter = "open_preference_Center"
    }

    @get:getProperty
    @get:method
    val channel = ChannelProxy()

    @get:getProperty
    @get:method
    val analytics = AnalyticsProxy()

    @get:getProperty
    @get:method
    val contact = ContactProxy()

    @get:getProperty
    @get:method
    val inAppAutomation = InAppAutomationProxy()

    @get:getProperty
    @get:method
    val locale = LocaleProxy()

    @get:getProperty
    @get:method
    val messageCenter = MessageCenterProxy()

    @get:getProperty
    @get:method
    val preferenceCenter = PreferenceCenterProxy()

    @get:getProperty
    @get:method
    val privacyManager = PrivacyManagerProxy()

    @get:getProperty
    @get:method
    val push = PushProxy()

    @get:getProperty
    @get:method
    val isFlying: Boolean
        get() = UAirship.isFlying() || UAirship.isTakingOff()

    @method
    fun takeOff(config: KrollDict?): Boolean {
        PluginLogger.logCall("takeOff", config)
        checkNotNull(config)

        val map = JsonValue.wrapOpt(config).map
        ConfigParser.parse(getActivity(), map)?.validate()

        PluginStore.shared(getActivity()).airshipConfig = map
        Autopilot.automaticTakeOff(TiApplication.getInstance())
        return UAirship.isFlying() || UAirship.isTakingOff()
    }

    init {
        EventManager.setDispatcher((Function { input: Event ->
            fireEvent(
                input.name,
                input.data
            )
        } as Function<Event, Boolean>))
    }

    override fun listenerAdded(type: String, count: Int, proxy: KrollProxy) {
        super.listenerAdded(type, count, proxy)
        EventManager.onListenerAdded()
    }
}