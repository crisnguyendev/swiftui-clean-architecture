//
//  NetworkServiceProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/11/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func performRequest<T: Decodable>(_ request: APIRequest) async throws -> T
}
