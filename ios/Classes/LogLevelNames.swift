/* Copyright Airship and Contributors */

import Foundation
import AirshipCore

struct LogLevelNames {
    static let map: [String: LogLevel] = [
        verbose: LogLevel.trace,
        debug: LogLevel.debug,
        info: LogLevel.info,
        warning: LogLevel.warn,
        error: LogLevel.error,
        LogLevelNames.none: LogLevel.none
    ]

    static let verbose = "verbose"
    static let debug = "debug"
    static let info = "info"
    static let warning = "warning"
    static let error = "error"
    static let none = "none"
}

extension LogLevel {
    static func parse(name: String) throws -> LogLevel {
        guard let logLevel = LogLevelNames.map[name.lowercased()] else {
            throw AirshipErrors.error("Invalid log level: \(name)")
        }

        return logLevel
    }
}
