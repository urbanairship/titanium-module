/*
 Copyright 2016 Urban Airship and Contributors
*/

package com.urbanairship.ti;

import android.app.Activity;

import com.urbanairship.Autopilot;
import com.urbanairship.richpush.RichPushInbox;
import com.urbanairship.UAirship;
import com.urbanairship.push.PushMessage;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.Log;
import org.appcelerator.titanium.TiApplication;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

@Kroll.module(name = "UrbanAirship", id = "com.urbanairship")
public class UrbanAirshipModule extends KrollModule {
    
    @Kroll.constant
    public static final String EVENT_CHANNEL_UPDATED = "EVENT_CHANNEL_UPDATED";

    @Kroll.constant
    public static final String EVENT_PUSH_RECEIVED = "PUSH_RECEIVED";

    private static final String TAG = "UrbanAirshipModule";

    private static final String MODULE_NAME = "UrbanAirship";

    // Stores the launch notification
    private static PushMessage launchPushMessage = null;
    private static Integer launchNotificationId = null;

    public UrbanAirshipModule() {
        super(MODULE_NAME);
    }

    @Kroll.onAppCreate
    public static void onAppCreate(TiApplication app) {
        Autopilot.automaticTakeOff(app);
    }

    @Kroll.method
    @Kroll.getProperty
    public String getChannelId() {
        return UAirship.shared().getPushManager().getChannelId();
    }

    @Kroll.getProperty
    public HashMap getLaunchNotification() {
        return getLaunchNotification(false);
    }

    @Kroll.method
    public HashMap getLaunchNotification(@Kroll.argument(optional=true) boolean clear) {
        HashMap pushMap = createPushEvent(launchPushMessage, launchNotificationId);

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
        return UAirship.shared().getPushManager().getNamedUser().getId();
    }

    @Kroll.method
    @Kroll.setProperty
    public void setNamedUser(String namedUser) {
        UAirship.shared().getPushManager().getNamedUser().setId(namedUser);
    }

    @Kroll.method 
    @Kroll.getProperty
    public Object[] getTags() {
        return UAirship.shared().getPushManager().getTags().toArray();
    }
    
    @Kroll.method
    @Kroll.setProperty
    public void setTags(Object[] tags) {
        HashSet<String> tagSet = new HashSet<String>();
        for (Object tag : tags) {
            tagSet.add(String.valueOf(tag));
        }
        UAirship.shared().getPushManager().setTags(tagSet);
    }

    @Kroll.method
    public void displayMessageCenter() {
        UAirship.shared().getInbox().startInboxActivity();
    }

    public static void onPushReceived(PushMessage message, Integer notificationId) {
        UrbanAirshipModule module = getModule();
        if (module != null) {
            module.fireEvent(EVENT_PUSH_RECEIVED, createPushEvent(message, notificationId));
        }
    }

    public static void onNotificationOpened(PushMessage message, int notificationId) {
        launchNotificationId = notificationId;
        launchPushMessage = message;
    }

    public static void onChannelUpdated(String channelId) {
        UrbanAirshipModule module = getModule();
        if (module != null) {
            HashMap<String, String> event = new HashMap<String, String>();
            event.put("channelId", channelId);
            module.fireEvent(EVENT_CHANNEL_UPDATED, event);
        }
    }

    private static UrbanAirshipModule getModule() {
        return (UrbanAirshipModule)TiApplication.getInstance().getModuleByName(MODULE_NAME);
    }

    private static HashMap createPushEvent(PushMessage message, Integer notificationId) {
        HashMap<String, Object> pushMap = new HashMap<String, Object>();
        if (message == null) {
            return pushMap;
        }

        Map<String, String> extras = new HashMap<String, String>();
        for (String key : message.getPushBundle().keySet()) {
            if ("android.support.content.wakelockid".equals(key)) {
                continue;
            }
            if ("google.sent_time".equals(key)) {
                extras.put(key, Long.toString(message.getPushBundle().getLong(key)));
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
