/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore

@objc(TiAirshipModule)
public class TiAirshipModule: TiModule {


    @objc
    public let eventPushReceived = EventNames.pushReceived

    @objc
    public let eventNotificationResponseReceived = EventNames.notificationResponseReceived

    @objc
    public let eventNotificationOptInStatusChanged = EventNames.notificationOptInStatusChanged

    @objc
    public let eventChannelCreated = EventNames.channelCreated

    @objc
    public let eventDeepLinkReceived = EventNames.deepLinkReceived

    @objc
    public let eventInboxUpdated = EventNames.inboxUpdated

    @objc
    public let eventOpenPreferenceCenter = EventNames.openPreferenceCenter

    @objc
    public let logLevelVerbose = LogLevelNames.verbose

    @objc
    public let logLevelDebug = LogLevelNames.debug

    @objc
    public let logLevelInfo = LogLevelNames.info

    @objc
    public let logLevelWarning = LogLevelNames.warning

    @objc
    public let logLevelError = LogLevelNames.error

    @objc
    public let logLevelNone = LogLevelNames.none

    @objc
    public let cloudSiteEu = CloudSiteName.eu

    @objc
    public let cloudSiteUs = CloudSiteName.us

    @objc
    public let push = TiAirshipPushProxy()

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
    public let preferenceCenter = TiAirshipPreferenceCenterProxy()

    @objc
    public let analytics = TiAirshipAnalyticsProxy()

    @objc
    public let messageCenter = TiAirshipMessageCenterProxy()

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
        AirshipLogger.debug("ti.airship loaded.")

        EventManager.shared.onDispatch = { [weak self] event in
            guard let strongSelf = self,
                  strongSelf._hasListeners(event.name)
            else {
                return false
            }

            strongSelf.fireEvent(event.name, with: event.data)
            return true
        }
    }

    public override func addEventListener(_ args: [Any]!) {
        AirshipLogger.debug(describe(args))
        super.addEventListener(args)
        EventManager.shared.onListenerAdded()
    }


    @objc(takeOff:)
    public func takeOff(arguments: [Any]?) -> Bool {
        AirshipLogger.debug(describe(arguments))

        guard let configDict = arguments?[0] as? [String: Any] else {
            rejectArguments(arguments)
        }

        let _ = try! Config.parse(configDict)
        PluginStore.config = configDict
        TiAirshipAutopilot.attemptTakeOff(launchOptions: nil)
        return Airship.isFlying
    }
}

