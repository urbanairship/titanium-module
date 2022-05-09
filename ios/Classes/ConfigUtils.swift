/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct ConfigUtils {
    static func parseConfig(_ configDict: [String : Any]?) throws -> Config? {
        guard let configDict = configDict else {
            return nil
        }

        let airshipConfig = Config.default()

        let defaultEnvironment = Environment.fromConfig(configDict["default"])
        let prodEnvironment = Environment.fromConfig(configDict["production"])
        let devEnvironment = Environment.fromConfig(configDict["development"])


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

        if configDict["inProduction"] != nil {
            airshipConfig.inProduction = configDict["inProduction"] as? Bool ?? false
        }

        if let iOSConfig = configDict["iOS"] as? [String : Any] {
            airshipConfig.itunesID = iOSConfig["itunesId"] as? String
        }

        if let site = (configDict["site"] as? String)?.asSite() {
            airshipConfig.site = site
        }

        if let features = configDict["enabledFeatures"] as? [String] {
            airshipConfig.enabledFeatures = try Features.parse(features)
        }

        if let allowList = configDict["urlAllowList"] as? [String] {
            airshipConfig.urlAllowList = allowList
        }

        if let allowList = configDict["urlAllowListScopeOpenUrl"] as? [String] {
            airshipConfig.urlAllowListScopeOpenURL = allowList
        }

        if let allowList = configDict["urlAllowListScopeJavaScriptInterface"] as? [String] {
            airshipConfig.urlAllowListScopeJavaScriptInterface = allowList
        }

        return airshipConfig
    }
}


private extension String {
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

private struct Environment {
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

