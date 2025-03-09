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
//    let modelContainer: ModelContainer
//    let modelContext: ModelContext
    
    init() {
//        do {
//            modelContainer = try ModelContainer(for: Menu.self, RecipeEntity.self)
//            modelContext = modelContainer.mainContext
//        } catch {
//            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
//        }
    }
    
    var body: some Scene {
        WindowGroup {
            //            let apiKeyInterceptor = ApiKeyInterceptor()
            //            let compositeInterceptor = CompositeInterceptor(
            //                            adaptors: [apiKeyInterceptor],
            //                            retriers: []
            //                        )
            //            let networkService = AlamofireNetworkService(session: AlamofireSessionProvider.makeAlamofireSession(interceptor: compositeInterceptor))
            //            let repository = MenuRepository(networkService: networkService, modelContext: modelContext)
            //            let useCase = FetchMenuItemsUseCase(repository: repository)
            //            let viewModel = MenuListViewModel(fetchMenuItemsUseCase: useCase, modelContext: modelContext)
            //
            //            MenuListView(viewModel: viewModel)
            //                .modelContainer(modelContainer)
            
            let networkService = URLSessionNetworkService()
            let persistentService = SwiftDataService<RecipeEntity>(
                modelContainer: ModelContainerManager.shared.modelContainer,
                autoSave: true)
            let repository = RecipeRepository(
                networkService: networkService,
                persistentService: persistentService
            )
            let useCase = SearchRecipeUseCase(repository: repository)
            let viewModel = SearchRecipeViewModel(usecase: useCase)
            SearchRecipeView(viewModel: viewModel)
            
            
            
        }
    }
}
