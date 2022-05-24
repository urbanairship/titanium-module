/* Copyright Airship and Contributors */
package ti.airship.editors

import com.urbanairship.channel.TagEditor
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.utils.PluginLogger

@proxy
class TagsEditorProxy(private val editor: TagEditor) : KrollProxy() {
    @method
    fun addTags(arg: Any): TagsEditorProxy {
        PluginLogger.logCall("add tag", arg)
        editor.addTags(parseTags(arg))
        return this
    }

    @method
    fun removeTags(arg: Any): TagsEditorProxy {
        PluginLogger.logCall("remove", arg)
        editor.removeTags(parseTags(arg))
        return this
    }

    @method
    fun clearTags(): TagsEditorProxy {
        PluginLogger.logCall("clear")
        editor.clear()
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