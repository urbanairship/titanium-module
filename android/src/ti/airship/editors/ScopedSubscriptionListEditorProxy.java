/* Copyright Airship and Contributors */

package ti.airship.editors;

import androidx.annotation.NonNull;

import com.urbanairship.contacts.Scope;
import com.urbanairship.contacts.ScopedSubscriptionListEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.Locale;

@Kroll.proxy
public class ScopedSubscriptionListEditorProxy extends KrollProxy {

    private final ScopedSubscriptionListEditor editor;

    public ScopedSubscriptionListEditorProxy(@NonNull ScopedSubscriptionListEditor editor) {
        this.editor = editor;
    }
    @Kroll.method
    public ScopedSubscriptionListEditorProxy subscribe(String subscriptionList, String scopeString) {
        Scope scope = Scope.valueOf(scopeString.toUpperCase(Locale.ROOT));
        editor.subscribe(subscriptionList, scope);
        return this;
    }

    @Kroll.method
    public ScopedSubscriptionListEditorProxy unsubscribe(String subscriptionList, String scopeString) {
        Scope scope = Scope.valueOf(scopeString.toUpperCase(Locale.ROOT));
        editor.unsubscribe(subscriptionList, scope);
        return this;
    }

    @Kroll.method
    public void apply() {
        editor.apply();
    }
}
