//
//  APIRequest.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/22/25.
//
import Foundation

struct APIRequest {
    let url: URL
    let method: HTTPMethod
    let hearders: [String: String]?
    let queryParams: [String: Any]?
    let body: Data?
}
