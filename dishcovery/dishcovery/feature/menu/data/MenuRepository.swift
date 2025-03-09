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
    
    func search(query: String,
                        offset: Int,
                        number: Int) async throws -> [Menu] {
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
            headers: nil,
            queryParams: queryParams,
            body: nil
        )
        
        do {
            let response: SearchMenuResult = try await networkService.performRequest(request)
            try await saveToCache(response.menus, clearOld: offset == 0)
            return response.menus
        } catch {
            let cached = try await loadFromCache()
            if !cached.isEmpty {
                return cached
            } else {
                throw RepositoryError.networkError(error)
            }
        }
    }
    
    @MainActor
    private func loadFromCache() async throws -> [Menu] {
        let descriptor = FetchDescriptor<Menu>()
        return try modelContext.fetch(descriptor)
    }
    
    @MainActor
    private func saveToCache(_ newItems: [Menu], clearOld: Bool) async throws {
        if clearOld {
            let existing = try await loadFromCache()
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
