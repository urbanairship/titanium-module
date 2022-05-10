/* Copyright Airship and Contributors */

package ti.airship.components;

import androidx.core.app.NotificationManagerCompat;

import com.urbanairship.UAirship;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollFunction;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.utils.PluginLogger;

@Kroll.proxy
public class PushProxy extends KrollProxy {

    @Kroll.method
    public KrollDict getNotificationStatus() {
        PluginLogger.logCall("getNotificationStatus");

        KrollDict dict = new KrollDict();
        dict.put("airshipOptIn", UAirship.shared().getPushManager().isOptIn());
        dict.put("airshipEnabled", UAirship.shared().getPushManager().getUserNotificationsEnabled());
        dict.put("systemEnabled", NotificationManagerCompat.from(getActivity()).areNotificationsEnabled());
        return dict;
    }

    @Kroll.method
    @Kroll.getProperty
    public String getPushToken() {
        return UAirship.shared().getPushManager().getPushToken();
    }

    @Kroll.method
    @Kroll.getProperty
    public boolean getUserNotificationsEnabled() {
        return UAirship.shared().getPushManager().getUserNotificationsEnabled();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setUserNotificationsEnabled(boolean enabled) {
        PluginLogger.logCall("getUserNotificationsEnabled", enabled);
        UAirship.shared().getPushManager().setUserNotificationsEnabled(enabled);
    }

    @Kroll.method
    public void enableUserNotifications(KrollFunction function) {
        PluginLogger.logCall("enableUserNotifications", function);
        UAirship.shared().getPushManager().setUserNotificationsEnabled(true);
        if (function != null) {
            function.callAsync(getKrollObject(), new Boolean[] { UAirship.shared().getPushManager().isOptIn() });
        }
    }

}
