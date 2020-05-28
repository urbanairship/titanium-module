#!/bin/bash

SCRIPT_DIR=`dirname "$0"`

echo "Updating carthage"
carthage update

echo "Copying frameworks"
cp -R "${SCRIPT_DIR}/Carthage/Build/iOS/AirshipCore.framework" "${SCRIPT_DIR}/platform/"
cp -R "${SCRIPT_DIR}/Carthage/Build/iOS/AirshipMessageCenter.framework" "${SCRIPT_DIR}/platform/"

echo "Done"
