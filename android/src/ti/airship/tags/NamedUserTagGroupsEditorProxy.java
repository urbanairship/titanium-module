/* Copyright Airship and Contributors */

package ti.airship.tags;

import com.urbanairship.UAirship;
import com.urbanairship.channel.TagGroupsEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.AirshipTitaniumModule;
import ti.airship.Utils;

@Kroll.proxy(creatableInModule = AirshipTitaniumModule.class)
public class NamedUserTagGroupsEditorProxy extends KrollProxy {

    private final TagGroupsEditor editor = UAirship.shared().getNamedUser().editTagGroups();

    @Kroll.method
    public void removeTags(String group, Object[] tags) {
        editor.removeTags(group, Utils.convertToStringSet(tags));
    }

    @Kroll.method
    public void addTags(String group, Object[] tags) {
        editor.addTags(group, Utils.convertToStringSet(tags));
    }

    @Kroll.method
    public void setTags(String group, Object[] tags) {
        editor.setTags(group, Utils.convertToStringSet(tags));
    }

    @Kroll.method
    public void applyTags() {
        editor.apply();
    }
}
