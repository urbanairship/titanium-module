/* Copyright Airship and Contributors */

package ti.airship.editors;

import androidx.annotation.NonNull;

import com.urbanairship.channel.TagGroupsEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.utils.Utils;

@Kroll.proxy
public class TagGroupsEditorProxy extends KrollProxy {

    private final TagGroupsEditor editor;

    public TagGroupsEditorProxy(@NonNull TagGroupsEditor editor) {
        this.editor = editor;
    }

    @Kroll.method
    public TagGroupsEditorProxy add(String group, Object[] tags) {
        editor.addTags(group, Utils.convertToStringSet(tags));
        return this;
    }

    @Kroll.method
    public TagGroupsEditorProxy remove(String group, Object[] tags) {
        editor.removeTags(group, Utils.convertToStringSet(tags));
        return this;
    }

    @Kroll.method
    public TagGroupsEditorProxy set(String group, Object[] tags) {
        editor.setTags(group, Utils.convertToStringSet(tags));
        return this;
    }

    @Kroll.method
    public void apply() {
        editor.apply();
    }
}
