//
//  TokenError.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//
import Foundation

enum TokenError: Error, LocalizedError {
    case invalidURL
    case missingRefreshToken
    case refreshFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The token refresh URL is invalid."
        case .missingRefreshToken:
            return "No refresh token available."
        case .refreshFailed:
            return "Failed to refresh access token."
        }
    }
}
