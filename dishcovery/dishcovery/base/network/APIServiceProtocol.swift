//
//  APIServiceProtocol.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/12/25.
//
import Foundation

protocol APIServiceProtocol {
    func fetchData<T: Codable>(
        endpoint: String,
        modelType: T.Type,
        queryParams: [String: String]?,
        completion: @escaping (Result<T, Error>) -> Void
    )
    
    func fetchData<T: Codable>(
        endpoint: String,
        modelType: T.Type,
        queryParams: [String: String]?,
        completion: @escaping (Result<[T], Error>) -> Void
    )
}
