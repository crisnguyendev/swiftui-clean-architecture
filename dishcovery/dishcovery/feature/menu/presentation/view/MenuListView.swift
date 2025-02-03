//
//  MenuListView.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//

import SwiftUI
import SwiftData

struct MenuListView: View {
    @ObservedObject var viewModel: MenuListViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.state.isLoading {
                    ProgressView("Loading Menu Items...")
                        .padding()
                    
                } else if let errorMessage = viewModel.state.errorMessage {
                    VStack(spacing: 20) {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Retry") {
                            viewModel.fetchMenuItems(query: searchText)
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                } else if viewModel.state.menuItems.isEmpty {
                    Text("No Menu Items Found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.state.menuItems) { menuItem in
                        NavigationLink(destination: MenuDetailView(menuItem: menuItem)) {
                            MenuItemRowView(menuItem: menuItem)
                                .onAppear {
                                    viewModel.loadMoreItemsIfNeeded(currentItem: menuItem)
                                }
                        }
                    }
                    .refreshable {
                        viewModel.refreshMenuItems()
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.refreshMenuItems(query: searchText)
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search menu items...")
            .onSubmit(of: .search) {
                viewModel.fetchMenuItems(query: searchText)
            }
            .onAppear {
                if viewModel.state.menuItems.isEmpty {
                    viewModel.fetchMenuItems(query: "pho")
                }
            }
        }
    }
}


