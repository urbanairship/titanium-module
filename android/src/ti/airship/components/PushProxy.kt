/* Copyright Airship and Contributors */
package ti.airship.components

import androidx.core.app.NotificationManagerCompat
import com.urbanairship.UAirship
import org.appcelerator.kroll.KrollDict
import org.appcelerator.kroll.KrollFunction
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.*
import ti.airship.utils.PluginLogger

@proxy
class PushProxy : KrollProxy() {
    @get:getProperty
    @get:method
    val notificationStatus: KrollDict
        get() {
            PluginLogger.logCall("getNotificationStatus")
            val dict = KrollDict()
            dict["airshipOptIn"] = UAirship.shared().pushManager.isOptIn
            dict["systemEnabled"] =
                NotificationManagerCompat.from(getActivity()).areNotificationsEnabled()
            return dict
        }

    @get:getProperty
    @get:method
    val pushToken: String?
        get() = UAirship.shared().pushManager.pushToken

    @get:getProperty
    @set:setProperty
    var userNotificationsEnabled: Boolean
        get() = UAirship.shared().pushManager.userNotificationsEnabled
        set(enabled) {
            PluginLogger.logCall("getUserNotificationsEnabled", enabled)
            UAirship.shared().pushManager.userNotificationsEnabled = enabled
        }

    @method
    fun enableUserNotifications(function: KrollFunction?) {
        PluginLogger.logCall("enableUserNotifications", function)
        UAirship.shared().pushManager.userNotificationsEnabled = true
        function?.callAsync(
            getKrollObject(),
            arrayOf(UAirship.shared().pushManager.isOptIn)
        )
    }
}