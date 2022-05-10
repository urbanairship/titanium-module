/* Copyright Airship and Contributors */

package ti.airship.components;

import com.urbanairship.automation.InAppAutomation;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.concurrent.TimeUnit;

import ti.airship.utils.PluginLogger;

@Kroll.proxy
public class InAppAutomationProxy extends KrollProxy {

    @Kroll.method
    @Kroll.getProperty
    public boolean getIsPaused() {
        return InAppAutomation.shared().isPaused();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setIsPaused(boolean paused) {
        PluginLogger.logCall("setIsPaused", paused);
        InAppAutomation.shared().setPaused(paused);
    }

    @Kroll.method
    @Kroll.getProperty
    public long getDisplayIntervalMilliseconds() {
        return InAppAutomation.shared().getInAppMessageManager().getDisplayInterval();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setDisplayIntervalMilliseconds(long time) {
        PluginLogger.logCall("setDisplayIntervalMilliseconds", time);
        InAppAutomation.shared().getInAppMessageManager().setDisplayInterval(time, TimeUnit.MILLISECONDS);
    }
}
