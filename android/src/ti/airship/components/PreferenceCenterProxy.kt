/* Copyright Airship and Contributors */
package ti.airship.components

import com.urbanairship.json.JsonValue
import com.urbanairship.preferencecenter.PreferenceCenter
import org.appcelerator.kroll.KrollFunction
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.method
import org.appcelerator.kroll.annotations.Kroll.proxy
import ti.airship.utils.PluginLogger
import ti.airship.utils.PluginStore
import ti.airship.utils.toAny
import ti.airship.utils.toKrollDict

@proxy
class PreferenceCenterProxy : KrollProxy() {
    @method
    fun display(preferenceCenterId: String) {
        PluginLogger.logCall("display", preferenceCenterId)
        PreferenceCenter.shared().open(preferenceCenterId)
    }

    @method
    fun setUseCustomPreferenceCenter(preferenceCenterId: String, useCustom: Boolean) {
        PluginLogger.logCall("setUseCustomPreferenceCenter", preferenceCenterId, useCustom)
        PluginStore.shared(getActivity())
            .setUseCustomPreferenceCenter(preferenceCenterId, useCustom)
    }

    @method
    fun getConfig(preferenceCenterId: String, function: KrollFunction) {
        PluginLogger.logCall("getConfig", preferenceCenterId, function)
        PreferenceCenter.shared().getJsonConfig(preferenceCenterId)
            .addResultCallback { result: JsonValue? ->
                val dict = (result ?: JsonValue.NULL).optMap().toKrollDict()
                function.callAsync(getKrollObject(), arrayOf(dict))
            }
    }

}