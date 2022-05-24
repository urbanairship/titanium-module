/* Copyright Airship and Contributors */
package ti.airship.editors

import com.urbanairship.contacts.Scope
import com.urbanairship.contacts.ScopedSubscriptionListEditor
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.utils.PluginLogger

@proxy
class ScopedSubscriptionListEditorProxy(private val editor: ScopedSubscriptionListEditor) :
    KrollProxy() {
    @method
    fun subscribe(
        subscriptionList: String,
        scopeString: String,
    ): ScopedSubscriptionListEditorProxy {
        PluginLogger.logCall("subscribe", subscriptionList, scopeString)
        val scope = Scope.valueOf(scopeString.uppercase())
        editor.subscribe(subscriptionList, scope)
        return this
    }

    @method
    fun unsubscribe(
        subscriptionList: String,
        scopeString: String
    ): ScopedSubscriptionListEditorProxy {
        PluginLogger.logCall("unsubscribe", subscriptionList, scopeString)
        val scope = Scope.valueOf(scopeString.uppercase())
        editor.unsubscribe(subscriptionList, scope)
        return this
    }

    @method
    fun apply() {
        PluginLogger.logCall("apply")
        editor.apply()
    }
}