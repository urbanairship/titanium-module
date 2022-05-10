/* Copyright Airship and Contributors */

package ti.airship.components;

import com.urbanairship.UAirship;
import com.urbanairship.json.JsonValue;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollFunction;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.Collections;

import ti.airship.utils.PluginLogger;
import ti.airship.utils.Utils;
import ti.airship.editors.AttributesEditorProxy;
import ti.airship.editors.SubscriptionListEditorProxy;
import ti.airship.editors.TagGroupsEditorProxy;

@Kroll.proxy
public class ChannelProxy extends KrollProxy {

    @Kroll.method
    @Kroll.getProperty
    public String getIdentifier() {
        return UAirship.shared().getChannel().getId();
    }

    @Kroll.method
    @Kroll.getProperty
    public Object[] getTags() {
        return UAirship.shared().getChannel().getTags().toArray();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setTags(Object[] tags) {
        PluginLogger.logCall("setTags", tags);
        if (tags == null) {
            UAirship.shared().getChannel().setTags(Collections.emptySet());
        } else {
            UAirship.shared().getChannel().setTags(Utils.convertToStringSet(tags));
        }
    }

    @Kroll.method
    public TagGroupsEditorProxy editTagGroups() {
        PluginLogger.logCall("editTagGroups");
        return new TagGroupsEditorProxy(UAirship.shared().getChannel().editTagGroups());
    }

    @Kroll.method
    public AttributesEditorProxy editAttributes() {
        PluginLogger.logCall("editAttributes");
        return new AttributesEditorProxy(UAirship.shared().getChannel().editAttributes());
    }

    @Kroll.method
    public SubscriptionListEditorProxy editSubscriptionLists() {
        PluginLogger.logCall("editAttributes");
        return new SubscriptionListEditorProxy(UAirship.shared().getChannel().editSubscriptionLists());
    }

    @Kroll.method
    public void fetchSubscriptionLists(KrollFunction function) {
        PluginLogger.logCall("fetchSubscriptionLists", function);
        Utils.checkNotNull(function);

        UAirship.shared().getChannel().getSubscriptionLists(true).addResultCallback(result -> {
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
