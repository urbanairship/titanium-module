#!/bin/bash -e

ROOT_PATH=`dirname "${0}"`/..

TITANIUM_VERSION_EXPECTED=$(awk -F ' = ' "\$1 == \"TITANIUM_SDK_VERSION\" { print \$2 }" $ROOT_PATH/ios/titanium.xcconfig)

echo "y" | npx appc setup --no-prompt --username $1 --password $2
ACTUAL_TITANIUM_VERSION=$(awk -F '[' "{ gsub(/ /, \"\"); print \$1 }" <(npx appc ti sdk | grep "\[selected\]"))

if [ "$TITANIUM_VERSION_EXPECTED" != "$ACTUAL_TITANIUM_VERSION" ]; then
	echo "Titanium SDK version: $ACTUAL_TITANIUM_VERSION"
	echo "Titanium SDK version expected: $TITANIUM_VERSION_EXPECTED"
	echo "Your actual Titanium SDK version does not match the expected version in titanium.xcconfig"
	exit 1
fi
