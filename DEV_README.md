# DEV Readme

Module uses a makefile for build and install commands:
- `build`: Builds both Android and iOS modules
- `build-android`: Builds the Android module
- `build-ios`: Builds the iOS module
- `install`: Builds both modules and unpacks the zips into the titanium module directory
- `install-android`: Builds and unpacks the Android zip into the titanium module directory
- `install-ios`:  Builds and unpacks the iOS zip into the titanium module directory
- `clean`: Cleans any build folders

## Updating Module Version
Run "./scripts/update_version <VERSION>" from root directory

## Updating SDKs
Android: Update android/build.gradle with latest airship version
iOS: Update ios/Cartfile with latest airship version
