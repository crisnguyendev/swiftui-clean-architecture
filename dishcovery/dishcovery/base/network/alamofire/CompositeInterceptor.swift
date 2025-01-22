//
//  CompositeInterceptor.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Alamofire
/// Interceptor that combines AuthorizationInterceptor and RetryInterceptor
final class CompositeInterceptor: RequestInterceptor, @unchecked Sendable {
    private let authorizationInterceptor: AuthorizationInterceptor
    private let retryInterceptor: RetryInterceptor

    init(authorizationInterceptor: AuthorizationInterceptor, retryInterceptor: RetryInterceptor) {
        self.authorizationInterceptor = authorizationInterceptor
        self.retryInterceptor = retryInterceptor
    }

    /// Adapts the request by delegating to the AuthorizationInterceptor
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        authorizationInterceptor.adapt(urlRequest, for: session, completion: completion)
    }

    /// Handles retry by delegating first to the AuthorizationInterceptor, then to the RetryInterceptor
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        authorizationInterceptor.retry(request, for: session, dueTo: error) { authRetryResult in
            switch authRetryResult {
            case .retry:
                completion(.retry)
            case .retryWithDelay(let delay):
                completion(.retryWithDelay(delay))
            case .doNotRetry:
                // If AuthorizationInterceptor does not retry, let RetryInterceptor handle it
                self.retryInterceptor.retry(request, for: session, dueTo: error, completion: completion)
            case .doNotRetryWithError(let retryError):
                // Pass the specific error to the completion handler
                completion(.doNotRetryWithError(retryError))
            @unknown default:
                // Handle any future cases gracefully
                completion(.doNotRetry)
            }
        }
    }
}

