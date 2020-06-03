/* Copyright Airship and Contributors */

package ti.airship.attributes;

import com.urbanairship.UAirship;
import com.urbanairship.channel.AttributeEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.Date;

import ti.airship.AirshipTitaniumModule;

@Kroll.proxy(creatableInModule = AirshipTitaniumModule.class)
public class NamedUserAttributesEditorProxy extends KrollProxy {

    private final AttributeEditor editor = UAirship.shared().getNamedUser().editAttributes();

    @Kroll.method
    public void removeAttribute(String attribute) {
        editor.removeAttribute(attribute);
    }

    @Kroll.method
    public void setAttribute(String attribute, Object value) {
        if (value instanceof Date) {
            editor.setAttribute(attribute, (Date) value);
        } else if (value instanceof String) {
            editor.setAttribute(attribute, (String) value);
        } else if (value instanceof Number) {
            editor.setAttribute(attribute, ((Number) value).doubleValue());
        }
    }

    @Kroll.method
    public void applyAttributes() {
        editor.apply();
    }
}
