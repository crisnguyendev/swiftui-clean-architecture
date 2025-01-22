//
//  Request.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/11/25.
//

import Foundation

struct NetworkRequest {
    let url: URL
    let method: HttpMethod
    let hearders: [String: String]?
    let queryParams: [String: String]?
    let body: Data?
    let requireAuth: Bool
}
