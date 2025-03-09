//
//  ModelContainerManager.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/6/25.
//
import SwiftData

@MainActor
final class ModelContainerManager {
    static let shared = ModelContainerManager()
       
       let modelContainer: ModelContainer
       
       private init() {
           do {
               modelContainer = try ModelContainer(for: RecipeEntity.self)
           } catch {
               fatalError("Failed to initialize ModelContainer: \(error)")
           }
       }
}
