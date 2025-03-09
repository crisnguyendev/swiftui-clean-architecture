//
//  MenuRepositoryProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

protocol MenuRepositoryProtocol {
    func query(query: String, offset: Int, limit: Int) async throws-> (total: Int, recipes: [MenuModel])
}
