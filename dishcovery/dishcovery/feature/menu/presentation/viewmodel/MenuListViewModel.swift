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
    @Published var state = MenuListState()

    private let fetchMenuItemsUseCase: FetchMenuItemsUseCaseProtocol
    private let modelContext: ModelContext

    init(fetchMenuItemsUseCase: FetchMenuItemsUseCaseProtocol, modelContext: ModelContext) {
        self.fetchMenuItemsUseCase = fetchMenuItemsUseCase
        self.modelContext = modelContext
    }

    func fetchMenuItems(query: String = "pho") {
        state.isLoading = true
        state.errorMessage = nil
        Task {
            do {
                let items = try await fetchMenuItemsUseCase.execute(query: query)
                self.state.menuItems = items
                self.state.isLoading = false
            } catch {
                self.state.errorMessage = error.localizedDescription
                self.state.isLoading = false
            }
        }
    }

    func refreshMenuItems(query: String = "pho") {
        fetchMenuItems(query: query)
    }
}
