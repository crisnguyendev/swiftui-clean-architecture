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
    
    func execute(query: String, offset: Int, number: Int) async throws -> [Menu] {
        try await repository.search(query: query, offset: offset, number: number)
    }
    
}
