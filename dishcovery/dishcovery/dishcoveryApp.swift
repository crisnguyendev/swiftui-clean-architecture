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
    @StateObject var authenticationManager: AuthenticationManager = AuthenticationManager()
    init() {
    
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
            SearchRecipeViewFactory.build()
                .environmentObject(authenticationManager)
        }
    }
}
