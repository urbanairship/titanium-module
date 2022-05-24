/* Copyright Airship and Contributors */

package ti.airship.components

import com.urbanairship.UAirship
import com.urbanairship.json.JsonValue
import org.appcelerator.kroll.KrollDict
import org.appcelerator.kroll.KrollFunction
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.*
import ti.airship.editors.AttributesEditorProxy
import ti.airship.editors.SubscriptionListEditorProxy
import ti.airship.editors.TagGroupsEditorProxy
import ti.airship.editors.TagsEditorProxy
import ti.airship.utils.PluginLogger
import ti.airship.utils.putJson
import ti.airship.utils.toStringSet

@proxy
class ChannelProxy : KrollProxy() {
    @get:getProperty
    @get:method
    val identifier: String?
        get() = UAirship.shared().channel.id

    @get:getProperty
    @set:setProperty
    var tags: Array<String>?
        get() = UAirship.shared().channel.tags.toTypedArray()
        set(value) {
            PluginLogger.logCall("tags", tags)
            UAirship.shared().channel.tags = value?.toSet() ?: emptySet()
        }

    @method
    fun editTags(): TagsEditorProxy {
        PluginLogger.logCall("editTags")
        return TagsEditorProxy(UAirship.shared().channel.editTags())
    }

    @method
    fun editTagGroups(): TagGroupsEditorProxy {
        PluginLogger.logCall("editTagGroups")
        return TagGroupsEditorProxy(UAirship.shared().channel.editTagGroups())
    }

    @method
    fun editAttributes(): AttributesEditorProxy {
        PluginLogger.logCall("editAttributes")
        return AttributesEditorProxy(UAirship.shared().channel.editAttributes())
    }

    @method
    fun editSubscriptionLists(): SubscriptionListEditorProxy {
        PluginLogger.logCall("editAttributes")
        return SubscriptionListEditorProxy(UAirship.shared().channel.editSubscriptionLists())
    }

    @method
    fun fetchSubscriptionLists(function: KrollFunction) {
        PluginLogger.logCall("fetchSubscriptionLists", function)
        UAirship.shared().channel.getSubscriptionLists(true)
            .addResultCallback { result: Set<String?>? ->
                val returnResult = KrollDict()
                if (result == null) {
                    returnResult["error"] = "Failed ot fetch subscription lists"
                } else {
                    returnResult.putJson("subscriptions", JsonValue.wrapOpt(result))
                }
                function.call(getKrollObject(), returnResult)
            }
    }
}