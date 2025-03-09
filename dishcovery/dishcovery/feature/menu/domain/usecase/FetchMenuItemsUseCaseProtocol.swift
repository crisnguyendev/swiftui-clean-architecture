//
//  FetchMenuItemsUseCaseProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//
import Foundation

protocol FetchMenuItemsUseCaseProtocol {
    func execute(query: String, offset: Int, number: Int) async throws -> [Menu]
}
