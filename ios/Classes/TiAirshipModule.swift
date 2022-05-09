/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore

@objc(TiAirshipModule)
public class TiAirshipModule: TiModule {

    @objc
    public let pushReceivedEvent = PushReceivedEvent.eventName

    @objc
    public let notificationResponseReceivedEvent = NotificationResponseReceivedEvent.eventName

    @objc
    public let notificationOptInStatusChangedEvent = NotificationOptInStatusChangedEvent.eventName

    @objc
    public let channelCreatedEvent = ChannelCreatedEvent.eventName

    @objc
    public let deepLinkReceivedEvent = DeepLinkReceivedEvent.eventName

    @objc
    public let inboxUpdatedEvent = InboxUpdatedEvent.eventName

    @objc
    public let openPreferenceCenterEvent = OpenPreferenceCenterEvent.eventName
    
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
        logCall(args)
        super.addEventListener(args)
        EventManager.shared.onListenerAdded()
    }


    @objc(takeOff:)
    public func takeOff(arguments: [Any]?) -> Bool {
        logCall(arguments)

        guard let configDict = arguments?[0] as? [String: Any],
              let config = try! ConfigUtils.parseConfig(configDict)
        else {
            rejectArguments(arguments)
        }

        PluginStore.config = config
        TiAirshipAutopilot.attemptTakeOff(launchOptions: nil)
        return Airship.isFlying
    }
}

