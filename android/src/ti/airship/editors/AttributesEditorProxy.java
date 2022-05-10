/* Copyright Airship and Contributors */

package ti.airship.editors;

import androidx.annotation.NonNull;

import com.urbanairship.channel.AttributeEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.Date;

@Kroll.proxy
public class AttributesEditorProxy extends KrollProxy {

    private final AttributeEditor editor;

    public AttributesEditorProxy(@NonNull AttributeEditor editor) {
        this.editor = editor;
    }

    @Kroll.method
    public AttributesEditorProxy set(String attribute, Object value) {
        if (value instanceof String) {
            editor.setAttribute(attribute, (String)value);
        } else if (value instanceof Double) {
            editor.setAttribute(attribute, (double)value);
        } else if (value instanceof Float) {
            editor.setAttribute(attribute, (float)value);
        } else if (value instanceof Integer) {
            editor.setAttribute(attribute, (int)value);
        } else if (value instanceof Date) {
            editor.setAttribute(attribute, (Date)value);
        } else if (value instanceof Number) {
            editor.setAttribute(attribute, ((Number)value).doubleValue());
        }
        return this;
    }

    @Kroll.method
    public AttributesEditorProxy remove(String attribute) {
        editor.removeAttribute(attribute);
        return this;
    }

    @Kroll.method
    public void apply() {
        editor.apply();
    }
}
