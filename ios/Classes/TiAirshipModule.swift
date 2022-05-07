/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore

/**

 Titanium Swift Module Requirements
 ---

 1. Use the @objc annotation to expose your class to Objective-C (used by the Titanium core)
 2. Use the @objc annotation to expose your method to Objective-C as well.
 3. Method arguments always have the "[Any]" type, specifying a various number of arguments.
 Unwrap them like you would do in Swift, e.g. "guard let arguments = arguments, let message = arguments.first"
 4. You can use any public Titanium API like before, e.g. TiUtils. Remember the type safety of Swift, like Int vs Int32
 and NSString vs. String.

 */

@objc(TiAirshipModule)
public class TiAirshipModule: TiModule {
    @objc
    public let push = TIAirshipPushProxy()

    @objc
    public let channel = TiAirshipChannelProxy()

    @objc
    public let contact = TiAirshipContactProxy()

    @objc
    public let locale = TiAirshipLocaleProxy()

    @objc
    public let privacyManager = TiAirshipPrivacyManagerProxy()

    @objc
    public let inAppAutomation = TiAirshipPrivacyManagerProxy()

    @objc
    public var isFlying: Bool {
        return Airship.isFlying
    }

    func moduleGUID() -> String {
      return "240dc468-ccad-479d-9510-14e9a7cae5c9"
    }

    public override func moduleId() -> String! {
        return "ti.airship"
    }

    public override func startup() {
        super.startup()
        Log.debug("ti.airship loaded.")
    }

    @objc(takeOff:)
    public func takeOff(arguments: Array<Any>?) -> Bool {
        logCall(arguments)

        let config = arguments?[0] as? [AnyHashable: Any]
        PluginStore.write(.config, value: config)
        TiAirshipAutopilot.attemptTakeOff(launchOptions: nil)
        return Airship.isFlying
    }
}

