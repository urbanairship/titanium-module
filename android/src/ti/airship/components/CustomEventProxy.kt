/* Copyright Airship and Contributors */

package ti.airship.components

import com.urbanairship.analytics.CustomEvent
import org.appcelerator.kroll.KrollDict
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll
import org.appcelerator.titanium.util.TiConvert
import ti.airship.utils.PluginLogger
import ti.airship.utils.toJson

@Kroll.proxy
class CustomEventProxy(private val eventName: String) : KrollProxy() {

    @get:Kroll.getProperty
    @set:Kroll.setProperty
    var eventProperties: KrollDict? = null

    @get:Kroll.getProperty
    @set:Kroll.setProperty
    var transactionId: String? = null

    @get:Kroll.getProperty
    @set:Kroll.setProperty
    var interactionType: String? = null

    @get:Kroll.getProperty
    @set:Kroll.setProperty
    var interactionId: String? = null

    @get:Kroll.getProperty
    @set:Kroll.setProperty
    var eventValue: Any? = null

    @Kroll.method
    fun track() {
        val event = CustomEvent.newBuilder(eventName)
            .setTransactionId(transactionId)
            .setInteraction(interactionId, interactionType)
            .setProperties(eventProperties?.toJson())
            .apply {
                eventValue?.let {
                    this.setEventValue(TiConvert.toDouble(it))
                }
            }
            .build()

        PluginLogger.logCall("track", event.toJsonValue())
        event.track()
    }
}