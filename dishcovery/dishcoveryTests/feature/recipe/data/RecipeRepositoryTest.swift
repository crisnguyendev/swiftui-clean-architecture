//
//  RecipeRepositoryTest.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//
import XCTest
@testable import dishcovery

@MainActor
class RecipeRepositoryTest: XCTestCase {
    
    var mockNetworkService: MockNetworkService<SearchRecipeResultDTO>!
    var mockRecipeDTO: RecipeDTO!
    var mockRecipeEntity: RecipeEntity!
    var mockSearchRecipeResult: SearchRecipeResultDTO!
    var mockPersistentService: MockPersistentService<RecipeEntity>!
    var repository: RecipeRepository<MockPersistentService<RecipeEntity>>!
    let mockId = 101
    let mockRemoteTitle = "Remote Recipe"
    let mockCachedTitle = "Cached Recipe"
    
    override func setUp() {
        super.setUp()
        mockRecipeDTO = RecipeDTO(
            id: mockId,
            title: mockRemoteTitle,
            image: "Test"
        )
        
        mockRecipeEntity = RecipeEntity(
            id: mockId,
            title: mockCachedTitle,
            image: "Test"
        )
        
        mockSearchRecipeResult = SearchRecipeResultDTO(
            data: [mockRecipeDTO],
            offset: 0,
            number: 10,
            total: 1)
        
        mockNetworkService = MockNetworkService()
        mockPersistentService = MockPersistentService()
        repository = RecipeRepository(
            networkService: mockNetworkService,
            persistentService: mockPersistentService
        )
    }
    
    override func tearDown() {
        mockNetworkService = nil
        mockPersistentService = nil
    }
    
    func testQuerySuccessful() async throws {
        mockNetworkService.result = .success(mockSearchRecipeResult)
        mockPersistentService.result = .success([mockRecipeEntity])
        repository = RecipeRepository(
            networkService: mockNetworkService,
            persistentService: mockPersistentService
        )
        
        let (total, data) = try await repository.query(query: "Test", offset: 0, limit: 10)
        XCTAssertEqual(total, 1)
        XCTAssertEqual(data[0].id, mockId)
        XCTAssertEqual(data[0].title, mockRemoteTitle)
    }
    
    func testQueryFailed() async throws {
        mockNetworkService.result = .failure(RepositoryError.invalidURL)
        mockPersistentService.result = .success([mockRecipeEntity])
        repository = RecipeRepository(
            networkService: mockNetworkService,
            persistentService: mockPersistentService
        )
        do {
            let _ = try await repository.query(query: "Test", offset: 0, limit: 10)
        } catch {
            XCTAssertEqual(error.localizedDescription, RepositoryError.invalidURL.localizedDescription)
        }
    }
    
}
