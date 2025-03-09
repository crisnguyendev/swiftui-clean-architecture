//
//  SearchRecipeView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/1/25.
//

import SwiftUI

struct SearchRecipeView: View {
    @ObservedObject var viewModel: SearchRecipeViewModel
    @State private var query: String = "burger"
    
    var body: some View {
        NavigationStack {
            StateRenderer(state: viewModel.state) { items in
                List(items) { item in
                    RecipeCell(recipe: item)
                        .onAppear {
                            if item == items.last {
                                Task {
                                    await viewModel.loadMoreIfNeeded()
                                }
                                
                            }
                        }
                }
                .listStyle(.plain)
                .refreshable {
                    Task {
                        await viewModel.refresh()
                    }
                    
                }
                .navigationTitle("Recipe")
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
