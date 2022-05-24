# Airship Titanium Module

Titanium module for Airship services. [Download the latest release here.](https://github.com/urbanairship/titanium-module/releases/latest)

## Resources
 - [API docs](documentation/index.md)
 - [Getting Started Guide](https://docs.airship.com/platform/titanium/getting-started/)

## Requirements
 - Android [FCM Setup](https://docs.airship.com/platform/android/getting-started/#fcm-configure-airship-dashboard)
 - iOS [APNS Setup](https://docs.airship.com/platform/ios/getting-started/#apple-setup)


## Quickstart

```
    var Airship = require("ti.airship");

    Airship.takeOff({
      "default": {
        "appKey": Your App Key,
        "appSecret": Your App Secret
      },
    });
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