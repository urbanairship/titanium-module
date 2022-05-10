package ti.airship.components;

import android.os.Bundle;

import com.urbanairship.messagecenter.Message;
import com.urbanairship.messagecenter.MessageCenter;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import ti.airship.utils.PluginLogger;
import ti.airship.utils.Utils;

@Kroll.proxy
public class MessageCenterProxy extends KrollProxy {

    @Kroll.method
    public void markRead(String messageId) {
        PluginLogger.logCall("markRead", messageId);
        Utils.checkNotNull(messageId);
        MessageCenter.shared().getInbox().markMessagesRead(Collections.singleton(messageId));
    }

    @Kroll.method
    public void delete(String messageId) {
        PluginLogger.logCall("delete", messageId);
        Utils.checkNotNull(messageId);
        MessageCenter.shared().getInbox().deleteMessages(Collections.singleton(messageId));
    }

    @Kroll.method
    public void display(String messageId) {
        PluginLogger.logCall("display", messageId);
        MessageCenter.shared().showMessageCenter(messageId);
    }

    @Kroll.method
    @Kroll.getProperty
    public Object[] getMessages() {
        List<KrollDict> messagesArray = new ArrayList<>();

        for (Message message : MessageCenter.shared().getInbox().getMessages()) {
            KrollDict messageMap = new KrollDict();
            messageMap.put("title", message.getTitle());
            messageMap.put("id", message.getMessageId());
            messageMap.put("sentDate", message.getSentDate().getTime());
            messageMap.put("listIconUrl", message.getListIconUrl());
            messageMap.put("isRead", message.isRead());
            messageMap.put("isDeleted", message.isDeleted());

            KrollDict extrasMap = new KrollDict();
            Bundle extras = message.getExtras();
            for (String key : extras.keySet()) {
                String value = String.valueOf(extras.get(key));
                extrasMap.put(key, value);
            }

            messageMap.put("extras", extrasMap);
            messagesArray.add(messageMap);
        }

        return messagesArray.toArray();
    }

    // messages
}
