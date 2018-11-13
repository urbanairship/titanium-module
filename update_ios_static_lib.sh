#!/bin/bash

# Parse framework version line from plugin and pull out the version number
VERSION=10.0.3

echo "Downloading libUAirship-$VERSION.zip from bintray..."
curl -s -LO "https://urbanairship.bintray.com/iOS/urbanairship-sdk/$VERSION/libUAirship-$VERSION.zip"

echo "Unpacking"
unzip -q -d temp libUAirship-$VERSION.zip
rm -rf ios/Airship
rm -rf ios/assets/AirshipResources.bundle
mv -f temp/Airship ios/Airship
mv -f ios/Airship/AirshipResources.bundle ios/assets/AirshipResources.bundle

rm -rf temp
rm -rf libUAirship-$VERSION.zip
echo "Done"