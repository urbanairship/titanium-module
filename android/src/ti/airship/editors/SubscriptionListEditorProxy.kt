/* Copyright Airship and Contributors */
package ti.airship.editors

import com.urbanairship.channel.SubscriptionListEditor
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.utils.PluginLogger

@proxy
class SubscriptionListEditorProxy(private val editor: SubscriptionListEditor) : KrollProxy() {
    @method
    fun subscribe(subscriptionList: String): SubscriptionListEditorProxy {
        PluginLogger.logCall("subscribe")
        editor.subscribe(subscriptionList)
        return this
    }

    @method
    fun unsubscribe(subscriptionList: String): SubscriptionListEditorProxy {
        PluginLogger.logCall("unsubscribe")
        editor.unsubscribe(subscriptionList)
        return this
    }

    @method
    fun apply() {
        PluginLogger.logCall("apply")
        editor.apply()
    }
}