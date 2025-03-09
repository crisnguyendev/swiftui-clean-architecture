//
//  SearchMenuUseCaseProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//
import Foundation

protocol SearchMenuUseCaseProtocol {
    mutating func fetch(query: String) async throws -> [MenuModel]
    mutating func loadMoreData() async throws -> [MenuModel]
    mutating func refresh() async throws -> [MenuModel]
    func hasMoreData() -> Bool
}
