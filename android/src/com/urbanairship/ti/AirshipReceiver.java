/*
 Copyright 2016 Urban Airship and Contributors
*/

package com.urbanairship.ti;

import java.util.HashMap;
import java.util.Set;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.urbanairship.push.BaseIntentReceiver;
import com.urbanairship.push.PushMessage;

public class AirshipReceiver extends BaseIntentReceiver {
    private static final String TAG = "AirshipReceiver";

    @Override
    protected void onChannelRegistrationSucceeded(Context context, String channelId) {
        Log.i(TAG, "Channel registration updated. Channel Id:" + channelId + ".");
        UrbanAirshipModule.onChannelUpdated(channelId);
    }

    @Override
    protected void onChannelRegistrationFailed(Context context) {
        Log.i(TAG, "Channel registration failed.");
    }

    @Override
    protected void onPushReceived(Context context, PushMessage message, int notificationId) {
        Log.i(TAG, "Received push notification. Alert: " + message.getAlert() + ". Notification ID: " + notificationId);
        UrbanAirshipModule.onPushReceived(message, notificationId);
    }

    @Override
    protected void onBackgroundPushReceived(Context context, PushMessage message) {
        Log.i(TAG, "Received background push message: " + message);
        UrbanAirshipModule.onPushReceived(message, null);
    }

    @Override
    protected boolean onNotificationOpened(Context context, PushMessage message, int notificationId) {
        Log.i(TAG, "Notification Opened. Alert: " + message.getAlert());
        UrbanAirshipModule.onNotificationOpened(message, notificationId);
        return false;
    }

    @Override
    protected boolean onNotificationActionOpened(Context context, PushMessage message, int notificationId, String buttonId, boolean isForeground) {
        Log.i(TAG, "User clicked notification button. Button ID: " + buttonId + " Alert: " + message.getAlert());
        UrbanAirshipModule.onNotificationOpened(message, notificationId);
        return false;
    }

    @Override
    protected void onNotificationDismissed(Context context, PushMessage message, int notificationId) {
        Log.i(TAG, "Notification dismissed. Alert: " + message.getAlert() + ". Notification ID: " + notificationId);
    }
}