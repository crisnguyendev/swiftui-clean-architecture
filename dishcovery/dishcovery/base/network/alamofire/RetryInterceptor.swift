//
//  RetryInterceptor.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Alamofire
import Foundation

final class RetryInterceptor: RequestInterceptor, @unchecked Sendable {
    private let maxRetryCount: Int
    private let retryDelay: TimeInterval

    init(maxRetryCount: Int = 3, retryDelay: TimeInterval = 1.0) {
        self.maxRetryCount = maxRetryCount
        self.retryDelay = retryDelay
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if shouldRetry(for: request, dueTo: error) {
            let retryCount = request.retryCount
            if retryCount < maxRetryCount {
                let delay = retryDelay * pow(2.0, Double(retryCount))
                completion(.retryWithDelay(delay))
                return
            }
        }
        completion(.doNotRetry)
    }

    private func shouldRetry(for request: Request, dueTo error: Error) -> Bool {
        if let afError = error.asAFError {
            switch afError {
            case .sessionTaskFailed(let urlError as URLError):
                return urlError.code == .timedOut ||
                       urlError.code == .cannotFindHost ||
                       urlError.code == .cannotConnectToHost ||
                       urlError.code == .networkConnectionLost ||
                       urlError.code == .dnsLookupFailed
            case .responseValidationFailed(reason: .unacceptableStatusCode(code: let statusCode)):
                return [500, 502, 503, 504].contains(statusCode)
            default:
                return false
            }
        }
        return false
    }
}
