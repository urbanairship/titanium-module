/* Copyright Airship and Contributors */
package ti.airship.components

import com.urbanairship.UAirship
import org.appcelerator.kroll.KrollProxy
import org.appcelerator.kroll.annotations.Kroll.*
import ti.airship.utils.FeatureUtils
import ti.airship.utils.PluginLogger

@proxy
class PrivacyManagerProxy : KrollProxy() {

    companion object {
        @constant val featureNone = "none"
        @constant val featureAll = "all"
        @constant val featurePush = "push"
        @constant val featureChat = "chat"
        @constant val featureAnalytics = "analytics"
        @constant val featureLocation = "location"
        @constant val featureMessageCenter = "message_center"
        @constant val featureInAppAutomation = "in_app_automation"
        @constant val featureContacts = "contacts"
        @constant val featureTagsAndAttributes = "tags_and_attributes"
    }

    @get:getProperty
    @get:method
    val enabledFeatures: Array<Any>
        get() {
            val names = FeatureUtils.toFeatureNames(UAirship.shared().privacyManager.enabledFeatures)
            return names.toTypedArray()
        }

    @method
    @setProperty
    fun setEnabledFeatures(names: Array<Any>) {
        PluginLogger.logCall("setEnabledFeatures", *names)
        UAirship.shared().privacyManager.setEnabledFeatures(FeatureUtils.parseFeature(names))
    }

    @method
    fun enable(names: Array<Any>) {
        PluginLogger.logCall("enable", *names)
        UAirship.shared().privacyManager.enable(FeatureUtils.parseFeature(names))
    }

    @method
    fun disable(names: Array<Any>) {
        PluginLogger.logCall("disable", *names)
        UAirship.shared().privacyManager.disable(FeatureUtils.parseFeature(names))
    }
}