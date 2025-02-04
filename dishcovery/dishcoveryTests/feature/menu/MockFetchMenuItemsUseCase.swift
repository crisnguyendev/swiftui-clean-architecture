//
//  MockFetchMenuItemsUseCase.swift
//  dishcovery
//
//  Created by Vu Nguyen on 2/4/25.
//

import Foundation
@testable import dishcovery

final class MockFetchMenuItemsUseCase: FetchMenuItemsUseCaseProtocol {
    // You can set these arrays to simulate different responses
    var firstPageItems: [MenuItem] = []
    var secondPageItems: [MenuItem] = []
    var shouldThrowError = false
    
    func execute(query: String, offset: Int, number: Int) async throws -> [MenuItem] {
        if shouldThrowError {
            throw TestError.mockFailure
        }
        
        // If offset is 0, return first page; otherwise, second page
        return (offset == 0) ? firstPageItems : secondPageItems
    }
    
    enum TestError: Error {
        case mockFailure
    }
}
