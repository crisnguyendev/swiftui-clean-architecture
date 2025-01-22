//
//  NetworkSessionProvider.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/17/25.
//

import Foundation
import Alamofire

final class NetworkSessionProvider {
    static func makeSession(interceptor: RequestInterceptor? = nil) -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30 // seconds
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        let networkLogger = NetworkLogger()
        let session = Session(configuration: configuration, interceptor: interceptor, eventMonitors: [networkLogger])
        return session
    }
    
}
