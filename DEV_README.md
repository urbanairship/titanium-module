# DEV Readme

## Android

1) Update android/lib/*.aars with latest versions
2) Build the module: `appc run -p android --build-only`
3) Install the module: `unzip -o dist/com.urbanairship-android-*.zip -d ~/Library/Application\ Support/Titanium/`

### SDK note
The last version of the SDK was built without `urbanAirshipFontPath` support due to a conflict of resources. To reproduce, remove this from attrs.xml and rebuild:
```
    <declare-styleable name="TextAppearance">
        <!-- Font path -->
        <attr name="urbanAirshipFontPath" format="string"/>
    </declare-styleable
```

Android is still using gcm package. I could only find 3rd party packages of FCM. We can move to FCM as soon as ti either supports gradle or provides a package.

## iOS

1) Update Airship version in `update_ios_static_lib.sh`
2) Run the script: `./update_ios_static_lib.sh`
3) Open `UrbanAirship.xcodeproj` and update any headers and reference to the new `.a` library
4) Build the module: `appc run -p ios --build-only`
5) Install the module `unzip -o com.urbanairship-iphone-*.zip -d ~/Library/Application\ Support/Titanium/`


## Environment

Last successful enviornment:

`$ appc info`:
```
Appcelerator Command-Line Interface, version 7.0.7
Copyright (c) 2014-2018, Appcelerator, Inc.  All Rights Reserved.

Operating System
  Name                        = Mac OS X
  Version                     = 10.13.6
  Architecture                = 64bit
  # CPUs                      = 8
  Memory                      = 16.0GB

Node.js
  Node.js Version             = 8.12.0
  npm Version                 = 6.4.1

Appcelerator CLI
  Installer                   = 4.2.13
  Core Package                = 7.0.7

Titanium CLI
  CLI Version                 = 5.1.1
  node-appc Version           = 0.2.44

Titanium SDKs
  7.4.1.GA
    Version                   = 7.4.1
    Install Location          = /Users/ryan.lepinski/Library/Application Support/Titanium/mobilesdk/osx/7.4.1.GA
    Platforms                 = iphone, android
    git Hash                  = f47cf79a83
    git Timestamp             = 10/8/2018 17:44
    node-appc Version         = 0.2.45
  7.3.1.GA
    Version                   = 7.3.1
    Install Location          = /Users/ryan.lepinski/Library/Application Support/Titanium/mobilesdk/osx/7.3.1.GA
    Platforms                 = iphone, android
    git Hash                  = 6164fa414d
    git Timestamp             = 8/29/2018 07:23
    node-appc Version         = 0.2.45
  7.2.0.GA
    Version                   = 7.2.0
    Install Location          = /Users/ryan.lepinski/Library/Application Support/Titanium/mobilesdk/osx/7.2.0.GA
    Platforms                 = iphone, android
    git Hash                  = ecae6740fe
    git Timestamp             = 6/7/2018 12:25
    node-appc Version         = 0.2.45
  7.0.1.GA
    Version                   = 7.0.1
    Install Location          = /Users/ryan.lepinski/Library/Application Support/Titanium/mobilesdk/osx/7.0.1.GA
    Platforms                 = iphone, android
    git Hash                  = f5ae7e5
    git Timestamp             = 12/18/2017 18:48
    node-appc Version         = 0.2.43
  6.0.4.GA
    Version                   = 6.0.4
    Install Location          = /Users/ryan.lepinski/Library/Application Support/Titanium/mobilesdk/osx/6.0.4.GA
    Platforms                 = iphone, android, mobileweb
    git Hash                  = 74f7d21
    git Timestamp             = 4/26/2017 21:06
    node-appc Version         = 0.2.41
  4.0.0.GA
    Version                   = 4.0.0
    Install Location          = /Users/ryan.lepinski/Library/Application Support/Titanium/mobilesdk/osx/4.0.0.GA
    Platforms                 = iphone, mobileweb, android
    git Hash                  = 9239ff9
    git Timestamp             = 05/18/15 15:42
    node-appc Version         = 0.2.24

Mac OS X
  Command Line Tools          = installed

Intel® Hardware Accelerated Execution Manager (HAXM)
  Installed                   = yes
  Memory Limit                = 2 GB

Java Development Kit
  Version                     = 1.8.0_131
  Java Home                   = /Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home

Genymotion
  Path                        = not found
  Genymotion Executable       = not found
  Genymotion Player           = not found
  Home                        = not found

VirtualBox
  Executable                  = not found
  Version                     = unknown

Android SDK
  Android Executable          = not found
  ADB Executable              = /Users/ryan.lepinski/Library/Android/sdk/platform-tools/adb
  SDK Path                    = /Users/ryan.lepinski/Library/Android/sdk

Android NDK
  NDK Path                    = /Users/ryan.lepinski/android-ndk-r12b
  NDK Version                 = 12.1.2977051

Android Platforms
  1) android-26
    Name                      = Android 8.0.0
    API Level                 = 26
    Revision                  = 1
    Skins                     = HVGA, QVGA, WQVGA400, WQVGA432, WSVGA, WVGA800, WVGA854, WXGA720, WXGA800, WXGA800-7in
    ABIs                      =
    Path                      = /Users/ryan.lepinski/Library/Android/sdk/platforms/android-26
  2) android-27
    Name                      = Android 8.1.0
    API Level                 = 27
    Revision                  = 1
    Skins                     = HVGA, QVGA, WQVGA400, WQVGA432, WSVGA, WVGA800, WVGA854, WXGA720, WXGA800, WXGA800-7in
    ABIs                      =
    Path                      = /Users/ryan.lepinski/Library/Android/sdk/platforms/android-27
  3) android-28
    Name                      = Android 9 (not supported by Titanium SDK 7.4.1.GA, but may work)
    API Level                 = 28
    Revision                  = 1
    Skins                     = HVGA, QVGA, WQVGA400, WQVGA432, WSVGA, WVGA800, WVGA854, WXGA720, WXGA800, WXGA800-7in
    ABIs                      = x86
    Path                      = /Users/ryan.lepinski/Library/Android/sdk/platforms/android-28

Android Add-Ons
  None

Android Emulators
  Android_Accelerated_Oreo
    ID                        = Android_Accelerated_Oreo
    SDK Version               = not installed
    ABI                       = x86
    Skin                      = 768x1280
    Path                      = /Users/ryan.lepinski/.android/avd/Android_Accelerated_Oreo.avd
    SD Card                   = /Users/ryan.lepinski/.android/avd/Android_Accelerated_Oreo.avd/sdcard.img
    Google APIs               = no
  Nexus 5X API P
    ID                        = Nexus_5X_API_P
    SDK Version               = not installed
    ABI                       = x86
    Skin                      = nexus_5x
    Path                      = /Users/ryan.lepinski/.android/avd/Nexus_5X_API_P.avd
    SD Card                   = /Users/ryan.lepinski/.android/avd/Nexus_5X_API_P.avd/sdcard.img
    Google APIs               = no
  Pixel 2 API 28
    ID                        = Pixel_2_API_28
    SDK Version               = Android 9 (API level 28)
    ABI                       = x86
    Skin                      = 1080x1920
    Path                      = /Users/ryan.lepinski/.android/avd/Pixel_2_API_28.avd
    SD Card                   = /Users/ryan.lepinski/.android/avd/Pixel_2_API_28.avd/sdcard.img
    Google APIs               = no

Genymotion Emulators
  None

Connected Android Devices
  None

Xcode
  10.0 (build 10A255) - Xcode default
    Install Location          = /Applications/Xcode.app/Contents/Developer
    iOS SDKs                  = 12.0
    iOS Simulators            = 12.0
    Watch SDKs                = 5.0
    Watch Simulators          = 5.0
    Supported by TiSDK 7.4.1.GA = yes
    EULA Accepted             = yes
    Teams                     = none

iOS Keychains
  login.keychain-db           = /Users/ryan.lepinski/Library/Keychains/login.keychain-db
  System.keychain             = /Library/Keychains/System.keychain

iOS Development Certificates
/Users/ryan.lepinski/Library/Keychains/login.keychain-db
  Ryan Lepinski (PY3YG9PUF6)
    Not valid before          = 8/16/2018 6:54 AM
    Not valid after           = 8/16/2019 6:54 AM
  ryan.lepinski@urbanairship.com (XM9KZY9U69)
    Not valid before          = 8/16/2018 6:55 AM
    Not valid after           = 8/16/2019 6:55 AM

iOS App Store Distribution Certificates
  None

Apple WWDR Certificate
  Apple WWDR                  = installed

Development iOS Provisioning Profiles
  iOS Team Provisioning Profile: *
    UUID                      = 7046d654-fb6c-4d6e-a3a4-a1dda12a4a8a
    App Prefix                = 5MWH5BU9J3
    App Id                    = *
    Date Created              = 8/16/2018 7:54 AM
    Date Expired              = 8/16/2019 7:54 AM
    Managed                   = Yes and is NOT compatible with Titanium
  iOS Team Provisioning Profile: com.urbanairship.goatdev
    UUID                      = e7f8c87d-e302-48ba-b43c-800c4e3196f9
    App Prefix                = PGJV57GD94
    App Id                    = com.urbanairship.goatdev
    Date Created              = 8/16/2018 7:47 AM
    Date Expired              = 8/16/2019 7:47 AM
    Managed                   = Yes and is NOT compatible with Titanium
  iOS Team Provisioning Profile: com.urbanairship.goatdev.GoatDevServiceExtension
    UUID                      = 85600beb-533f-415a-9b54-5e9d54e8061f
    App Prefix                = PGJV57GD94
    App Id                    = com.urbanairship.goatdev.GoatDevServiceExtension
    Date Created              = 8/16/2018 7:47 AM
    Date Expired              = 8/16/2019 7:47 AM
    Managed                   = Yes and is NOT compatible with Titanium
  iOS Team Provisioning Profile: com.urbanairship.richpush
    UUID                      = 16086840-101e-4728-8a58-fedd158f06a1
    App Prefix                = ARR9AKHJP9
    App Id                    = com.urbanairship.richpush
    Date Created              = 8/16/2018 7:04 AM
    Date Expired              = 8/16/2019 7:04 AM
    Managed                   = Yes and is NOT compatible with Titanium
  iOS Team Provisioning Profile: com.urbanairship.testship
    UUID                      = c8b938b4-1cb0-4b57-acd4-76a6f5c325a6
    App Prefix                = PGJV57GD94
    App Id                    = com.urbanairship.testship
    Date Created              = 8/16/2018 7:04 AM
    Date Expired              = 8/16/2019 7:04 AM
    Managed                   = Yes and is NOT compatible with Titanium
  tvOS Team Provisioning Profile: com.urbanairship.richpush
    UUID                      = 675be7a1-fc65-469b-bdbc-b1226e1d9e27
    App Prefix                = ARR9AKHJP9
    App Id                    = com.urbanairship.richpush
    Date Created              = 8/16/2018 7:04 AM
    Date Expired              = 8/16/2019 7:04 AM
    Managed                   = No

App Store Distribution iOS Provisioning Profiles
  None

Ad Hoc iOS Provisioning Profiles
  None

Enterprise Ad Hoc iOS Provisioning Profiles
  None

iOS Simulators
12.0
  iPhone X (iphone)
    UDID                      = 749707CC-73B9-4B18-A93A-3CBD554CD84B
    Supports Watch Apps       = yes
  iPhone XR (iphone)
    UDID                      = 3B44B93B-28D1-445F-B224-273F1463D6E3
    Supports Watch Apps       = yes

WatchOS Simulators
5.0
  Apple Watch - 38mm (watch)
    UDID                      = B5CF98D2-0F40-4931-A2B1-AAD26AB23726
  Apple Watch - 42mm (watch)
    UDID                      = 53B9418F-D0FD-4093-908D-8AA1E09C715C
  Apple Watch Series 2 - 38mm (watch)
    UDID                      = C5CA6D4F-A631-4CFD-8664-4AE5A83FC220
  Apple Watch Series 2 - 42mm (watch)
    UDID                      = FC1982F4-41F2-45BF-B496-097F37B16AB0
  Apple Watch Series 3 - 38mm (watch)
    UDID                      = 31F094D2-98B2-4974-88FE-167326601D3A
  Apple Watch Series 3 - 42mm (watch)
    UDID                      = 57087244-9AEA-4FC5-AC99-E2AC25709105
  Apple Watch Series 4 - 40mm (watch)
    UDID                      = 08CA56B5-EF8A-460C-A5CE-33C9AC9EDF7E
  Apple Watch Series 4 - 44mm (watch)
    UDID                      = AD0250DE-D893-4D42-BF8B-85E21C99F4F8
```

