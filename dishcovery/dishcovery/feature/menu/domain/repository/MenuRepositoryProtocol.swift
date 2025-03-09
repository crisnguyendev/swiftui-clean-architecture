//
//  MenuRepositoryProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/14/25.
//

protocol MenuRepositoryProtocol {
    func search(query: String, offset: Int, number: Int) async throws -> [Menu]
}
