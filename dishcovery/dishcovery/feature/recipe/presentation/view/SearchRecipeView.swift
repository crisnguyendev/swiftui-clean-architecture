//
//  SearchRecipeView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

import SwiftUI

struct SearchRecipeView: View {
    @ObservedObject var viewModel: SearchRecipeViewModel
    @ObservedObject var coordinator: SearchRecipeCoordinator
    @EnvironmentObject var authManager: AuthenticationManager
    
    @State private var query: String = "burger"
    
    var body: some View {
        NavigationStack (path: $coordinator.path) {
            StateRenderer(state: viewModel.state) { items in
                List(items) { item in
                    NavigationLink(
                        value: SearchRecipeRoute.detail(recipeId: item.id)
                    ) {
                        RecipeCell(recipe: item)
                    }
                    .onAppear {
                        if item == items.last {
                            Task {
                                await viewModel.loadMoreIfNeeded()
                            }
                            
                        }
                    }
                }
                .animation(.default, value: items)
                .listStyle(.plain)
                .refreshable {
                    Task {
                        await viewModel.refresh()
                    }
                    
                }
                .navigationTitle("Recipe")
                .navigationDestination(for: SearchRecipeRoute.self) { route in
                    coordinator.destination(for: route)
                }
                
            }
            
            .onAppear {
                Task {
                    await viewModel.search(query: query)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await viewModel.refresh()
                        }
                        
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .searchable(text: $query, prompt: "Search Recipe")
            .onSubmit {
                Task {
                    await viewModel.search(query: query)
                }
                
            }
            
        }
    }
}
