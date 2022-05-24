/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore
import AirshipMessageCenter
import Foundation

@objc(TiAirshipCustomEventProxy)
public class TiAirshipCustomEventProxy: TiProxy {

    @objc
    public var eventValue: NSNumber?

    @objc
    public var transactionId: String?

    @objc
    public var interactionId: String?

    @objc
    public var interactionType: String?

    @objc
    public var eventProperties: [String: Any]?

    private let eventName: String

    init(eventName: String) {
        self.eventName = eventName
    }

    @objc(track:)
    public func track(arguments: [Any]?) {
        let event = CustomEvent(name: eventName, value: eventValue)
        event.transactionID = transactionId
        event.interactionType = interactionType
        event.interactionID = interactionId
        event.properties = eventProperties ?? [:]

        AirshipLogger.debug(event.description)
        event.track()
    }

}
