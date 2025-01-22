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
         modelContext: ModelContext,
         apiKey: String) {
        self.networkService = networkService
        self.modelContext = modelContext
    }
    
    func fetchMenuItems(query: String) async throws -> [MenuItem] {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=\(encodedQuery)&apiKey=\(AppConfig.apiKey)") else {
            throw RepositoryError.invalidURL
        }
        
        do {
            let response: MenuSearchResponse = try await networkService.fetch(from: url)
            let menuItems = response.menuItems
            
            try await cacheMenuItems(menuItems)
            print("fetchMenuItems: \(menuItems.count)")
            return menuItems
        } catch {
            // Attempt to retrieve from cache
            let cachedItems = try await fetchMenuItemsFromCache()
            if !cachedItems.isEmpty {
                return cachedItems
            } else {
                throw RepositoryError.networkError(error)
            }
        }
    }
    
    @MainActor
    private func fetchMenuItemsFromCache() async throws -> [MenuItem] {
        let fetchDescriptor = FetchDescriptor<MenuItem>()
        let menuItems = try modelContext.fetch(fetchDescriptor)
        print("fetchMenuItemsFromCache: \(menuItems.count)")
        return menuItems
    }
    
    @MainActor
    private func cacheMenuItems(_ menuItems: [MenuItem]) async throws {
        let context = modelContext
        
        // Optionally, clear existing cache before saving new items
        let existingItems = try await fetchMenuItemsFromCache()
        for item in existingItems {
            context.delete(item)
        }
        
        // Insert new items
        for item in menuItems {
            context.insert(item)
        }
        
        // Save changes
        try context.save()
    }
}
