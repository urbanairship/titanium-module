/* Copyright Urban Airship and Contributors */

package ti.airship.utils;

import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RestrictTo;

import com.urbanairship.LoggingCore;

/**
 * Cordova logger for Urban Airship.
 */
public final class PluginLogger {

    private static LoggingCore logger = new LoggingCore(Log.ERROR, "UALib-Ti.Airship");

    /**
     * Private, unused constructor
     */
    private PluginLogger() {
    }

    public static void logCall(@NonNull String name, @Nullable Object... args) {
        debug("%s: %s", name, args);
    }

    public static void setLogLevel(int logLevel) {
        logger.setLogLevel(logLevel);
    }

    public static void warn(@NonNull String message, @Nullable Object... args) {
        logger.log(Log.WARN, null, message, args);
    }

    public static void warn(@NonNull Throwable t, @NonNull String message, @Nullable Object... args) {
        logger.log(Log.WARN, t, message, args);
    }

    public static void warn(@NonNull Throwable t) {
        logger.log(Log.WARN, t, null);
    }

    public static void verbose(@NonNull String message, @Nullable Object... args) {
        logger.log(Log.VERBOSE, null, message, args);
    }

    public static void debug(@NonNull String message, @Nullable Object... args) {
        logger.log(Log.DEBUG, null, message, args);
    }

    public static void debug(@NonNull Throwable t, @NonNull String message, @Nullable Object... args) {
        logger.log(Log.DEBUG, t, message, args);
    }

    public static void info(@NonNull String message, @NonNull Object... args) {
        logger.log(Log.INFO, null, message, args);
    }

    public static void info(@NonNull Throwable t, @NonNull String message, @Nullable Object... args) {
        logger.log(Log.INFO, t, message, args);
    }

    public static void error(@NonNull String message, @Nullable Object... args) {
        logger.log(Log.ERROR, null, message, args);
    }

    public static void error(@NonNull Throwable t) {
        logger.log(Log.ERROR, t, null);
    }

    public static void error(@NonNull Throwable t, @NonNull String message, @Nullable Object... args) {
        logger.log(Log.ERROR, t, message, args);
    }
}