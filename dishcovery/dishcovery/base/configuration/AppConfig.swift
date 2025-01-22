//
//  AppConfig.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/17/25.
//

import Foundation

struct AppConfig {
    static let baseURL: String = {
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "https://default.example.com"
    }()
    
    static let apiKey: String = {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }()
    
    static let logLevel: LogLevel = {
        // Access the LogLevel string from Info.plist
        let logLevelString = Bundle.main.object(forInfoDictionaryKey: "LOG_LEVEL") as? String ?? "info"
        
        // Match the string to the LogLevel enum
        return LogLevel(rawValue: logLevelString.lowercased()) ?? .info
    }()
}
