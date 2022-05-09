/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

class PluginStore {

    private static let defaults = UserDefaults(suiteName: "ti.airship")!

    public static var config: Config? {
        get {
            if let configDict: [String: Any] = self.read("config") {
                return try? ConfigUtils.parseConfig(configDict)
            }
            return nil
        }
        set {
            self.write("config", value: newValue)
        }
    }

    public static var presentationOptions: UNNotificationPresentationOptions {
        get {
            return self.read("presentationOptions") ?? []
        }
        set {
            self.write("presentationOptions", value: newValue)
        }
    }

    public static func getUseCustomPreferenceCenter(_ preferenceCenterID: String) -> Bool {
        return self.read("useCustomPreferenceCenter-\(preferenceCenterID)") ?? false
    }

    public static func setUseCustomPreferenceCenter(_ preferenceCenterID: String, enabled: Bool) {
        self.write("useCustomPreferenceCenter-\(preferenceCenterID)", value: enabled)
    }

    private static func write(_ key: String, value: Any?) -> Void {
        if let value = value {
            defaults.set(value, forKey: key)
        } else {
            defaults.removeObject(forKey: key)
        }
    }

    private static func read<T>(_ key: String) -> T? {
        return defaults.value(forKey: key) as? T
    }
}

