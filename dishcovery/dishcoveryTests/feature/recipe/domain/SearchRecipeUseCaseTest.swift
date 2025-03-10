//
//  SearchRecipeUseCaseTest.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//
import XCTest
@testable import dishcovery

class SearchRecipeUseCaseTest: XCTestCase {
    var mockRepository: MockRecipeRepository!
    var useCase: SearchRecipeUseCase!
    var mockRecipe: RecipeModel!
    var mockTotalResults = 1
    let mockId = 1
    let mockTitle = "Mock Title"
    
    override func setUp() {
        mockRecipe = RecipeModel(
            id: mockId,
            title: mockTitle,
            image: ""
        )
        mockRepository = MockRecipeRepository(mockTotalResult: mockTotalResults, mockData: [mockRecipe])
        useCase = SearchRecipeUseCase(repository: mockRepository)
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        
    }
    
    func testFetchSuccess() async throws{
        let result = try await useCase.fetch(query: "Test")
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, mockId)
        XCTAssertEqual(result[0].title, mockTitle)
    }
    
    func testHasMoreData() {
        let result = useCase.hasMoreData()
        XCTAssertFalse(result)
    }
    
    func testLoadMoreData() async throws {
        let result = try await useCase.loadMoreData()
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, mockId)
        XCTAssertEqual(result[0].title, mockTitle)
    }
    
    func testRefresh() async throws {
        let result = await useCase.refresh()
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, mockId)
        XCTAssertEqual(result[0].title, mockTitle)
    }
}
