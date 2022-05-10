/* Copyright Airship and Contributors */

package ti.airship.components;

import com.urbanairship.UAirship;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.Locale;

import ti.airship.utils.PluginLogger;
import ti.airship.utils.Utils;

@Kroll.proxy
public class LocaleProxy extends KrollProxy {

    @Kroll.method
    @Kroll.getProperty
    public String getCurrentLocale() {
        return UAirship.shared().getLocale().toString();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setCurrentLocale(String localeId) {
        PluginLogger.logCall("setCurrentLocale", localeId);
        Utils.checkNotEmpty(localeId);
        UAirship.shared().setLocaleOverride(new Locale(localeId));
    }

    @Kroll.method
    public void clearLocale() {
        PluginLogger.logCall("clearLocale");
        UAirship.shared().setLocaleOverride(null);
    }
}
