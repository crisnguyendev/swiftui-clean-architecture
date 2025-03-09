//
//  SearchRecipeUseCaseProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

protocol SearchRecipeUseCaseProtocol {
    mutating func fetch(query: String) async throws -> [RecipeModel]
    mutating func loadMoreData() async throws -> [RecipeModel]
    mutating func refresh() async throws -> [RecipeModel]
    func hasMoreData() -> Bool
}
