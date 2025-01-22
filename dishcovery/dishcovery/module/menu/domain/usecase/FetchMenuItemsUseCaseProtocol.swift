//
//  FetchMenuItemsUseCaseProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//
import Foundation

protocol FetchMenuItemsUseCaseProtocol {
    func execute(query: String) async throws -> [MenuItem]
}
