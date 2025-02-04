//
//  MockMenuRepository.swift
//  dishcovery
//
//  Created by Vu Nguyen on 2/4/25.
//

@testable import dishcovery
import Foundation

final class MockMenuRepository: MenuRepositoryProtocol {
    
    /// If true, we throw an error on fetch instead of returning items.
    var shouldThrowError = false
    
    /// Fake “page 1” data; returned when offset = 0.
    var firstPageItems: [MenuItem] = []
    
    /// Fake “page 2” data; returned when offset > 0.
    var secondPageItems: [MenuItem] = []
    
    // Conforms to MenuRepositoryProtocol
    func fetchMenuItems(query: String, offset: Int, number: Int) async throws -> [MenuItem] {
        print("Mock repo called with query= \(query) & offset=\(offset)")
        if shouldThrowError {
            throw URLError(.badServerResponse)  // or a custom error
        }
        
        // For simplicity, if offset = 0 => page 1, else => page 2
        if offset == 0 {
            return firstPageItems
        } else {
            return secondPageItems
        }
    }
}
