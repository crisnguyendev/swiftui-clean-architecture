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
    
    private var offset: Int = 0
    private let limit: Int = 10
    private var hasMoreData: Bool = true
    private var isFetchingMore: Bool = false
    
    private var currentQuery: String = "pho"
    
    init(fetchMenuItemsUseCase: FetchMenuItemsUseCaseProtocol,
         modelContext: ModelContext) {
        self.fetchMenuItemsUseCase = fetchMenuItemsUseCase
        self.modelContext = modelContext
    }
    
    func fetchMenuItems(query: String = "pho") {
        currentQuery = query
        offset = 0
        hasMoreData = true
        
        state.isLoading = true
        state.errorMessage = nil
        
        Task {
            do {
                let items = try await fetchMenuItemsUseCase.execute(
                    query: currentQuery,
                    offset: offset,
                    number: limit
                )
                state.menuItems = items
                state.isLoading = false
                
                if items.count < limit {
                    hasMoreData = false
                }
            } catch {
                state.errorMessage = error.localizedDescription
                state.isLoading = false
            }
        }
    }
    
    func loadMoreItemsIfNeeded(currentItem: Menu) {
        guard !isFetchingMore,
              hasMoreData,
              let lastItem = state.menuItems.last,
              lastItem.id == currentItem.id
        else {
            return
        }
        
        isFetchingMore = true
        offset += limit
        
        Task {
            do {
                let additionalItems = try await fetchMenuItemsUseCase.execute(
                    query: currentQuery,
                    offset: offset,
                    number: limit
                )
                state.menuItems.append(contentsOf: additionalItems)
                
                if additionalItems.count < limit {
                    hasMoreData = false
                }
            } catch {
                offset -= limit
            }
            isFetchingMore = false
        }
    }
    
    func refreshMenuItems(query: String? = nil) {
        fetchMenuItems(query: query ?? currentQuery)
    }
}
