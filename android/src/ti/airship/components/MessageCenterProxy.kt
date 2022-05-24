package ti.airship.components

import com.urbanairship.messagecenter.MessageCenter
import org.appcelerator.kroll.KrollDict
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.*
import ti.airship.utils.PluginLogger

@proxy
class MessageCenterProxy : KrollProxy() {
    @method
    fun markMessageRead(messageId: String) {
        PluginLogger.logCall("markRead", messageId)
        MessageCenter.shared().inbox.markMessagesRead(setOf(messageId))
    }

    @method
    fun deleteMessage(messageId: String) {
        PluginLogger.logCall("delete", messageId)
        MessageCenter.shared().inbox.deleteMessages(setOf(messageId))
    }

    @method
    fun display() {
        PluginLogger.logCall("display")
        MessageCenter.shared().showMessageCenter()
    }

    @method
    fun displayMessage(messageId: String) {
        PluginLogger.logCall("display", messageId)
        MessageCenter.shared().showMessageCenter(messageId)
    }

    @get:getProperty
    @get:method
    val messages: Array<Any>
        get() {
            val messagesArray: MutableList<KrollDict> = ArrayList()
            for (message in MessageCenter.shared().inbox.messages) {
                val messageMap = KrollDict()
                messageMap["title"] = message.title
                messageMap["id"] = message.messageId
                messageMap["sentDate"] = message.sentDate.time
                messageMap["listIconUrl"] = message.listIconUrl
                messageMap["isRead"] = message.isRead
                messageMap["isDeleted"] = message.isDeleted
                val extrasMap = KrollDict()
                val extras = message.extras
                for (key in extras.keySet()) {
                    val value = extras[key].toString()
                    extrasMap[key] = value
                }
                messageMap["extras"] = extrasMap
                messagesArray.add(messageMap)
            }
            return messagesArray.toTypedArray()
        }
}