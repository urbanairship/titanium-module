/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

@objc(TiAirshipAutopilot)
public class TiAirshipAutopilot: NSObject {
    @objc(attemptTakeOffWithLaunchOptions:)
    public static func attemptTakeOff(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        Log.debug("attemptTakeOff: \(String(describing: launchOptions))")

        guard !Airship.isFlying else {
            return;
        }

        guard let config = config() else {
            return
        }

        Log.debug("Taking off! \(config)")
        Airship.takeOff(config, launchOptions: launchOptions)
    }

    static func config() -> Config? {
        guard let storedConfig: [String : Any] = PluginStore.read(.config) else {
            return nil
        }

        let airshipConfig = Config.default()

        let defaultEnvironment = Environment.fromConfig(storedConfig["default"])
        let prodEnvironment = Environment.fromConfig(storedConfig["production"])
        let devEnvironment = Environment.fromConfig(storedConfig["development"])


        if let appKey = defaultEnvironment?.appKey, let appSecret = defaultEnvironment?.appSecret {
            airshipConfig.defaultAppKey = appKey
            airshipConfig.defaultAppSecret = appSecret
        }

        if let appKey = prodEnvironment?.appKey, let appSecret = prodEnvironment?.appSecret {
            airshipConfig.productionAppKey = appKey
            airshipConfig.productionAppSecret = appSecret
        }

        if let appKey = devEnvironment?.appKey, let appSecret = devEnvironment?.appSecret {
            airshipConfig.developmentAppKey = appKey
            airshipConfig.developmentAppSecret = appSecret
        }

        if let logLevel = (prodEnvironment?.logLevel ?? defaultEnvironment?.logLevel) {
            airshipConfig.productionLogLevel = logLevel;
        }

        if let logLevel = (devEnvironment?.logLevel ?? defaultEnvironment?.logLevel) {
            airshipConfig.developmentLogLevel = logLevel;
        }

        if storedConfig["inProduction"] != nil {
            airshipConfig.inProduction = storedConfig["inProduction"] as? Bool ?? false
        }

        if let iOSConfig = storedConfig["iOS"] as? [String : Any] {
            airshipConfig.itunesID = iOSConfig["itunesId"] as? String
        }

        if let site = (storedConfig["site"] as? String)?.asSite() {
            airshipConfig.site = site
        }

        if let features = storedConfig["enabledFeatures"] as? [String] {
            airshipConfig.enabledFeatures = Utils.parseFeatures(features)
        }

        if let allowList = storedConfig["urlAllowList"] as? [String] {
            airshipConfig.urlAllowList = allowList
        }

        if let allowList = storedConfig["urlAllowListScopeOpenUrl"] as? [String] {
            airshipConfig.urlAllowListScopeOpenURL = allowList
        }

        if let allowList = storedConfig["urlAllowListScopeJavaScriptInterface"] as? [String] {
            airshipConfig.urlAllowListScopeJavaScriptInterface = allowList
        }

        return airshipConfig
    }
}


extension String {
    func asLogLevel() -> LogLevel? {
        switch(self) {
        case "verbose": return .trace
        case "debug": return .debug
        case "info": return .info
        case "warning": return .warn
        case "error": return .error
        case "none": return LogLevel.none
        default: return nil
        }
    }

    func asSite() -> CloudSite? {
        switch(self) {
        case "us": return .us
        case "eu": return .eu
        default: return nil
        }
    }
}

struct Environment {
    let logLevel: LogLevel?
    let appKey: String?
    let appSecret: String?

    static func fromConfig(_ config: Any?) -> Environment? {
        guard let config = config as? [String : String] else {
            return nil
        }

        return Environment(logLevel: config["logLevel"]?.asLogLevel(),
                           appKey: config["appKey"],
                           appSecret: config["appSecret"])
        
    }
}
