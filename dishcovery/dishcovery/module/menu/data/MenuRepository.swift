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
    
    func fetchMenuItems(query: String) async throws -> [MenuItem] {
        guard let url = URL(string: "\(AppConfig.baseURL)/food/menuItems/search") else {
            throw RepositoryError.invalidURL
        }
        
        let queryParameters: [String: Any] = [
            "query": query
        ]
        
        let request = APIRequest(
            url: url, method: .get,
            hearders: nil,
            queryParams: queryParameters,
            body: nil
        )
        
        do {
            let response: MenuSearchResponse = try await networkService.performRequest(request)
            let menuItems = response.menuItems
            
            try await cacheMenuItems(menuItems)
            print("fetchMenuItems: \(menuItems.count) items fetched and cached.")
            
            return menuItems
        } catch {
            // Attempt to retrieve menu items from cache in case of a network error.
            let cachedItems = try await fetchMenuItemsFromCache()
            if !cachedItems.isEmpty {
                print("fetchMenuItems: Retrieved \(cachedItems.count) items from cache due to network error.")
                return cachedItems
            } else {
                print("fetchMenuItems: No cached items available. Propagating network error.")
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
        
        let existingItems = try await fetchMenuItemsFromCache()
        for item in existingItems {
            context.delete(item)
        }
        
        for item in menuItems {
            context.insert(item)
        }
        
        try context.save()
    }
}
