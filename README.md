# Airship Titanium Module

Titanium module for Airship services. [Download the latest release here.](https://github.com/urbanairship/titanium-module/releases/latest)

## Resources
 - [API docs](documentation/index.md)
 - [Getting Started Guide](https://docs.airship.com/platform/titanium/getting-started/)

## Requirements
 - Android [FCM Setup](https://docs.airship.com/platform/android/getting-started/#fcm-configure-airship-dashboard)
 - iOS [APNS Setup](https://docs.airship.com/platform/ios/getting-started/#apple-setup)


## Quickstart

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
  <property name="com.urbanairship.notification_icon" type="string">Name of an icon in /project_name/platform/android/res/drawable folders, e.g. ic_notification.png</property>
  <property name="com.urbanairship.notification_accent_color" type="string">Notification accent color, e.g. #ff0000</property>

  <!-- iOS alert foreground notification presentation option -->
  <property name="com.urbanairship.ios_foreground_notification_presentation_alert" type="bool">true</property>
  <!-- iOS badge foreground notification presentation option -->
  <property name="com.urbanairship.ios_foreground_notification_presentation_badge" type="bool">true</property>
  <!-- iOS sound foreground notification presentation option -->
  <property name="com.urbanairship.ios_foreground_notification_presentation_sound" type="bool">true</property>
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

For Android, add the `google-services.json` to `platform/android/google-services.json`.

### Accessing the Airship Module

To access this module from JavaScript, you would do the following:

```
    var Airship = require("ti.airship");
```