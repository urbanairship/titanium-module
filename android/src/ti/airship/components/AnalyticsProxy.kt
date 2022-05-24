/* Copyright Airship and Contributors */
package ti.airship.components

import com.urbanairship.UAirship
import com.urbanairship.actions.ActionArguments
import com.urbanairship.actions.ActionResult
import com.urbanairship.actions.ActionRunRequest
import com.urbanairship.actions.AddCustomEventAction
import org.appcelerator.kroll.KrollDict
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.editors.AssociatedIdEditorProxy
import ti.airship.utils.PluginLogger
import ti.airship.utils.toJson

@proxy
class AnalyticsProxy : KrollProxy() {

    @method
    fun trackScreen(screen: String?) {
        PluginLogger.logCall("trackScreen", screen)
        UAirship.shared().analytics.trackScreen(screen)
    }

    @method
    fun newEvent(eventName: String): CustomEventProxy {
        return CustomEventProxy(eventName)
    }

    @method
    fun editAssociatedIdentifiers(): AssociatedIdEditorProxy {
        PluginLogger.logCall("editAssociatedIdentifiers")
        return AssociatedIdEditorProxy(UAirship.shared().analytics.editAssociatedIdentifiers())
    }
}