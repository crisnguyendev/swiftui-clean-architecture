//
//  MenuRepository.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

import Foundation
import SwiftData


final class MenuRepository: MenuRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let modelContext: ModelContext
    
    init(networkService: NetworkServiceProtocol,
         modelContext: ModelContext) {
        self.networkService = networkService
        self.modelContext = modelContext
    }
    
    func fetchMenuItems(query: String,
                        offset: Int,
                        number: Int) async throws -> [MenuItem] {
        guard let url = URL(string: "\(AppConfig.baseURL)/food/menuItems/search")
        else {
            throw RepositoryError.invalidURL
        }
        
        let queryParams: [String: Any] = [
            "query": query,
            "offset": offset,
            "number": number
        ]
        
        let request = APIRequest(
            url: url,
            method: .get,
            hearders: nil,
            queryParams: queryParams,
            body: nil
        )
        
        do {
            let response: MenuSearchResponse = try await networkService.performRequest(request)
            try await cacheMenuItems(response.menuItems, clearOld: offset == 0)
            return response.menuItems
        } catch {
            let cached = try await readMenuItemsFromCache()
            if !cached.isEmpty {
                return cached
            } else {
                throw RepositoryError.networkError(error)
            }
        }
    }
    
    @MainActor
    private func readMenuItemsFromCache() async throws -> [MenuItem] {
        let descriptor = FetchDescriptor<MenuItem>()
        return try modelContext.fetch(descriptor)
    }
    
    @MainActor
    private func cacheMenuItems(_ newItems: [MenuItem], clearOld: Bool) async throws {
        if clearOld {
            let existing = try await readMenuItemsFromCache()
            for item in existing {
                modelContext.delete(item)
            }
        }
        
        for item in newItems {
            modelContext.insert(item)
        }
        
        try modelContext.save()
    }
}
