//
//  MenuRepositoryProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

protocol MenuRepositoryProtocol {
    func fetchMenuItems(query: String, offset: Int, number: Int) async throws -> [MenuItem]
}
