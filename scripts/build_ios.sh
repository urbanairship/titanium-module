#!/bin/bash -e

ROOT_PATH=`dirname "${0}"`/..

# iOS
echo "Building iOS"

cd $ROOT_PATH/ios


echo "Updating carthage"
carthage update

echo "Copying frameworks"
cp -R "Carthage/Build/iOS/AirshipCore.framework" "platform/"
cp -R "Carthage/Build/iOS/AirshipMessageCenter.framework" "platform/"

echo "Building iOS"
npx appc run -p ios --build-only

echo "Finished building iOS"

cd -

