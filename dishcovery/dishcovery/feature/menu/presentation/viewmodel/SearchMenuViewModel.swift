//
//  SearchMenuViewModel.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/16/25.
//

import Foundation
import SwiftData

@MainActor
final class SearchMenuViewModel: ObservableObject {
    @Published var state: ViewState<[MenuModel]> = .loaded([])
    
    private var usecase: SearchMenuUseCaseProtocol
    
    private var isLoadingMore = false
    
    required init(usecase: SearchMenuUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func search(query: String) async {
        state = .loading
        
        do {
            let data = try await usecase.fetch(query: query)
            state = data.isEmpty ? .error("Not found") : .loaded(data)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func loadMoreIfNeeded() async {
        guard case .loaded(let currentData) = state, !currentData.isEmpty else {
            return
        }
        guard usecase.hasMoreData() && !isLoadingMore else {
            return
        }
        
        
        do {
            isLoadingMore = true
            let newData = try await usecase.loadMoreData()
            if !newData.isEmpty {
                state = .loaded(currentData + newData)
            }
        } catch {
            state = .error(error.localizedDescription)
        }
        isLoadingMore = false
        
    }
    
    func refresh() async {
        
        do {
            let newData = try await usecase.refresh()
            state = newData.isEmpty ? .error("Not found") : .loaded(newData)
        } catch {
            state = .error(error.localizedDescription)
        }
        
    }
}
