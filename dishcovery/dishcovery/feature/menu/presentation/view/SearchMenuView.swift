//
//  SearchMenuView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//

import SwiftUI
import SwiftData

struct SearchMenuView: View {
    @ObservedObject var viewModel: SearchMenuViewModel
    @State private var query: String = "pho"
    
    var body: some View {
        NavigationStack {
            StateRenderer(state: viewModel.state) { items in
                List(items) { item in
                    MenuCell(data: item)
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
                .navigationTitle("Menu")
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
            .searchable(text: $query, prompt: "Search Menu")
            .onSubmit {
                Task {
                    await viewModel.search(query: query)
                }
                
            }
        }
    }
}


