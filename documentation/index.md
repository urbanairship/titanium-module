# Airship Titanium Module API

## Events

#### EVENT_CHANNEL_UPDATED

Listens for any channel updates. Event contains the following:
 - channelId: The channel ID of the app instance.
 - deviceToken: (iOS only) The device token.

```
    Airship.addEventListener(Airship.EVENT_CHANNEL_UPDATED, function(e) {
        Ti.API.info('Channel Updated: ' + Airship.channelId)
    });
```

#### EVENT_PUSH_RECEIVED

Listens for any push received events. Event contains the following:
 - message: The push alert message.
 - extras: Map of all the push extras.
 - notificationId: (Android only) The ID of the posted notification.

```
    Airship.addEventListener(Airship.EVENT_PUSH_RECEIVED, function(e) {
        Ti.API.info('Push received: ' + e.message);
    });
```

#### EVENT_DEEP_LINK_RECEIVED

Listens for any deep link events. Event contains the following:
 - deepLink: The deep link.

```
    Airship.addEventListener(Airship.EVENT_DEEP_LINK_RECEIVED, function(e) {
        Ti.API.info('DeepLink: ' + e.deepLink);
    });
```

## Properties

#### channelId

Returns the app's channel ID. The channel ID might not be immediately available on a new install. Use
the EVENT_CHANNEL_UPDATED event to be notified when it becomes available.

```
    Ti.API.info('Channel ID: ' + Airship.channelId);
```

#### userNotificationsEnabled

Enables or disables user notifications. On iOS, user notifications can only be enabled and enabling
notifications the first time will prompt the user to enable notifications.

```
    Airship.userNotificationsEnabled = true;
```


#### tags

Sets or gets the channel tags. Tags can be used to segment the audience.

```
    Airship.tags = ["test", "titanium"]

    Airship.tags.forEach(function(tag) {
        Ti.API.info("Tag: " + tag)
    });
```



#### namedUser

Sets the namedUser for the device.

```
    Airship.namedUser = "totes mcgoats"
```

## Methods

### createChannelTagsEditor

The tag editor allows adding and removing tags on the channel.

```
    var editor = Airship.createChannelTagsEditor()
    editor.clearTags()
    editor.addTags("neat", "rad")
    editor.removeTags("cool")
    editor.applyTags()
```

### createChannelTagGroupEditor

The tag editor allows editing channel tag groups.

```
    var editor = Airship.createChannelTagGroupsEditor()
    editor.addTags("group", "neat", "rad")
    editor.removeTags("group", "cool")
    editor.setTags("another group", "awesome")
    editor.applyTags()
```

### createNamedUserTagGroupEditor

The tag editor allows editing named user tag groups.

```
    var editor = Airship.createNamedUserTagGroupsEditor()
    editor.addTags("group", "neat", "rad")
    editor.removeTag("group", "cool")
    editor.setTags("another group", "awesome")
    editor.applyTags()
```

### createNamedUserAttributesEditor

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

### createChannelAttributesEditor

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
 - eventPayload: The custom event payload as a string.

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

    var customEventPayload = JSON.stringify(customEvent)
    Airship.addCustomEvent(customEventPayload)
```
