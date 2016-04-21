# Urban Airship Titanium Module


## Contributing Code

We accept pull requests! If you would like to submit a pull request, please fill out and submit a
[Code Contribution Agreement](http://docs.urbanairship.com/contribution-agreement.html).

## Requirements:
 - Android [GCM Setup](http://docs.urbanairship.com/reference/push-providers/gcm.html#android-gcm-setup)
 - iOS [APNS Setup](http://docs.urbanairship.com/reference/push-providers/apns.html)

## Setup

Modify the `tiapp.xml` file to include the Urban Airship Config:

```
  <!-- Production credentials -->
  <property name="com.urbanairship.production_app_key" type="string">Your Production App Key</property>
  <property name="com.urbanairship.production_app_secret" type="string">Your Production App Secret</property>

  <!-- Development credentials -->
  <property name="com.urbanairship.development_app_key" type="string">Your Development App Key</property>
  <property name="com.urbanairship.development_app_secret" type="string">Your Development App Secret</property>

  <!-- Selects between production vs development credentials -->
  <property name="com.urbanairship.in_production" type="bool">false</property>

  <!-- Android -->
  <property name="com.urbanairship.gcm_sender" type="String">GCM Sender ID or Project Number</property>
  <property name="com.urbanairship.notification_icon" type="string">Name of an icon in assets directory, e.g. ic_notification</property>
  <property name="com.urbanairship.notification_accent_color" type="string">Notification accent color, e.g. #ff0000</property>
```

For iOS, enable background remote notifications in the `tiapp.xml` file:

```
  ...
  <ios>
  <plist>
  <dict>    
      ...
       <key>UIBackgroundModes</key>
       <array>
           <string>remote-notification</string>
       </array>
  </dict>
  </plist>
  </ios>
  ...
```

## Accessing the urbanairship Module

To access this module from JavaScript, you would do the following:

```
    var UrbanAirship = require("com.urbanairship");
```

## Events

#### EVENT_CHANNEL_UPDATED

Listens for any channel updates. Event contains the following:
 - channelId: The channel ID of the app instance.
 - deviceToken: (iOS only) The device token.

```
    UrbanAirship.addEventListener(UrbanAirship.EVENT_CHANNEL_UPDATED, new function(e) {
        Ti.API.info('Channel Updated' + e.channelId)
    })
```

#### EVENT_PUSH_RECEIVED

Listens for any push received events. Event contains the following:
 - message: The push alert message.
 - extras: Map of all the push extras.
 - notificationId: (Android only) The ID of the posted notification.

```
    UrbanAirship.addEventListener(UrbanAirship.EVENT_PUSH_RECEIVED, new function(e) {
        Ti.API.info('Push received' + e.message)
    })
```

## Properties

#### channelId

Returns the app's channel ID. The channel ID might not be immediately available on a new install. Use
the EVENT_CHANNEL_UPDATED event to be notified when it becomes available.

```
    Ti.API.info('Channel ID: ' + UrbanAirship.channelId)
```

#### userNotificationsEnabled

Enables or disables user notifications. On iOS, user notifications can only be enabled and enabling
notifications the first time will promopt the user to enable notifications.

```
    UrbanAirship.userNotificationsEnabled = true
```


#### tags

Sets or gets the channel tags. Tags can be used to segment the audience.

```
    UrbanAirship.tags = ["test", "titanium"]

    UrbanAirship.tags.forEach(function(tag) {
        Ti.API.info("Tag: " + tag)
    })
```

#### namedUser

Sets the namedUser for the device.

```
    UrbanAirship.namedUser = "totes mcgoats"
```

## Methods

### getLaunchNotification([clear])

Gets the notification that launched the app. The notification will have the following:
 - message: The push alert message.
 - extras: Map of all the push extras.
 - notificationId: (Android only) The ID of the posted notification.

`clear` is used to prevent getLaunchNotification from returning the notification again.


```
    Ti.API.info("Launch notification: " + UrbanAirship.getLaunchNotification(false).message)
```


### displayMessageCenter()

Displays the message center.

```
    UrbanAirship.displayMessageCenter();
```

