/* Copyright Urban Airship and Contributors */

package ti.airship.utils

import android.content.Context
import android.content.SharedPreferences
import com.urbanairship.json.JsonException
import com.urbanairship.json.JsonMap
import com.urbanairship.json.JsonValue

/**
 * Stores shared preferences and checks preference-dependent state.
 */
class PluginStore private constructor(context: Context) {
    companion object {
        private const val SHARED_PREFERENCES_FILE = "ti.airship"
        private const val AIRSHIP_CONFIG = "AIRSHIP_CONFIG"
        private const val PREFERENCE_CENTER_CUSTOM_UI_PREFIX = "PREFERENCE_CENTER_CUSTOM_UI-"

        @Volatile
        private var INSTANCE: PluginStore? = null

        fun shared(context: Context): PluginStore =
            INSTANCE ?: synchronized(this) {
                INSTANCE ?: PluginStore(context).also { INSTANCE = it }
            }


        private fun useCustomPreferenceCenterKey(preferenceId: String): String {
            return PREFERENCE_CENTER_CUSTOM_UI_PREFIX + preferenceId
        }
    }

    private val preferences: SharedPreferences

    init {
        preferences = context.getSharedPreferences(SHARED_PREFERENCES_FILE, Context.MODE_PRIVATE)
    }

    var airshipConfig: JsonMap?
        get() {
            val config = preferences.getString(AIRSHIP_CONFIG, null)
                ?: return JsonMap.EMPTY_MAP
            return try {
                JsonValue.parseString(config).map
            } catch (e: JsonException) {
                PluginLogger.error("Failed to parse config.", e)
                null
            }
        }
        set(value) {
            preferences.edit().putString(AIRSHIP_CONFIG, value.toString()).apply()
        }

    fun setUseCustomPreferenceCenter(preferenceId: String, useCustom: Boolean) {
        preferences.edit()
            .putBoolean(useCustomPreferenceCenterKey(preferenceId), useCustom)
            .apply()
    }

    fun getUseCustomPreferenceCenter(preferenceId: String): Boolean {
        return preferences.getBoolean(useCustomPreferenceCenterKey(preferenceId), false)
    }


}