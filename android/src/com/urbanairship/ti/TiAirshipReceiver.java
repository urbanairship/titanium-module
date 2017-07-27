/*
 Copyright 2017 Urban Airship and Contributors
*/

package com.urbanairship.ti;

import java.util.HashMap;
import java.util.Set;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.urbanairship.AirshipReceiver;
import com.urbanairship.push.PushMessage;

public class TiAirshipReceiver extends AirshipReceiver {
    private static final String TAG = "TiAirshipReceiver";

    @Override
    protected void onChannelCreated(Context context, String channelId) {
        Log.i(TAG, "Channel created. Channel ID:" + channelId + ".");
        UrbanAirshipModule.onChannelUpdated(channelId);
    }

    @Override
    protected void onChannelUpdated(Context context, String channelId) {
        Log.i(TAG, "Channel updated. Channel ID:" + channelId + ".");
        UrbanAirshipModule.onChannelUpdated(channelId);
    }

    @Override
    protected void onPushReceived(Context context, PushMessage message, boolean notificationPosted) {
        Log.i(TAG, "Received push. Alert: " + message.getAlert());

        if (!notificationPosted) {
            UrbanAirshipModule.onPushReceived(message, null);
        }
    }

    @Override
    protected void onNotificationPosted(Context context, NotificationInfo notificationInfo) {
        Log.i(TAG, "Notification posted. Alert: " + notificationInfo.getMessage().getAlert());
        UrbanAirshipModule.onPushReceived(notificationInfo.getMessage(), notificationInfo.getNotificationId());
    }

    @Override
    protected boolean onNotificationOpened(Context context, NotificationInfo notificationInfo) {
        Log.i(TAG, "Notification Opened. Alert: " + notificationInfo.getMessage().getAlert());
        UrbanAirshipModule.onNotificationOpened(notificationInfo.getMessage(), notificationInfo.getNotificationId());
        return false;
    }

    @Override
    protected boolean onNotificationOpened(Context context, NotificationInfo notificationInfo, ActionButtonInfo actionButtonInfo) {
        Log.i(TAG, "User clicked notification button. Button ID: " + actionButtonInfo.getButtonId() + " Alert: " + notificationInfo.getMessage().getAlert());
        UrbanAirshipModule.onNotificationOpened(notificationInfo.getMessage(), notificationInfo.getNotificationId());
        return false;
    }
}