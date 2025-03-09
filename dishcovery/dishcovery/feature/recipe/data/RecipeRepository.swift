//
//  RecipeRepository.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//
import Foundation

@MainActor
struct RecipeRepository<RecipePersistentService: PersistentServiceProtocol>: RecipeRepositoryProtocol where RecipePersistentService.ModelType == RecipeEntity {
    
    private let networkService: NetworkServiceProtocol
    private let persistentService: RecipePersistentService
    
    init(
        networkService: NetworkServiceProtocol,
        persistentService: RecipePersistentService
    ) {
        self.networkService = networkService
        self.persistentService = persistentService
    }
    
    func query(query: String, offset: Int, limit: Int) async throws -> (total: Int, recipes: [RecipeModel]) {
        do {
            let result = try await loadFromNetwork(query: query, offset: offset, number: limit)
            try await saveToCache(recipes: result.data)
            return (total: result.total, recipes: result.data.map { RecipeModel(dto: $0) })
        } catch {
            let cachedData = try await loadFromCache().map { RecipeModel(entity: $0) }
            return (total: cachedData.count, recipes: cachedData)
        }
    }
    
    private func loadFromNetwork(query: String, offset: Int, number: Int) async throws -> SearchRecipeResultDTO {
        guard let url = URL(string: "\(AppConfig.baseURL)/recipes/complexSearch") else {
            throw APIError.invalidURL
        }
        
        let params: [String: Any] = [
            "apiKey": AppConfig.apiKey,
            "query": query,
            "offset": offset,
            "number": number
        ]
        
        let request = APIRequest(
            url: url,
            method: .get,
            headers: nil,
            queryParams: params,
            body: nil
        )
        
        do {
            return try await networkService.performRequest(request)
        } catch {
            throw RepositoryError.networkError(error)
        }
    }
    
    private func loadFromCache() async throws -> [RecipeEntity] {
        return try await persistentService.fetch(predicate: nil)
    }
    
    private func saveToCache(recipes: [RecipeDTO]) async throws {
        for recipe in recipes {
            try await persistentService.create(RecipeEntity(dto: recipe))
        }
        try await persistentService.commit()
    }
    
    func clearCache() async throws {
        try await persistentService.clearAll()
    }
}
