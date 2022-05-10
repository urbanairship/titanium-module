 /* Copyright Airship and Contributors */

package ti.airship.editors;

 import androidx.annotation.NonNull;

 import com.urbanairship.analytics.AssociatedIdentifiers;

 import org.appcelerator.kroll.KrollProxy;
 import org.appcelerator.kroll.annotations.Kroll;

 import ti.airship.utils.PluginLogger;
 import ti.airship.utils.Utils;


 @Kroll.proxy
public class AssociatedIdEditorProxy extends KrollProxy {

    private final AssociatedIdentifiers.Editor editor;

    public AssociatedIdEditorProxy(@NonNull AssociatedIdentifiers.Editor editor) {
        this.editor = editor;
    }

    @Kroll.method
    public AssociatedIdEditorProxy set(String name, String value) {
        PluginLogger.logCall("set", value);
        Utils.checkNotNull(name);
        Utils.checkNotNull(value);
        editor.addIdentifier(name, value);
        return this;
    }

    @Kroll.method
    public AssociatedIdEditorProxy remove(String name) {
        PluginLogger.logCall("remove");
        Utils.checkNotNull(name);
        editor.removeIdentifier(name);
        return this;
    }

    @Kroll.method
    public void apply() {
        editor.apply();
    }
}
