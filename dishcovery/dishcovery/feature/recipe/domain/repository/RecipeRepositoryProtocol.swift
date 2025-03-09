//
//  RecipeRepositoryProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

protocol RecipeRepositoryProtocol {
    func query(query: String, offset: Int, limit: Int) async throws-> (total: Int, recipes: [RecipeModel])
    func clearCache() async throws
}
