#!/bin/bash -ex
VERSION=$1
ROOT_PATH=`dirname "${0}"`/../

if [ -z "$1" ]
  then
    echo "No version number supplied"
    exit
fi

# iOS and Android Manifests
sed -i '' "s/\(^version:\).*/\1 $VERSION/g" $ROOT_PATH/ios/manifest
sed -i '' "s/\(^version:\).*/\1 $VERSION/g" $ROOT_PATH/android/manifest

# Android - TiAutopilot.kt
sed -i '' "s/\(VERSION *= *\)\".*\"/\1\"$VERSION\"/g" $ROOT_PATH/android/src/ti/airship/TiAutopilot.kt

# iOS - TiAirshipAutopilot.kt
sed -i '' "s/\(version *= *\)\".*\"/\1\"$VERSION\"/g" $ROOT_PATH/ios/Classes/TiAirshipAutopilot.swift

