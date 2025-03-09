//
//  SwiftyBeaverLogger.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/22/25.
//
import Foundation
import SwiftyBeaver


final class SwiftyBeaverLogger: LoggerProtocol {
    static var shared: LoggerProtocol = SwiftyBeaverLogger()
    private let log = SwiftyBeaver.self
    private let logLevel: LogLevel
    
    private init() {
        self.logLevel = AppConfig.logLevel
        
        // Only add destinations if logLevel is not 'none'
        guard logLevel != .none else {
            return
        }
        
        // Configure SwiftyBeaver destinations
        let console = ConsoleDestination()
        let file = FileDestination()
        
        // Customize log formats if desired
        console.format = "$DHH:mm:ss$d $L $M"
        file.format = "$Dyyyy-MM-dd HH:mm:ss$d $L $M"
        console.logPrintWay = .logger(subsystem: "Main", category: "UI")
        console.useTerminalColors = true
        
        // Add destinations to SwiftyBeaver
        log.addDestination(console)
//        log.addDestination(file)
    }
    
    func log(_ message: String, level: LogLevel) {
        guard shouldLog(level: level) else { return }
        
        switch logLevel {
        case .verbose:
            log.verbose(message)
        case .debug:
            log.debug(message)
        case .info:
            log.info(message)
        case .warning:
            log.warning(message)
        case .error:
            log.error(message)
        case .none:
            break
        }
    }
    private func shouldLog(level: LogLevel) -> Bool {
        // If current log level is .none, do not log anything
        if level == .none {
            return false
        }
        
        // Define the hierarchy of log levels
        let levels: [LogLevel] = [.verbose, .debug, .info, .warning, .error]
        
        // Determine the index of the current log level
        guard let currentIndex = levels.firstIndex(of: level) else { return false }
        
        // Determine the index of the message's level
        guard let messageIndex = levels.firstIndex(of: level) else { return false }
        
        // Log if the message's level is >= current log level
        return messageIndex >= currentIndex
    }
}
