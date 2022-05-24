/* Copyright Urban Airship and Contributors */

package ti.airship.utils

import android.util.Log
import com.urbanairship.LoggingCore

/**
 * Cordova logger for Urban Airship.
 */
object PluginLogger {
    private val logger = LoggingCore(Log.ERROR, "UALib-Ti.Airship")
    fun logCall(name: String, vararg args: Any?) {
        debug("$name: ${args.contentDeepToString()}")
    }

    fun setLogLevel(logLevel: Int) {
        logger.logLevel = logLevel
    }

    fun warn(message: String, vararg args: Any?) {
        logger.log(Log.WARN, null, message, *args)
    }

    fun warn(t: Throwable, message: String, vararg args: Any?) {
        logger.log(Log.WARN, t, message, *args)
    }

    fun warn(t: Throwable) {
        logger.log(Log.WARN, t, null)
    }

    fun verbose(message: String, vararg args: Any?) {
        logger.log(Log.VERBOSE, null, message, *args)
    }

    fun debug(message: String, vararg args: Any?) {
        logger.log(Log.DEBUG, null, message, *args)
    }

    fun debug(t: Throwable, message: String, vararg args: Any?) {
        logger.log(Log.DEBUG, t, message, *args)
    }

    fun info(message: String, vararg args: Any) {
        logger.log(Log.INFO, null, message, *args)
    }

    fun info(t: Throwable, message: String, vararg args: Any?) {
        logger.log(Log.INFO, t, message, *args)
    }

    fun error(message: String, vararg args: Any?) {
        logger.log(Log.ERROR, null, message, *args)
    }

    fun error(t: Throwable) {
        logger.log(Log.ERROR, t, null)
    }

    fun error(t: Throwable, message: String, vararg args: Any?) {
        logger.log(Log.ERROR, t, message, *args)
    }


}