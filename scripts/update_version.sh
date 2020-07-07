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

# Android - TiAirshipModuleVersion.java
sed -i '' "s/\(tiAirshipModuleVersion *= *\)\".*\"/\1\"$VERSION\"/g" $ROOT_PATH/android/src/ti/airship/TiAirshipModuleVersion.java

# iOS - TiAirshipModuleVersion.m
sed -i '' "s/\(tiAirshipModuleVersionString *= *@\)\".*\"/\1\"$VERSION\"/g" $ROOT_PATH/ios/Classes/TiAirshipModuleVersion.m

