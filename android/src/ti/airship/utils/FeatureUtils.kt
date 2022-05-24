/* Copyright Airship and Contributors */

package ti.airship.utils

import com.urbanairship.PrivacyManager
import ti.airship.components.PrivacyManagerProxy

object FeatureUtils {
    private val featureMap = mapOf(
        PrivacyManagerProxy.featureNone to PrivacyManager.FEATURE_NONE,
        PrivacyManagerProxy.featureInAppAutomation to PrivacyManager.FEATURE_IN_APP_AUTOMATION,
        PrivacyManagerProxy.featureMessageCenter to PrivacyManager.FEATURE_MESSAGE_CENTER,
        PrivacyManagerProxy.featurePush to PrivacyManager.FEATURE_PUSH,
        PrivacyManagerProxy.featureChat to PrivacyManager.FEATURE_CHAT,
        PrivacyManagerProxy.featureAnalytics to PrivacyManager.FEATURE_ANALYTICS,
        PrivacyManagerProxy.featureTagsAndAttributes to PrivacyManager.FEATURE_TAGS_AND_ATTRIBUTES,
        PrivacyManagerProxy.featureContacts to PrivacyManager.FEATURE_CONTACTS,
        PrivacyManagerProxy.featureLocation to PrivacyManager.FEATURE_LOCATION,
        PrivacyManagerProxy.featureAll to PrivacyManager.FEATURE_ALL
    )

    fun parseFeature(names: Array<Any>): Int {
        var result = PrivacyManager.FEATURE_NONE
        names.toStringSet().forEach {
            result = result or parseFeature(it)
        }
        return result
    }

    @PrivacyManager.Feature
    fun parseFeature(name: String): Int {
        val value = featureMap[name.lowercase()]
        if (value != null) {
            return value
        }
        throw IllegalArgumentException("Invalid feature: $name")
    }

    fun toFeatureNames(@PrivacyManager.Feature features: Int): List<String> {
        val result: MutableList<String> = ArrayList()
        for ((key, value) in featureMap) {
            if (value == PrivacyManager.FEATURE_ALL || value == PrivacyManager.FEATURE_NONE) {
                continue
            }

            if (value and features == value) {
                result.add(key)
            }
        }
        return result
    }
}