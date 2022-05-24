/* Copyright Airship and Contributors */

package ti.airship.utils

import com.urbanairship.json.JsonMap
import com.urbanairship.json.JsonSerializable
import com.urbanairship.json.JsonValue
import org.appcelerator.kroll.KrollDict
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

fun Array<Any>.toStringSet(): Set<String> {
    return map { it.toString() }.toSet()
}

fun KrollDict.toJson(): JsonMap {
    return JsonValue.wrapOpt(this).optMap()
}

fun KrollDict.putJson(key: String, json: JsonSerializable) {
    val jsonValue = json.toJsonValue()
    if (jsonValue.isJsonList) {
        val array = JSONArray(jsonValue.toString())
        this[key] = KrollDict.fromJSON(array)
    } else if (jsonValue.isJsonMap) {
        val jsonObject = JSONObject(jsonValue.toString())
        this[key] = KrollDict.fromJSON(jsonObject)
    } else {
        this[key] = jsonValue.value
    }
}

fun JsonMap.toKrollDict(): KrollDict {
    val jsonObject = JSONObject(this.toString())
    return KrollDict(jsonObject)
}

fun JsonSerializable.toAny(): Any? {
    return try {
        val jsonValue = toJsonValue()
        if (jsonValue.isJsonList) {
            JSONArray(jsonValue.toString())
        } else if (jsonValue.isJsonMap) {
            JSONObject(jsonValue.toString())
        } else {
            jsonValue.value
        }
    } catch (e: JSONException) {
        PluginLogger.error(e)
        null
    }
}
