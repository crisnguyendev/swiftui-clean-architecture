//
//  SearchRecipeViewFactory.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/10/25.
//

@MainActor
struct SearchRecipeViewFactory {
    private init() {
        
    }
    static func build() -> SearchRecipeView {
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
        let coordinator = SearchRecipeCoordinator()
        return SearchRecipeView(viewModel: viewModel, coordinator: coordinator)
    }
}
