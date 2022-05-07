/* Copyright Airship and Contributors */

import Foundation
class PluginStore {
    private static let defaults = UserDefaults(suiteName: "ti.airship")!

    enum Key: String {
        case config
    }

    public static func write(_ key: Key, value: Any?) -> Void {
        if let value = value {
            defaults.set(value, forKey: key.rawValue)
        } else {
            defaults.removeObject(forKey: key.rawValue)
        }
    }

    public static func read<T>(_ key: Key) -> T? {
        return defaults.value(forKey: key.rawValue) as? T
    }

    public static func read<T>(_ key: Key, defaultValue: T) -> T {
        return read(key) ?? defaultValue
    }


}

