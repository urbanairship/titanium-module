# Airship Titanium Module API

## Events

### EVENT_CHANNEL_UPDATED

Event sent when the channel is updated or created.
 - channelId: String. The channel ID of the app instance.
 - deviceToken: (deprecated, iOS only) String. The device token.
 - pushToken: String. The push token.

```
    Airship.addEventListener(Airship.EVENT_CHANNEL_UPDATED, function(e) {
        Ti.API.info('Channel Updated: ' + e.channelId)
    })
```

### EVENT_NOTIFICATION_OPT_IN_CHANGED

Event sent when the notification opt-in status changes.
- optIn: Boolean. True if the notifications are opted-in, otherwise false.
- authorizedSettings: Object. iOS Only.
    - alert: Boolean. True if alert is allowed, otherwise false.
    - badge: Boolean. True if badge is allowed, otherwise false.
    - sound: Boolean. True if sound is allowed, otherwise false.
    - criticalAlert: Boolean. True if critical alerts are allowed, otherwise false.
    - announcement: Boolean. True if announcements is allowed, otherwise false.
    - lockScreen: Boolean. True if lock screen notifications are allowed, otherwise false.
    - notificationCenter: Boolean. True if notification center notifications are allowed, otherwise false.
    - carPlay: Boolean. True if car play notifications are allowed, otherwise false.

```
    Airship.addEventListener(Airship.EVENT_NOTIFICATION_OPT_IN_CHANGED, function(e) {
        Ti.API.info('OptIn: ' + e.optIn)
    })
```

### EVENT_PUSH_RECEIVED

Event sent when a push is received.
 - message: String. The message's alert.
 - title: String. The message's title.
 - extras: Object. The message's extras.
 - notificationId: String. The notification ID.
 - receivedInForeground: Boolean. True if received in foreground, otherwise false.

```
    Airship.addEventListener(Airship.EVENT_PUSH_RECEIVED, function(e) {
        Ti.API.info('Push received: ' + e.message)
    })
```

### EVENT_NOTIFICATION_RESPONSE

Event sent when a notification response is received.
 - message: String. The message's alert.
 - title: String. The message's title.
 - extras: Object. The message's extras.
 - notificationId: String. The notification ID. On Android, this will either be "<TAG>:<ID>" or just "<ID>".
 - actionId: String. The button action Id if a button was tapped.
 - isForeground: Boolean. True if the response will foreground app, otherwise false.

```
    Airship.addEventListener(Airship.EVENT_NOTIFICATION_RESPONSE, function(e) {
        Ti.API.info('Notification response: ' + e.message)
    })
```

### EVENT_DEEP_LINK_RECEIVED

Event when a deep link is received.
 - deepLink: The deep link.

```
    Airship.addEventListener(Airship.EVENT_DEEP_LINK_RECEIVED, function(e) {
        Ti.API.info('DeepLink: ' + e.deepLink)
    })
```

## Properties

### channelId

Returns the app's channel ID. The channel ID might not be immediately available on a new install. Use
the EVENT_CHANNEL_UPDATED event to be notified when it becomes available.

```
    Ti.API.info('Channel ID: ' + Airship.channelId);
```

### pushToken

Returns the app's push token
```
    Ti.API.info('Push token: ' + Airship.pushToken);
```

### userNotificationsEnabled

Enables or disables user notifications. On iOS, user notifications can only be enabled and enabling
notifications the first time will prompt the user to enable notifications.

```
    Airship.userNotificationsEnabled = true;
```

### isUserNotificationsOptedIn

Checks if notifications are currently opted-in.

```
    Ti.API.info('Notifications opted-in:' + Airship.isUserNotificationsOptedIn);
```

### tags

Sets or gets the channel tags. Tags can be used to segment the audience. Applications
should use createChannelTagEditor() to add or remove tags.

```
    Airship.tags = ["test", "titanium"]

    Airship.tags.forEach(function(tag) {
        Ti.API.info("Tag: " + tag)
    });
```

### namedUser

Sets the namedUser for the device.

```
    Airship.namedUser = "totes mcgoats"
```

### isDataCollectionEnabled

Enables or disables data collection. To require data be opted in before collected, set
`com.urbanairship.data_collection_opt_in_enabled` to true in the app's config. Disabling
data collection disables tags, attributes, analytics, named user, and push. To allow the user to still receive broadcast pushes, set `isPushTokenRegistrationEnabled` to true.

```
    Airship.isDataCollectionEnabled = true
```

### isPushTokenRegistrationEnabled

Enables or disables push token registration. This value defaults to the current value of `isDataCollectionEnabled`. Can be used to enable broadcast push and still have data collection disabled.

```
    Airship.isPushTokenRegistrationEnabled = true
```

### isInAppAutomationPaused

Pauses or resumes In-App messaging.

```
    Airship.isInAppAutomationPaused = true
```

### authorizedNotificationSettings (iOS only)

Returns the authorized notification settings object:

- alert: Boolean. True if alert is allowed, otherwise false.
- badge: Boolean. True if badge is allowed, otherwise false.
- sound: Boolean. True if sound is allowed, otherwise false.
- criticalAlert: Boolean. True if critical alerts are allowed, otherwise false.
- announcement: Boolean. True if announcements is allowed, otherwise false.
- lockScreen: Boolean. True if lock screen notifications are allowed, otherwise false.
- notificationCenter: Boolean. True if notification center notifications are allowed, otherwise false.
- carPlay: Boolean. True if car play notifications are allowed, otherwise false.

```
    Ti.API.info("Authorized settings: " + JSON.stringify(Airship.authorizedNotificationSettings)
```

### authorizedNotificationStatus (iOS only)

Returns the authorized notification status. One of: "denied", "provisional", "authorized", or "not_determined".

```
    Ti.API.info("Authorized status: " + Airship.authorizedNotificationStatus)
```

### isAutoBadgeEnabled (iOS only)

Property to enable auto badge on iOS.

```
    Airship.isAutoBadgeEnabled = true
```

### badgeNumber (iOS only)

The badge number on iOS.

```
    Airship.badgeNumber = 3
```

## Methods

### enableUserNotifications(callback)

Enables user notifications with a callback with the result.


```
    Airship.enableUserNotifications((function(result) {
        Ti.API.info("Notifications Enabled: " + result.success)
    })
```

### createChannelTagsEditor()

The tag editor allows adding and removing tags on the channel.

```
    var editor = Airship.createChannelTagsEditor()
    editor.clearTags()
    editor.addTags("neat", "rad")
    editor.removeTags("cool")
    editor.applyTags()
```

### createChannelTagGroupEditor()

The tag editor allows editing channel tag groups.

```
    var editor = Airship.createChannelTagGroupsEditor()
    editor.addTags("group", "neat", "rad")
    editor.removeTags("group", "cool")
    editor.setTags("another group", "awesome")
    editor.applyTags()
```

### createNamedUserTagGroupEditor()

The tag editor allows editing named user tag groups.

```
    var editor = Airship.createNamedUserTagGroupsEditor()
    editor.addTags("group", "neat", "rad")
    editor.removeTag("group", "cool")
    editor.setTags("another group", "awesome")
    editor.applyTags()
```

### createNamedUserAttributesEditor()

The attributes editor allows editing named user attributes. The supported attribute types are
String, Number, and Date.

```
    var editor = Airship.createNamedUserAttributesEditor()
    editor.setAttribute("name", "gary")
    editor.setAttribute("current date", new Date())
    editor.setAttribute("level", 3)
    editor.removeAttribute("legacy_name")
    editor.applyAttributes()
```

### createChannelAttributesEditor()

The attributes editor allows editing channel attributes. The supported attribute types are
String, Number, and Date.

```
    var editor = Airship.createChannelAttributesEditor()
    editor.setAttribute("name", "gary")
    editor.setAttribute("current date", new Date())
    editor.setAttribute("level", 3)
    editor.removeAttribute("legacy_name")
    editor.applyAttributes()
```

### getLaunchNotification([clear])

Gets the notification that launched the app. The notification will have the following:
 - message: The push alert message.
 - extras: Map of all the push extras.
 - notificationId: (Android only) The ID of the posted notification.

`clear` is used to prevent getLaunchNotification from returning the notification again.


```
    Ti.API.info("Launch notification: " + Airship.getLaunchNotification(false).message);
```

### getDeepLink([clear])

Gets the deep link that launched the app.

`clear` is used to prevent getDeepLink from returning the deepLink again.

```
    Ti.API.info("Deep link: " + Airship.getDeepLink(false))
```

### displayMessageCenter()

Displays the message center.

```
    Airship.displayMessageCenter()
```

### associateIdentifier(key, identifier)

Associate a custom identifier.
Previous identifiers will be replaced by the new identifiers each time associateIdentifier is called.
It is a set operation.
 - key: The custom key for the identifier as a string.
 - identifier: The value of the identifier as a string, or `null` to remove the identifier.

```
    Airship.associateIdentifier("customKey", "customIdentifier")
```

### addCustomEvent(eventPayload)

Adds a custom event.
 - eventPayload: The custom event object.

```
    var customEvent = {
      event_name: 'customEventName',
      event_value: 2016,
      transaction_id: 'customTransactionId',
      interaction_id: 'customInteractionId',
      interaction_type: 'customInteractionType',
      properties: {
        someBoolean: true,
        someDouble: 124.49,
        someString: "customString",
        someInt: 5,
        someLong: 1234567890,
        someArray: ["tangerine", "pineapple", "kiwi"]
      }
    }

    Airship.addCustomEvent(customEventPayload)
```

### trackScreen(screenName)

Screen tracking event.

```
    Airship.trackScreen("home")
```

### resetBadge() (iOS only)

Resets the badge on iOS.

```
    Airship.resetBadge()
```
