//
//  AuthorizationInterceptor.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Alamofire

/// Interceptor responsible for adding authorization headers and handling token refresh
final class AuthorizationInterceptor: RequestInterceptor, @unchecked Sendable {
    private let state = AuthorizationInterceptorState()
    
    /// Adds the Authorization header to outgoing requests
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let token = TokenManager.shared.getAccessToken() {
            urlRequest.headers.add(.authorization(bearerToken: token))
        }
        completion(.success(urlRequest))
    }
    
    /// Handles retry logic for failed requests
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        Task {
            if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
                await state.addRequestToRetry(completion)
                
                if await !state.isRefreshing {
                    await state.setRefreshing(true)
                    do {
                        let _ = try await TokenManager.shared.refreshAccessToken()
                        print("Token refreshed successfully.")
                        await state.processRequestsToRetry(with: .retry)
                    } catch {
                        print("Token refresh failed: \(error)")
                        await state.processRequestsToRetry(with: .doNotRetryWithError(error))
                    }
                    
                    await state.setRefreshing(false)
                }
            } else {
                // Do not retry for other errors
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
