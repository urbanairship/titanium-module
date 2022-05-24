/* Copyright Airship and Contributors */
package ti.airship.editors

import com.urbanairship.analytics.AssociatedIdentifiers
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.utils.PluginLogger

@proxy
class AssociatedIdEditorProxy(private val editor: AssociatedIdentifiers.Editor) : KrollProxy() {
    @method
    fun setIdentifier(name: String, value: String): AssociatedIdEditorProxy {
        PluginLogger.logCall("set", value)
        editor.addIdentifier(name, value)
        return this
    }

    @method
    fun removeIdentifier(name: String): AssociatedIdEditorProxy {
        PluginLogger.logCall("remove", name)
        editor.removeIdentifier(name)
        return this
    }

    @method
    fun apply() {
        PluginLogger.logCall("apply")
        editor.apply()
    }
}