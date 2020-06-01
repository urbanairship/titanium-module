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
import com.urbanairship.push.PushMessage;
import com.urbanairship.util.UAStringUtil;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.Log;
import org.appcelerator.titanium.TiApplication;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

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

    // Store state
    private static PushMessage launchPushMessage = null;
    private static Integer launchNotificationId = null;
    private static String deepLink = null;

    public AirshipTitaniumModule() {
        super(MODULE_NAME);
    }

    @Kroll.onAppCreate
    public static void onAppCreate(TiApplication app) {
        Autopilot.automaticTakeOff(app);
    }

    @Kroll.method
    @Kroll.getProperty
    public String getChannelId() {
        return UAirship.shared().getChannel().getId();
    }

    @Kroll.getProperty
    public HashMap getLaunchNotification() {
        return getLaunchNotification(false);
    }

    @Kroll.method
    public HashMap getLaunchNotification(@Kroll.argument(optional=true) boolean clear) {
        HashMap<String, Object> pushMap = createPushEvent(launchPushMessage, launchNotificationId);

        if (clear) {
            launchNotificationId = null;
            launchPushMessage = null;
        }

        return pushMap;
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
    public void addCustomEvent(final String eventPayload) {
        Log.d(TAG, "Add custom event: " + eventPayload);

        if (UAStringUtil.isEmpty(eventPayload)) {
            Log.e(TAG, "Missing event payload.");
            return;
        }

        JsonMap eventArgs = null;
        try {
            eventArgs = JsonValue.parseString(eventPayload).getMap();
        } catch (JsonException e) {
            Log.e(TAG, "Failed to parse event payload", e);
        }

        if (eventArgs == null) {
            Log.e(TAG, "Event payload must define a JSON object.");
            return;
        }

        ActionRunRequest.createRequest(AddCustomEventAction.DEFAULT_REGISTRY_NAME)
                        .setValue(eventArgs)
                        .run((arguments, result) -> {
                            if (result.getException() != null) {
                                Log.e(TAG, "Failed to add custom event: " + eventPayload, result.getException());
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
    public String getDeepLink(@Kroll.argument(optional=true) boolean clear) {
        String dl = deepLink;

        if (clear) {
          deepLink = null;
        }

        return dl;
    }

    @Kroll.method
    public void displayMessageCenter() {
        MessageCenter.shared().showMessageCenter();
    }

    public static void onPushReceived(PushMessage message, Integer notificationId) {
        AirshipTitaniumModule module = getModule();
        if (module != null) {
            module.fireEvent(EVENT_PUSH_RECEIVED, createPushEvent(message, notificationId));
        }
    }

    public static void onNotificationOpened(PushMessage message, int notificationId) {
        launchNotificationId = notificationId;
        launchPushMessage = message;
    }

    public static void onChannelUpdated(String channelId) {
        AirshipTitaniumModule module = getModule();
        if (module != null) {
            HashMap<String, String> event = new HashMap<>();
            event.put("channelId", channelId);
            module.fireEvent(EVENT_CHANNEL_UPDATED, event);
        }
    }

    public static void deepLinkReceived(String dl) {
      deepLink = dl;
    	AirshipTitaniumModule module = getModule();
        if (module != null) {
            HashMap<String, String> event = new HashMap<String, String>();
            event.put("deepLink", dl);
            module.fireEvent(EVENT_DEEP_LINK_RECEIVED, event);
        }
    }

    private static AirshipTitaniumModule getModule() {
        return (AirshipTitaniumModule)TiApplication.getInstance().getModuleByName(MODULE_NAME);
    }

    private static HashMap<String, Object> createPushEvent(PushMessage message, Integer notificationId) {
        HashMap<String, Object> pushMap = new HashMap<>();
        if (message == null) {
            return pushMap;
        }

        Map<String, String> extras = new HashMap<>();
        for (String key : message.getPushBundle().keySet()) {
            if ("android.support.content.wakelockid".equals(key)) {
                continue;
            }

            if ("google.sent_time".equals(key)) {
                extras.put(key, Long.toString(message.getPushBundle().getLong(key)));
                continue;
            }

            if ("google.ttl".equals(key)) {
                extras.put(key, Integer.toString(message.getPushBundle().getInt(key)));
                continue;
            }

            extras.put(key, message.getPushBundle().getString(key));
        }
        pushMap.put("extras", extras);

        if (message.getAlert() != null) {
            pushMap.put("message", message.getAlert());
        }

        if (notificationId != null) {
            pushMap.put("notificationId", notificationId);
        }

        return pushMap;
    }
}
