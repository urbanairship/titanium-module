#!/bin/bash -e

ROOT_PATH=`dirname "${0}"`/..

# Android
echo "Building Android"

cd $ROOT_PATH/android
npx appc run -p android --build-only

echo "Finished building Android"

cd -

