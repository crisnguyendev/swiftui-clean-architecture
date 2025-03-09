//
//  SearchRecipeViewModelTest.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

import XCTest

@testable import dishcovery

@MainActor
class SearchRecipeViewModelTest: XCTestCase {
    var mockUseCase: MockSearchUseCase!
    var viewModel: SearchRecipeViewModel!
    var mockErrorMessage: String!
    var mockData: [RecipeModel]!
    let mockId = 101
    let mockMoreId = 102
    let mockTitle = "Mock title"
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockSearchUseCase()
        mockData = [RecipeModel(
            id: mockId,
            title: mockTitle,
            image: "")]
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testSearchReturnEmpty() async throws {
        mockUseCase.result = .success([])
        viewModel = SearchRecipeViewModel(usecase: mockUseCase)
        await viewModel.search(query: "Test")
        
        switch viewModel.state{
        case .error(let errorMessage):
            XCTAssertEqual(errorMessage, "Not found")
        default:
            break
        }
    }
    
    func testSearchReturnData() async throws {
        mockUseCase.result = .success(mockData)
        viewModel = SearchRecipeViewModel(usecase: mockUseCase)
        await viewModel.search(query: "Test")
        
        switch viewModel.state{
        case .loaded(let data):
            XCTAssertEqual(data[0].id, mockId)
            XCTAssertEqual(data[0].title, mockTitle)
        default:
            break
        }
    }
    
    func testSearchThrowError() async throws {
        mockUseCase.result = .failure(RepositoryError.invalidURL)
        viewModel = SearchRecipeViewModel(usecase: mockUseCase)
        await viewModel.search(query: "Test")
        
        switch viewModel.state{
        case .error(let errorMessage):
            XCTAssertEqual(errorMessage, RepositoryError.invalidURL.localizedDescription )
        default:
            break
        }
    }
    
    func testLoadMoreIfNeededReturnData() async throws {
        let moreData: [RecipeModel] = [RecipeModel(
            id: mockMoreId,
            title: mockTitle,
            image: ""
        )]
        
        mockUseCase.result = .success(moreData)
        mockUseCase.mockHasMoreData = true
        
        viewModel = SearchRecipeViewModel(usecase: mockUseCase)
        viewModel.state = .loaded(mockData)
        
        await viewModel.loadMoreIfNeeded()
        
        switch viewModel.state{
        case .loaded(let data):
            XCTAssertEqual(data.count, 2)
            XCTAssertEqual(data[0].id, mockId)
            XCTAssertEqual(data[1].id, mockMoreId)
        default:
            break
        }
    }
    
    func testLoadMoreIfNeededThrowError() async throws {
        mockUseCase.result = .failure(RepositoryError.missingAPIKey)
        mockUseCase.mockHasMoreData = true
        
        viewModel = SearchRecipeViewModel(usecase: mockUseCase)
        viewModel.state = .loaded(mockData)
        
        await viewModel.loadMoreIfNeeded()
        
        switch viewModel.state{
        case .error(let errorMessage):
            XCTAssertEqual(errorMessage, RepositoryError.missingAPIKey.localizedDescription )
        default:
            break
        }
    }
    
    func testRefresh() async throws {
        mockUseCase.result = .success(mockData)
        
        viewModel = SearchRecipeViewModel(usecase: mockUseCase)
        await viewModel.refresh()
        
        switch viewModel.state{
        case .loaded(let data):
            XCTAssertEqual(data[0].id, mockId)
            XCTAssertEqual(data[0].title, mockTitle)
        default:
            break
        }
    }
    
    
    
}
