/* Copyright Airship and Contributors */

package ti.airship;

import com.urbanairship.Autopilot;
import com.urbanairship.UAirship;
import com.urbanairship.actions.ActionRunRequest;
import com.urbanairship.actions.AddCustomEventAction;
import com.urbanairship.json.JsonException;
import com.urbanairship.json.JsonMap;
import com.urbanairship.json.JsonValue;
import com.urbanairship.messagecenter.MessageCenter;
import com.urbanairship.util.UAStringUtil;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.Log;
import org.appcelerator.titanium.TiApplication;

import java.util.HashMap;
import java.util.HashSet;

import ti.airship.events.EventEmitter;

@Kroll.module(name = "AirshipTitanium", id = "ti.airship")
public class AirshipTitaniumModule extends KrollModule {

    @Kroll.constant
    public static final String EVENT_CHANNEL_UPDATED = "EVENT_CHANNEL_UPDATED";

    @Kroll.constant
    public static final String EVENT_DEEP_LINK_RECEIVED = "EVENT_DEEP_LINK_RECEIVED";

    @Kroll.constant
    public static final String EVENT_PUSH_RECEIVED = "PUSH_RECEIVED";

    public static final String TAG = "AirshipTitaniumModule";

    private static final String MODULE_NAME = "AirshipTitanium";

    public AirshipTitaniumModule() {
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
    @Kroll.getProperty
    public String getChannelId() {
        return UAirship.shared().getChannel().getId();
    }

    @Kroll.getProperty
    public Object getLaunchNotification() {
        return getLaunchNotification(false);
    }

    @Kroll.method
    public Object getLaunchNotification(@Kroll.argument(optional = true) boolean clear) {
        TiPush push = TiAirship.shared().getLaunchPush(clear);
        if (push == null) {
            return new HashMap<String, Object>();
        } else {
            return push.toMap();
        }
    }

    @Kroll.method
    @Kroll.getProperty
    public boolean getUserNotificationsEnabled() {
        return UAirship.shared().getPushManager().getUserNotificationsEnabled();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setUserNotificationsEnabled(boolean enabled) {
        UAirship.shared().getPushManager().setUserNotificationsEnabled(enabled);
    }

    @Kroll.method
    @Kroll.getProperty
    public String getNamedUser() {
        return UAirship.shared().getNamedUser().getId();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setNamedUser(String namedUser) {
        UAirship.shared().getNamedUser().setId(namedUser);
    }

    @Kroll.method
    public void trackScreen(String screen) {
        UAirship.shared().getAnalytics().trackScreen(screen);
    }

    @Kroll.method
    @Kroll.setProperty
    public void setIsDataCollectionEnabled(boolean enabled) {
        UAirship.shared().setDataCollectionEnabled(enabled);
    }

    @Kroll.getProperty
    @Kroll.method
    public boolean getIsDataCollectionEnabled() {
        return UAirship.shared().isDataCollectionEnabled();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setIsPushTokenRegistrationEnabled(boolean enabled) {
        UAirship.shared().getPushManager().setPushTokenRegistrationEnabled(enabled);
    }

    @Kroll.getProperty
    @Kroll.method
    public boolean getIsPushTokenRegistrationEnabled() {
        return UAirship.shared().getPushManager().isPushTokenRegistrationEnabled();
    }

    @Kroll.method
    public void associateIdentifier(String key, String identifier) {
        if (key == null) {
            Log.d(TAG, "AssociateIdentifier failed, key cannot be null.");
            return;
        }

        if (identifier == null) {
            Log.d(TAG, "AssociateIdentifier removed identifier for key: " + key);
            UAirship.shared().getAnalytics().editAssociatedIdentifiers().removeIdentifier(key).apply();
        } else {
            Log.d(TAG, "AssociateIdentifier with identifier: " + identifier + " for key: " + key);
            UAirship.shared().getAnalytics().editAssociatedIdentifiers().addIdentifier(key, identifier).apply();
        }
    }

    @Kroll.method
    public void addCustomEvent(final Object arg) {
        Log.d(TAG, "Add custom event: " + arg);
        JsonMap eventArgs = null;

        if (arg instanceof String) {
            String eventPayload = (String) arg;
            if (UAStringUtil.isEmpty(eventPayload)) {
                Log.e(TAG, "Missing event payload.");
                return;
            }
            try {
                eventArgs = JsonValue.parseString(eventPayload).getMap();
            } catch (JsonException e) {
                Log.e(TAG, "Failed to parse event payload", e);
            }

            if (eventArgs == null) {
                Log.e(TAG, "Event payload must define a JSON object.");
                return;
            }
        } else {
            eventArgs = JsonValue.wrapOpt(arg).optMap();
        }

        ActionRunRequest.createRequest(AddCustomEventAction.DEFAULT_REGISTRY_NAME)
                .setValue(eventArgs)
                .run((arguments, result) -> {
                    if (result.getException() != null) {
                        Log.e(TAG, "Failed to add custom event: " + arg, result.getException());
                    }
                });
    }

    @Kroll.method
    @Kroll.getProperty
    public Object[] getTags() {
        return UAirship.shared().getChannel().getTags().toArray();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setTags(Object[] tags) {
        HashSet<String> tagSet = new HashSet<String>();
        for (Object tag : tags) {
            tagSet.add(String.valueOf(tag));
        }
        UAirship.shared().getChannel().setTags(tagSet);
    }

    @Kroll.method
    public String getDeepLink(@Kroll.argument(optional = true) boolean clear) {
        return TiAirship.shared().getDeepLink(clear);
    }

    @Kroll.method
    public void displayMessageCenter() {
        MessageCenter.shared().showMessageCenter();
    }
}
