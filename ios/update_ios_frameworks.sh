#!/bin/bash

echo "Updating carthage"
carthage update

echo "Copying frameworks"
cp -R Carthage/Build/iOS/AirshipCore.framework platform/
cp -R Carthage/Build/iOS/AirshipMessageCenter.framework platform/

echo "Done"
