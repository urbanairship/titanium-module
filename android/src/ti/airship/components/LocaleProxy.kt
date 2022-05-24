/* Copyright Airship and Contributors */
package ti.airship.components

import com.urbanairship.UAirship
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.*
import ti.airship.utils.PluginLogger
import java.util.*

@proxy
class LocaleProxy : KrollProxy() {
    @get:getProperty
    @set:setProperty
    var currentLocale: String
        get() = UAirship.shared().locale.toString()
        set(localeId) {
            PluginLogger.logCall("setCurrentLocale", localeId)
            check(localeId.isNotEmpty())
            UAirship.shared().setLocaleOverride(Locale(localeId))
        }

    @method
    fun reset() {
        PluginLogger.logCall("reset")
        UAirship.shared().setLocaleOverride(null)
    }
}