//
//  MockPersistentService.swift.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

import Foundation
@testable import dishcovery

struct MockPersistentService<T>: PersistentServiceProtocol {
    typealias ModelType = T
    
    var result: Result<[T], Error>?
    
    func create(_ object: T) async throws {
        
    }
    func fetch(predicate: ((T) -> Bool)?) async throws -> [T] {
        guard let result = result else {
            return []
        }
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    func delete(_ object: T) async throws {
        
    }
    func clearAll() async throws {
        
    }
    func commit() async throws{
        
    }
    
}
