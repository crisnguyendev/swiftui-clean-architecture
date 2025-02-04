//
//  MenuListViewModelTests.swift
//  dishcovery
//
//  Created by Vu Nguyen on 2/4/25.
//

import XCTest
import SwiftData
@testable import dishcovery

@MainActor
final class MenuListViewModelTests: XCTestCase {
    
    var mockRepository: MockMenuRepository!
    var useCase: FetchMenuItemsUseCase!
    var viewModel: MenuListViewModel!
    var modelContext: ModelContext!
    
    override func setUp() {
        super.setUp()
        
        // 1) Create an in-memory ModelContainer for SwiftData
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: MenuItem.self, configurations: config)
            modelContext = container.mainContext
        } catch {
            XCTFail("Failed to create in-memory ModelContainer: \(error.localizedDescription)")
        }
        
        // 2) Create the mock repository
        mockRepository = MockMenuRepository()
        
        // 3) Create the use case with the mock repository
        useCase = FetchMenuItemsUseCase(repository: mockRepository)
        
        // 4) Instantiate the ViewModel
        viewModel = MenuListViewModel(
            fetchMenuItemsUseCase: useCase,
            modelContext: modelContext
        )
        
        // 5) (Optional) Provide fake data for first/second pages
        let serving1 = Serving(number: 1.0, size: 2.0, unit: "pcs")
        let serving2 = Serving(number: 1.0, size: nil, unit: nil)
        
        let item1 = MenuItem(
            id: 1,
            title: "Item 1",
            image: "https://example.com/img1.jpg",
            restaurantChain: "Chain A",
            servings: serving1
        )
        let item2 = MenuItem(
            id: 2,
            title: "Item 2",
            image: "https://example.com/img2.jpg",
            restaurantChain: "Chain B",
            servings: serving1
        )
        mockRepository.firstPageItems = [item1, item2]
        
        let item3 = MenuItem(
            id: 3,
            title: "Item 3",
            image: "https://example.com/img3.jpg",
            restaurantChain: "Chain A",
            servings: serving2
        )
        let item4 = MenuItem(
            id: 4,
            title: "Item 4",
            image: "https://example.com/img4.jpg",
            restaurantChain: "Chain C",
            servings: serving2
        )
        mockRepository.secondPageItems = [item3, item4]
    }
    
    override func tearDown() {
        mockRepository = nil
        useCase = nil
        viewModel = nil
        modelContext = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchMenuItems_Success() async throws {
        // Initially empty
        XCTAssertTrue(viewModel.state.menuItems.isEmpty)
        
        // 1) Call fetch
        viewModel.fetchMenuItems(query: "test")
        
        // 2) Wait for the async Task in the viewModel to complete
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // 3) Verify we got page 1 from the mock
        XCTAssertFalse(viewModel.state.menuItems.isEmpty)
        XCTAssertEqual(viewModel.state.menuItems.count, 2)
        XCTAssertEqual(viewModel.state.menuItems.first?.title, "Item 1")
    }
    
    func testFetchError() async throws {
        // Make the mock fail
        mockRepository.shouldThrowError = true
        
        // 1) Attempt fetch
        viewModel.fetchMenuItems(query: "errorTest")
        try await Task.sleep(nanoseconds: 100_000_000)
        
        // 2) Expect no items, but an error message
        XCTAssertTrue(viewModel.state.menuItems.isEmpty)
        XCTAssertNotNil(viewModel.state.errorMessage)
    }
}
