//
//  NetworkLogger.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Alamofire

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.dishcovery.networkLogger")
    private let logger = SwiftyBeaverLogger.shared
    
    /// Logs when a request is created.
    func requestDidResume(_ request: Request) {
        guard let url = request.request?.url else { return }
        let method = request.request?.httpMethod ?? "UNKNOWN"
        logger.log("📡 [Request] \(method) \(url.absoluteString)", level: .info)
        
        if let headers = request.request?.allHTTPHeaderFields {
            logger.log("📡 [Headers] \(headers)", level: .debug)
        }
        
        if let body = request.request?.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            logger.log("📡 [Body] \(bodyString)", level: .debug)
        }
    }
    
    /// Logs when a response is received.
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let url = request.request?.url else { return }
        let statusCode = response.response?.statusCode ?? 0
        logger.log("📡 [Response] \(url.absoluteString) - Status Code: \(statusCode)", level: .info)
        
        if let data = response.data,
           let responseString = String(data: data, encoding: .utf8) {
            logger.log("📡 [Response Body] \(responseString)", level: .debug)
        }
        
        if let error = response.error {
            logger.log("❌ [Error] \(error.localizedDescription)", level: .error)
        }
    }
}
