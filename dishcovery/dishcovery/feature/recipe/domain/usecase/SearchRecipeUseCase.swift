//
//  SearchRecipeUseCase.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

struct SearchRecipeUseCase: SearchRecipeUseCaseProtocol {
    
    private let repository: RecipeRepositoryProtocol
    
    private let limit = 15
    
    private var currentOffset = 0
    private var currentQuery: String = ""
    private var totalResults = 0
    
    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    mutating func fetch(query: String) async throws -> [RecipeModel] {
        currentQuery = query
        currentOffset = 0
        try await repository.clearCache()
        let (total, data) = try await repository.query(query: currentQuery, offset: currentOffset, limit: limit)
        totalResults = total
        return data
    }
    
    func hasMoreData() -> Bool {
        return currentOffset < totalResults
    }
    
    
    mutating func loadMoreData() async throws -> [RecipeModel] {
        currentOffset += limit
        let (_, data) = try await repository.query(query: currentQuery, offset: currentOffset, limit: limit)
        return data
    }
    
    mutating func refresh() async throws -> [RecipeModel] {
        return try await fetch(query: currentQuery)
    }
}


