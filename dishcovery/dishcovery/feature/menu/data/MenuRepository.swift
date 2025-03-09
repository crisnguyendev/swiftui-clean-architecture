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
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func query(query: String, offset: Int, limit: Int) async throws-> (total: Int, recipes: [MenuModel]){
        guard let url = URL(string: "\(AppConfig.baseURL)/food/menuItems/search")
        else {
            throw RepositoryError.invalidURL
        }
        
        let queryParams: [String: Any] = [
            "query": query,
            "offset": offset,
            "number": limit
        ]
        
        let request = APIRequest(
            url: url,
            method: .get,
            headers: nil,
            queryParams: queryParams,
            body: nil
        )
        
        do {
            let response: SearchMenuResultDTO = try await networkService.performRequest(request)
            let totalResults = response.totalResults
            let data = response.data.map { MenuModel(dto: $0) }
            return (totalResults, data)
        } catch {
            throw RepositoryError.networkError(error)
        }
    }
}
