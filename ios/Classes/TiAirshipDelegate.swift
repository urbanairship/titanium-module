/* Copyright Airship and Contributors */

import Foundation
import AirshipPreferenceCenter
import AirshipCore
import AirshipMessageCenter

class TiAirshipDelegate: NSObject, PushNotificationDelegate, RegistrationDelegate, DeepLinkDelegate, PreferenceCenterOpenDelegate {

    public override init() {
        super.init()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(inboxUpdated),
                                               name: NSNotification.Name.UAInboxMessageListUpdated,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(channelCreated),
                                               name: Channel.channelCreatedEvent,
                                               object: nil)
    }

    @objc
    public func channelCreated() {
        guard let channelID = Airship.channel.identifier else { return }
        ChannelCreatedEvent(channelID: channelID).dispatch()
    }

    @objc
    public func inboxUpdated() {
        InboxUpdatedEvent().dispatch()
    }

    func receivedDeepLink(_ deepLink: URL, completionHandler: @escaping () -> Void) {
        DeepLinkReceivedEvent(deepLink: deepLink.absoluteString).dispatch()
        completionHandler()
    }

    func receivedNotificationResponse(_ notificationResponse: UNNotificationResponse, completionHandler: @escaping () -> Void) {
        NotificationResponseReceivedEvent(response: notificationResponse).dispatch()
        completionHandler()
    }

    func receivedForegroundNotification(_ userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        PushReceivedEvent(userInfo: userInfo).dispatch()
        completionHandler()
    }

    func receivedBackgroundNotification(_ userInfo: [AnyHashable : Any], completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PushReceivedEvent(userInfo: userInfo).dispatch()
        completionHandler(.noData)
    }

    func notificationAuthorizedSettingsDidChange(_ authorizedSettings: UAAuthorizedNotificationSettings) {
        NotificationOptInStatusChangedEvent(authroizedSettings: authorizedSettings).dispatch()
    }

    func openPreferenceCenter(_ preferenceCenterID: String) -> Bool {
        guard PluginStore.getUseCustomPreferenceCenter(preferenceCenterID) else {
            return false
        }
        OpenPreferenceCenterEvent(preferenceCenterID: preferenceCenterID).dispatch()
        return true
    }
}
