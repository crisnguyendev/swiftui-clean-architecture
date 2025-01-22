//
//  NetworkError.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/15/25.
//

import Foundation
import Alamofire

//enum NetworkError: Error, LocalizedError {
//    case invalidResponse
//    case decodingFailed(Error)
//    case underlying(Error)
//
//    static func from(error: AFError) -> NetworkError {
//        if let underlyingError = error.underlyingError {
//            return .underlying(underlyingError)
//        }
//
//        switch error {
//        case .responseValidationFailed:
//            return .invalidResponse
//        case .decodingFailed(error: <#T##any Error#>):
//            return .decodingFailed(reason)
//        default:
//            return .underlying(error)
//        }
//    }
//
//    var errorDescription: String? {
//        switch self {
//        case .invalidResponse:
//            return "Received an invalid response from the server."
//        case .decodingFailed(let error):
//            return "Failed to decode the data: \(error.localizedDescription)"
//        case .underlying(let error):
//            return error.localizedDescription
//        }
//    }
//}
