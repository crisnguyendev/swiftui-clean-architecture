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
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.state.isLoading {
                    ProgressView("Loading Pho Menu Items...")
                        .padding()
                } else if let errorMessage = viewModel.state.errorMessage {
                    VStack(spacing: 20) {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button(action: {
                            viewModel.fetchMenuItems()
                        }) {
                            Text("Retry")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                } else if viewModel.state.menuItems.isEmpty {
                    Text("No Menu Items Found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.state.menuItems) { menuItem in
                        NavigationLink(destination: MenuDetailView(menuItem: menuItem)) {
                            MenuItemRowView(menuItem: menuItem)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Pho Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.refreshMenuItems()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                print("MenuListView using ViewModel with id: \(ObjectIdentifier(viewModel))")
                viewModel.fetchMenuItems()
            }
        }
    }
}



