#!/bin/bash -ex
echo "y" | sudo ${ANDROID_HOME}/tools/bin/sdkmanager --install "ndk;20.0.5948944" --sdk_root=${ANDROID_SDK_ROOT}

npm install appcelerator
echo "y" | npx appc setup --no-prompt --username $1 --password $2
npx appc ti sdk install latest --no-prompt