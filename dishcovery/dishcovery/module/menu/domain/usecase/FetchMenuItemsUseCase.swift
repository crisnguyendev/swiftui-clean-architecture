//
//  FetchMenuItemsUseCase.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

struct FetchMenuItemsUseCase: FetchMenuItemsUseCaseProtocol {
    private let repository: MenuRepositoryProtocol
    
    init(repository: MenuRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(query: String) async throws -> [MenuItem] {
        return try await repository.fetchMenuItems(query: query)
    }
    
}
