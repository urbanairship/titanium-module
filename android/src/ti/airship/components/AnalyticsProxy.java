/* Copyright Airship and Contributors */

package ti.airship.components;

import com.urbanairship.UAirship;
import com.urbanairship.actions.ActionRunRequest;
import com.urbanairship.actions.AddCustomEventAction;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.utils.PluginLogger;
import ti.airship.utils.Utils;
import ti.airship.editors.AssociatedIdEditorProxy;

@Kroll.proxy
public class AnalyticsProxy extends KrollProxy {

    @Kroll.method
    public void trackScreen(String screen) {
        PluginLogger.logCall("trackScreen", screen);
        UAirship.shared().getAnalytics().trackScreen(screen);
    }

    @Kroll.method
    public void addCustomEvent(final Object arg) {
        PluginLogger.logCall("addCustomEvent", arg);
        Utils.checkNotNull(arg);

        ActionRunRequest.createRequest(AddCustomEventAction.DEFAULT_REGISTRY_NAME)
                .setValue(arg)
                .run((arguments, result) -> {
                    if (result.getException() != null) {
                        PluginLogger.error(result.getException(), "Failed to add custom event: %s", arg);
                    }
                });
    }

    @Kroll.method
    public AssociatedIdEditorProxy editAssociatedIdentifiers() {
        PluginLogger.logCall("editAssociatedIdentifiers");
        return new AssociatedIdEditorProxy(UAirship.shared().getAnalytics().editAssociatedIdentifiers());
    }
}
