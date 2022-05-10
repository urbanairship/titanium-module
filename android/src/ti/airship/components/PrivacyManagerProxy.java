/* Copyright Airship and Contributors */

package ti.airship.components;

import com.urbanairship.UAirship;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.List;

import ti.airship.utils.PluginLogger;
import ti.airship.utils.Utils;

@Kroll.proxy
public class PrivacyManagerProxy extends KrollProxy {
    @Kroll.method
    @Kroll.getProperty
    public Object[] getEnabledFeatures() {
        List<String> names = Utils.featureNames(UAirship.shared().getPrivacyManager().getEnabledFeatures());
        return names.toArray();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setEnabledFeatures(Object[] names) {
        PluginLogger.logCall("setEnabledFeatures", names);
        UAirship.shared().getPrivacyManager().setEnabledFeatures(Utils.parseFeature(names));
    }

    @Kroll.method
    public void enable(Object[] names) {
        PluginLogger.logCall("enable", names);
        Utils.checkNotNull(names);
        UAirship.shared().getPrivacyManager().enable(Utils.parseFeature(names));
    }

    @Kroll.method
    public void disable(Object[] names) {
        PluginLogger.logCall("disable", names);
        Utils.checkNotNull(names);
        UAirship.shared().getPrivacyManager().disable(Utils.parseFeature(names));
    }
}
