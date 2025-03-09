//
//  MockNetworkService.swift
//  dishcovery
//
//  Created by Vu Nguyen on 3/8/25.
//

import Foundation
@testable import dishcovery

struct MockNetworkService<Data>: NetworkServiceProtocol {
    var result: Result<Data, Error>?
    
    func performRequest<T>(_ request: dishcovery.APIRequest) async throws -> T where T : Decodable {
        guard let result = result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let data):
            guard let convertedData = data as? T else {
                throw URLError(.cannotParseResponse)
            }
            return convertedData
        case .failure(let error):
            throw error
        }
    }
    
    
}
