//
//  SearchRecipeViewModel.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//
import SwiftUI

@MainActor
final class SearchRecipeViewModel: ObservableObject {
    @Published var state: ViewState<[RecipeModel]> = .loaded([])
    
    private var usecase: SearchRecipeUseCaseProtocol
    
    private var isLoadingMore = false
    
    required init(usecase: SearchRecipeUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func search(query: String) async {
        state = .loading
        
        do {
            let recipes = try await usecase.fetch(query: query)
            state = recipes.isEmpty ? .error("Not found") : .loaded(recipes)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func loadMoreIfNeeded() async {
        guard case .loaded(let currentRecipes) = state, !currentRecipes.isEmpty else {
            return
        }
        guard usecase.hasMoreData() && !isLoadingMore else {
            return
        }
        
        
        do {
            isLoadingMore = true
            let newRecipes = try await usecase.loadMoreData()
            if !newRecipes.isEmpty {
                state = .loaded(currentRecipes + newRecipes)
            }
        } catch {
            state = .error(error.localizedDescription)
        }
        isLoadingMore = false
        
    }
    
    func refresh() async {
        
        do {
            let refreshedRecipes = try await usecase.refresh()
            state = refreshedRecipes.isEmpty ? .error("Not found") : .loaded(refreshedRecipes)
        } catch {
            state = .error(error.localizedDescription)
        }
        
    }
}


