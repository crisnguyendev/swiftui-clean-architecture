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
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    func destination(for route: SearchRecipeRoute) -> AnyView {
        switch route {
        case .detail( _):
            if authenticationManager.isLoggedIn {
                return AnyView(RecipeDetailViewFactory.build())
            } else {
                return AnyView(Text("Need Login"))
            }
        }
    }
}
