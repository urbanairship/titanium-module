#!/bin/bash -e
IOS_VERSION='14.2.1'
ROOT_PATH=`dirname "${0}"`/..
DOWNLOAD_DIRECTORY="$ROOT_PATH/build/download/iOS/$IOS_VERSION"

if [ ! -f "$DOWNLOAD_DIRECTORY/Airship.zip" ]; then
  echo "Downloading frameworks"
  rm -rf $DOWNLOAD_DIRECTORY
  mkdir -p $DOWNLOAD_DIRECTORY
  cd $DOWNLOAD_DIRECTORY
  curl -OL https://github.com/urbanairship/ios-library/releases/download/$IOS_VERSION/Airship.zip
  tar xvzf Airship.zip
  cd -
fi

echo "Copying frameworks"
rm -rf "$ROOT_PATH/ios/platform/Airship*.xcframework"
rm -rf "$ROOT_PATH/ios/platform/Airship*.framework"
cp -R "$DOWNLOAD_DIRECTORY/AirshipCore.xcframework" "$ROOT_PATH/ios/platform/"
cp -R "$DOWNLOAD_DIRECTORY/AirshipMessageCenter.xcframework" "$ROOT_PATH/ios/platform/"
cp -R "$DOWNLOAD_DIRECTORY/AirshipAutomation.xcframework" "$ROOT_PATH/ios/platform/"

cd $ROOT_PATH/ios

echo "Building iOS"
npx appc run -p ios --build-only

echo "Finished building iOS"

cd -

