/* Copyright Airship and Contributors */

package ti.airship.components;

import com.urbanairship.preferencecenter.PreferenceCenter;

import org.appcelerator.kroll.KrollFunction;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import ti.airship.utils.PluginLogger;
import ti.airship.utils.PluginStore;
import ti.airship.utils.Utils;

@Kroll.proxy
public class PreferenceCenterProxy extends KrollProxy {

    @Kroll.method
    public void display(String preferenceCenterId) {
        PluginLogger.logCall("display", preferenceCenterId);
        Utils.checkNotNull(preferenceCenterId);
        PreferenceCenter.shared().open(preferenceCenterId);
    }

    @Kroll.method
    public void setUseCustomPreferenceCenter(String preferenceCenterId, boolean useCustom) {
        PluginLogger.logCall("setUseCustomPreferenceCenter", preferenceCenterId, useCustom);
        Utils.checkNotNull(preferenceCenterId);
        PluginStore.shared(getActivity()).setUseCustomPreferenceCenter(preferenceCenterId, useCustom);
    }

    @Kroll.method
    public void getConfig(String preferenceCenterId, KrollFunction function) {
        PluginLogger.logCall("getConfig", preferenceCenterId, function);
        Utils.checkNotNull(preferenceCenterId);
        Utils.checkNotNull(function);

        PreferenceCenter.shared().getJsonConfig(preferenceCenterId).addResultCallback(result -> {
            function.callAsync(getKrollObject(), new Object[] { Utils.convert(result) });
        });
    }
}
