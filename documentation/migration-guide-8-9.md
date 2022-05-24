
  
# Plugin 8.x to 9.x migration guide

Version 9.x of the plugin is a major release that breaks the majority of the APIs and how Airship is configured. 

## Configuring Airship

Configuring airship using the `tiapp.xml` file has been removed. You now need to call `takeOff` directly from the app, preferably when the app launches:

```
Airship.takeOff({
	default: {
		appKey: <APP_KEY>
		appSecret: <APP_SECRET>
		logLevel: "debug"
	},
	site: "us",
	enabledFeatures: ["all"],
	urlAllowList: ["*"]
})
```

The new `takeOff` exposes more options than what was previously available in the `xml` file:

Config mapping:
- `com.urbanairship.production_app_key` -> production.appKey
- `com.urbanairship.production_app_secret` -> production.appSecret
- `com.urbanairship.development_app_key` -> development.appKey
- `com.urbanairship.development_app_secret` -> development.appSecret
- `com.urbanairship.site` -> site
- `com.urbanairship.in_production` -> inProduction
- `com.urbanairship.notification_icon` -> android.notificationConfig.icon
- `com.urbanairship.notification_accent_color` -> android.notificationConfig.accentColor
- `com.urbanairship.ios_foreground_notification_presentation_*` -> Replaced by foreground presentation options using `Airship.push.iOS.foregroundPresentationOptions`
- `com.urbanairship.data_collection_opt_in_enabled`: Replaced by `enabledFeatures` see privacy manager for more info.


## Plugin Events

#### EVENT_CHANNEL_UPDATED:

Replaced by `Airship.eventChannelCreated`. This will now only fire when the channel is created.

#### EVENT_DEEP_LINK_RECEIVED

Replaced by `Airship.eventDeepLinkReceived`. The event body is the same.

### EVENT_PUSH_RECEIVED & EVENT_NOTIFICATION_RESPONSE

Replaced by `Airship.eventPushReceived` and `Airship.eventNotificationResponseReceived`. The event body has changed:
- message -> notification.alert
- title -> notification.title
- extras -> extras
- notificationId -> notification.notificationId
- receivedInForeground -> REMOVED
- (Response only) actionId -> actionId
- (Response only) isForeground -> isForeground

#### EVENT_NOTIFICATION_OPT_IN_CHANGED:

Replaced by Airship.eventNotificationOptInStatusChanged. On iOS, instead of a map of authorized setting to a boolean, its now an array of authorized setting names. 

 
### AttributeEditor

#### Moved:
- applyAttributes() -> apply()

### TagGroupEditor:

#### Moved
- applyTags() -> apply()

#### Replaced

**setTag, addTag, removeTag:**

You can now call addTags with either an array or a single tag.

#### Modified

**setTags(group, ...), removeTags(group, ...), addTags(group, ...):**

For tags you can pass a single string or an array of tags as the second parameter.

### TagEditor:

#### Moved
- applyTags() -> apply()

#### Replaced

**addTag, removeTag:**

You can now call addTags with either an array or a single tag.

#### Modified

**removeTags(...), addTags(...):**
For tags you can pass a single string or an array of tags as the parameter.

### Airship:

#### Moved

- channelId -> channel.identifier
- pushToken -> push.pushToken
- userNotificationsEnabled -> push.userNotificationsEnabled
- isInAppAutomationPaused -> inAppAutomation.isPaused
- trackScreen(screen) -> analytics.trackScreen(screen)
- tags -> channel.tags
- enableUserNotifications(callback) -> push.enableUserNotifications(callback)
- displayMessageCenter() -> messageCenter.display()
- isAutoBadgeEnabled -> push.iOS.isAutoBadgeEnabled
- badgeNumber -> push.iOS.badgeNumber
- resetBadge() -> push.iOS.resetBadge()
- createChannelTagsEditor() -> channel.editTags()
- createChannelTagGroupEditor() -> channel.editTagGroups()
- createChannelAttributesEditor() -> channel.editAttributes()
- createChannelTagGroupEditor() -> channel.editTagGroups()
- createNamedUserTagGroupEditor() -> contact.editTagGroups()
- createNamedUserAttributesEditor() -> contact.editAttributes()

#### Replaced

**isUserNotificationsOptedIn, authorizedNotificationSettings:**

You can now get the status using push.notificationStatus. This will return a dictionary with airship and system status:
- airshipOptIn: true/false - Airship channel opt-in
- systemEnabled: true/false - If notifications are enabled at the system level.
- iOS
	- authorizedSettings: The list of authorized settings on iOS
	- authorizedStatus: The authorized status on iOS.

**namedUser:**

Named user is replaced by contact:
- contact.identify(namedUserId): Sets the named user Id
- contact.reset(): Resets the contact
- contact.namedUserId: Read only property for the last named user ID set through the SDK that is still associated with the channel.

**isDataCollectionEnabled & isPushTokenRegistrationEnabled:**

Data collection flags have been replaced with `privacyManager`. Privacy manager gives you more granular control over what data is collected based on enabled features. `isPushTokenRegistrationEnabled` is replaced by enabling/disabling the feature `push`, while `isDataCollectionEnabled` being disabled use to still allow `in_app_automation` and `message_center`.
  
**associateIdentifier(key, value):**

Replaced by `analytics.editAssociatedIdentifiers()`. You can use this method to return an editor that lets you set and remove identifiers. Make sure to call `apply()` on the instance created with `editAssociatedIdentifiers()`:
```
 Airship.editAssociatedIdentifiers()
	 .setIdentifier("foo", "bar")(
	 .apply()
```

**addEvent(dict):**
Replaced by `analytics.newEvent(eventName)`. You can create an event and set properties on the object. Once the event is populated, call `track()` on the instance. 

```
var event = Airship.analytics.newEvent("cool_event_name")
event.eventValue = 100.0
event.eventProperties = {
    "some_json_key": "some_json_value"
}
event.track()
```


#### Removed:

**launchNotification, getLaunchNotification:**

The event `Airship.notificationResponseReceivedEvent` will fire for the launch notification once you add a listener. You can capture the launch notification using that event.  

**getDeepLink(clear):**

The event `Airship.deepLinkReceivedEvent` will fire for the launch notification once you add a listener. You can capture the deep link received using that event.
