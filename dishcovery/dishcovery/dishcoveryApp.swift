//
//  dishcoveryApp.swift
//  dishcovery
//
//  Created by Vu Nguyen on 12/26/24.
//

import SwiftUI
import SwiftData

@main
struct DishcoveryApp: App {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    init() {
        do {
            modelContainer = try ModelContainer(for: MenuItem.self)
            modelContext = modelContainer.mainContext
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
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
