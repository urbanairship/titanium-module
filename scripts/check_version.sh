#!/bin/bash -e

ROOT_PATH=`dirname "${0}"`/..

IOS_VERSION=$(awk <"$ROOT_PATH/ios/manifest" "\$1 == \"version:\" { print \$2 }")
ANDROID_VERSION=$(awk <"$ROOT_PATH/android/manifest" "\$1 == \"version:\" { print \$2 }")

if [ "$IOS_VERSION" != "$ANDROID_VERSION" ]; then
  echo "iOS and Android versions do not match in the manifests"
  exit 1
fi

if [ "$1" ]; then
  if [ $1 != "$ANDROID_VERSION" ]; then
    echo "iOS and Android version ($ANDROID_VERSION) do not match input: $1"
    exit 1
  fi
fi

