//
//  RetryInterceptor.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Alamofire
import Foundation

/// Interceptor responsible for retrying failed requests based on defined criteria
final class RetryInterceptor: RequestInterceptor, @unchecked Sendable {
    private let maxRetryCount: Int
    private let retryDelay: TimeInterval

    init(maxRetryCount: Int = 3, retryDelay: TimeInterval = 1.0) {
        self.maxRetryCount = maxRetryCount
        self.retryDelay = retryDelay
    }

    /// Determines whether to retry a failed request
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Determine if the request should be retried
        if shouldRetry(for: request, dueTo: error) {
            let retryCount = request.retryCount
            if retryCount < maxRetryCount {
                // Exponential backoff strategy
                let delay = retryDelay * pow(2.0, Double(retryCount))
                completion(.retryWithDelay(delay))
                return
            }
        }
        // Do not retry
        completion(.doNotRetry)
    }

    /// Determines if a request should be retried based on the error
    private func shouldRetry(for request: Request, dueTo error: Error) -> Bool {
        // Determine if the error is transient and the request is retryable
        if let afError = error.asAFError {
            switch afError {
            case .sessionTaskFailed(let urlError as URLError):
                // Retry for specific URLErrors
                return urlError.code == .timedOut ||
                       urlError.code == .cannotFindHost ||
                       urlError.code == .cannotConnectToHost ||
                       urlError.code == .networkConnectionLost ||
                       urlError.code == .dnsLookupFailed
            case .responseValidationFailed(reason: .unacceptableStatusCode(code: let statusCode)):
                // Optionally retry for specific status codes (e.g., 500, 502, 503, 504)
                return [500, 502, 503, 504].contains(statusCode)
            default:
                return false
            }
        }
        return false
    }
}
