//
//  CompositeInterceptor.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Alamofire

final class CompositeInterceptor: RequestInterceptor, @unchecked Sendable {
    private let adaptors: [RequestAdapter]
    private let retriers: [RequestRetrier]
    
    init(adaptors: [RequestAdapter], retriers: [RequestRetrier]) {
        self.adaptors = adaptors
        self.retriers = retriers
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        adapt(urlRequest, with: adaptors, session: session, completion: completion)
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        handleRetry(request: request, session: session, error: error, retriers: retriers, completion: completion)
    }
    
    private func adapt(_ request: URLRequest, with adaptors: [RequestAdapter], session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let first = adaptors.first else {
            completion(.success(request))
            return
        }
        
        let remaining = Array(adaptors.dropFirst())
        first.adapt(request, for: session) { result in
            switch result {
            case .success(let adaptedRequest):
                self.adapt(adaptedRequest, with: remaining, session: session, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleRetry(request: Request, session: Session, error: Error, retriers: [RequestRetrier], completion: @escaping (RetryResult) -> Void) {
        guard let first = retriers.first else {
            completion(.doNotRetry)
            return
        }
        
        let remaining = Array(retriers.dropFirst())
        first.retry(request, for: session, dueTo: error) { retryResult in
            switch retryResult {
            case .retry, .retryWithDelay(_):
                completion(retryResult)
            case .doNotRetry:
                self.handleRetry(request: request, session: session, error: error, retriers: remaining, completion: completion)
            case .doNotRetryWithError(let retryError):
                completion(.doNotRetryWithError(retryError))
            @unknown default:
                completion(.doNotRetry)
            }
        }
    }
}
