//
//  LoggerProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/22/25.
//

import Foundation

protocol LoggerProtocol: Sendable {
    func log(_ message: String, level: LogLevel)
}
