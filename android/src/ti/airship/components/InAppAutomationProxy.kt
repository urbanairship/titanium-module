/* Copyright Airship and Contributors */
package ti.airship.components

import com.urbanairship.automation.InAppAutomation
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.*
import ti.airship.utils.PluginLogger
import java.util.concurrent.TimeUnit

@proxy
class InAppAutomationProxy : KrollProxy() {
    @get:getProperty
    @set:setProperty
    var isPaused: Boolean
        get() = InAppAutomation.shared().isPaused
        set(paused) {
            PluginLogger.logCall("setIsPaused", paused)
            InAppAutomation.shared().isPaused = paused
        }

    @get:getProperty
    @set:setProperty
    var displayIntervalMilliseconds: Long
        get() = InAppAutomation.shared().inAppMessageManager.displayInterval
        set(time) {
            PluginLogger.logCall("setDisplayIntervalMilliseconds", time)
            InAppAutomation.shared().inAppMessageManager.setDisplayInterval(
                time,
                TimeUnit.MILLISECONDS
            )
        }
}