//
//  NetworkSessionProvider.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/17/25.
//

import Foundation
import Alamofire

final class NetworkSessionProvider {
    static func makeSession() -> Session {
        // Create a basic Alamofire Session without any interceptors or SSL pinning
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 30 // seconds
//        configuration.timeoutIntervalForResource = 60 // seconds
//        
//        // No interceptors added for now
//        let session = Session(configuration: configuration,
//                              serverTrustManager: SecurityManager.makeServerTrustManager(),
//                              eventMonitors: [NetworkLogger()])
        
        return Session()
    }
    
}
