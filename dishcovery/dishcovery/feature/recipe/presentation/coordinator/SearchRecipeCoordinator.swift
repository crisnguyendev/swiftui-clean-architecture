//
//  SearchRecipeCoordinator.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/10/25.
//
import SwiftUI

class SearchRecipeCoordinator: ObservableObject, CoordinatorProtocol {
    typealias Route = SearchRecipeRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    func destination(for route: SearchRecipeRoute) -> AnyView {
        switch route {
        case .detail( _):
            return AnyView(RecipeDetailViewFactory.build())
        }
    }
}
