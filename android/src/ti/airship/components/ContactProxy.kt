/* Copyright Airship and Contributors */

package ti.airship.components

import com.urbanairship.UAirship
import com.urbanairship.contacts.Scope
import com.urbanairship.json.JsonValue
import org.appcelerator.kroll.KrollDict
import org.appcelerator.kroll.KrollFunction
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.editors.AttributesEditorProxy
import ti.airship.editors.ScopedSubscriptionListEditorProxy
import ti.airship.editors.TagGroupsEditorProxy
import ti.airship.utils.PluginLogger
import ti.airship.utils.putJson

@proxy
class ContactProxy : KrollProxy() {

    companion object {
        @Kroll.constant
        val scopeApp = "app"

        @Kroll.constant
        val scopeWeb = "web"

        @Kroll.constant
        val scopeEmail = "email"

        @Kroll.constant
        val scopeSms = "sms"
    }

    @get:Kroll.getProperty
    @get:method
    val namedUserId: String?
        get() = UAirship.shared().contact.namedUserId

    @method
    fun identify(identifier: String) {
        PluginLogger.logCall("identify", identifier)
        check(identifier.isNotEmpty())
        UAirship.shared().contact.identify(identifier)
    }

    @method
    fun reset() {
        PluginLogger.logCall("reset")
        UAirship.shared().contact.reset()
    }

    @method
    fun editTagGroups(): TagGroupsEditorProxy {
        PluginLogger.logCall("editTagGroups")
        return TagGroupsEditorProxy(UAirship.shared().contact.editTagGroups())
    }

    @method
    fun editAttributes(): AttributesEditorProxy {
        PluginLogger.logCall("editAttributes")
        return AttributesEditorProxy(UAirship.shared().contact.editAttributes())
    }

    @method
    fun editSubscriptionLists(): ScopedSubscriptionListEditorProxy {
        PluginLogger.logCall("editAttributes")
        return ScopedSubscriptionListEditorProxy(UAirship.shared().contact.editSubscriptionLists())
    }

    @method
    fun fetchSubscriptionLists(function: KrollFunction) {
        PluginLogger.logCall("fetchSubscriptionLists", function)
        UAirship.shared().contact.getSubscriptionLists(true)
            .addResultCallback { result: Map<String?, Set<Scope?>?>? ->
                val returnResult = KrollDict()
                if (result == null) {
                    returnResult["error"] = "Failed to fetch subscription lists"
                } else {
                    returnResult.putJson("subscriptions", JsonValue.wrapOpt(result))
                }
                function.call(getKrollObject(), returnResult)
            }
    }
}