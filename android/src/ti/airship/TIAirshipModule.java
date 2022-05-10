/* Copyright Airship and Contributors */

package ti.airship;

import com.urbanairship.Autopilot;
import com.urbanairship.UAirship;
import com.urbanairship.actions.ActionRunRequest;
import com.urbanairship.actions.AddCustomEventAction;
import com.urbanairship.automation.InAppAutomation;
import com.urbanairship.json.JsonException;
import com.urbanairship.json.JsonMap;
import com.urbanairship.json.JsonValue;
import com.urbanairship.messagecenter.MessageCenter;
import com.urbanairship.util.UAStringUtil;

import org.appcelerator.kroll.KrollFunction;
import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.Log;
import org.appcelerator.titanium.TiApplication;

import java.util.HashMap;
import java.util.HashSet;

import ti.airship.events.EventEmitter;

@Kroll.module(name = "ti.airship", id = "ti.airship")
public class TIAirshipModule extends KrollModule {

    @Kroll.constant
    public static final String EVENT_CHANNEL_UPDATED = "EVENT_CHANNEL_UPDATED";

    @Kroll.constant
    public static final String EVENT_DEEP_LINK_RECEIVED = "EVENT_DEEP_LINK_RECEIVED";

    @Kroll.constant
    public static final String EVENT_PUSH_RECEIVED = "EVENT_PUSH_RECEIVED";

    @Kroll.constant
    public static final String EVENT_NOTIFICATION_RESPONSE = "EVENT_NOTIFICATION_RESPONSE";

    @Kroll.constant
    public static final String EVENT_NOTIFICATION_OPT_IN_CHANGED = "EVENT_NOTIFICATION_OPT_IN_CHANGED";

    private static final String MODULE_NAME = "AirshipTitanium";

    public TIAirshipModule() {
        super(MODULE_NAME);
    }

    @Kroll.onAppCreate
    public static void onAppCreate(TiApplication app) {
        Autopilot.automaticTakeOff(app);
    }

    @Override
    public void listenerAdded(String type, int count, KrollProxy proxy) {
        super.listenerAdded(type, count, proxy);
        EventEmitter.shared().addListeners(type, count, this);
    }

    @Override
    public void listenerRemoved(String type, int count, KrollProxy proxy) {
        super.listenerRemoved(type, count, proxy);
        EventEmitter.shared().removeListeners(type, count, this);
    }

    @Kroll.method
    public void displayMessageCenter() {
        MessageCenter.shared().showMessageCenter();
    }


}
