/* Copyright Airship and Contributors */

package ti.airship.editors;

import androidx.annotation.NonNull;

import com.urbanairship.channel.TagEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.utils.Utils;

@Kroll.proxy
public class TagsEditorProxy extends KrollProxy {

    private final TagEditor editor;

    public TagsEditorProxy(@NonNull TagEditor editor) {
        this.editor = editor;
    }

    @Kroll.method
    public TagsEditorProxy add(String tag) {
        editor.addTag(tag);
        return this;
    }

    @Kroll.method
    public TagsEditorProxy add(Object[] tags) {
        editor.addTags(Utils.convertToStringSet(tags));
        return this;
    }

    @Kroll.method
    public TagsEditorProxy remove(String tag) {
        editor.removeTag(tag);
        return this;
    }

    @Kroll.method
    public TagsEditorProxy remove(Object[] tags) {
        editor.removeTags(Utils.convertToStringSet(tags));
        return this;
    }

    @Kroll.method
    public TagsEditorProxy clear() {
        editor.clear();
        return this;
    }

    @Kroll.method
    public void apply() {
        editor.apply();
    }
}
