//
//  MenuRepositoryProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

protocol MenuRepositoryProtocol {
    func fetchMenuItems(query: String) async throws -> [MenuItem]
}
