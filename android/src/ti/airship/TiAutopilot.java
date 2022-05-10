/* Copyright Airship and Contributors */

package ti.airship;

import android.content.Context;

import androidx.annotation.NonNull;

import com.urbanairship.AirshipConfigOptions;
import com.urbanairship.Autopilot;
import com.urbanairship.UAirship;
import com.urbanairship.analytics.Analytics;
import com.urbanairship.app.GlobalActivityMonitor;
import com.urbanairship.json.JsonMap;

import ti.airship.utils.ConfigUtils;
import ti.airship.utils.PluginLogger;
import ti.airship.utils.PluginStore;

public class TiAutopilot extends Autopilot {

    private static final String VERSION = "10.0.0";

    private AirshipConfigOptions configOptions;

    @Override
    public void onAirshipReady(@NonNull UAirship airship) {
        PluginLogger.setLogLevel(airship.getAirshipConfigOptions().logLevel);
        airship.getAnalytics().registerSDKExtension(Analytics.EXTENSION_TITANIUM, VERSION);

        TiAirshipListener listener = TiAirshipListener.newListener(GlobalActivityMonitor.shared(UAirship.getApplicationContext()));
        airship.getChannel().addChannelListener(listener);
        airship.getPushManager().addPushListener(listener);
        airship.getPushManager().setNotificationListener(listener);
    }

    @Override
    public boolean isReady(@NonNull Context context) {
        configOptions = loadConfig(context);
        if (configOptions == null) {
            return false;
        }

        try {
            configOptions.validate();
            return true;
        } catch (Exception e) {
            PluginLogger.error(e, "Unable to takeOff");
            return false;
        }
    }

    private AirshipConfigOptions loadConfig(@NonNull Context context) {
        JsonMap config = PluginStore.shared(context).getAirshipConfig();
        if (config == null) {
            return null;
        }
        return ConfigUtils.parseConfig(context, config);
    }

    @Override
    public AirshipConfigOptions createAirshipConfigOptions(@NonNull Context context) {
        return configOptions;
    }
}
