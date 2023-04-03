/* Copyright Airship and Contributors */
package ti.airship

import android.content.Context
import androidx.annotation.Keep
import com.urbanairship.AirshipConfigOptions
import com.urbanairship.Autopilot
import com.urbanairship.UAirship
import com.urbanairship.analytics.Analytics
import com.urbanairship.messagecenter.MessageCenter
import com.urbanairship.preferencecenter.PreferenceCenter
import ti.airship.utils.ConfigParser
import ti.airship.utils.PluginLogger
import ti.airship.utils.PluginStore

@Keep
class TiAutopilot : Autopilot() {

    companion object {
        private const val VERSION = "9.2.0"
    }

    private var configOptions: AirshipConfigOptions? = null

    override fun onAirshipReady(airship: UAirship) {
        PluginLogger.setLogLevel(airship.airshipConfigOptions.logLevel)
        airship.analytics.registerSDKExtension(Analytics.EXTENSION_TITANIUM, VERSION)

        val listener = TiAirshipListener(UAirship.getApplicationContext())
        airship.channel.addChannelListener(listener)
        airship.pushManager.addPushListener(listener)
        airship.pushManager.notificationListener = listener
        airship.deepLinkListener = listener
        MessageCenter.shared().inbox.addListener(listener)
        PreferenceCenter.shared().openListener = listener
    }

    override fun isReady(context: Context): Boolean {
        configOptions = loadConfig(context)
        return if (configOptions == null) {
            false
        } else try {
            configOptions!!.validate()
            true
        } catch (e: Exception) {
            PluginLogger.error(e, "Unable to takeOff")
            false
        }
    }

    private fun loadConfig(context: Context): AirshipConfigOptions? {
        val config = PluginStore.shared(context).airshipConfig ?: return null
        return ConfigParser.parse(context, config)
    }

    override fun createAirshipConfigOptions(context: Context): AirshipConfigOptions? {
        return configOptions
    }
}