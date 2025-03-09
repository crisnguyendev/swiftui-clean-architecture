//
//  SwiftDataStore.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/4/25.
//
import SwiftData

@MainActor
struct SwiftDataService<T: PersistentModel>: PersistentServiceProtocol {
    typealias ModelType = T
    
    private var modelContext: ModelContext
    
    init(modelContainer: ModelContainer, autoSave: Bool? = true) {
        self.modelContext = modelContainer.mainContext
        if let autoSave = autoSave {
            modelContext.autosaveEnabled = autoSave
        }
    }
    
    func create(_ entity: T) throws {
        modelContext.insert(entity)
    }

    func fetch(predicate: (( T) -> Bool)?) async throws -> [ T] {
        let fetchDescriptor = FetchDescriptor< T>()
        let results: [ T] = try modelContext.fetch(fetchDescriptor)
        return predicate.map { results.filter($0) } ?? results
    }

    
    func delete(_ entity:  T) throws {
        modelContext.delete(entity)
    }
    
    func clearAll() throws {
        try modelContext.delete(model: T.self)
    }
    
    
    func commit() throws {
        try modelContext.save()
    }
    
}
