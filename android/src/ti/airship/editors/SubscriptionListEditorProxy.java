/* Copyright Airship and Contributors */

package ti.airship.editors;

import androidx.annotation.NonNull;

import com.urbanairship.channel.SubscriptionListEditor;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

@Kroll.proxy
public class SubscriptionListEditorProxy extends KrollProxy {
    private final SubscriptionListEditor editor;

    public SubscriptionListEditorProxy(@NonNull SubscriptionListEditor editor) {
        this.editor = editor;
    }

    @Kroll.method
    public SubscriptionListEditorProxy subscribe(String subscriptionList) {
        editor.subscribe(subscriptionList);
        return this;
    }

    @Kroll.method
    public SubscriptionListEditorProxy unsubscribe(String subscriptionList) {
        editor.unsubscribe(subscriptionList);
        return this;
    }

    @Kroll.method
    public void apply() {
        editor.apply();
    }
}