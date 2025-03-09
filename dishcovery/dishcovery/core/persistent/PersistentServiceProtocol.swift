//
//  PersistentServiceProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/4/25.
//

@MainActor
protocol PersistentServiceProtocol {
    associatedtype ModelType
    func create(_ object: ModelType) async throws
    func fetch(predicate: ((ModelType) -> Bool)?) async throws -> [ModelType]
    func delete(_ object: ModelType) async throws
    func clearAll() async throws
    func commit() async throws
}
