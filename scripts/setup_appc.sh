#!/bin/bash -ex

npm install appcelerator
echo "y" | npx appc setup --no-prompt --username $1 --password $2
npx appc ti sdk install 9.3.0.GA --no-prompt
npx appc info

