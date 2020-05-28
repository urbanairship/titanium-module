build: build-ios build-android

build-android:
	bash ./scripts/build_android.sh

build-ios:
	bash ./scripts/build_ios.sh

install: build
	unzip -o ios/dist/ti.airship-iphone-*.zip -d ~/Library/Application\ Support/Titanium/
	unzip -o android/dist/ti.airship-android-*.zip -d ~/Library/Application\ Support/Titanium/

clean:
	rm -rf android/build
	rm -rf android/dist
	rm -rf android/libs
	rm -rf ios/build
	rm -rf ios/dist

