/* Copyright Airship and Contributors */

import TitaniumKit
import AirshipCore
import AirshipMessageCenter

@objc(TiAirshipMessageCenterProxy)
public class TiAirshipMessageCenterProxy: TiProxy {

    @objc
    public var messages: [[String: Any]] {
        return MessageCenter.shared.messageList.messages.map { message in
            var payload = ["title": message.title,
                           "message_id": message.messageID,
                           "sent_date": Utils.isoDateFormatterUTCWithDelimiter().string(from: message.messageSent),
                           "is_read": !message.unread,
                           "extras": message.extra] as [String : Any]

            if let icons = message.rawMessageObject["icons"] as? [String:Any] {
                if let listIcon = icons["list_icon"] {
                    payload["list_icon"] = listIcon
                }
            }

            if let expiration = message.messageExpiration {
                payload["expiration_date"] = Utils.isoDateFormatterUTCWithDelimiter().string(from: expiration)
            }
            return payload
        }
    }
    
    @objc(markRead:)
    public func markRead(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        guard let messageID = arguments?.first as? String else { rejectArguments(arguments) }

        if let message = MessageCenter.shared.messageList.message(forID: messageID) {
            MessageCenter.shared.messageList.markMessagesRead([message as Any])
        }
    }

    @objc(delete:)
    public func delete(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        guard let messageID = arguments?.first as? String else { rejectArguments(arguments) }
        if let message = MessageCenter.shared.messageList.message(forID: messageID) {
            MessageCenter.shared.messageList.markMessagesDeleted([message as Any])
        }
    }

    @objc(display:)
    public func display(arguments: [Any]?) {
        AirshipLogger.debug(describe(arguments))
        if let messageID = arguments?.first as? String {
            MessageCenter.shared.displayMessage(forID: messageID)
        } else {
            MessageCenter.shared.display()
        }
    }

}
