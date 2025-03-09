//
//  MockRecipeRepository.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

import Foundation

@testable import dishcovery

struct MockRecipeRepository: RecipeRepositoryProtocol {
    
    let mockData: [RecipeModel]
    let mockTotalResult: Int
    
    
    init (mockTotalResult: Int, mockData: [RecipeModel]) {
        self.mockTotalResult = mockTotalResult
        self.mockData = mockData
    }
    
    func query(query: String, offset: Int, limit: Int) async throws -> (total: Int, recipes: [RecipeModel]) {
        return (mockTotalResult, mockData)
    }
    
    func clearCache() async throws {
        // Do nothing here
    }
    
    
}
