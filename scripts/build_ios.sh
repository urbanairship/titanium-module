#!/bin/bash -e

ROOT_PATH=`dirname "${0}"`/..

# iOS
echo "Building iOS"

cd $ROOT_PATH/ios

SCRIPT_DIR=`dirname "$0"`

echo "Updating carthage"
carthage update

echo "Copying frameworks"
cp -R "${SCRIPT_DIR}/Carthage/Build/iOS/AirshipCore.framework" "${SCRIPT_DIR}/platform/"
cp -R "${SCRIPT_DIR}/Carthage/Build/iOS/AirshipMessageCenter.framework" "${SCRIPT_DIR}/platform/"

echo "Building iOS"
npx appc run -p ios --build-only

echo "Finished building iOS"

cd -

