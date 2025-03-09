//
//  MockSearchUseCase.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//
import Foundation
@testable import dishcovery

struct MockSearchUseCase: SearchRecipeUseCaseProtocol {
    
    var result: Result<[RecipeModel], Error>?
    var mockHasMoreData: Bool?
    
    
    mutating func fetch(query: String) async throws -> [RecipeModel] {
        return try getData()
    }
    
    mutating func loadMoreData() async throws -> [RecipeModel] {
        return try getData()
    }
    
    mutating func refresh() async -> [RecipeModel] {
        do {
            return try getData()
        } catch {
            return []
        }
    }
    
    func hasMoreData() -> Bool {
        guard let mockResponse = mockHasMoreData else {
            fatalError("Need to set hasMoreData")
        }
        return mockResponse
    }
    
    private func getData() throws -> [RecipeModel] {
        guard  let result = result else {
            fatalError("Need to set result")
        }
        
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    
}
