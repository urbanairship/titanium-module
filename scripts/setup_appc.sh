#!/bin/bash -ex

npm install appcelerator
echo "y" | npx appc setup --no-prompt --username $1 --password $2
npx appc ti sdk install latest --no-prompt