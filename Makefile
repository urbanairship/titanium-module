build: build-ios build-android

build-android:
	bash ./scripts/build_android.sh

build-ios:
	bash ./scripts/check_titanium_version.sh
	bash ./scripts/build_ios.sh

install: install-ios install-android

install-android: build-android
	unzip -o android/dist/ti.airship-android-*.zip -d ~/Library/Application\ Support/Titanium/

install-ios: build-ios
	unzip -o ios/dist/ti.airship-iphone-*.zip -d ~/Library/Application\ Support/Titanium/

clean:
	rm -rf android/build
	rm -rf android/dist
	rm -rf android/libs
	rm -rf ios/build
	rm -rf ios/dist
	rm -rf "${HOME}/Library/Application Support/Titanium/modules/iphone/ti.airship/"


