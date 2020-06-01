package ti.airship.tags;

import com.urbanairship.UAirship;
import com.urbanairship.channel.TagEditor;
import com.urbanairship.channel.TagGroupsEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.AirshipTitaniumModule;
import ti.airship.Utils;

@Kroll.proxy(creatableInModule = AirshipTitaniumModule.class)
public class ChannelTagGroupsEditorProxy extends KrollProxy {

    private final TagGroupsEditor editor = UAirship.shared().getChannel().editTagGroups();

    @Kroll.method
    public void removeTags(String group, Object[] args) {
        editor.removeTags(group, Utils.convertToStringSet(args));
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
