//
//  dishcoveryApp.swift
//  dishcovery
//
//  Created by Vu Nguyen on 12/26/24.
//

import SwiftUI
import SwiftData

//@main
//struct dishcoveryApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ListRecipeView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}


@main
struct DishcoveryApp: App {
    // Initialize your ModelContainer and dependencies here
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    init() {
        // Initialize the ModelContainer with persistent storage
        // For production, set inMemory to false
        do {
            modelContainer = try ModelContainer(for: MenuItem.self)
            modelContext = modelContainer.mainContext
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            // Create and inject the ViewModel
            let apiKeyInterceptor = ApiKeyInterceptor()
            let compositeInterceptor = CompositeInterceptor(
                            adaptors: [apiKeyInterceptor],
                            retriers: []
                        )
            let networkService = AlamofireNetworkService(session: NetworkSessionProvider.makeSession(interceptor: compositeInterceptor))
            let repository = MenuRepository(networkService: networkService, modelContext: modelContext)
            let useCase = FetchMenuItemsUseCase(repository: repository)
            let viewModel = MenuListViewModel(fetchMenuItemsUseCase: useCase, modelContext: modelContext)
            
            MenuListView(viewModel: viewModel)
                .modelContainer(modelContainer)
        }
    }
}
