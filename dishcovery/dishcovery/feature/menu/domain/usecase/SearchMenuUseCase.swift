//
//  SearchMenuUseCase.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

struct SearchMenuUseCase: SearchMenuUseCaseProtocol {
    private let repository: MenuRepositoryProtocol
    
    private let limit = 15
    
    private var currentOffset = 0
    private var currentQuery: String = ""
    private var totalResults = 0
    
    init(repository: MenuRepositoryProtocol) {
        self.repository = repository
    }
    
    mutating func fetch(query: String) async throws -> [MenuModel] {
        currentQuery = query
        currentOffset = 0
        let (total, data) = try await repository.query(query: currentQuery, offset: currentOffset, limit: limit)
        totalResults = total
        return data
    }
    
    func hasMoreData() -> Bool {
        return currentOffset < totalResults
    }
    
    
    mutating func loadMoreData() async throws -> [MenuModel] {
        currentOffset += limit
        let (_, data) = try await repository.query(query: currentQuery, offset: currentOffset, limit: limit)
        return data
    }
    
    mutating func refresh() async throws -> [MenuModel] {
        return try await fetch(query: currentQuery)
    }

}
