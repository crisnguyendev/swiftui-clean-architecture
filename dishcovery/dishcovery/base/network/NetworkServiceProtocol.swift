//
//  NetworkServiceProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/11/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}
