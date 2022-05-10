/* Copyright Airship and Contributors */

package ti.airship.components;

import com.urbanairship.UAirship;
import com.urbanairship.json.JsonValue;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollFunction;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.utils.PluginLogger;
import ti.airship.utils.Utils;
import ti.airship.editors.AttributesEditorProxy;
import ti.airship.editors.ScopedSubscriptionListEditorProxy;
import ti.airship.editors.TagGroupsEditorProxy;

@Kroll.proxy
public class ContactProxy extends KrollProxy {

    @Kroll.method
    public void identify(String identifier) {
        PluginLogger.logCall("identify", identifier);
        Utils.checkNotEmpty(identifier);
        UAirship.shared().getContact().identify(identifier);
    }

    @Kroll.method
    public void reset() {
        PluginLogger.logCall("reset");
        UAirship.shared().getContact().reset();
    }

    @Kroll.method
    public TagGroupsEditorProxy editTagGroups() {
        PluginLogger.logCall("editTagGroups");
        return new TagGroupsEditorProxy(UAirship.shared().getContact().editTagGroups());
    }

    @Kroll.method
    public AttributesEditorProxy editAttributes() {
        PluginLogger.logCall("editAttributes");
        return new AttributesEditorProxy(UAirship.shared().getContact().editAttributes());
    }

    @Kroll.method
    public ScopedSubscriptionListEditorProxy editSubscriptionLists() {
        PluginLogger.logCall("editAttributes");
        return new ScopedSubscriptionListEditorProxy(UAirship.shared().getContact().editSubscriptionLists());
    }

    @Kroll.method
    public void fetchSubscriptionLists(KrollFunction function) {
        PluginLogger.logCall("fetchSubscriptionLists", function);
        Utils.checkNotNull(function);

        UAirship.shared().getContact().getSubscriptionLists(true).addResultCallback(result -> {
            KrollDict returnResult = new KrollDict();
            if (result == null) {
                returnResult.put("error", "Failed ot fetch subscription lists");
            } else {
                Utils.put(returnResult, "subscriptions", JsonValue.wrapOpt(result));
            }

            function.call(getKrollObject(), returnResult);
        });
    }
}
