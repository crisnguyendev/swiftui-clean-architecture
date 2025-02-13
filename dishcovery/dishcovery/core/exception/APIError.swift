//
//  APIError.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/22/25.
//
import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case serverError(statusCode: Int, message: String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .decodingError:
            return "Failed to decode the response."
        case .serverError(let statusCode, let message):
            return "Server Error (\(statusCode)): \(message)"
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
