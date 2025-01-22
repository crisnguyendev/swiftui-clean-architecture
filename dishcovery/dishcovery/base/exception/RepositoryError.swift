//
//  RepositoryError.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation

enum RepositoryError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case cachingFailed(Error)
    case missingAPIKey

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The constructed URL is invalid."
        case .networkError(let error):
            return error.localizedDescription
        case .cachingFailed(let error):
            return "Failed to cache data: \(error.localizedDescription)"
        case .missingAPIKey:
            return "API Key is missing. Please configure it properly."
        }
    }
}
