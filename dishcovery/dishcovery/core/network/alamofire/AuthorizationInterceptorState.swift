//
//  AuthorizationInterceptorState.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Alamofire

actor AuthorizationInterceptorState {
    var isRefreshing = false
    var requestsToRetry: [(RetryResult) -> Void] = []
    
    func addRequestToRetry(_ completion: @escaping (RetryResult) -> Void) {
        requestsToRetry.append(completion)
    }
    
    func setRefreshing(_ refreshing: Bool) {
        isRefreshing = refreshing
    }
    
    func processRequestsToRetry(with result: RetryResult) {
        for completion in requestsToRetry {
            completion(result)
        }
        requestsToRetry.removeAll()
    }
}
