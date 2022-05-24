# Airship Titanium Module API

## Airship

Top level Airship instance.

### Constants

#### eventChannelCreated

Event sent when the channel created. The event body will include:
 - channelId: String. The channel ID of the app instance.


#### eventNotificationOptInStatusChanged

Event sent when the notification opt-in status changes. The event body will include:
- optIn: Boolean. True if the notifications are opted-in, otherwise false.
- authorizedSettings: Array of authorized settings.

#### eventPushReceived

Event sent when a push is received. The event body will include:
 - payload: The full message payload. Will be different between iOS and Android.
 - notification:
    - title: String. The message's title.
    - alert: String. The message's alert.
    - notificationId: (Android only) String. The notification ID
 - extras: Object. The message's extras.


#### eventNotificationResponseReceived

Event sent when a notification response is received. The event body will include:
 - payload: The full message payload. Will be different between iOS and Android.
 - notification:
    - title: String. The message's title.
    - alert: String. The message's alert.
    - notificationId: (Android only) String. The notification ID.
 - extras: Object. The message's extras.
 - actionId: String. The button action Id if a button was tapped.
 - isForeground: Boolean. True if the response will foreground app, otherwise false.

### logLevelVerbose

Verbose log level.

### logLevelDebug

Debug log level.

### logLevelInfo

Info log level.

### logLevelWarning

Warning log level.

### logLevelError

Error log level.

### logLevelNone

Used to disable logging.

### cloudSiteEu

EU cloud site.

### cloudSiteUs

US cloud site.

### Methods

#### takeOff(config)

Called to initialize the Airship instance. Airship can only be initialized once per app init. Config will be cached and applied to the following app inits. If takeOff is called after Airship is initialized, the config will be applied to the next app run.

config:
 - default: Environment.
 - production: Environment.
 - development: Environment.
 - inProduction: Boolean. true if in production, false if development. If not set, the plugin will auto determine the flag.
 - site: The cloud site. Defaults to US.
 - enabledFeatures: The list of features to enable by default. Use `["none"]` to disable all features.
 - urlAllowList: Array of strings. A list of allow list rules. Use `["*"]` to allow all Urls. Applies to both `urlAllowListScopeOpenUrl` and `urlAllowListScopeJavaScriptInterface`
 - urlAllowListScopeOpenUrl: Array of allow list rules for URLs that the SDK is allowed to open.
 - urlAllowListScopeJavaScriptInterface: Array of allow list rules for URLs that the SDK is should inject the JS interface when loaded in a web view.
 - android
    - appStoreUri: The app store Uri. Used by the rate app action.
    - fcmFirebaseAppName: The firebase app name if using a FCM project other than default.
    - notificationConfig:
        - icon: The notification icon name.
        - largeIcon: The notification large icon name.
        - accentColor: The notification accent color a color string #AARRGGBB
        - defaultChannelId: The default notification channel/category.
 - iOS
    - itunesId: The itunes ID. Used by the rate app action.

Environment:
 - appKey: The app key.
 - appKey: The app secret.
 - logLevel: The log level.

A valid environment is required, everything else is optional. Production and development environment will override default depending.

### Properties 

#### isFlying

Boolean property that indicates if Airship is initialized or not.

#### channel

The channel instance.

#### contact

The contact instance. 

#### push

The push instance.

#### analytics

The analytics instance.

#### locale

The locale instance.

#### inAppAutomation

The in-app automation instance.

#### messageCenter

The message center instance.

#### preferenceCenter

The preference center instance.

#### privacyManager

The privacy manager instance.

## Channel

Provides access to channel level segmentation properties.

### Properties

#### identifier

The channel identifier. The identifier will not be available right away on the first run, use `Airship.eventChannelCreated` to listen for when the channel is created.

#### tags

Sets or gets the channel tags. Tags can be used to segment the audience. Applications
should use Airship.editTags() to add or remove tags.

```
    Airship.channel.tags = ["test", "titanium"]
```

### Methods

#### editTags()

Creates a tag editor instance for the channel. Once edits are done, make sure to call apply on the instance to save changes to the channel.

```
Airship.channel.editTags()
  .addTags(["foo"])
  .removeTags(["cool", "neat"])
  .apply()
```

#### editTagGroups()

Creates a tag group editor instance for the channel. Once edits are done, make sure to call apply on the instance to save changes to the channel.

```
Airship.channel.editTagGroups()
  .addTags("some-group", ["foo"])
  .removeTags("some-other-group", ["cool", "neat"])
  .apply()
```

#### editSubscriptionLists()

Creates a subscription list editor instance for the channel. Once edits are done, make sure to call apply on the instance to save changes to channel.

```
Airship.channel.editSubscriptionLists()
  .subscribe("bears")
  .unsubscribe("battle-star")
  .apply()
```

#### editAttributes()

Creates an attribute editor instance for the channel. Once edits are done, make sure to call apply on the instance to save changes to the channel.

```
Airship.channel.editAttributes()
  .setAttribute("favorite_color", "red")
  .apply()
```

#### fetchSubscriptionLists(callback)

Fetches the current subscription lists for the channel. The lists are an array of subscription ids that the channel is currently subscribed to. The result body includes:
- error: An error if it failed ot fetch subscriptions.
- subscriptions: The list of subscriptions.

```
Airship.channel.fetchSubscriptionLists(function (result) {
    Ti.API.info("lists: " + JSON.stringify(result))
});
```

## Contact

Provides access to segmentation data at the contact/user level. If a contact is not named you can still apply attributes, tags, and subscription lists as an anonymous contact.

### Constants

#### scopeApp

The app scope when getting/setting subscription lists.

#### scopeWeb

The web scope when getting/setting subscription lists.

#### scopeEmail

The email scope when getting/setting subscription lists.

#### scopeSms

The SMS scope when getting/setting subscription lists.

### Properties

### namedUserId

The current named user Id that was set through the App.

### Methods

#### editTagGroups()

Creates a tag group editor instance for the contact. Once edits are done, make sure to call apply on the instance to save changes to the contact.

```
Airship.contact.editTagGroups()
  .addTags("some-group", ["foo"])
  .removeTags("some-other-group", ["cool", "neat"])
  .apply()
```

#### editSubscriptionLists()

Creates a scoped subscription list editor instance for the contact. Once edits are done, make sure to call apply on the instance to save changes to contact.

```
Airship.contact.editSubscriptionLists()
  .subscribe("bears", Airship.contact.scopeApp)
  .unsubscribe("battle-star", Airship.contact.scopeEmail)
  .apply()
```

#### editAttributes()

Creates an attribute editor instance for the contact. Once edits are done, make sure to call apply on the instance to save changes to the contact.

```
Airship.contact.editAttributes()
  .setAttribute("favorite_color", "red")
  .apply()
```

#### fetchSubscriptionLists(callback)

Fetches the current subscription lists for the channel. The result body includes:
- error: An error if it failed ot fetch subscriptions.
- subscriptions: A map of subscribed Ids to a list of scopes.

```
Airship.contact.fetchSubscriptionLists(function (result) {
    Ti.API.info("lists: " + JSON.stringify(result))
});
```

#### identify(namedUserId)

Identifies the contact.

```
Airship.contact.identify("bart")
```

#### reset()

Resets the contact.

```
Airship.contact.reset()
```


## Push

### userNotificationsEnabled

Enables or disables user notifications. On iOS, enabling notifications the first time will
prompt the user to enable notifications.

```
    Airship.push.userNotificationsEnabled = true;
```

### enableUserNotifications(callback)

Enables user notifications with a callback with the result.

```
    Airship.enableUserNotifications((function(result) {
        Ti.API.info("Notifications Enabled: " + result.success)
    })
```


### notificationStatus

Gets the current notification status:
 - systemEnabled: Boolean. True if notifications are enabled in the system settings for the app or false.
 - airshipOptIn: Boolean. True if push notifications are receivable through Airship.


## Push.iOS

Push extensions for iOS.

### Constants

#### authorizedSettingAlert

Authorized setting for alert.

#### authorizedSettingBadge

Authorized setting for badge.

#### authorizedSettingSound

Authorized setting for sound.

#### authorizedSettingAnnouncement

Authorized setting for announcement.

#### authorizedSettingCarPlay

Authorized setting for car play.

#### authorizedSettingCriticalAlert

Authorized setting for critical alert.

#### authorizedSettingNotificationCenter 

Authorized setting for notification center.

#### authorizedSettingScheduledDelivery

Authorized setting for scheduled delivery.

#### authorizedSettingTimeSensitive 

Authorized setting for time sensitive notifications.

#### authorizedSettingLockScreen

Authorized setting for lock screen.

#### presentationOptionAlert

Foreground presentation option for alert. Use list or banner for iOS 14.

#### presentationOptionBadge

Foreground presentation option for badge.

#### presentationOptionSound

Foreground presentation option for sound.

#### presentationOptionList

Foreground presentation option for list. iOS 14+ only.

#### presentationOptionBanner

Foreground presentation option for banner. iOS 14+ only.

#### notificationOptionAlert

Notification option for alert.

#### notificationOptionBadge

Notification option for badge.

#### notificationOptionSound

Notification option for sound.

#### notificationOptionCarPlay

Notification option for car play.

#### notificationOptionCriticalAlert

Notification option for critical alert.

#### notificationOptionProvidesAppNotificationSettings

Notification option if your app provides settings for notifications.

#### notificationOptionProvisional

Notification option for provisional notifications.

#### authorizedStatusAuthorized

Authorized notification status.

#### authorizedStatusEphemeral

Ephemeral notification status.

#### authorizedStatusProvisional

Provisional notification status.

#### authorizedStatusNotDetermined

Not determined notification status.

#### authorizedStatusDenied

Denied notification status.

### Properties 

#### foregroundPresentationOptions

Gets or sets the foreground presentation options.

#### notificationOptions

Gets or sets the notification options.

#### isAutoBadgeEnabled

Property to enable or disable auto badge on iOS.

#### badgeNumber

The badge number on iOS.    

### Methods

#### resetBadge()

Resets the badge to zero.

### isInAppAutomationPaused

Pauses or resumes In-App messaging.

```
    Airship.isInAppAutomationPaused = true
```

## Privacy Manager

### Constants

#### featureAll

All features.

#### featureNone

No features.

#### featurePush

Push notification feature.

#### featureMessageCenter

Message Center feature.

#### featureInAppAutomation

In-App Automation feature.

#### featureContacts

Contacts feature.

#### featureTagsAndAttributes

Tags, Attributes, and Subscription feature.

#### featureAnalytics

Analytics feature.

#### featureChat

Chat feature.

#### featureLocation

Location feature.

Privacy manager controls what features and data is collected by the Airship SDK.

### Properties

#### privacyManager.enabledFeatures

Gets or sets the list of enabled features.

### privacyManager.enable(features)

Adds features to the enabled set.

### privacyManager.disable(features)

Removes features to the enabled set.

## Analytics

### Methods

#### editAssociatedIdentifiers()

Creates an editor to edit the associated identifiers.

```
    Airship.analytics.editAssociatedIdentifiers()
        .setIdentifier("foo", "bar")
        .apply();
```

#### newEvent(eventName)

Creates a new event with the given event name.

```
    var event = Airship.analytics.newEvent("foo")
    event.eventValue = 100.0
    event.eventProperties = {
        someBoolean: true,
        someDouble: 124.49,
        someString: "customString",
        someInt: 5,
        someLong: 1234567890,
        someArray: ["tangerine", "pineapple", "kiwi"]
    }
    event.track()
```

#### trackScreen(screenName)

Tracks a screen.

```
    Airship.trackScreen("home")
```

## Locale

Locale controls which locale is configured for the Channel when using Airship messaging features.

### Properties

### currentLocale

Gets or sets the locale for Airship.

### reset()

Reset the locale to the app's locale.

## In App Automation

### Properties

#### inAppAutomation.isPaused

Resumes or pauses in-app automations.

#### inAppAutomation.displayIntervalMilliseconds

Sets the display interval in milliseconds.

## Preference Center

### Methods

#### preferenceCenter.setUseCustomPreferenceCenter(preferenceCenterId, useCustom)

Sets if Airship should automatically display a preference center for the given ID or not.

#### display(preferenceCenterId)

Displays a preference center with the given ID. If `useCustom` is set for the preference center Id, it will
emit an event instead of displaying the preference center.

#### getConfig(preferenceCenterId)

Gets the config for the preference center.

## Message Center

### Properties

#### messages

The list of messages.

### Methods

#### markMessageRead(messageId)

Marks a message read.

#### deleteMessage(messageId)

Deletes a message.

#### display()

Displays the message center.

#### displayMessage(messageId)

Displays the message.

### displayMessageCenter()


Displays the message center.

```
    Airship.displayMessageCenter()
```

## ScopedSubscriptionListEditor

Editor for a contact subscription lists.

### Methods

#### subscribe(listId, scope)

Subscribes to a list with the given scope.

#### unsubscribe(listId, scope)

Unsubscribes from a list with the given scope.

#### apply()

Applies the changes.


## SubscriptionListEditor

Editor for a channel subscription lists.

### Methods

#### subscribe(listId)

Subscribes to a list.

#### unsubscribe(listId)

Unsubscribes from a list.

#### apply()

Applies the changes.

## TagEditor

### Methods

#### addTags(tags)

Adds tags.

#### removeTags(tags)

Removes tags.

#### clearTags()

Clears the tags.

#### apply()

Applies the changes.

## TagGroupEditor

### Methods

#### addTags(group, tags)

Adds tags to the group.

#### removeTags(group, tags)

Removes tags from the group.

#### apply()

Applies the changes.

## AttributesEditor

### Methods

#### setAttribute(attributeId, value)

Sets the attribute. The value can be a number, string, or date.

#### removeAttribute(attributeId)

Removes the attribute.

#### apply()

Applies the changes.

## AssociatedIdEditor

### Methods

#### setIdentifier(key, value)

Sets the identifier. Both need to be a string.

#### removeIdentifier(key)

Removes the identifier.

#### apply()

Applies the changes.

## CustomEvent

### Properties

#### eventValue

The event value. Must be a number.

#### transactionId

Sets the transaction ID.

#### interactionId

Sets the interaction ID. Both ID and type must be set if one is set.

#### interactionType

Sets the interaction type. Both ID and type must be set if one is set.

#### eventProperties

Additional event properties. Must be a JSON object.

### Methods

#### track()

Tracks the event.