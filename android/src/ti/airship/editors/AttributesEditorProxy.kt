/* Copyright Airship and Contributors */
package ti.airship.editors

import com.urbanairship.channel.AttributeEditor
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.utils.PluginLogger
import java.util.*

@proxy
class AttributesEditorProxy(private val editor: AttributeEditor) : KrollProxy() {
    @method
    fun setAttribute(attribute: String, value: Any): AttributesEditorProxy {
        PluginLogger.logCall("set", attribute)
        when (value) {
            is String -> editor.setAttribute(attribute, value)
            is Double -> editor.setAttribute(attribute, value)
            is Float -> editor.setAttribute(attribute, value)
            is Int -> editor.setAttribute(attribute, value)
            is Date -> editor.setAttribute(attribute, value)
            is Number -> editor.setAttribute(attribute, value.toDouble())
        }
        return this
    }

    @method
    fun removeAttribute(attribute: String): AttributesEditorProxy {
        PluginLogger.logCall("remove", attribute)
        editor.removeAttribute(attribute)
        return this
    }

    @method
    fun apply() {
        PluginLogger.logCall("apply")
        editor.apply()
    }
}