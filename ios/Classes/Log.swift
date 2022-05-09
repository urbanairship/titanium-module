import Foundation
import os
import TitaniumKit


struct Log {

    private enum LogLevel: Int {
        case verbose
        case warning
        case error
    }

    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "ti.airship",
                                       category: "ti.airship")

    public static func debug(_ message: String,
                             fileID: String = #fileID,
                             line: Int = #line,
                             function: String = #function) {

        log(logLevel: LogLevel.verbose,
            message: message,
            fileID: fileID,
            line: line,
            function: function)
    }

    public static func warning(_ message: String,
                               fileID: String = #fileID,
                               line: Int = #line,
                               function: String = #function) {

        log(logLevel: LogLevel.warning,
            message: message,
            fileID: fileID,
            line: line,
            function: function)
    }

    public static func error(_ message: String,
                             fileID: String = #fileID,
                             line: Int = #line,
                             function: String = #function) {

        log(logLevel: LogLevel.error,
            message: message,
            fileID: fileID,
            line: line,
            function: function)
    }

    private static func log(logLevel: LogLevel,
                            message: String,
                            fileID: String,
                            line: Int,
                            function: String,
                            skipLogLevelCheck: Bool = true) {


        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            logger.log(level: logType(logLevel), "[\(logInitial(logLevel))] \(fileID) \(function) [Line \(line)] \(message)")
            NSLog("[\(logInitial(logLevel))] \(fileID) \(function) [Line \(line)] \(message)")
        } else {
            print("[\(logInitial(logLevel))] \(fileID) \(function) [Line \(line)] \(message)")
        }
    }

    private static func logInitial(_ logLevel: LogLevel) -> String {
        switch logLevel {
        case .verbose: return "D"
        case .warning: return "W"
        case .error: return "E"
        }
    }

    private static func logType(_ logLevel: LogLevel) -> OSLogType {
        switch logLevel {
        case .verbose: return OSLogType.debug
        case .warning: return OSLogType.info
        case .error: return OSLogType.error
        }
    }
}



