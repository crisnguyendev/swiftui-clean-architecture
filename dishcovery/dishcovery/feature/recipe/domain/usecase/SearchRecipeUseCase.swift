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
        if (query != currentQuery) {
            try await repository.clearCache()
        }
        currentQuery = query
        currentOffset = 0
        let (total, data) = try await repository.query(query: currentQuery, offset: currentOffset, limit: limit)
        totalResults = total
        return data
    }
    
    func hasMoreData() -> Bool {
        return currentOffset < totalResults
    }
    
    
    mutating func loadMoreData() async throws -> [RecipeModel] {
        currentOffset += limit
        let (total, data) = try await repository.query(query: currentQuery, offset: currentOffset, limit: limit)
        totalResults = total
        return data
    }
    
    mutating func refresh() async -> [RecipeModel] {
        do {
            let refreshData = try await fetch(query: currentQuery)
            return refreshData
        } catch {
            return (try? await repository.loadFromCache()) ?? []
        }
    }
}


