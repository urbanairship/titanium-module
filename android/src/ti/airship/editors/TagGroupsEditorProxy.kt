/* Copyright Airship and Contributors */
package ti.airship.editors

import com.urbanairship.channel.TagGroupsEditor
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.utils.PluginLogger

@proxy
class TagGroupsEditorProxy(private val editor: TagGroupsEditor) : KrollProxy() {
    @method
    fun addTags(group: String, tags: Any): TagGroupsEditorProxy {
        PluginLogger.logCall("add", group, tags)
        editor.addTags(group, parseTags(tags))
        return this
    }

    @method
    fun removeTags(group: String, tags: Any): TagGroupsEditorProxy {
        PluginLogger.logCall("remove", group, tags)
        editor.removeTags(group, parseTags(tags))
        return this
    }

    @method
    fun setTags(group: String, tags: Any): TagGroupsEditorProxy {
        PluginLogger.logCall("set", group, tags)
        editor.setTags(group, parseTags(tags))
        return this
    }

    @method
    fun apply() {
        PluginLogger.logCall("apply")
        editor.apply()
    }

    private fun parseTags(arg: Any): Set<String> {
        return  when (arg) {
            is Array<*> -> arg.map { value -> value.toString() }.toSet()
            is String -> setOf(arg)
            else -> throw IllegalArgumentException("Invalid tag: $arg")
        }
    }
}