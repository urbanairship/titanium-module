/* Copyright Airship and Contributors */

package ti.airship.tags;

import com.urbanairship.UAirship;
import com.urbanairship.channel.TagEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.AirshipTitaniumModule;
import ti.airship.Utils;

@Kroll.proxy(creatableInModule = AirshipTitaniumModule.class)
public class ChannelTagsEditorProxy extends KrollProxy {

    private final TagEditor editor = UAirship.shared().getChannel().editTags();

    @Kroll.method
    public void removeTags(Object[] tags) {
        editor.removeTags(Utils.convertToStringSet(tags));
    }

    @Kroll.method
    public void addTags(Object[] tags) {
        editor.addTags(Utils.convertToStringSet(tags));
    }

    @Kroll.method
    public void clearTags() {
        editor.clear();
    }

    @Kroll.method
    public void applyTags() {
        editor.apply();
    }
}
