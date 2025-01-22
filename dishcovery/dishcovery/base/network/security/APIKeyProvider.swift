//
//  APIKeyProvider.swift
//  dishcovery
//
//  Created by Vu Nguyen on 1/17/25.
//

import Foundation

final class APIKeyProvider {
    static var spoonacularAPIKey: String {
        guard let key = ProcessInfo.processInfo.environment["SPOONACULAR_API_KEY"] else {
            fatalError("Spoonacular API Key not set in environment variables.")
        }
        return key
    }
}
