# DEV Readme

Module uses a makefile for build and install commands:
- `build`: Builds both Android and iOS modules
- `build-android`: Only builds the Android module
- `build-ios`: Only builds the iOS module
- `install`: Builds both modules and unpacks the zips into the titanium module directory
- `clean`: Cleans any build folders

## Updating SDKs
Android: Update android/build.gradle with latest airship version
iOS: Update ios/Cartfile with latest airship version
