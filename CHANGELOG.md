# Airship Titanium Module

## Version 7.1.0 - August 20, 2020
Minor release bundling the following SDK updates:

### iOS (Updated iOS SDK from 13.4.0 to 13.5.4)
- Addresses [Dynamic Type](https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically) build warnings and Message Center Inbox UI issues. (13.5.4)
- Fixes a crash with Accengage data migration. (13.5.3)
- Improves iOS 14 support and fixes In-App Automation issues. (13.5.2)
- Improves compatibility with Xcode 12, adding new messageCenterStyle properties to the default message center UI classes to avoid conflicting with UIKit changes in iOS 14 (13.5.1)
- Adds support for application-defined locale overrides, and fixes issues in In-App Automation and the Actions Framework. (13.5.0)

For more details, see the [iOS CHANGELOG](https://github.com/urbanairship/ios-library/blob/13.5.4/CHANGELOG.md).

### Android (Updated Android SDK from 13.2.1 to 13.3.2)
- Fixes In-App Automation version triggers to only fire on app updates instead of new installs. (13.3.2)
- Fixes ADM registration exceptions that occur on first run and text alignment issues with In-App Automation. (13.3.1)
- Allows overriding the locale used by Airship. (13.3.0)
- Fixes In-App automation display intervals being ignored if the app is killed and HMS token registration on older Huawei devices. (13.2.2)

For more details, see the [Android CHANGELOG](https://github.com/urbanairship/android-library/blob/13.3.2/CHANGELOG.md.

## Version 7.0.0 - July 8, 2020
Major update to add significant functionality to the Titanium module. These updates take advantage of the latest iOS and Android SDKs APIs.

### Changes
- Updated Airship Android SDK to 13.2.1
- Updated Airship iOS SDK to 13.4.0
- Added channel tag editor.
- Added named user and channel attribute editor.
- Added named user and channel tag group editor.
- Added iOS badge support.
- Added screen tracking support.
- Added flag to pause or resume the display of In-App Automation.
- Added opt-in status flag.
- Added enableUserNotifications method with a result status callback.
- Added EUCS cloud site support.
- Added more robust event handlers.
- Added notifications for opt-in status changed and notification reponse events.
- Added custom events support.

## Version 6.0.0 - May 28, 2020
Major update to support Titanium 9.0.0+ and Android and iOS SDKs.

### Changes
- Updated Airship Android SDK to 13.1.2
- Updated Airship iOS SDK to 13.3.2
- Updated Titanium to 9.0.0
- Changed module name from `UrbanAirship` to `AirshipTitanium`
- Changed module id from `com.urbanairship` to `ti.airship`

## Version 5.0.2 - March 14, 2018
Fixed a security issue within Android Urban Airship SDK, that could allow
trusted URL redirects in certain edge cases. All applications that are using Urban Airship Titanium module for Android version 5.0.0 - 5.0.1 should update as soon as possible. For more details, please email security@urbanairship.com.

## Version 5.0.1 - November 20, 2018
- Updated Android SDK to 9.5.6

## Version 5.0.0 - November 12, 2018
- Updated Android SDK to 9.5.4
- Updated iOS SDK to 10.0.3
- Fixed parsing error when converting google.ttl to a String

## Version 4.0.1 - April 6, 2018
- Fixed bug causing iOS resource bundle verification errors.

## Version 4.0.0 - February 6, 2018
 - Update to Titanium 7.0.1
 - Updated Android SDK to 8.9.7
 - Updated iOS SDK to 8.6.3

## Version 3.2.0 - October 30, 2017
 - Added deep link support.
 - Updated Android SDK to 8.7.0
 - Updated iOS SDK to 8.6.0
 - Updated to Titanium 6.1.1 GA.

## Version 3.1.1 - January 26, 2017
 - Updated Urban Airship iOS library to 8.1.6

## Version 3.1.0 - December 9, 2016
 - Updated Urban Airship Android Library to 8.2.2
 - Updated Urban Airship iOS library to 8.1.4

## Version 3.0.0 - November 22, 2016
 - Updated to Titanium 6.0.0 GA.
 - Added iOS foreground presentation support.
 - Added support for associated identifiers.
 - Added support for custom events.

## Version 2.0.2 - November 21, 2016
 - Fixed getLaunchNotification on iOS not returning the notification when app is started from a push notification.

## Version 2.0.1 - October 4, 2016
 - Updated Urban Airship iOS Library to 8.0.2

## Version 2.0.0 - September 28, 2016
 - Updated Urban Airship iOS Library to 8.0.1 (requires Xcode 8)
 - Updated to Titanium 5.5.0 GA SDK.

## Version 1.3.0 - June 23, 2016
 - Updated Urban Airship Android library to 7.2.0
 - For iOS set the launchNotification in the startup method.

## Version 1.2.0 - June 2, 2016
 - Updated Urban Airship iOS Library to 7.2.0
 - Updated Urban Airship Android library to 7.1.5

## Version 1.1.1 - May 12, 2016
 - Updated Urban Airship Android Library to 7.1.3
 - Updated Urban Airship iOS library to 7.1.2

## Version 1.1.0 - May 4, 2016
 - Updated Urban Airship Android Library to 7.1.2
 - Updated Urban Airship iOS library to 7.1.0

## Version 1.0.0 - April 15, 2016
 - Initial release
