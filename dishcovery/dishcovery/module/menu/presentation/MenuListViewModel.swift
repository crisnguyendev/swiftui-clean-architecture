//
//  MenuListViewModel.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//

import Foundation
import SwiftData

@MainActor
final class MenuListViewModel: ObservableObject {
    // MARK: - State

    @Published var state = MenuListState()

    // MARK: - Dependencies

    private let fetchMenuItemsUseCase: FetchMenuItemsUseCaseProtocol
    private let modelContext: ModelContext

    // MARK: - Initializer

    init(fetchMenuItemsUseCase: FetchMenuItemsUseCaseProtocol, modelContext: ModelContext) {
        self.fetchMenuItemsUseCase = fetchMenuItemsUseCase
        self.modelContext = modelContext
        print("MenuListViewModel initialized")
    }


    /// Fetches menu items based on a query.
    func fetchMenuItems(query: String = "pho") {
        state.isLoading = true
        state.errorMessage = nil
        Task {
            do {
                let items = try await fetchMenuItemsUseCase.execute(query: query)
                self.state.menuItems = items
                print("Loaded - fetchMenuItems: \(state.menuItems.count)")
                self.state.isLoading = false
            } catch {
                self.state.errorMessage = error.localizedDescription
                self.state.isLoading = false
            }
        }
    }

    /// Refreshes menu items with the existing query.
    func refreshMenuItems(query: String = "pho") {
        print("Refresh menu items")
        fetchMenuItems(query: query)
    }

    /// Adds a new menu item.
//    func addMenuItem(id: Int, title: String, image: String, imageType: String) {
//        let newMenuItem = MenuItem(id: id, title: title, image: image)
//        modelContext.insert(newMenuItem)
//        try? modelContext.save()
//        fetchMenuItems()
//    }

    /// Deletes a menu item.
    func deleteMenuItem(_ menuItem: MenuItem) {
        modelContext.delete(menuItem)
        try? modelContext.save()
        fetchMenuItems()
    }
}
